<?php

namespace App\Exports;

use Illuminate\Support\Collection;
use Maatwebsite\Excel\Concerns\FromCollection;
use Maatwebsite\Excel\Concerns\ShouldAutoSize;
use Maatwebsite\Excel\Concerns\WithHeadings;
use Maatwebsite\Excel\Concerns\WithMapping;
use Maatwebsite\Excel\Concerns\WithStyles;
use Maatwebsite\Excel\Concerns\WithTitle;
use PhpOffice\PhpSpreadsheet\Worksheet\Worksheet;

class EventCalendarExport implements FromCollection, ShouldAutoSize, WithHeadings, WithMapping, WithStyles, WithTitle
{
    protected Collection $events;

    protected string $month;

    protected string $year;

    public function __construct(Collection $events, string $month, string $year)
    {
        $this->events = $events;
        $this->month = $month;
        $this->year = $year;
    }

    /**
     * @return \Illuminate\Support\Collection
     */
    public function collection()
    {
        return $this->events;
    }

    /**
     * Define the headings for the export.
     */
    public function headings(): array
    {
        return [
            'No.',
            'Reference',
            'Event Date',
            'Event Day',
            'Event Time',
            'Client Name',
            'Mobile',
            'Event Type',
            'Event For',
            'Total Pax',
            'Status',
            'Note',
        ];
    }

    /**
     * Map the data for each row.
     */
    public function map($event): array
    {
        static $rowNumber = 0;
        $rowNumber++;

        $eventTime = $event->event_time ? \Carbon\Carbon::parse($event->event_time) : null;

        return [
            $rowNumber,
            $event->reference,
            $eventTime ? $eventTime->format('d/m/Y') : '—',
            $eventTime ? $eventTime->format('l') : '—',
            $eventTime ? $eventTime->format('h:i A') : '—',
            $event->customer->name ?? 'N/A',
            $event->customer->mobile ?? 'N/A',
            $event->eventType->name ?? 'N/A',
            $event->event_for ?? '—',
            $event->total_pax ?? '—',
            $event->status,
            strip_tags($event->note ?? ''),
        ];
    }

    /**
     * Apply styles to the worksheet.
     */
    public function styles(Worksheet $sheet)
    {
        return [
            // Style the first row (headers)
            1 => [
                'font' => ['bold' => true, 'size' => 12],
                'fill' => [
                    'fillType' => \PhpOffice\PhpSpreadsheet\Style\Fill::FILL_SOLID,
                    'startColor' => ['argb' => 'FFF3F4F6'],
                ],
                'alignment' => [
                    'horizontal' => \PhpOffice\PhpSpreadsheet\Style\Alignment::HORIZONTAL_CENTER,
                    'vertical' => \PhpOffice\PhpSpreadsheet\Style\Alignment::VERTICAL_CENTER,
                ],
            ],
        ];
    }

    /**
     * Set the title for the worksheet.
     */
    public function title(): string
    {
        $monthName = \Carbon\Carbon::createFromDate($this->year, $this->month, 1)->format('F');

        return "Event Calendar {$monthName} {$this->year}";
    }
}
