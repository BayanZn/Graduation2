<?php

namespace App\Http\Controllers\Admin\Projects;

use App\Exports\ProjectsExport;
use App\Http\Controllers\Controller;
use App\Imports\ProjectsImport;
use App\Models\Department;
use App\Models\Project;
use App\Models\ProjectAssignment;
use App\Models\Specialization;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\Gate;
use Illuminate\Support\Facades\Redirect;
use Inertia\Inertia;
use Maatwebsite\Excel\Facades\Excel;

class ProjectsController extends Controller
{
    /**
     * Display a listing of the resource.
     */
    public function index()
    {
        abort_if(Gate::denies('view_projects'), 403);

        $per_page = request()->input('per_page') ?? 10;

        $projects = Project::query()
            ->with(['department', 'specialization', 'creator'])
            ->when(request()->input('search'), function ($query, $search) {
                return $query->where(function ($q) use ($search) {
                    $q->where('title', 'LIKE', '%'.$search.'%')
                        ->orWhere('project_type', 'LIKE', '%'.$search.'%');
                });
            })
            ->when(request()->input('department_id'), function ($query, $department_id) {
                return $query->where('department_id', $department_id);
            })
            ->when(request()->input('specialization_id'), function ($query, $specialization_id) {
                return $query->where('specialization_id', $specialization_id);
            })
            ->when(request()->input('project_type'), function ($query, $project_type) {
                return $query->where('project_type', $project_type);
            })
            ->latest()
            ->paginate($per_page)
            ->withQueryString();

        return Inertia::render('Admin/Projects/Index', [
            'projects' => $projects,
            'departments' => Department::all(['id', 'name']),
            'specializations' => Specialization::all(['id', 'name', 'department_id']),
            'filters' => request()->all('search', 'per_page', 'department_id', 'specialization_id', 'project_type'),
        ]);
    }

    /**
     * Display proposed projects.
     */
    public function proposed()
    {
        abort_if(Gate::denies('view_projects'), 403);

        $per_page = request()->input('per_page') ?? 10;

        $projects = Project::query()
            ->with(['department', 'specialization', 'creator'])
            ->where('status', 'Proposed')
            ->when(request()->input('search'), function ($query, $search) {
                return $query->where(function ($q) use ($search) {
                    $q->where('title', 'LIKE', '%'.$search.'%')
                        ->orWhere('project_type', 'LIKE', '%'.$search.'%');
                });
            })
            ->when(request()->input('department_id'), function ($query, $department_id) {
                return $query->where('department_id', $department_id);
            })
            ->when(request()->input('specialization_id'), function ($query, $specialization_id) {
                return $query->where('specialization_id', $specialization_id);
            })
            ->when(request()->input('project_type'), function ($query, $project_type) {
                return $query->where('project_type', $project_type);
            })
            ->latest()
            ->paginate($per_page)
            ->withQueryString();

        return Inertia::render('Admin/Projects/Proposed', [
            'projects' => $projects,
            'departments' => Department::all(['id', 'name']),
            'specializations' => Specialization::all(['id', 'name', 'department_id']),
            'filters' => request()->all('search', 'per_page', 'department_id', 'specialization_id', 'project_type'),
        ]);
    }

    /**
     * Display approved projects.
     */
    public function approved()
    {
        abort_if(Gate::denies('view_projects'), 403);

        $per_page = request()->input('per_page') ?? 10;

        $projects = Project::query()
            ->with(['department', 'specialization', 'creator'])
            ->where('status', 'Approved')
            ->when(request()->input('search'), function ($query, $search) {
                return $query->where(function ($q) use ($search) {
                    $q->where('title', 'LIKE', '%'.$search.'%')
                        ->orWhere('project_type', 'LIKE', '%'.$search.'%');
                });
            })
            ->when(request()->input('department_id'), function ($query, $department_id) {
                return $query->where('department_id', $department_id);
            })
            ->when(request()->input('specialization_id'), function ($query, $specialization_id) {
                return $query->where('specialization_id', $specialization_id);
            })
            ->when(request()->input('project_type'), function ($query, $project_type) {
                return $query->where('project_type', $project_type);
            })
            ->latest()
            ->paginate($per_page)
            ->withQueryString();

        return Inertia::render('Admin/Projects/Approved', [
            'projects' => $projects,
            'departments' => Department::all(['id', 'name']),
            'specializations' => Specialization::all(['id', 'name', 'department_id']),
            'filters' => request()->all('search', 'per_page', 'department_id', 'specialization_id', 'project_type'),
        ]);
    }

    /**
     * Display declined projects.
     */
    public function declined()
    {
        abort_if(Gate::denies('view_projects'), 403);

        $per_page = request()->input('per_page') ?? 10;

        $projects = Project::query()
            ->with(['department', 'specialization', 'creator'])
            ->where('status', 'Rejected')
            ->when(request()->input('search'), function ($query, $search) {
                return $query->where(function ($q) use ($search) {
                    $q->where('title', 'LIKE', '%'.$search.'%')
                        ->orWhere('project_type', 'LIKE', '%'.$search.'%');
                });
            })
            ->when(request()->input('department_id'), function ($query, $department_id) {
                return $query->where('department_id', $department_id);
            })
            ->when(request()->input('specialization_id'), function ($query, $specialization_id) {
                return $query->where('specialization_id', $specialization_id);
            })
            ->when(request()->input('project_type'), function ($query, $project_type) {
                return $query->where('project_type', $project_type);
            })
            ->latest()
            ->paginate($per_page)
            ->withQueryString();

        return Inertia::render('Admin/Projects/Declined', [
            'projects' => $projects,
            'departments' => Department::all(['id', 'name']),
            'specializations' => Specialization::all(['id', 'name', 'department_id']),
            'filters' => request()->all('search', 'per_page', 'department_id', 'specialization_id', 'project_type'),
        ]);
    }

    /**
     * Show the form for creating a new resource.
     */
    public function create()
    {
        abort_if(Gate::denies('create_projects'), 403);

        $departments = Department::all();
        $specializations = Specialization::all();

        return Inertia::render('Admin/Projects/Create', [
            'departments' => $departments,
            'specializations' => $specializations,
        ]);
    }

    /**
     * Store a newly created resource in storage.
     */
    public function store(Request $request)
    {
        abort_if(Gate::denies('create_projects'), 403);

        $request->validate([
            'title' => 'required|string|max:255|unique:projects,title',
            'description' => 'required|string',
            'project_type' => 'required|string|in:Semester,Graduation 1,Graduation 2',
            'specialization_id' => 'required|exists:specializations,id',
            'department_id' => 'required|exists:departments,id',
            'status' => 'nullable|string|in:Proposed,Approved,Rejected,Completed',
        ], [
            'title.unique' => 'A project with this title already exists. Please use a different title.',
        ]);

        Project::create([
            'title' => $request->title,
            'description' => $request->description,
            'project_type' => $request->project_type,
            'specialization_id' => $request->specialization_id,
            'department_id' => $request->department_id,
            'status' => $request->status ?? 'Proposed',
            'created_by' => Auth::id(),
        ]);

        return Redirect::route('projects.proposed');
    }

    /**
     * Display the specified resource.
     */
    public function show(Project $project)
    {
        abort_if(Gate::denies('view_projects'), 403);

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

        // Load all submissions for this project
        $submissions = $project->submissions()
            ->with(['uploadedBy:id,name,email', 'reviewer:id,name'])
            ->orderBy('created_at', 'desc')
            ->get();

        return Inertia::render('Admin/Projects/Show', [
            'project' => $project,
            'submissions' => $submissions,
        ]);
    }

    /**
     * Show the form for editing the specified resource.
     */
    public function edit(Project $project)
    {
        abort_if(Gate::denies('edit_projects'), 403);

        $departments = Department::all();
        $specializations = Specialization::all();

        return Inertia::render('Admin/Projects/Edit', [
            'project' => $project->load(['department', 'specialization']),
            'departments' => $departments,
            'specializations' => $specializations,
        ]);
    }

    /**
     * Update the specified resource in storage.
     */
    public function update(Request $request, Project $project)
    {
        abort_if(Gate::denies('edit_projects'), 403);

        $request->validate([
            'title' => 'required|string|max:255|unique:projects,title,'.$project->id,
            'description' => 'required|string',
            'project_type' => 'required|string|in:Semester,Graduation 1,Graduation 2',
            'specialization_id' => 'required|exists:specializations,id',
            'department_id' => 'required|exists:departments,id',
            'status' => 'nullable|string|in:Proposed,Approved,Rejected,Completed',
        ], [
            'title.unique' => 'A project with this title already exists. Please use a different title.',
        ]);

        $oldStatus = $project->status;
        $project->update([
            'title' => $request->title,
            'description' => $request->description,
            'project_type' => $request->project_type,
            'specialization_id' => $request->specialization_id,
            'department_id' => $request->department_id,
            'status' => $request->status,
        ]);

        // If project is approved and was previously proposed, check if creator is a supervisor
        if ($request->status === 'Approved' && $oldStatus === 'Proposed') {
            $creator = $project->creator;
            if ($creator && $creator->hasRole('supervisor')) {
                // Auto-assign the supervisor if not already assigned
                if (! $project->supervisors()->where('user_id', $creator->id)->exists()) {
                    ProjectAssignment::create([
                        'project_id' => $project->id,
                        'user_id' => $creator->id,
                        'role' => 'supervisor',
                        'assigned_by' => Auth::id(),
                        'assigned_at' => now(),
                    ]);
                }
            }
        }

        return Redirect::route('projects.proposed');
    }

    /**
     * Update the status of the specified resource.
     */
    public function updateStatus(Request $request, Project $project)
    {
        abort_if(Gate::denies('edit_projects'), 403);

        $request->validate([
            'status' => 'required|string|in:Proposed,Approved,Rejected,Completed',
        ]);

        $oldStatus = $project->status;
        $project->update([
            'status' => $request->status,
        ]);

        // If project is approved and was previously proposed, check if creator is a supervisor
        if ($request->status === 'Approved' && $oldStatus === 'Proposed') {
            $creator = $project->creator;
            if ($creator && $creator->hasRole('supervisor')) {
                // Auto-assign the supervisor if not already assigned
                if (! $project->supervisors()->where('user_id', $creator->id)->exists()) {
                    ProjectAssignment::create([
                        'project_id' => $project->id,
                        'user_id' => $creator->id,
                        'role' => 'supervisor',
                        'assigned_by' => Auth::id(),
                        'assigned_at' => now(),
                    ]);
                }
            }
        }

        return Redirect::back();
    }

    /**
     * Update the project type of the specified resource.
     */
    public function updateType(Request $request, Project $project)
    {
        abort_if(Gate::denies('edit_projects'), 403);

        $request->validate([
            'project_type' => 'required|string|in:Semester,Graduation 1,Graduation 2',
        ]);

        $project->update([
            'project_type' => $request->project_type,
        ]);

        return Redirect::back();
    }

    /**
     * Remove the specified resource from storage.
     */
    public function destroy(Project $project)
    {
        abort_if(Gate::denies('delete_projects'), 403);

        $project->delete();

        return Redirect::back();
    }

    /**
     * Export projects to Excel.
     */
    public function export()
    {
        abort_if(Gate::denies('view_projects'), 403);

        $filters = request()->only(['search']);

        return Excel::download(new ProjectsExport($filters), 'projects_'.now()->format('Y-m-d_H-i-s').'.xlsx');
    }

    /**
     * Import projects from Excel.
     */
    public function import(Request $request)
    {
        abort_if(Gate::denies('create_projects'), 403);

        $request->validate([
            'file' => 'required|mimes:xlsx,xls,csv',
        ]);

        try {
            $import = new ProjectsImport;
            Excel::import($import, $request->file('file'));

            $message = 'Projects imported successfully!';
            $type = 'success';

            // Check for errors or skipped rows
            if (! empty($import->errors) || ! empty($import->skipped)) {
                $errorMessages = [];

                if (! empty($import->errors)) {
                    $errorMessages[] = '<strong>Validation Errors:</strong><br>'.implode('<br>', array_slice($import->errors, 0, 5));
                    if (count($import->errors) > 5) {
                        $errorMessages[] = '... and '.(count($import->errors) - 5).' more errors';
                    }
                }

                if (! empty($import->skipped)) {
                    $errorMessages[] = '<strong>Skipped Rows:</strong><br>'.implode('<br>', array_slice($import->skipped, 0, 5));
                    if (count($import->skipped) > 5) {
                        $errorMessages[] = '... and '.(count($import->skipped) - 5).' more skipped';
                    }
                }

                $message = 'Import completed with issues:<br>'.implode('<br>', $errorMessages);
                $type = 'warning';
            }

            return Redirect::back()->with('message', [
                'type' => $type,
                'message' => $message,
            ]);
        } catch (\Exception $e) {
            return Redirect::back()->with('message', [
                'type' => 'error',
                'message' => 'Error importing projects: '.$e->getMessage(),
            ]);
        }
    }
}
