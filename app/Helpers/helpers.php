<?php

use Carbon\Carbon;

if (! function_exists('settings')) {
    function settings(): object
    {
        return cache()->remember('settings', 24 * 60, function () {
            return new \App\Http\Resources\SettingsResource(\App\Models\Setting::firstOrFail());
        });
    }
}

if (! function_exists('settings')) {
    function settings(): object
    {
        return cache()->remember('settings', 24 * 60, function () {
            return new \App\Http\Resources\SettingsResource(\App\Models\Setting::firstOrFail());
        });
    }
}

if (! function_exists('make_reference_id')) {
    function make_reference_id($prefix, $number): string
    {
        return $prefix.'-'.date('y').'-'.str_pad($number, 5, 0, STR_PAD_LEFT);
    }
}

if (! function_exists('get_start_end_date')) {
    function get_start_end_date($date_range): array
    {
        $start_date = null;
        $end_date = null;

        if (request()->input('date_range')) {
            $start_date = Carbon::parse($date_range[0])->format('Y-m-d');
            if (! (request()->input('date_range')[1] == 'Invalid date')) {
                $end_date = Carbon::parse($date_range[1])->format('Y-m-d');
            } else {
                $end_date = Carbon::parse(today())->format('Y-m-d');
            }
        }

        return [$start_date, $end_date];
    }
}

if (! function_exists('format_currency')) {
    function format_currency($value, $format = true)
    {
        if (! $format) {
            return $value;
        }

        $settings = settings();
        $position = $settings->currency_position;
        $symbol = $settings->currency->symbol;
        $decimal_separator = $settings->currency->decimal_separator;
        $thousand_separator = $settings->currency->thousand_separator;
        $decimal_places = $settings->decimal_point == 1 ? 2 : 0; // Use decimal_point setting

        if ($position == 'prefix') {
            $formatted_value = $symbol.number_format((float) $value, $decimal_places, $decimal_separator, $thousand_separator);
        } elseif ($position == 'suffix') {
            $formatted_value = number_format((float) $value, $decimal_places, $decimal_separator, $thousand_separator).$symbol;
        } elseif ($position == 'suffix_space') {
            $formatted_value = number_format((float) $value, $decimal_places, $decimal_separator, $thousand_separator).' '.$symbol;
        } elseif ($position == 'prefix_space') {
            $formatted_value = $symbol.' '.number_format((float) $value, $decimal_places, $decimal_separator, $thousand_separator);
        } else {
            $formatted_value = $value;
        }

        return $formatted_value;
    }
}
