<?php

namespace App\Http\Controllers\Student;

use App\Http\Controllers\Controller;
use App\Models\Project;
use App\Models\ProjectAssignment;
use App\Models\ProjectSubmission;
use App\Notifications\ChapterSubmittedNotification;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\Redirect;
use Illuminate\Support\Facades\Storage;
use Inertia\Inertia;

class ProjectSubmissionsController extends Controller
{
    /**
     * Display a listing of the submissions for student's assigned project.
     */
    public function index()
    {
        // Get all projects assigned to this student
        $assignments = ProjectAssignment::where('user_id', Auth::id())
            ->where('role', 'student')
            ->with('project')
            ->get();

        if ($assignments->isEmpty()) {
            return Inertia::render('Student/ProjectSubmissions/Index', [
                'projects' => [],
                'selectedProject' => null,
                'submissions' => [],
                'groupMembers' => [],
                'error' => 'You are not assigned to any project yet.',
            ]);
        }

        // Get selected project from query or use first one
        $projectId = request()->query('project_id');

        if ($projectId) {
            $selectedAssignment = $assignments->firstWhere('project_id', $projectId);
        } else {
            $selectedAssignment = $assignments->first();
        }

        $selectedProject = $selectedAssignment ? $selectedAssignment->project : null;

        // Load all submissions for the selected project
        $submissions = [];
        $groupMembers = [];

        if ($selectedProject) {
            $submissions = ProjectSubmission::where('project_id', $selectedProject->id)
                ->with(['uploadedBy:id,name,email', 'reviewer:id,name'])
                ->orderBy('created_at', 'desc')
                ->get();

            // Get all students assigned to this project
            $groupMembers = ProjectAssignment::where('project_id', $selectedProject->id)
                ->where('role', 'student')
                ->with('user:id,name,email')
                ->get()
                ->pluck('user');
        }

        return Inertia::render('Student/ProjectSubmissions/Index', [
            'projects' => $assignments->pluck('project'),
            'selectedProject' => $selectedProject,
            'submissions' => $submissions,
            'groupMembers' => $groupMembers,
        ]);
    }

    /**
     * Store a newly created submission.
     */
    public function store(Request $request)
    {
        $request->validate([
            'project_id' => 'required|exists:projects,id',
            'chapter_type' => 'required|in:Introduction,Literature Review,Methodology,Result & Analysis,Conclusion,Abstract,Full Draft',
            'file' => 'nullable|required_without:code_link|file|mimes:pdf,doc,docx|max:10240', // 10MB max
            'code_link' => 'nullable|required_without:file|url|max:500',
        ], [
            'file.required_without' => 'Please either upload a file or provide a code link.',
            'code_link.required_without' => 'Please either upload a file or provide a code link.',
            'code_link.url' => 'Please provide a valid URL for the code link.',
        ]);

        // Verify student is assigned to this project
        $assignment = ProjectAssignment::where('user_id', Auth::id())
            ->where('role', 'student')
            ->where('project_id', $request->project_id)
            ->first();

        if (! $assignment) {
            return Redirect::back()->with('error', 'You are not assigned to this project.');
        }

        // Store the file if provided
        $filePath = null;
        if ($request->hasFile('file')) {
            $filePath = $request->file('file')->store('project-submissions', 'public');
        }

        // Create submission
        $submission = ProjectSubmission::create([
            'project_id' => $request->project_id,
            'uploaded_by' => Auth::id(),
            'chapter_type' => $request->chapter_type,
            'file_path' => $filePath,
            'code_link' => $request->code_link,
            'status' => 'pending',
        ]);

        // Load relationships for notification
        $submission->load(['project', 'uploadedBy']);

        // Notify all supervisors of this project
        $project = Project::find($request->project_id);
        $supervisors = $project->supervisors;

        foreach ($supervisors as $supervisor) {
            $supervisor->notify(new ChapterSubmittedNotification($submission));
        }

        return Redirect::back()->with('success', 'Chapter submitted successfully!');
    }

    /**
     * Remove the specified submission (only if student owns it and it's pending).
     */
    public function destroy(ProjectSubmission $projectSubmission)
    {
        // Verify student owns this submission
        if ($projectSubmission->uploaded_by !== Auth::id()) {
            abort(403, 'Unauthorized action.');
        }

        // Only allow deletion if pending
        if ($projectSubmission->status !== 'pending') {
            return Redirect::back()->with('error', 'Cannot delete reviewed submissions.');
        }

        // Delete the file
        if (Storage::disk('public')->exists($projectSubmission->file_path)) {
            Storage::disk('public')->delete($projectSubmission->file_path);
        }

        $projectSubmission->delete();

        return Redirect::back()->with('success', 'Submission deleted successfully!');
    }
}
