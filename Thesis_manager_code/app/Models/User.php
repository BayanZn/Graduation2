<?php

namespace App\Models;

// use Illuminate\Contracts\Auth\MustVerifyEmail;
use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Foundation\Auth\User as Authenticatable;
use Illuminate\Notifications\Notifiable;
use Laravel\Sanctum\HasApiTokens;
use Spatie\Activitylog\Traits\CausesActivity;
use Spatie\MediaLibrary\HasMedia;
use Spatie\MediaLibrary\InteractsWithMedia;
use Spatie\Permission\Traits\HasRoles;

class User extends Authenticatable implements HasMedia
{
    use CausesActivity, HasApiTokens, HasFactory, HasRoles, InteractsWithMedia, Notifiable;

    protected $with = ['roles', 'media'];

    /**
     * The attributes that are mass assignable.
     *
     * @var array<int, string>
     */
    protected $fillable = [
        'name',
        'email',
        'password',
        'mobile',
        'address',
        'gender',
        'first_name',
        'last_name',
        'date_of_birth',
        'specialization_id',
    ];

    /**
     * The attributes that should be hidden for serialization.
     *
     * @var array<int, string>
     */
    protected $hidden = [
        'password',
        'remember_token',
    ];

    /**
     * The attributes that should be cast.
     *
     * @var array<string, string>
     */
    protected $casts = [
        'email_verified_at' => 'datetime',
        'password' => 'hashed',
    ];

    public function registerMediaCollections(): void
    {
        $this->addMediaCollection('avatar')
            ->useFallbackUrl('https://www.gravatar.com/avatar/andfajk8230sdfma');
    }

    /**
     * Get the project assignments for the user.
     */
    public function assignments()
    {
        return $this->hasMany(ProjectAssignment::class);
    }

    /**
     * Get all conversations the user is participating in.
     */
    public function conversations()
    {
        return $this->belongsToMany(Conversation::class, 'conversation_participants')
            ->withPivot(['role', 'unread_count', 'last_read_at', 'joined_at'])
            ->withTimestamps()
            ->orderBy('last_message_at', 'desc');
    }

    /**
     * Get all messages sent by the user.
     */
    public function messages()
    {
        return $this->hasMany(Message::class, 'sender_id');
    }

    /**
     * Get the specialization that the user belongs to.
     */
    public function specialization()
    {
        return $this->belongsTo(Specialization::class);
    }
    public function projectAssignments()
    {
        return $this->hasMany(ProjectAssignment::class);
    }

    public function projectRequests()
    {
        return $this->hasMany(ProjectRequest::class, 'student_id');
    }
}
