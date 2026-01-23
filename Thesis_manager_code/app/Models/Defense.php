<?php

namespace App\Models;

use App\Traits\AddLogOptions;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Relations\BelongsTo;
use Illuminate\Database\Eloquent\Relations\BelongsToMany;
use Illuminate\Support\Facades\Storage;
use Spatie\Activitylog\Traits\LogsActivity;

class Defense extends Model
{
    use AddLogOptions, LogsActivity;

    protected $guarded = [];

    protected $log_name = 'defenses';

    protected $casts = [
        'discussion_date' => 'datetime',
        'graded_at' => 'datetime',
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
            ->withPivot(['grade', 'feedback', 'graded_at'])
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

    /**
     * Get the maximum grade for this discussion type.
     */
    public function getMaxGrade(): float
    {
        return match($this->discussion_type) {
            'proposal' => 10,
            'seminar' => 10,
            'code' => 20,
            'final' => 60,
            default => 0,
        };
    }

    /**
     * Check if all members have submitted their grades.
     */
    public function isFullyGraded(): bool
    {
        $totalMembers = $this->members()->count();
        if ($totalMembers === 0) {
            return false;
        }

        $gradedMembers = $this->members()
            ->wherePivotNotNull('grade')
            ->count();

        return $totalMembers === $gradedMembers;
    }

    /**
     * Calculate and update the total grade.
     */
    public function calculateTotalGrade(): void
    {
        if (!$this->isFullyGraded()) {
            return;
        }

        $grades = $this->members()
            ->wherePivotNotNull('grade')
            ->pluck('defense_members.grade');

        if ($grades->isEmpty()) {
            return;
        }

        // Calculate average of all member grades
        $averageGrade = $grades->avg();
        
        // Update the defense with the total grade
        $this->update([
            'total_grade' => round($averageGrade, 2),
            'graded_at' => now(),
        ]);

        // Check if this is a code defense and trigger project type upgrade if needed
        if ($this->discussion_type === 'code' && $this->total_grade >= 12.5) {
            $this->upgradeProjectType();
        }
    }

    /**
     * Upgrade project type based on code defense grade.
     */
    public function upgradeProjectType(): void
    {
        $project = $this->project;
        
        $upgradeMap = [
            'Semester project' => 'Graduation 1',
            'Graduation 1' => 'Graduation 2',
            'Graduation 2' => 'Completed',
        ];

        $currentType = $project->project_type;
        
        if (isset($upgradeMap[$currentType])) {
            $newType = $upgradeMap[$currentType];
            
            // Archive or delete all project submissions before upgrading
            $this->archiveProjectFiles($project);
            
            // Update project type
            $project->update(['project_type' => $newType]);
        }
    }

    /**
     * Archive or delete project files when upgrading project type.
     */
    protected function archiveProjectFiles($project): void
    {
        $submissions = $project->submissions;
        
        foreach ($submissions as $submission) {
            // Delete the physical file if it exists
            if ($submission->file_path && \Storage::exists($submission->file_path)) {
                \Storage::delete($submission->file_path);
            }
            
            // Delete the submission record
            $submission->delete();
        }
    }

    /**
     * Get grade summary for this defense.
     */
    public function getGradeSummary(): array
    {
        $members = $this->members()
            ->withPivot(['grade', 'feedback', 'graded_at'])
            ->get();

        $summary = [
            'discussion_type' => $this->discussion_type,
            'max_grade' => $this->getMaxGrade(),
            'total_grade' => $this->total_grade,
            'is_fully_graded' => $this->isFullyGraded(),
            'graded_at' => $this->graded_at,
            'member_grades' => [],
        ];

        foreach ($members as $member) {
            $summary['member_grades'][] = [
                'member_id' => $member->id,
                'member_name' => $member->name,
                'grade' => $member->pivot->grade,
                'feedback' => $member->pivot->feedback,
                'graded_at' => $member->pivot->graded_at,
            ];
        }

        return $summary;
    }

    /**
     * Calculate total project grade from all defenses.
     */
    public static function calculateProjectTotalGrade($projectId): float
    {
        $defenses = self::where('project_id', $projectId)
            ->whereNotNull('total_grade')
            ->get();

        $totalGrade = 0;
        foreach ($defenses as $defense) {
            $totalGrade += $defense->total_grade ?? 0;
        }

        return round($totalGrade, 2);
    }
}
