<?php

namespace App\Http\Controllers\Student\Dashboard;

use App\Http\Controllers\Controller;
use App\Models\Project;
use App\Models\Defense;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;
use Inertia\Inertia;

class DashboardController extends Controller
{
    public function dashboard()
    {
        $user = Auth::user();

        // Get projects assigned to this student
        $assignedProjectIds = $user->assignments()
            ->where('role', 'student')
            ->pluck('project_id');

        $myProjects = Project::whereIn('id', $assignedProjectIds)
            ->with(['department', 'specialization', 'creator'])
            ->latest()
            ->get();

        // Get defenses for student's assigned projects
        $myDefenses = Defense::whereIn('project_id', $assignedProjectIds)
            ->with(['project.department', 'project.creator'])
            ->latest()
            ->get();

        // Calculate statistics
        $statistics = [
            'total_projects' => $myProjects->count(),
            'approved_projects' => $myProjects->where('status', 'Approved')->count(),
            'pending_projects' => $myProjects->where('status', 'Proposed')->count(),
            'total_defenses' => $myDefenses->count(),
        ];

        return Inertia::render('Student/Dashboard', [
            'statistics' => $statistics,
            'myProjects' => $myProjects->take(5), // Latest 5 projects
            'myDefenses' => $myDefenses->take(5), // Latest 5 defenses
        ]);
    }
}
