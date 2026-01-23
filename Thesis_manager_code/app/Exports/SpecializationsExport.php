<?php

namespace App\Exports;

use App\Models\Specialization;
use Maatwebsite\Excel\Concerns\FromCollection;
use Maatwebsite\Excel\Concerns\ShouldAutoSize;
use Maatwebsite\Excel\Concerns\WithHeadings;
use Maatwebsite\Excel\Concerns\WithMapping;
use Maatwebsite\Excel\Concerns\WithStyles;
use PhpOffice\PhpSpreadsheet\Worksheet\Worksheet;

class SpecializationsExport implements FromCollection, ShouldAutoSize, WithHeadings, WithMapping, WithStyles
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
        $query = Specialization::query()->with('department');

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
            'Department',
            'Short Name',
            'Name',
            'Created At',
            'Updated At',
        ];
    }

    /**
     * @param  Specialization  $specialization
     */
    public function map($specialization): array
    {
        return [
            $specialization->id,
            $specialization->department?->name,
            $specialization->short_name,
            $specialization->name,
            $specialization->created_at->format('Y-m-d H:i:s'),
            $specialization->updated_at->format('Y-m-d H:i:s'),
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
