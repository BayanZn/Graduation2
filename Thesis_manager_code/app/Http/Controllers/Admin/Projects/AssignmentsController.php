<?php

namespace App\Http\Controllers\Admin\Projects;

use App\Http\Controllers\Controller;
use App\Models\Project;
use App\Models\User;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Gate;
use Illuminate\Support\Facades\Redirect;
use Inertia\Inertia;

class AssignmentsController extends Controller
{
    /**
     * Display a listing of the resource.
     */
    public function index()
    {
        abort_if(Gate::denies('view_assignments'), 403);

        $per_page = request()->input('per_page') ?? 10;

        $projects = Project::with(['supervisors', 'students', 'department', 'specialization'])
            ->whereHas('assignments')
            ->when(request()->has('search'), function ($query) {
                return $query->where('title', 'LIKE', '%'.request()->input('search').'%');
            })
            ->latest()
            ->paginate($per_page)
            ->withQueryString();

        return Inertia::render('Admin/Projects/Assignments/Index', [
            'projects' => $projects,
            'filters' => request()->all('search', 'per_page'),
        ]);
    }

    /**
     * Show the form for creating a new resource.
     */
    public function create()
    {
        abort_if(Gate::denies('create_assignments'), 403);

        $projects = Project::where('status', 'Approved')
            ->whereDoesntHave('assignments')
            ->whereDoesntHave('requests')
            ->with(['department', 'specialization'])
            ->get();

        $supervisors = User::whereHas('roles', fn ($q) => $q->where('name', 'supervisor'))
            ->with('specialization:id,short_name')
            ->get();

        $students = User::whereHas('roles', fn ($q) => $q->where('name', 'student'))
            ->whereDoesntHave('projectAssignments')
            ->whereDoesntHave('projectRequests')
            ->with('specialization:id,short_name')
            ->get();

        return Inertia::render('Admin/Projects/Assignments/Create', [
            'projects' => $projects,
            'supervisors' => $supervisors,
            'students' => $students,
        ]);
    }

    /**
     * Store a newly created resource in storage.
     */
    public function store(Request $request)
    {
        abort_if(Gate::denies('create_assignments'), 403);

        $request->validate([
            'project_id' => 'required|exists:projects,id',
            'supervisors' => 'required|array|min:1|max:2',
            'supervisors.*' => 'exists:users,id',
            'students' => 'required|array|min:1|max:3',
            'students.*' => 'exists:users,id',
        ], [
            'students.max' => 'Project has reached the maximum of 3 students.',
            'supervisors.max' => 'Project can have at most 2 supervisors.',
        ]);

        $project = Project::findOrFail($request->project_id);

        // Assign supervisors
        foreach ($request->supervisors as $supervisorId) {
            $project->assignSupervisor($supervisorId);
        }

        // Assign students
        foreach ($request->students as $studentId) {
            $project->assignStudent($studentId);
        }

        return Redirect::route('assignments.index');
    }

    /**
     * Display the specified resource.
     */
    public function show(Project $project)
    {
        abort_if(Gate::denies('view_assignments'), 403);

        $project->load([
            'department',
            'specialization',
            'supervisors',
            'students',
            'defenses' => function ($query) {
                $query->with('members')->latest('discussion_date');
            },
        ]);

        return Inertia::render('Admin/Projects/Assignments/Show', [
            'project' => $project,
        ]);
    }

    /**
     * Show the form for editing the specified resource.
     */
    public function edit(Project $project)
    {
        abort_if(Gate::denies('edit_assignments'), 403);

        $project->load([
            'department',
            'specialization',
            'supervisors.specialization:id,short_name',
            'students.specialization:id,short_name',
        ]);

        $specializationId = $project->specialization_id;

        $allSupervisors = User::whereHas('roles', function ($query) {
                $query->where('name', 'supervisor');
            })
            ->where('specialization_id', $specializationId)
            ->with('specialization:id,short_name')
            ->get();

        $allStudents = User::whereHas('roles', function ($query) {
                $query->where('name', 'student');
            })
            ->where('specialization_id', $specializationId)
            ->with('specialization:id,short_name')
            ->get();

        return Inertia::render('Admin/Projects/Assignments/Edit', [
            'project' => $project,
            'allSupervisors' => $allSupervisors,
            'allStudents' => $allStudents,
        ]);
    }


    /**
     * Update the specified resource in storage.
     */
    public function update(Request $request, Project $project)
    {
        abort_if(Gate::denies('edit_assignments'), 403);

        $request->validate([
            'project_id' => 'required|exists:projects,id',
            'supervisors' => 'required|array|min:1|max:2',
            'supervisors.*' => 'exists:users,id',
            'students' => 'required|array|min:1|max:3',
            'students.*' => 'exists:users,id',
        ], [
            'students.max' => 'Project has reached the maximum of 3 students.',
            'supervisors.max' => 'Project can have at most 2 supervisors.',
        ]);

        // If project has changed, remove all assignments from old project first
        if ($project->id != $request->project_id) {
            $currentSupervisors = $project->supervisors->pluck('id')->toArray();
            $currentStudents = $project->students->pluck('id')->toArray();

            foreach ($currentSupervisors as $supervisorId) {
                $project->removeSupervisor($supervisorId);
            }

            foreach ($currentStudents as $studentId) {
                $project->removeStudent($studentId);
            }

            // Get the new project
            $project = Project::findOrFail($request->project_id);
        }

        // Sync supervisors
        $currentSupervisors = $project->supervisors->pluck('id')->toArray();
        $newSupervisors = $request->supervisors;

        // Remove supervisors not in the new list
        foreach ($currentSupervisors as $supervisorId) {
            if (! in_array($supervisorId, $newSupervisors)) {
                $project->removeSupervisor($supervisorId);
            }
        }

        // Add new supervisors
        foreach ($newSupervisors as $supervisorId) {
            $project->assignSupervisor($supervisorId);
        }

        // Sync students
        $currentStudents = $project->students->pluck('id')->toArray();
        $newStudents = $request->students;

        // Remove students not in the new list
        foreach ($currentStudents as $studentId) {
            if (! in_array($studentId, $newStudents)) {
                $project->removeStudent($studentId);
            }
        }

        // Add new students
        foreach ($newStudents as $studentId) {
            $project->assignStudent($studentId);
        }

        return Redirect::route('assignments.index');
    }

    /**
     * Remove the specified resource from storage.
     */
    public function destroy(Project $project)
    {
        abort_if(Gate::denies('delete_assignments'), 403);

        $project->assignments()->delete();

        return Redirect::route('assignments.index');
    }

    /**
     * Remove a supervisor from a project.
     */
    public function removeSupervisor(Project $project, User $user)
    {
        abort_if(Gate::denies('edit_assignments'), 403);

        $project->removeSupervisor($user->id);

        return Redirect::back();
    }

    /**
     * Remove a student from a project.
     */
    public function removeStudent(Project $project, User $user)
    {
        abort_if(Gate::denies('edit_assignments'), 403);

        $project->removeStudent($user->id);

        return Redirect::back();
    }
}
