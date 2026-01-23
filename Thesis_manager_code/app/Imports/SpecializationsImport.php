<?php

namespace App\Imports;

use App\Models\Specialization;
use Maatwebsite\Excel\Concerns\ToModel;
use Maatwebsite\Excel\Concerns\WithHeadingRow;
use Maatwebsite\Excel\Concerns\WithValidation;

class SpecializationsImport implements ToModel, WithHeadingRow, WithValidation
{
    /**
     * @return \Illuminate\Database\Eloquent\Model|null
     */
    public function model(array $row)
    {
        // Check if specialization already exists by short_name
        $existing = Specialization::where('short_name', $row['short_name'])->first();

        if ($existing) {
            return null; // Skip if already exists
        }

        return new Specialization([
            'department_id' => $row['department_id'],
            'short_name' => $row['short_name'],
            'name' => $row['name'],
        ]);
    }

    public function rules(): array
    {
        return [
            'department_id' => 'required|exists:departments,id',
            'short_name' => 'required|string|max:20',
            'name' => 'required|string|max:255',
        ];
    }
}
