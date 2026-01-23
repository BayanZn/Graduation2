<?php

namespace App\Http\Controllers\Admin\Projects;

use App\Exports\DepartmentsExport;
use App\Http\Controllers\Controller;
use App\Imports\DepartmentsImport;
use App\Models\Department;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Gate;
use Illuminate\Support\Facades\Redirect;
use Inertia\Inertia;
use Maatwebsite\Excel\Facades\Excel;

class DepartmentsController extends Controller
{
    /**
     * Display a listing of the resource.
     */
    public function index()
    {
        abort_if(Gate::denies('access_departments'), 403);

        $per_page = request()->input('per_page') ?? 10;

        $departments = Department::query()
            ->when(request()->has('search'), function ($query) {
                return $query
                    ->where('name', 'LIKE', '%'.request()->input('search').'%')
                    ->orWhere('short_name', 'LIKE', '%'.request()->input('search').'%');
            })
            ->paginate($per_page)
            ->withQueryString();

        return Inertia::render('Admin/Projects/Departments/Index', [
            'departments' => $departments,
            'filters' => request()->all('search', 'per_page'),
        ]);
    }

    /**
     * Store a newly created resource in storage.
     */
    public function store(Request $request)
    {
        abort_if(Gate::denies('access_departments'), 403);

        $request->validate([
            'short_name' => 'required|string|max:20|unique:departments,short_name',
            'name' => 'required|string|max:255',
        ]);

        Department::create($request->all());

        return Redirect::route('departments.index');
    }

    /**
     * Show the form for editing the specified resource.
     */
    public function edit(string $id)
    {
        abort_if(Gate::denies('access_departments'), 403);

        $department = Department::findOrFail($id);

        return response()->json($department);
    }

    /**
     * Update the specified resource in storage.
     */
    public function update(Request $request, Department $department)
    {
        abort_if(Gate::denies('access_departments'), 403);

        $request->validate([
            'short_name' => 'required|string|max:20|unique:departments,short_name,'.$department->id,
            'name' => 'required|string|max:255',
        ]);

        $department->update($request->all());

        return Redirect::route('departments.index');
    }

    /**
     * Remove the specified resource from storage.
     */
    public function destroy(Department $department)
    {
        abort_if(Gate::denies('access_departments'), 403);

        $department->delete();

        return Redirect::route('departments.index');
    }

    /**
     * Export departments to Excel.
     */
    public function export()
    {
        abort_if(Gate::denies('access_departments'), 403);

        $filters = request()->only(['search']);

        return Excel::download(new DepartmentsExport($filters), 'departments_'.now()->format('Y-m-d_H-i-s').'.xlsx');
    }

    /**
     * Import departments from Excel.
     */
    public function import(Request $request)
    {
        abort_if(Gate::denies('access_departments'), 403);

        $request->validate([
            'file' => 'required|mimes:xlsx,xls,csv',
        ]);

        try {
            Excel::import(new DepartmentsImport, $request->file('file'));

            return Redirect::back()->with('message', [
                'type' => 'success',
                'message' => 'Departments imported successfully!',
            ]);
        } catch (\Exception $e) {
            return Redirect::back()->with('message', [
                'type' => 'error',
                'message' => 'Error importing departments: '.$e->getMessage(),
            ]);
        }
    }
}
