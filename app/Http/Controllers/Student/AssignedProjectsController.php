<?php

namespace App\Http\Controllers\Student;

use App\Http\Controllers\Controller;
use App\Models\Project;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;
use Inertia\Inertia;

class AssignedProjectsController extends Controller
{
    /**
     * Display a listing of assigned projects.
     */
    public function index()
    {
        $user = Auth::user();
        $per_page = request()->input('per_page') ?? 10;

        // Get projects assigned to this student
        $assignedProjectIds = $user->assignments()
            ->where('role', 'student')
            ->pluck('project_id');

        $projects = Project::whereIn('id', $assignedProjectIds)
            ->with(['department', 'specialization', 'creator', 'supervisors', 'students'])
            ->when(request()->has('search'), function ($query) {
                return $query
                    ->where('title', 'LIKE', '%'.request()->input('search').'%')
                    ->orWhere('project_type', 'LIKE', '%'.request()->input('search').'%');
            })
            ->latest()
            ->paginate($per_page)
            ->withQueryString();

        return Inertia::render('Student/AssignedProjects/Index', [
            'projects' => $projects,
            'filters' => request()->all('search', 'per_page'),
        ]);
    }

    /**
     * Display the specified assigned project.
     */
    public function show(Project $project)
    {
        $user = Auth::user();

        // Ensure student can only view projects assigned to them
        $isAssigned = $user->assignments()
            ->where('role', 'student')
            ->where('project_id', $project->id)
            ->exists();

        abort_if(!$isAssigned, 403);

        $project->load([
            'department',
            'specialization',
            'creator',
            'supervisors',
            'students',
            'defenses' => function ($query) {
                $query->with('members')->latest('discussion_date');
            },
        ]);

        return Inertia::render('Student/AssignedProjects/Show', [
            'project' => $project,
        ]);
    }
}
