<?php

namespace App\Http\Resources;

use Illuminate\Http\Request;
use Illuminate\Http\Resources\Json\JsonResource;
use Spatie\Permission\Models\Permission;

class UserResource extends JsonResource
{
    /**
     * Transform the resource into an array.
     *
     * @return array<string, mixed>
     */
    public function toArray(Request $request): array
    {
        return [
            'branch_id' => $this->branch_id,
            'id' => $this->id,
            'name' => $this->name,
            'email' => $this->email,
            'mobile' => $this->mobile,
            'first_name' => $this->first_name,
            'last_name' => $this->last_name,
            'gender' => $this->gender,
            'date_of_birth' => $this->date_of_birth,
            'address' => $this->address,
            'roles' => $this->getRoleNames(),
            'permissions' => $this->hasRole('Super Admin') || $this->hasRole('Developer') ?
                Permission::get()->pluck('name') :
                $this->getAllPermissions()->pluck('name'),
            'avatar' => $this->getFirstMediaUrl('avatar'),
            'media_urls' => $this->getMedia('avatar')->pluck('original_url')->toArray(),
        ];
    }
}
