<?php

namespace App\Http\Controllers\Supervisor;

use App\Http\Controllers\Controller;
use App\Models\Department;
use App\Models\Project;
use App\Models\Specialization;
use App\Models\User;
use App\Notifications\ProjectProposedNotification;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\Notification;
use Illuminate\Support\Facades\Redirect;
use Inertia\Inertia;

class ProjectsController extends Controller
{
    /**
     * Display a listing of the resource.
     */
    public function index()
    {
        $per_page = request()->input('per_page') ?? 10;

        $projects = Project::query()
            ->with(['department', 'specialization', 'creator'])
            ->where('created_by', Auth::id())
            ->when(request()->has('search'), function ($query) {
                return $query
                    ->where('title', 'LIKE', '%'.request()->input('search').'%')
                    ->orWhere('project_type', 'LIKE', '%'.request()->input('search').'%');
            })
            ->latest()
            ->paginate($per_page)
            ->withQueryString();

        return Inertia::render('Supervisor/Projects/Index', [
            'projects' => $projects,
            'filters' => request()->all('search', 'per_page'),
        ]);
    }

    /**
     * Show the form for creating a new resource.
     */
    public function create()
    {
        $departments = Department::all();
        $specializations = Specialization::all();

        // If supervisor has a specialization, we might want to pre-select it or restrict it
        $userSpecializationId = Auth::user()->specialization_id;

        return Inertia::render('Supervisor/Projects/Create', [
            'departments' => $departments,
            'specializations' => $specializations,
            'user_specialization_id' => $userSpecializationId,
        ]);
    }

    /**
     * Store a newly created resource in storage.
     */
    public function store(Request $request)
    {
        $rules = [
            'title' => 'required|string|max:255|unique:projects,title',
            'description' => 'required|string',
            'project_type' => 'required|string|in:Semester,Graduation 1,Graduation 2',
            'specialization_id' => 'required|exists:specializations,id',
            'department_id' => 'required|exists:departments,id',
        ];

        if (Auth::user()->specialization_id) {
            $rules['specialization_id'] .= '|in:'.Auth::user()->specialization_id;
        }

        $request->validate($rules, [
            'title.unique' => 'A project with this title already exists. Please use a different title.',
            'specialization_id.in' => 'You can only propose projects for your own specialization.',
        ]);

        $project = Project::create([
            'title' => $request->title,
            'description' => $request->description,
            'project_type' => $request->project_type,
            'specialization_id' => $request->specialization_id,
            'department_id' => $request->department_id,
            'status' => 'Proposed',
            'created_by' => Auth::id(),
        ]);

        // Notify all admins about the new project proposal
        $admins = User::role('Admin')->get();
        Notification::send($admins, new ProjectProposedNotification($project));

        return Redirect::route('supervisor.projects.index');
    }

    /**
     * Display the specified resource.
     */
    public function show(Project $project)
    {
        abort_if($project->created_by !== Auth::id(), 403);

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

        return Inertia::render('Supervisor/Projects/Show', [
            'project' => $project,
        ]);
    }

    /**
     * Show the form for editing the specified resource.
     */
    public function edit(Project $project)
    {
        abort_if($project->created_by !== Auth::id(), 403);

        $departments = Department::all();
        $specializations = Specialization::all();
        $userSpecializationId = Auth::user()->specialization_id;

        $project->load(['department', 'specialization']);

        return Inertia::render('Supervisor/Projects/Edit', [
            'project' => $project,
            'departments' => $departments,
            'specializations' => $specializations,
            'user_specialization_id' => $userSpecializationId,
        ]);
    }

    /**
     * Update the specified resource in storage.
     */
    public function update(Request $request, Project $project)
    {
        abort_if($project->created_by !== Auth::id(), 403);

        $rules = [
            'title' => 'required|string|max:255|unique:projects,title,'.$project->id,
            'description' => 'required|string',
            'project_type' => 'required|string|in:Semester,Graduation 1,Graduation 2',
            'specialization_id' => 'required|exists:specializations,id',
            'department_id' => 'required|exists:departments,id',
        ];

        if (Auth::user()->specialization_id) {
            $rules['specialization_id'] .= '|in:'.Auth::user()->specialization_id;
        }

        $request->validate($rules, [
            'title.unique' => 'A project with this title already exists. Please use a different title.',
            'specialization_id.in' => 'You can only propose projects for your own specialization.',
        ]);

        $project->update([
            'title' => $request->title,
            'description' => $request->description,
            'project_type' => $request->project_type,
            'specialization_id' => $request->specialization_id,
            'department_id' => $request->department_id,
        ]);

        return Redirect::route('supervisor.projects.index');
    }

    /**
     * Remove the specified resource from storage.
     */
    public function destroy(Project $project)
    {
        abort_if($project->created_by !== Auth::id(), 403);

        $project->delete();

        return Redirect::route('supervisor.projects.index');
    }
}
