<?php

namespace App\Http\Controllers\Admin\Projects;

use App\Exports\SpecializationsExport;
use App\Http\Controllers\Controller;
use App\Imports\SpecializationsImport;
use App\Models\Department;
use App\Models\Specialization;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Gate;
use Illuminate\Support\Facades\Redirect;
use Inertia\Inertia;
use Maatwebsite\Excel\Facades\Excel;

class SpecializationsController extends Controller
{
    /**
     * Display a listing of the resource.
     */
    public function index()
    {
        abort_if(Gate::denies('access_specializations'), 403);

        $per_page = request()->input('per_page') ?? 10;

        $specializations = Specialization::query()
            ->with('department')
            ->when(request()->has('search'), function ($query) {
                return $query
                    ->where('name', 'LIKE', '%'.request()->input('search').'%')
                    ->orWhere('short_name', 'LIKE', '%'.request()->input('search').'%');
            })
            ->paginate($per_page)
            ->withQueryString();

        $departments = Department::all(['id', 'name']);

        return Inertia::render('Admin/Projects/Specializations/Index', [
            'specializations' => $specializations,
            'departments' => $departments,
            'filters' => request()->all('search', 'per_page'),
        ]);
    }

    /**
     * Store a newly created resource in storage.
     */
    public function store(Request $request)
    {
        abort_if(Gate::denies('access_specializations'), 403);

        $request->validate([
            'department_id' => 'required|exists:departments,id',
            'short_name' => 'required|string|max:20|unique:specializations,short_name',
            'name' => 'required|string|max:255',
            'chapters' => 'nullable|array',
            'chapters.*' => 'required|string|max:100',
            'chapter_template' => 'nullable|file|mimes:pdf,doc,docx|max:10240',
        ]);

        $data = $request->only(['department_id', 'short_name', 'name', 'chapters']);

        // Handle template file upload
        if ($request->hasFile('chapter_template')) {
            $data['chapter_template_path'] = $request->file('chapter_template')->store('chapter-templates', 'public');
        }

        Specialization::create($data);

        return Redirect::route('specializations.index');
    }

    /**
     * Show the form for editing the specified resource.
     */
    public function edit(string $id)
    {
        abort_if(Gate::denies('access_specializations'), 403);

        $specialization = Specialization::findOrFail($id);

        return response()->json($specialization);
    }

    /**
     * Update the specified resource in storage.
     */
    public function update(Request $request, Specialization $specialization)
    {
        abort_if(Gate::denies('access_specializations'), 403);

        $request->validate([
            'department_id' => 'required|exists:departments,id',
            'short_name' => 'required|string|max:20|unique:specializations,short_name,'.$specialization->id,
            'name' => 'required|string|max:255',
            'chapters' => 'nullable|array',
            'chapters.*' => 'required|string|max:100',
            'chapter_template' => 'nullable|file|mimes:pdf,doc,docx|max:10240',
        ]);

        $data = $request->only(['department_id', 'short_name', 'name', 'chapters']);

        // Handle template file upload
        if ($request->hasFile('chapter_template')) {
            // Delete old template if exists
            if ($specialization->chapter_template_path && \Storage::disk('public')->exists($specialization->chapter_template_path)) {
                \Storage::disk('public')->delete($specialization->chapter_template_path);
            }
            $data['chapter_template_path'] = $request->file('chapter_template')->store('chapter-templates', 'public');
        }

        $specialization->update($data);

        return Redirect::route('specializations.index');
    }

    /**
     * Remove the specified resource from storage.
     */
    public function destroy(Specialization $specialization)
    {
        abort_if(Gate::denies('access_specializations'), 403);

        $specialization->delete();

        return Redirect::route('specializations.index');
    }

    /**
     * Export specializations to Excel.
     */
    public function export()
    {
        abort_if(Gate::denies('access_specializations'), 403);

        $filters = request()->only(['search']);

        return Excel::download(new SpecializationsExport($filters), 'specializations_'.now()->format('Y-m-d_H-i-s').'.xlsx');
    }

    /**
     * Import specializations from Excel.
     */
    public function import(Request $request)
    {
        abort_if(Gate::denies('access_specializations'), 403);

        $request->validate([
            'file' => 'required|mimes:xlsx,xls,csv',
        ]);

        try {
            Excel::import(new SpecializationsImport, $request->file('file'));

            return Redirect::back()->with('message', [
                'type' => 'success',
                'message' => 'Specializations imported successfully!',
            ]);
        } catch (\Exception $e) {
            return Redirect::back()->with('message', [
                'type' => 'error',
                'message' => 'Error importing specializations: '.$e->getMessage(),
            ]);
        }
    }
}
