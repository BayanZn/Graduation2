<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title>Event Calendar - {{ $monthName }} {{ $year }}</title>
    <style>
        body {
            font-family: 'Arial', sans-serif;
            font-size: 11px;
            margin: 0;
            padding: 20px;
        }

        h4 {
            margin: 0 0 5px 0;
            font-size: 16px;
        }

        h5 {
            font-size: 14px;
            margin: 0 0 10px 0;
            font-weight: normal;
        }

        p {
            margin: 0 0 3px 0;
            font-size: 11px;
        }

        table {
            border-collapse: collapse;
            width: 100%;
        }

        .bordered-table {
            border: 1px solid #ddd;
        }

        .bordered-table th,
        .bordered-table td {
            border: 1px solid #ddd;
            padding: 5px;
            font-size: 11px;
        }

        .bordered-table thead th {
            background-color: #f5f5f5;
            font-weight: bold;
            text-align: center;
        }

        .note-row {
            background-color: #fafafa;
        }

        .note-row td {
            padding: 8px;
            font-style: italic;
            color: #555;
        }

        .total-row {
            font-weight: bold;
        }
    </style>
    <script>
        window.onload = function() {
            window.print();
        };
    </script>
</head>

<body>
    <div style="width: 100%;">
        <!-- Header Section -->
        <table style="width: 100%; border: none; margin-bottom: 20px;">
            <tr>
                <td style="width: 50%; border: none; vertical-align: top;">
                    <img src="{{ asset('images/app-logo-v2.png') }}" alt="Logo" style="width: 80px; height: auto;">
                </td>
                <td style="width: 50%; border: none; vertical-align: top; text-align: left;">
                    <h4>{{ $settings->company_name }}</h4>
                    <p>{{ $settings->company_address }}</p>
                    <p>GST No: {{ $settings->vat_id }}</p>
                    <p>FUNXTREME {{ $currentBranch->address }}</p>
                    <p>Phone: {{ $currentBranch->phone }}</p>
                </td>
            </tr>
        </table>

        <!-- Title Section -->
        <table style="width: 100%; border: none; margin-bottom: 15px;">
            <tr>
                <td style="border: none; text-align: center;">
                    <h4>Event Calendar - {{ $monthName }} {{ $year }}</h4>
                </td>
            </tr>
        </table>

        <!-- Events Table -->
        <table class="bordered-table" style="width: 100%; margin-bottom: 20px;">
            <thead>
                <tr>
                    <th style="width: 5%;">No.</th>
                    <th style="width: 10%;">Reference</th>
                    <th style="width: 12%;">Event Date</th>
                    <th style="width: 8%;">Time</th>
                    <th style="width: 12%;">Client Name</th>
                    <th style="width: 10%;">Mobile</th>
                    <th style="width: 10%;">Event Type</th>
                    <th style="width: 10%;">Event For</th>
                    <th style="width: 8%;">Total Pax</th>
                    <th style="width: 10%;">Status</th>
                </tr>
            </thead>
            <tbody>
                @forelse ($events as $event)
                    <tr>
                        <td style="text-align: center;">{{ $loop->iteration }}</td>
                        <td style="text-align: center;">{{ $event->reference }}</td>
                        <td style="text-align: center;">
                            {{ $event->event_time ? \Carbon\Carbon::parse($event->event_time)->format('d/m/Y') : '—' }}
                        </td>
                        <td style="text-align: center;">
                            {{ $event->event_time ? \Carbon\Carbon::parse($event->event_time)->format('h:i A') : '—' }}
                        </td>
                        <td style="text-align: center;">{{ $event->customer->name ?? 'N/A' }}</td>
                        <td style="text-align: center;">{{ $event->customer->mobile ?? 'N/A' }}</td>
                        <td style="text-align: center;">{{ $event->eventType->name ?? 'N/A' }}</td>
                        <td style="text-align: center;">{{ $event->event_for ?? '—' }}</td>
                        <td style="text-align: center;">{{ $event->total_pax ?? '—' }}</td>
                        <td style="text-align: center;">{{ $event->status }}</td>
                    </tr>
                    @if ($event->note)
                        <tr class="note-row">
                            <td colspan="10" style="text-align: left;">
                                <strong>Note:</strong> {!! $event->note !!}
                            </td>
                        </tr>
                    @endif
                @empty
                    <tr>
                        <td colspan="10" style="text-align: center; padding: 20px;">
                            No events found for {{ $monthName }} {{ $year }}
                        </td>
                    </tr>
                @endforelse
            </tbody>
        </table>

        <!-- Footer -->
        <table style="width: 100%; border: none; margin-top: 20px;">
            <tr>
                <td style="border: none; text-align: left; font-size: 10px; color: #666;">
                    <p>Total Events: {{ $events->count() }}</p>
                    <p>Generated on: {{ \Carbon\Carbon::now()->format('d/m/Y h:i A') }}</p>
                </td>
            </tr>
        </table>
    </div>
</body>

</html>
