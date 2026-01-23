<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Relations\BelongsTo;
use Illuminate\Database\Eloquent\Relations\BelongsToMany;
use Illuminate\Database\Eloquent\Relations\HasMany;

class Conversation extends Model
{
    protected $fillable = [
        'type',
        'project_id',
        'name',
        'last_message_at',
        'created_by',
    ];

    protected $casts = [
        'last_message_at' => 'datetime',
    ];

    /**
     * Get the project associated with this conversation.
     */
    public function project(): BelongsTo
    {
        return $this->belongsTo(Project::class);
    }

    /**
     * Get the creator of the conversation.
     */
    public function creator(): BelongsTo
    {
        return $this->belongsTo(User::class, 'created_by');
    }

    /**
     * Get all participants of the conversation.
     */
    public function participants(): BelongsToMany
    {
        return $this->belongsToMany(User::class, 'conversation_participants')
            ->withPivot(['role', 'unread_count', 'last_read_at', 'joined_at'])
            ->withTimestamps();
    }

    /**
     * Get all messages in the conversation.
     */
    public function messages(): HasMany
    {
        return $this->hasMany(Message::class)->orderBy('created_at', 'asc');
    }

    /**
     * Get the latest message in the conversation.
     */
    public function latestMessage(): HasMany
    {
        return $this->hasMany(Message::class)->latest();
    }

    /**
     * Scope a query to only include direct conversations.
     */
    public function scopeDirect($query)
    {
        return $query->where('type', 'direct');
    }

    /**
     * Scope a query to only include project group conversations.
     */
    public function scopeProjectGroup($query)
    {
        return $query->where('type', 'project_group');
    }

    /**
     * Check if conversation is a direct chat.
     */
    public function isDirectChat(): bool
    {
        return $this->type === 'direct';
    }

    /**
     * Check if conversation is a project group.
     */
    public function isProjectGroup(): bool
    {
        return $this->type === 'project_group';
    }

    /**
     * Scope a query to only include admin support conversations.
     */
    public function scopeAdminSupport($query)
    {
        return $query->where('type', 'admin_support');
    }

    /**
     * Check if conversation is admin support.
     */
    public function isAdminSupport(): bool
    {
        return $this->type === 'admin_support';
    }

    /**
     * Get or create an admin support conversation for a user.
     */
    public static function getOrCreateAdminSupport(User $user): self
    {
        // Find existing admin support conversation
        $conversation = self::where('type', 'admin_support')
            ->whereHas('participants', function ($query) use ($user) {
                $query->where('user_id', $user->id);
            })
            ->first();

        if ($conversation) {
            return $conversation;
        }

        // Create new admin support conversation
        $conversation = self::create([
            'type' => 'admin_support',
            'name' => 'Support Chat - ' . $user->name,
            'created_by' => $user->id,
        ]);

        // Add the user
        $conversation->addParticipant($user, 'user');

        // Add all super admins
        $superAdmins = User::role('Super Admin')->get();
        foreach ($superAdmins as $admin) {
            $conversation->addParticipant($admin, 'admin');
        }

        // Post system message
        Message::create([
            'conversation_id' => $conversation->id,
            'sender_id' => null,
            'message' => 'Support chat created. A Super Admin will assist you shortly.',
            'type' => 'system',
        ]);

        return $conversation;
    }

    /**
     * Add a participant to the conversation.
     */
    public function addParticipant(User $user, string $role = 'member'): void
    {
        $this->participants()->attach($user->id, [
            'role' => $role,
            'joined_at' => now(),
        ]);
    }

    /**
     * Remove a participant from the conversation.
     */
    public function removeParticipant(User $user): void
    {
        $this->participants()->detach($user->id);
    }

    /**
     * Get unread count for a specific user.
     */
    public function getUnreadCountFor(User $user): int
    {
        $participant = $this->participants()->where('user_id', $user->id)->first();

        return $participant?->pivot->unread_count ?? 0;
    }

    /**
     * Reset unread count for a specific user.
     */
    public function resetUnreadCountFor(User $user): void
    {
        $this->participants()->updateExistingPivot($user->id, [
            'unread_count' => 0,
            'last_read_at' => now(),
        ]);
    }

    /**
     * Increment unread count for all participants except sender.
     */
    public function incrementUnreadCountExcept(User $sender): void
    {
        $this->participants()
            ->where('user_id', '!=', $sender->id)
            ->increment('unread_count');
    }
}
