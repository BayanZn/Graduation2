<?php

namespace App\Models;

use App\Traits\AddLogOptions;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Relations\BelongsTo;
use Spatie\Activitylog\Traits\LogsActivity;

class Specialization extends Model
{
    use AddLogOptions, LogsActivity;

    protected $guarded = [];

    protected $log_name = 'specializations';
    
    protected $fillable = ['name', 'short_name'];
    protected $casts = [
        'chapters' => 'array',
    ];

    /**
     * Get the default chapters if no custom chapters are set.
     */
    
    public function getChaptersAttribute($value)
    {
        $chapters = json_decode($value, true);
        
        // Return custom chapters if set, otherwise return default
        if (!empty($chapters)) {
            return $chapters;
        }

        return [
            'Introduction',
            'Literature Review',
            'Methodology',
            'Result & Analysis',
            'Conclusion',
            'Abstract',
            'Full Draft',
        ];
    }

    /**
     * Get the department that owns the specialization.
     */
    public function department(): BelongsTo
    {
        return $this->belongsTo(Department::class);
    }
}