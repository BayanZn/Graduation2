<?php

namespace App\Models;

use App\Traits\AddLogOptions;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Relations\BelongsTo;
use Spatie\Activitylog\Traits\LogsActivity;

class ProjectRequest extends Model
{
    use AddLogOptions, LogsActivity;

    protected $guarded = [];

    protected $log_name = 'project_requests';

    protected $casts = [
        'group_members' => 'array',
        'reviewed_at' => 'datetime',
    ];

    public function project(): BelongsTo
    {
        return $this->belongsTo(Project::class);
    }

    public function student(): BelongsTo
    {
        return $this->belongsTo(User::class, 'student_id');
    }

    public function reviewer(): BelongsTo
    {
        return $this->belongsTo(User::class, 'reviewed_by');
    }
}
