<?php

namespace App\Http\Controllers\Student;

use App\Http\Controllers\Controller;
use App\Models\Project;
use App\Models\ProjectRequest;
use App\Models\User;
use App\Notifications\ProjectRequestNotification;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\Redirect;
use Inertia\Inertia;

class AvailableProjectsController extends Controller
{
    /**
     * Display a listing of available projects.
     */
    public function index()
    {
        // Check if student is already assigned to any project
        $hasAssignment = Auth::user()->assignments()
            ->where('role', 'student')
            ->exists();

        if ($hasAssignment) {
            return Inertia::render('Student/AvailableProjects/Index', [
                'projects' => null,
                'hasAssignment' => true,
                'filters' => request()->all('search', 'per_page'),
            ]);
        }

        $per_page = request()->input('per_page') ?? 10;

        $projects = Project::query()
            ->with(['department', 'specialization', 'creator', 'supervisors', 'students'])
            ->where('status', 'Approved')
            ->when(request()->has('search'), function ($query) {
                return $query
                    ->where('title', 'LIKE', '%'.request()->input('search').'%')
                    ->orWhere('project_type', 'LIKE', '%'.request()->input('search').'%');
            })
            ->withCount('students')
            ->latest()
            ->paginate($per_page)
            ->withQueryString();

        return Inertia::render('Student/AvailableProjects/Index', [
            'projects' => $projects,
            'hasAssignment' => false,
            'filters' => request()->all('search', 'per_page'),
        ]);
    }

    /**
     * Display the specified project.
     */
    public function show(Project $project)
    {
        abort_if($project->status !== 'Approved', 404);

        // Check if student is already assigned to any project
        $hasAssignment = Auth::user()->assignments()
            ->where('role', 'student')
            ->exists();

        if ($hasAssignment) {
            return Redirect::route('student.available-projects.index')
                ->with('error', 'You are already assigned to a project and cannot request another one.');
        }

        $project->load([
            'department',
            'specialization',
            'creator',
            'supervisors',
            'students',
        ]);

        // Check if student has already requested this project
        $existingRequest = ProjectRequest::where('project_id', $project->id)
            ->where('student_id', Auth::id())
            ->first();

        // Check if student is already assigned to this project
        $isAssigned = Auth::user()->assignments()
            ->where('project_id', $project->id)
            ->where('role', 'student')
            ->exists();

        // Get all students (excluding current user)
        $students = User::role('student')
            ->where('id', '!=', Auth::id())
            ->select('id', 'name', 'email')
            ->get();

        return Inertia::render('Student/AvailableProjects/Show', [
            'project' => $project,
            'existingRequest' => $existingRequest,
            'isAssigned' => $isAssigned,
            'students' => $students,
        ]);
    }

    /**
     * Store a project request.
     */
    public function requestProject(Request $request, Project $project)
    {
        abort_if($project->status !== 'Approved', 404);

        $validated = $request->validate([
            'request_type' => 'required|in:individual,group',
            'group_members' => 'required_if:request_type,group|array|min:1|max:2',
            'group_members.*' => 'exists:users,id|different:'.Auth::id(),
            'message' => 'nullable|string|max:500',
        ], [
            'group_members.required_if' => 'Please select at least one group member.',
            'group_members.max' => 'You can only select a maximum of 2 group members (3 students total including you).',
            'group_members.*.exists' => 'One or more selected students are invalid.',
            'group_members.*.different' => 'You cannot add yourself as a group member.',
        ]);

        // Check if student already has a pending request for this project
        $existingRequest = ProjectRequest::where('project_id', $project->id)
            ->where('student_id', Auth::id())
            ->where('status', 'pending')
            ->first();

        if ($existingRequest) {
            return Redirect::back()->with('error', 'You already have a pending request for this project.');
        }

        // Check if student is already assigned to this project
        $isAssigned = Auth::user()->assignments()
            ->where('project_id', $project->id)
            ->where('role', 'student')
            ->exists();

        if ($isAssigned) {
            return Redirect::back()->with('error', 'You are already assigned to this project.');
        }

        // Check if project would exceed 3 students if this request is approved
        $currentStudentCount = $project->students()->count();
        $requestedStudentCount = $validated['request_type'] === 'group' ? count($validated['group_members']) + 1 : 1;

        if ($currentStudentCount + $requestedStudentCount > 3) {
            return Redirect::back()->with('error', 'This project cannot accommodate your request as it would exceed the maximum of 3 students per project.');
        }

        $projectRequest = ProjectRequest::create([
            'project_id' => $project->id,
            'student_id' => Auth::id(),
            'request_type' => $validated['request_type'],
            'group_members' => $validated['request_type'] === 'group' ? $validated['group_members'] : null,
            'message' => $validated['message'] ?? null,
            'status' => 'pending',
        ]);

        // Load relationships for notification
        $projectRequest->load(['project', 'student']);

        // Notify all admins about the new project request
        $admins = User::role('admin')->get();
        foreach ($admins as $admin) {
            $admin->notify(new ProjectRequestNotification($projectRequest));
        }

        return Redirect::route('student.available-projects.index')
            ->with('success', 'Project request submitted successfully!');
    }
}
