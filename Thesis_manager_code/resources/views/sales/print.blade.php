<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title>Sale#{{ $sale->reference }}</title>
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

        <!-- Sale Info Table -->
        <table class="bordered-table" style="width: 100%; margin-bottom: 10px;">
            <tbody>
                <tr>
                    <th style="width: 20%; text-align: left; background-color: #f5f5f5;">Reference</th>
                    <td style="width: 30%; text-align: left;">{{ $sale->reference }}</td>
                    <th style="width: 20%; text-align: left; background-color: #f5f5f5;">Status</th>
                    <td style="width: 30%; text-align: left;">{{ $sale->status }}</td>
                </tr>
                <tr>
                    <th style="text-align: left; background-color: #f5f5f5;">Client Name</th>
                    <td>{{ $sale->customer->name }}</td>
                    <th style="text-align: left; background-color: #f5f5f5;">Mobile No.</th>
                    <td>{{ $sale->customer->mobile }}</td>
                </tr>
                <tr>
                    <th style="text-align: left; background-color: #f5f5f5;">Created at</th>
                    <td colspan="3">{{ \Carbon\Carbon::parse($sale->created_at)->format('d/m/Y h:i A') }}</td>
                </tr>
            </tbody>
        </table>

        <!-- Products Table -->
        <table class="bordered-table" style="width: 100%; margin-bottom: 20px;">
            <thead>
                <tr>
                    <th>No.</th>
                    <th>Item</th>
                    <th>Price</th>
                    <th>Qty</th>
                    <th>Tax</th>
                    <th>Tax Total</th>
                    <th>Sub Total</th>
                </tr>
            </thead>
            <tbody>
                @foreach ($sale->products as $item)
                    <tr>
                        <td style="text-align: center; width: 30px;">{{ $loop->iteration }}</td>
                        <td style="text-align: center;">{{ $item->product->name }}</td>
                        <td style="text-align: center;">
                            {{ format_currency($item->unit_price) }}
                        </td>
                        <td style="text-align: center;">{{ $item->quantity }}
                            {{ $item->product->unit->short_name ?? '' }}</td>
                        <td style="text-align: center;">{{ $item->tax_rate }}%</td>
                        <td style="text-align: center;">
                            {{ format_currency($item->tax_amount) }}
                        </td>
                        <td style="text-align: center;">
                            {{ format_currency($item->sub_total) }}
                        </td>
                    </tr>
                @endforeach
            </tbody>
        </table>

        <!-- Summary Section -->
        <table style="width: 100%; border: none; margin-top: 20px;">
            <tr>
                <td style="width: 70%; border: none; vertical-align: top;">
                    <h5><strong>Note</strong></h5>
                    <div style="font-size: 11px; line-height: 1.6;">
                        {!! $sale->note ?? '<p>No notes available</p>' !!}
                    </div>
                </td>
                <td style="width: 30%; border: none; vertical-align: top;">
                    <table class="bordered-table" style="width: 100%;">
                        <tbody>
                            <tr>
                                <th style="text-align: left;">Sub Total</th>
                                <td style="text-align: right;">
                                    {{ format_currency($sale->sub_total) }}
                                </td>
                            </tr>
                            <tr>
                                <th style="text-align: left;">Tax Total</th>
                                <td style="text-align: right;">
                                    {{ format_currency($sale->tax_amount) }}
                                </td>
                            </tr>
                            <tr>
                                <th style="text-align: left;">Discount</th>
                                <td style="text-align: right;">
                                    {{ format_currency($sale->total_discount_amount) }}
                                </td>
                            </tr>
                            <tr class="total-row">
                                <th style="text-align: left;">Total</th>
                                <td style="text-align: right;">
                                    {{ format_currency($sale->total) }}
                                </td>
                            </tr>
                            <tr>
                                <th style="text-align: left;">Paid</th>
                                <td style="text-align: right;">
                                    {{ format_currency($sale->paid) }}
                                </td>
                            </tr>
                            <tr class="total-row">
                                <th style="text-align: left;">Due</th>
                                <td style="text-align: right;">
                                    {{ format_currency($sale->due) }}
                                </td>
                            </tr>
                        </tbody>
                    </table>
                </td>
            </tr>
        </table>
    </div>
</body>

</html>
