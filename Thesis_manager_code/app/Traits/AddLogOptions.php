<?php

namespace App\Traits;

use Illuminate\Support\Facades\Auth;
use Spatie\Activitylog\LogOptions;

trait AddLogOptions
{
    public function getActivitylogOptions(): LogOptions
    {
        if (Auth::check()) {
            return LogOptions::defaults()
                ->useLogName($this->log_name)
                ->setDescriptionForEvent(function ($eventName) {
                    return "ID#$this->id has been {$eventName} by ".Auth::user()->name.' '.Auth::user()->getRoleNames();
                });
        } else {
            return LogOptions::defaults()
                ->useLogName($this->log_name)
                ->setDescriptionForEvent(function ($eventName) {
                    return "ID#$this->id has been {$eventName} by ".'Super Admin';
                });
        }
    }
}
