<?php

namespace App\Http\Controllers\Supervisor;

use App\Http\Controllers\Controller;
use App\Models\Project;
use App\Models\ProjectSubmission;
use App\Notifications\SubmissionFeedbackNotification;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\Redirect;
use Inertia\Inertia;

class SupervisedProjectsController extends Controller
{
    public function index(Request $request)
    {
        $user = Auth::user();

        // Get projects where user is assigned as supervisor through project_assignments table
        $projects = Project::whereHas('assignments', function ($query) use ($user) {
            $query->where('user_id', $user->id)
                ->where('role', 'supervisor');
        })
            ->with(['department', 'specialization', 'creator'])
            ->when($request->search, function ($query, $search) {
                $query->where('title', 'like', "%{$search}%")
                    ->orWhere('description', 'like', "%{$search}%");
            })
            ->latest()
            ->paginate($request->per_page ?? 10)
            ->withQueryString();

        return Inertia::render('Supervisor/SupervisedProjects/Index', [
            'projects' => $projects,
            'filters' => $request->only(['search', 'per_page']),
        ]);
    }

    public function show(Project $project)
    {
        $user = Auth::user();

        // Verify that the user is a supervisor for this project
        $isSupervisor = $project->assignments()
            ->where('user_id', $user->id)
            ->where('role', 'supervisor')
            ->exists();

        abort_unless($isSupervisor, 403, 'Unauthorized access to this project.');

        $project->load([
            'department',
            'specialization',
            'creator',
            'supervisors.media',
            'students.media',
            'defenses.members',
        ]);

        // Load project submissions
        $submissions = $project->submissions()
            ->with(['uploadedBy:id,name,email', 'reviewer:id,name'])
            ->orderBy('created_at', 'desc')
            ->get();

        return Inertia::render('Supervisor/SupervisedProjects/Show', [
            'project' => $project,
            'submissions' => $submissions,
        ]);
    }

    /**
     * Update the project type.
     */
    public function updateType(Request $request, Project $project): \Illuminate\Http\RedirectResponse
    {
        $user = Auth::user();

        // Verify that the user is a supervisor for this project
        $isSupervisor = $project->assignments()
            ->where('user_id', $user->id)
            ->where('role', 'supervisor')
            ->exists();

        abort_unless($isSupervisor, 403, 'Unauthorized to update this project.');

        $request->validate([
            'project_type' => 'required|in:Semester,Graduation 1,Graduation 2',
        ]);

        $project->update([
            'project_type' => $request->project_type,
        ]);

        return Redirect::back()->with('success', 'Project type updated successfully!');
    }

    /**
     * Update submission status with feedback.
     */
    public function updateSubmissionStatus(Request $request, ProjectSubmission $projectSubmission): \Illuminate\Http\RedirectResponse
    {
        $user = Auth::user();

        // Verify supervisor has access to this project
        $hasAccess = $projectSubmission->project->assignments()
            ->where('user_id', $user->id)
            ->where('role', 'supervisor')
            ->exists();

        abort_unless($hasAccess, 403, 'Unauthorized action.');

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

        // Load relationships for notification
        $projectSubmission->load(['project', 'uploadedBy']);

        // Notify the student who uploaded this submission
        $projectSubmission->uploadedBy->notify(new SubmissionFeedbackNotification($projectSubmission));

        return Redirect::back()->with('success', 'Submission status updated successfully!');
    }
}
