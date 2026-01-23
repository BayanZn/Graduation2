<?php

namespace App\Exports;

use App\Models\Department;
use Maatwebsite\Excel\Concerns\FromCollection;
use Maatwebsite\Excel\Concerns\ShouldAutoSize;
use Maatwebsite\Excel\Concerns\WithHeadings;
use Maatwebsite\Excel\Concerns\WithMapping;
use Maatwebsite\Excel\Concerns\WithStyles;
use PhpOffice\PhpSpreadsheet\Worksheet\Worksheet;

class DepartmentsExport implements FromCollection, ShouldAutoSize, WithHeadings, WithMapping, WithStyles
{
    protected $filters;

    public function __construct($filters = [])
    {
        $this->filters = $filters;
    }

    /**
     * @return \Illuminate\Support\Collection
     */
    public function collection()
    {
        $query = Department::query();

        // Apply search filter
        if (! empty($this->filters['search'])) {
            $query->where('name', 'LIKE', '%'.$this->filters['search'].'%');
        }

        return $query->latest()->get();
    }

    public function headings(): array
    {
        return [
            'ID',
            'Short Name',
            'Name',
            'Created At',
            'Updated At',
        ];
    }

    /**
     * @param  Department  $department
     */
    public function map($department): array
    {
        return [
            $department->id,
            $department->short_name,
            $department->name,
            $department->created_at->format('Y-m-d H:i:s'),
            $department->updated_at->format('Y-m-d H:i:s'),
        ];
    }

    /**
     * @return array
     */
    public function styles(Worksheet $sheet)
    {
        return [
            1 => ['font' => ['bold' => true]],
        ];
    }
}
