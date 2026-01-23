<?php

namespace App\Models;

use App\Traits\AddLogOptions;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Relations\HasMany;
use Spatie\Activitylog\Traits\LogsActivity;

class Department extends Model
{
    use AddLogOptions, LogsActivity;

    protected $guarded = [];

    protected $log_name = 'departments';

    /**
     * Get the specializations for the department.
     */
    public function specializations(): HasMany
    {
        return $this->hasMany(Specialization::class);
    }
}
