<?php

namespace Database\Seeders;

use App\Models\Setting;
use Illuminate\Database\Seeder;

class SettingsSeeder extends Seeder
{
    /**
     * Run the database seeds.
     */
    public function run(): void
    {
        Setting::create([
            'company_name' => 'Cool Company',
            'company_email' => 'coolcompany@gmail.com',
            'company_mobile' => '1234567890',
            'company_address' => '123 Cool Street, Cool City, 12345',
            'vat_id' => '',
            'time_zone' => 'Asia/Dhaka',
            'date_format' => 'DD-MM-YYYY',
            'time_format' => '12H',
            'currency_position' => 'suffix_space',
            'currency_id' => 1,
        ]);
    }
}
