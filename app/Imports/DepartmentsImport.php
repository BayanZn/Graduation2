<?php

namespace App\Imports;

use App\Models\Department;
use Maatwebsite\Excel\Concerns\ToModel;
use Maatwebsite\Excel\Concerns\WithHeadingRow;
use Maatwebsite\Excel\Concerns\WithValidation;

class DepartmentsImport implements ToModel, WithHeadingRow, WithValidation
{
    /**
     * @return \Illuminate\Database\Eloquent\Model|null
     */
    public function model(array $row)
    {
        // Check if department already exists by short_name
        $existing = Department::where('short_name', $row['short_name'])->first();

        if ($existing) {
            return null; // Skip if already exists
        }

        return new Department([
            'short_name' => $row['short_name'],
            'name' => $row['name'],
        ]);
    }

    public function rules(): array
    {
        return [
            'short_name' => 'required|string|max:20',
            'name' => 'required|string|max:255',
        ];
    }
}
