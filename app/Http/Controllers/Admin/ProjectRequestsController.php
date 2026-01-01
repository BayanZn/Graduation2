<?php

namespace App\Http\Controllers\Admin;

use App\Http\Controllers\Controller;
use App\Models\Project;
use App\Models\ProjectAssignment;
use App\Models\ProjectRequest;
use App\Models\User;
use App\Notifications\ProjectAssignedNotification;
use App\Notifications\SupervisorAssignedNotification;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Redirect;
use Inertia\Inertia;

class ProjectRequestsController extends Controller
{
    /**
     * Display a listing of project requests.
     */
    public function index()
    {
        $per_page = request()->input('per_page') ?? 10;

        $requests = ProjectRequest::query()
            ->with(['project', 'student', 'reviewer'])
            ->when(request()->has('search'), function ($query) {
                return $query->whereHas('student', function ($q) {
                    $q->where('name', 'LIKE', '%'.request()->input('search').'%');
                })->orWhereHas('project', function ($q) {
                    $q->where('title', 'LIKE', '%'.request()->input('search').'%');
                });
            })
            ->when(request()->has('status'), function ($query) {
                return $query->where('status', request()->input('status'));
            })
            ->latest()
            ->paginate($per_page)
            ->withQueryString();

        return Inertia::render('Admin/ProjectRequests/Index', [
            'requests' => $requests,
            'filters' => request()->all('search', 'per_page', 'status'),
        ]);
    }

    /**
     * Display the specified project request.
     */
    public function show(ProjectRequest $projectRequest)
    {
        $projectRequest->load([
            'project.department',
            'project.specialization',
            'project.supervisors',
            'project.assignments.user',
            'student',
            'reviewer',
        ]);

        // Load group members if group request
        $groupMembers = [];
        if ($projectRequest->request_type === 'group' && $projectRequest->group_members) {
            $groupMembers = User::whereIn('id', $projectRequest->group_members)
                ->select('id', 'name', 'email')
                ->get();
        }

        // Get all supervisors for selection
        $supervisors = User::role('supervisor')
            ->select('id', 'name', 'email')
            ->get();

        return Inertia::render('Admin/ProjectRequests/Show', [
            'projectRequest' => $projectRequest,
            'groupMembers' => $groupMembers,
            'supervisors' => $supervisors,
        ]);
    }

    /**
     * Approve a project request and create assignments.
     */
    public function approve(Request $request, ProjectRequest $projectRequest)
    {
        if ($projectRequest->status !== 'pending') {
            return Redirect::back()->with('error', 'This request has already been processed.');
        }

        $validated = $request->validate([
            'supervisor_ids' => 'required|array|min:1',
            'supervisor_ids.*' => 'exists:users,id',
        ], [
            'supervisor_ids.required' => 'Please select at least one supervisor.',
            'supervisor_ids.*.exists' => 'One or more selected supervisors are invalid.',
        ]);

        DB::beginTransaction();
        try {
            // Update request status
            $projectRequest->update([
                'status' => 'approved',
                'reviewed_by' => Auth::id(),
                'reviewed_at' => now(),
            ]);

            $project = Project::find($projectRequest->project_id);

            // Create assignment for the requesting student
            ProjectAssignment::updateOrCreate([
                'project_id' => $projectRequest->project_id,
                'user_id' => $projectRequest->student_id,
                'role' => 'student',
            ]);

            // Notify the requesting student
            $projectRequest->student->notify(new ProjectAssignedNotification($project));

            // Create assignments for group members if group request
            if ($projectRequest->request_type === 'group' && $projectRequest->group_members) {
                foreach ($projectRequest->group_members as $memberId) {
                    ProjectAssignment::updateOrCreate([
                        'project_id' => $projectRequest->project_id,
                        'user_id' => $memberId,
                        'role' => 'student',
                    ]);

                    // Notify each group member
                    $member = User::find($memberId);
                    if ($member) {
                        $member->notify(new ProjectAssignedNotification($project));
                    }
                }
            }

            // Create assignments for supervisors
            foreach ($validated['supervisor_ids'] as $supervisorId) {
                ProjectAssignment::updateOrCreate([
                    'project_id' => $projectRequest->project_id,
                    'user_id' => $supervisorId,
                    'role' => 'supervisor',
                ]);

                // Notify each supervisor
                $supervisor = User::find($supervisorId);
                if ($supervisor) {
                    $supervisor->notify(new SupervisorAssignedNotification($project));
                }
            }

            DB::commit();

            return Redirect::route('project.requests.index')
                ->with('success', 'Project request approved and assignments created successfully!');
        } catch (\Exception $e) {
            DB::rollBack();
            \Log::error('Project request approval failed: '.$e->getMessage());

            return Redirect::back()->with('error', 'Failed to approve request: '.$e->getMessage());
        }
    }

    /**
     * Reject a project request.
     */
    public function reject(Request $request, ProjectRequest $projectRequest)
    {
        if ($projectRequest->status !== 'pending') {
            return Redirect::back()->with('error', 'This request has already been processed.');
        }

        $projectRequest->update([
            'status' => 'rejected',
            'reviewed_by' => Auth::id(),
            'reviewed_at' => now(),
        ]);

        return Redirect::route('project.requests.index')
            ->with('success', 'Project request rejected successfully.');
    }

    /**
     * Reset a rejected request back to pending.
     */
    public function resetToPending(ProjectRequest $projectRequest)
    {
        if ($projectRequest->status !== 'rejected') {
            return Redirect::back()->with('error', 'Only rejected requests can be reset to pending.');
        }

        $projectRequest->update([
            'status' => 'pending',
            'reviewed_by' => null,
            'reviewed_at' => null,
        ]);

        return Redirect::back()->with('success', 'Request has been reset to pending successfully.');
    }
}
