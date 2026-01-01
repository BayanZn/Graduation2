<?php

namespace App\Models;

use App\Traits\AddLogOptions;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Relations\BelongsTo;
use Illuminate\Database\Eloquent\Relations\BelongsToMany;
use Spatie\Activitylog\Traits\LogsActivity;

class Defense extends Model
{
    use AddLogOptions, LogsActivity;

    protected $guarded = [];

    protected $log_name = 'defenses';

    protected $casts = [
        'discussion_date' => 'datetime',
    ];

    /**
     * Get the project that this defense belongs to.
     */
    public function project(): BelongsTo
    {
        return $this->belongsTo(Project::class);
    }

    /**
     * Get the user who created this defense.
     */
    public function creator(): BelongsTo
    {
        return $this->belongsTo(User::class, 'created_by');
    }

    /**
     * Get all members (supervisors) assigned to this defense.
     */
    public function members(): BelongsToMany
    {
        return $this->belongsToMany(User::class, 'defense_members')
            ->withTimestamps();
    }

    /**
     * Add a member (supervisor) to this defense.
     */
    public function addMember($userId): void
    {
        if (! $this->members()->where('user_id', $userId)->exists()) {
            $this->members()->attach($userId);
        }
    }

    /**
     * Remove a member from this defense.
     */
    public function removeMember($userId): void
    {
        $this->members()->detach($userId);
    }

    /**
     * Check if the defense is scheduled.
     */
    public function isScheduled(): bool
    {
        return $this->status === 'scheduled';
    }

    /**
     * Check if the defense is completed.
     */
    public function isCompleted(): bool
    {
        return $this->status === 'completed';
    }

    /**
     * Check if the defense is cancelled.
     */
    public function isCancelled(): bool
    {
        return $this->status === 'cancelled';
    }

    /**
     * Check if the defense can be modified.
     */
    public function canBeModified(): bool
    {
        return $this->status === 'scheduled';
    }

    /**
     * Mark the defense as completed.
     */
    public function markAsCompleted(): void
    {
        $this->update(['status' => 'completed']);
    }

    /**
     * Mark the defense as cancelled.
     */
    public function markAsCancelled(): void
    {
        $this->update(['status' => 'cancelled']);
    }

    /**
     * Scope a query to only include scheduled defenses.
     */
    public function scopeScheduled($query)
    {
        return $query->where('status', 'scheduled');
    }

    /**
     * Scope a query to only include completed defenses.
     */
    public function scopeCompleted($query)
    {
        return $query->where('status', 'completed');
    }

    /**
     * Scope a query to only include cancelled defenses.
     */
    public function scopeCancelled($query)
    {
        return $query->where('status', 'cancelled');
    }

    /**
     * Scope a query to filter by discussion type.
     */
    public function scopeOfType($query, $type)
    {
        return $query->where('discussion_type', $type);
    }
}
