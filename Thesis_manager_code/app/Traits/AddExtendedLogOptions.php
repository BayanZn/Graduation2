<?php

namespace App\Traits;

use Illuminate\Support\Facades\Auth;
use Spatie\Activitylog\LogOptions;

trait AddExtendedLogOptions
{
    public function getActivitylogOptions(): LogOptions
    {
        $options = LogOptions::defaults()
            ->useLogName($this->log_name ?? 'default');

        if (Auth::check()) {
            $options->setDescriptionForEvent(function ($eventName) {
                $user = Auth::user();
                $description = "ID#{$this->id} has been {$eventName} by {$user->name} ({$user->getRoleNames()->implode(', ')})";

                // Include changed fields with old and new values only for updates
                if ($eventName === 'updated') {
                    $changes = $this->getChanges(); // Changed attributes with new values
                    $original = $this->getOriginal(); // Original values

                    if (! empty($changes)) {
                        $changeDetails = [];
                        foreach ($changes as $field => $newValue) {
                            $oldValue = $original[$field] ?? null;
                            $changeDetails[] = "{$field}: '{$oldValue}' => '{$newValue}'";
                        }
                        $description .= '. Changes: '.implode(', ', $changeDetails);
                    }
                }

                return $description;
            });
        } else {
            $options->setDescriptionForEvent(function ($eventName) {
                $description = "ID#{$this->id} has been {$eventName} by Super Admin";

                // Include changed fields with old and new values only for updates
                if ($eventName === 'updated') {
                    $changes = $this->getChanges();
                    $original = $this->getOriginal();

                    if (! empty($changes)) {
                        $changeDetails = [];
                        foreach ($changes as $field => $newValue) {
                            $oldValue = $original[$field] ?? null;
                            $changeDetails[] = "{$field}: '{$oldValue}' => '{$newValue}'";
                        }
                        $description .= '. Changes: '.implode(', ', $changeDetails);
                    }
                }

                return $description;
            });
        }

        return $options;
    }
}
