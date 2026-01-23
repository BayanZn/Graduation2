<?php

namespace App\Models;

use App\Traits\AddLogOptions;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Relations\BelongsTo;
use Illuminate\Database\Eloquent\Relations\BelongsToMany;
use Illuminate\Database\Eloquent\Relations\HasMany;
use Illuminate\Support\Facades\Auth;
use Spatie\Activitylog\Traits\LogsActivity;

class Project extends Model
{
    use AddLogOptions, LogsActivity;

    protected $guarded = [];

    protected $log_name = 'projects';

    public function specialization(): BelongsTo
    {
        return $this->belongsTo(Specialization::class, 'specialization_id', 'id');
    }

    public function department(): BelongsTo
    {
        return $this->belongsTo(Department::class, 'department_id', 'id');
    }

    public function creator(): BelongsTo
    {
        return $this->belongsTo(User::class, 'created_by', 'id');
    }

    /**
     * Get all assignments for this project.
     */
    public function assignments(): HasMany
    {
        return $this->hasMany(ProjectAssignment::class);
    }

    /**
     * Get all supervisors assigned to this project.
     */
    public function supervisors(): BelongsToMany
    {
        return $this->belongsToMany(User::class, 'project_assignments')
            ->wherePivot('role', 'supervisor')
            ->withPivot(['assigned_by', 'assigned_at'])
            ->withTimestamps();
    }

    /**
     * Get all students assigned to this project.
     */
    public function students(): BelongsToMany
    {
        return $this->belongsToMany(User::class, 'project_assignments')
            ->wherePivot('role', 'student')
            ->withPivot(['assigned_by', 'assigned_at'])
            ->withTimestamps();
    }

    /**
     * Assign a supervisor to this project.
     */
    public function assignSupervisor($userId): void
    {
        // Check if supervisor is already assigned
        if ($this->supervisors()->where('user_id', $userId)->exists()) {
            return;
        }

        // Check if project already has 2 supervisors (max limit)
        if ($this->supervisors()->count() >= 2) {
            return;
        }

        ProjectAssignment::create([
            'project_id' => $this->id,
            'user_id' => $userId,
            'role' => 'supervisor',
            'assigned_by' => Auth::id(),
            'assigned_at' => now(),
        ]);
    }

    /**
     * Assign a student to this project.
     */
    public function assignStudent($userId): void
    {
        // Check if student is already assigned
        if ($this->students()->where('user_id', $userId)->exists()) {
            return;
        }

        // Check if project already has 3 students (max limit)
        if ($this->students()->count() >= 3) {
            return;
        }

        ProjectAssignment::create([
            'project_id' => $this->id,
            'user_id' => $userId,
            'role' => 'student',
            'assigned_by' => Auth::id(),
            'assigned_at' => now(),
        ]);
    }

    /**
     * Remove a supervisor from this project.
     */
    public function removeSupervisor($userId): void
    {
        ProjectAssignment::where('project_id', $this->id)
            ->where('user_id', $userId)
            ->where('role', 'supervisor')
            ->delete();
    }

    /**
     * Remove a student from this project.
     */
    public function removeStudent($userId): void
    {
        ProjectAssignment::where('project_id', $this->id)
            ->where('user_id', $userId)
            ->where('role', 'student')
            ->delete();
    }

    /**
     * Sync conversation participants with current project assignments.
     */
    public function syncConversationParticipants(): void
    {
        $conversation = Conversation::where('project_id', $this->id)
            ->where('type', 'project_group')
            ->first();

        // Get all current supervisors and students
        $supervisors = $this->supervisors()->get();
        $students = $this->students()->get();

        if (! $conversation) {
            // Only create if there are participants
            if ($supervisors->isEmpty() && $students->isEmpty()) {
                return;
            }

            $conversation = Conversation::create([
                'type' => 'project_group',
                'project_id' => $this->id,
                'name' => 'Project Group: '.$this->title,
                'created_by' => Auth::id(),
            ]);

            // Add a system message
            Message::create([
                'conversation_id' => $conversation->id,
                'sender_id' => null,
                'message' => 'Project group chat created for: '.$this->title,
                'type' => 'system',
            ]);
        }

        // Get current participants
        $currentParticipants = $conversation->participants()->pluck('user_id')->toArray();

        // Add new participants
        foreach ($supervisors as $supervisor) {
            if (! in_array($supervisor->id, $currentParticipants)) {
                $conversation->addParticipant($supervisor, 'supervisor');
            }
        }

        foreach ($students as $student) {
            if (! in_array($student->id, $currentParticipants)) {
                $conversation->addParticipant($student, 'student');
            }
        }

        // Remove participants who are no longer assigned
        $assignedUserIds = $supervisors->pluck('id')->merge($students->pluck('id'))->toArray();
        $participantsToRemove = array_diff($currentParticipants, $assignedUserIds);

        foreach ($participantsToRemove as $userId) {
            $user = User::find($userId);
            if ($user) {
                $conversation->removeParticipant($user);
            }
        }
    }

    /**
     * Check if the project has any assignments.
     */
    public function isAssigned(): bool
    {
        return $this->assignments()->exists();
    }

    /**
     * Check if the project is fully assigned (has both supervisors and students).
     */
    public function isFullyAssigned(): bool
    {
        return $this->supervisors()->exists() && $this->students()->exists();
    }

    /**
     * Get all defenses for this project.
     */
    public function defenses(): HasMany
    {
        return $this->hasMany(Defense::class);
    }

    /**
     * Get all submissions for this project.
     */
    public function submissions(): HasMany
    {
        return $this->hasMany(ProjectSubmission::class);
    }

    /**
     * Schedule a defense for this project.
     */
    public function scheduleDefense(array $data): Defense
    {
        return $this->defenses()->create(array_merge($data, [
            'created_by' => Auth::id(),
        ]));
    }

    /**
     * Check if the project has a defense of a specific type.
     */
    public function hasDefense(string $type): bool
    {
        return $this->defenses()->where('discussion_type', $type)->exists();
    }

    /**
     * Get the latest defense for this project.
     */
    public function latestDefense()
    {
        return $this->defenses()->latest('discussion_date')->first();
    }

    /**
     * Get defenses by type.
     */
    public function getDefenseByType(string $type)
    {
        return $this->defenses()->where('discussion_type', $type)->first();
    }
    public function requests()
    {
        return $this->hasMany(ProjectRequest::class);
    }
}
