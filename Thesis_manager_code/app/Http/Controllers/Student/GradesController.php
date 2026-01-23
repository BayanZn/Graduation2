<?php

namespace App\Http\Controllers\Student;

use App\Http\Controllers\Controller;
use App\Models\Defense;
use App\Models\Project;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;
use Inertia\Inertia;
use Barryvdh\DomPDF\Facade\Pdf;

class GradesController extends Controller
{
    /**
     * Show grades for a specific project.
     */
    public function show(Project $project)
    {
        $user = Auth::user();

        // Verify that the user is assigned to this project as a student
        $isStudent = $project->students()
            ->where('user_id', $user->id)
            ->exists();

        abort_unless($isStudent, 403, 'Unauthorized access to this project.');

        // Get all graded defenses for this project
        $defenses = Defense::where('project_id', $project->id)
            ->whereNotNull('total_grade')
            ->with(['members' => function ($query) {
                $query->withPivot(['grade', 'feedback', 'graded_at']);
            }])
            ->orderBy('discussion_date')
            ->get();

        $gradeData = [];
        $totalGrade = 0;

        foreach ($defenses as $defense) {
            $summary = $defense->getGradeSummary();
            $gradeData[] = $summary;
            $totalGrade += $defense->total_grade ?? 0;
        }

        return Inertia::render('Student/Grades/Show', [
            'project' => $project->load(['department', 'specialization', 'students', 'supervisors']),
            'gradeData' => $gradeData,
            'totalGrade' => round($totalGrade, 2),
            'maxTotalGrade' => 100,
        ]);
    }

    /**
     * Export grades to PDF.
     */
    public function exportPdf(Project $project)
    {
        $user = Auth::user();

        // Verify that the user is assigned to this project as a student or supervisor
        $isStudent = $project->students()->where('user_id', $user->id)->exists();
        $isSupervisor = $project->supervisors()->where('user_id', $user->id)->exists();

        abort_unless($isStudent || $isSupervisor, 403, 'Unauthorized access to this project.');

        // Get all graded defenses for this project
        $defenses = Defense::where('project_id', $project->id)
            ->whereNotNull('total_grade')
            ->with(['members' => function ($query) {
                $query->withPivot(['grade', 'feedback', 'graded_at']);
            }])
            ->orderBy('discussion_date')
            ->get();

        $gradeData = [];
        $totalGrade = 0;

        foreach ($defenses as $defense) {
            $summary = $defense->getGradeSummary();
            $gradeData[] = $summary;
            $totalGrade += $defense->total_grade ?? 0;
        }

        $project->load(['department', 'specialization', 'students', 'supervisors']);

        $pdf = Pdf::loadView('pdf.grades', [
            'project' => $project,
            'gradeData' => $gradeData,
            'totalGrade' => round($totalGrade, 2),
            'maxTotalGrade' => 100,
            'exportDate' => now()->format('F d, Y'),
        ]);

        return $pdf->download('project-grades-' . $project->id . '.pdf');
    }
}
