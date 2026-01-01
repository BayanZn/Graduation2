<?php

namespace App\Http\Controllers\Supervisor;

use App\Http\Controllers\Controller;
use App\Models\ProjectAssignment;
use App\Models\ProjectSubmission;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\Redirect;
use Inertia\Inertia;

class ProjectSubmissionsController extends Controller
{
    /**
     * Display a listing of submissions for supervisor's projects.
     */
    public function index()
    {
        // Get all projects supervised by this user
        $supervisedProjectIds = ProjectAssignment::where('user_id', Auth::id())
            ->where('role', 'supervisor')
            ->pluck('project_id');

        // Get all submissions for these projects
        $submissions = ProjectSubmission::whereIn('project_id', $supervisedProjectIds)
            ->with([
                'project:id,title',
                'uploadedBy:id,name,email',
                'reviewer:id,name',
            ])
            ->orderBy('created_at', 'desc')
            ->get();

        return Inertia::render('Supervisor/ProjectSubmissions/Index', [
            'submissions' => $submissions,
        ]);
    }

    /**
     * Display the specified submission.
     */
    public function show(ProjectSubmission $projectSubmission)
    {
        // Verify supervisor has access to this project
        $hasAccess = ProjectAssignment::where('user_id', Auth::id())
            ->where('role', 'supervisor')
            ->where('project_id', $projectSubmission->project_id)
            ->exists();

        if (! $hasAccess) {
            abort(403, 'Unauthorized action.');
        }

        $projectSubmission->load([
            'project:id,title',
            'uploadedBy:id,name,email',
            'reviewer:id,name',
        ]);

        return Inertia::render('Supervisor/ProjectSubmissions/Show', [
            'submission' => $projectSubmission,
        ]);
    }

    /**
     * Update the status of a submission (approve/reject with feedback).
     */
    public function updateStatus(Request $request, ProjectSubmission $projectSubmission)
    {
        // Verify supervisor has access to this project
        $hasAccess = ProjectAssignment::where('user_id', Auth::id())
            ->where('role', 'supervisor')
            ->where('project_id', $projectSubmission->project_id)
            ->exists();

        if (! $hasAccess) {
            abort(403, 'Unauthorized action.');
        }

        $request->validate([
            'status' => 'required|in:approved,rejected,pending',
            'supervisor_feedback' => 'nullable|string',
        ]);

        $projectSubmission->update([
            'status' => $request->status,
            'supervisor_feedback' => $request->supervisor_feedback,
            'reviewed_by' => Auth::id(),
            'reviewed_at' => now(),
        ]);

        return Redirect::back()->with('success', 'Submission status updated successfully!');
    }
}
