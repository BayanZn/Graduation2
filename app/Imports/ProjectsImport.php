<?php

namespace App\Imports;

use App\Models\Department;
use App\Models\Project;
use App\Models\Specialization;
use Illuminate\Support\Facades\Auth;
use Maatwebsite\Excel\Concerns\SkipsOnError;
use Maatwebsite\Excel\Concerns\SkipsOnFailure;
use Maatwebsite\Excel\Concerns\ToModel;
use Maatwebsite\Excel\Concerns\WithHeadingRow;
use Maatwebsite\Excel\Concerns\WithValidation;
use Maatwebsite\Excel\Validators\Failure;

class ProjectsImport implements SkipsOnError, SkipsOnFailure, ToModel, WithHeadingRow, WithValidation
{
    public $errors = [];

    public $skipped = [];

    /**
     * @return \Illuminate\Database\Eloquent\Model|null
     */
    public function model(array $row)
    {
        // Find department by short_name
        $department = Department::where('short_name', $row['department_short_name'])->first();

        // Find specialization by short_name
        $specialization = Specialization::where('short_name', $row['specialization_short_name'])->first();

        if (! $department) {
            $this->skipped[] = "Row {$row['title']}: Department '{$row['department_short_name']}' not found";

            return null;
        }

        if (! $specialization) {
            $this->skipped[] = "Row {$row['title']}: Specialization '{$row['specialization_short_name']}' not found";

            return null;
        }

        return new Project([
            'title' => $row['title'],
            'description' => $row['description'],
            'project_type' => $row['project_type'],
            'status' => $row['status'] ?? 'Proposed',
            'department_id' => $department->id,
            'specialization_id' => $specialization->id,
            'created_by' => Auth::id(),
        ]);
    }

    public function rules(): array
    {
        return [
            'title' => 'required|string|max:255',
            'description' => 'required|string',
            'project_type' => 'required|in:Semester,Graduation 1,Graduation 2',
            'status' => 'nullable|in:Proposed,Approved,Rejected,Completed',
            'department_short_name' => 'required|string',
            'specialization_short_name' => 'required|string',
        ];
    }

    public function customValidationMessages(): array
    {
        return [
            'title.required' => 'Title is required',
            'description.required' => 'Description is required',
            'project_type.required' => 'Project type is required',
            'project_type.in' => 'Project type must be: Semester, Graduation 1, or Graduation 2',
            'status.in' => 'Status must be: Proposed, Approved, Rejected, or Completed',
            'department_short_name.required' => 'Department short name is required',
            'specialization_short_name.required' => 'Specialization short name is required',
        ];
    }

    public function onFailure(Failure ...$failures)
    {
        foreach ($failures as $failure) {
            $this->errors[] = "Row {$failure->row()}: ".implode(', ', $failure->errors());
        }
    }

    public function onError(\Throwable $e)
    {
        $this->errors[] = $e->getMessage();
    }
}
