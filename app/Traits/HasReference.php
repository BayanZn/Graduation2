<?php

namespace App\Traits;

trait HasReference
{
    public static function bootHasReference()
    {
        static::creating(function ($model) {
            $number = $model::max('id') + 1;
            $model->reference = make_reference_id($model->getReferencePrefix(), $number);
        });

        static::updating(function ($model) {
            unset($model->reference);
        });
    }
}
