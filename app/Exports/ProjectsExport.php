<?php

namespace App\Exports;

use App\Models\Project;
use Maatwebsite\Excel\Concerns\FromCollection;
use Maatwebsite\Excel\Concerns\ShouldAutoSize;
use Maatwebsite\Excel\Concerns\WithHeadings;
use Maatwebsite\Excel\Concerns\WithMapping;
use Maatwebsite\Excel\Concerns\WithStyles;
use PhpOffice\PhpSpreadsheet\Worksheet\Worksheet;

class ProjectsExport implements FromCollection, ShouldAutoSize, WithHeadings, WithMapping, WithStyles
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
        $query = Project::with(['department', 'specialization', 'creator']);

        // Apply search filter
        if (! empty($this->filters['search'])) {
            $query->where(function ($q) {
                $q->where('title', 'LIKE', '%'.$this->filters['search'].'%')
                    ->orWhere('project_type', 'LIKE', '%'.$this->filters['search'].'%');
            });
        }

        return $query->latest()->get();
    }

    public function headings(): array
    {
        return [
            'ID',
            'Title',
            'Description',
            'Project Type',
            'Status',
            'Department Short Name',
            'Specialization Short Name',
            'Created By',
            'Created At',
        ];
    }

    /**
     * @param  Project  $project
     */
    public function map($project): array
    {
        return [
            $project->id,
            $project->title,
            strip_tags($project->description),
            $project->project_type,
            $project->status,
            $project->department->short_name ?? 'N/A',
            $project->specialization->short_name ?? 'N/A',
            $project->creator->name ?? 'N/A',
            $project->created_at->format('Y-m-d H:i:s'),
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
