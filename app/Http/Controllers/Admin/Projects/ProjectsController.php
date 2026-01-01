<?php

namespace App\Http\Controllers\Admin\Projects;

use App\Exports\ProjectsExport;
use App\Http\Controllers\Controller;
use App\Imports\ProjectsImport;
use App\Models\Department;
use App\Models\Project;
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
            ->when(request()->has('search'), function ($query) {
                return $query
                    ->where('title', 'LIKE', '%'.request()->input('search').'%')
                    ->orWhere('project_type', 'LIKE', '%'.request()->input('search').'%');
            })
            ->latest()
            ->paginate($per_page)
            ->withQueryString();

        return Inertia::render('Admin/Projects/Index', [
            'projects' => $projects,
            'filters' => request()->all('search', 'per_page'),
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
            ->when(request()->has('search'), function ($query) {
                return $query
                    ->where('title', 'LIKE', '%'.request()->input('search').'%')
                    ->orWhere('project_type', 'LIKE', '%'.request()->input('search').'%');
            })
            ->latest()
            ->paginate($per_page)
            ->withQueryString();

        return Inertia::render('Admin/Projects/Proposed', [
            'projects' => $projects,
            'filters' => request()->all('search', 'per_page'),
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
            ->when(request()->has('search'), function ($query) {
                return $query
                    ->where('title', 'LIKE', '%'.request()->input('search').'%')
                    ->orWhere('project_type', 'LIKE', '%'.request()->input('search').'%');
            })
            ->latest()
            ->paginate($per_page)
            ->withQueryString();

        return Inertia::render('Admin/Projects/Approved', [
            'projects' => $projects,
            'filters' => request()->all('search', 'per_page'),
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
            ->when(request()->has('search'), function ($query) {
                return $query
                    ->where('title', 'LIKE', '%'.request()->input('search').'%')
                    ->orWhere('project_type', 'LIKE', '%'.request()->input('search').'%');
            })
            ->latest()
            ->paginate($per_page)
            ->withQueryString();

        return Inertia::render('Admin/Projects/Declined', [
            'projects' => $projects,
            'filters' => request()->all('search', 'per_page'),
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

        $project->update([
            'title' => $request->title,
            'description' => $request->description,
            'project_type' => $request->project_type,
            'specialization_id' => $request->specialization_id,
            'department_id' => $request->department_id,
            'status' => $request->status,
        ]);

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

        $project->update([
            'status' => $request->status,
        ]);

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
