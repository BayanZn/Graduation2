<?php

use Illuminate\Support\Facades\Broadcast;

/*
|--------------------------------------------------------------------------
| Broadcast Channels
|--------------------------------------------------------------------------
|
| Here you may register all of the event broadcasting channels that your
| application supports. The given channel authorization callbacks are
| used to check if an authenticated user can listen to the channel.
|
*/

Broadcast::channel('App.Models.User.{id}', function ($user, $id) {
    return (int) $user->id === (int) $id;
});

// Project Group Chat Channel
Broadcast::channel('project-chat.{projectId}', function ($user, $projectId) {
    $project = \App\Models\Project::find($projectId);

    if (!$project) {
        return false;
    }

    // Check if user is supervisor or student of this project
    $isSupervisor = $project->supervisors()->where('user_id', $user->id)->exists();
    $isStudent = $project->students()->where('user_id', $user->id)->exists();

    if ($isSupervisor || $isStudent) {
        return [
            'id' => $user->id,
            'name' => $user->name,
            'role' => $isSupervisor ? 'supervisor' : 'student',
        ];
    }

    return false;
});

// Direct Conversation Channel
Broadcast::channel('conversation.{conversationId}', function ($user, $conversationId) {
    $conversation = \App\Models\Conversation::find($conversationId);

    if (!$conversation) {
        return false;
    }

    // Check if user is a participant
    $isParticipant = $conversation->participants()->where('user_id', $user->id)->exists();

    if ($isParticipant) {
        return [
            'id' => $user->id,
            'name' => $user->name,
        ];
    }

    return false;
});

// Admin Support Channel
Broadcast::channel('admin-support.{conversationId}', function ($user, $conversationId) {
    $conversation = \App\Models\Conversation::find($conversationId);

    if (!$conversation || $conversation->type !== 'admin_support') {
        return false;
    }

    // Check if user is a participant (either the user or a super admin)
    $isParticipant = $conversation->participants()->where('user_id', $user->id)->exists();

    if ($isParticipant) {
        $isSuperAdmin = $user->hasRole('Super Admin');
        return [
            'id' => $user->id,
            'name' => $user->name,
            'role' => $isSuperAdmin ? 'admin' : 'user',
        ];
    }

    return false;
});
