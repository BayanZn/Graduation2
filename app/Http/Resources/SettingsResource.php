<?php

namespace App\Http\Resources;

use Illuminate\Http\Request;
use Illuminate\Http\Resources\Json\JsonResource;

class SettingsResource extends JsonResource
{
    /**
     * Transform the resource into an array.
     *
     * @return array<string, mixed>
     */
    public function toArray(Request $request): array
    {
        return [
            'id' => $this->id,
            'company_name' => $this->company_name,
            'company_email' => $this->company_email,
            'company_mobile' => $this->company_mobile,
            'company_address' => $this->company_address,
            'currency_id' => $this->currency_id,
            'currency_position' => $this->currency_position,
            'vat_id' => $this->vat_id,
            'tax_percentage' => $this->tax_percentage,
            'decimal_point' => $this->decimal_point,
            'currency' => $this->currency,
            'time_zone' => $this->time_zone,
            'time_format' => $this->time_format,
            'date_format' => $this->date_format,
            'logo' => $this->getFirstMediaUrl('logo'),
            'favicon' => $this->getFirstMediaUrl('favicon'),
        ];
    }
}
