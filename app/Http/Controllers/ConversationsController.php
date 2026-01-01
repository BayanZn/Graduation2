<?php

namespace App\Http\Controllers;

use App\Models\Conversation;
use App\Models\Message;
use App\Models\Project;
use App\Models\User;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;
use Inertia\Inertia;

class ConversationsController extends Controller
{
    /**
     * Display a listing of user's conversations.
     */
    public function index(Request $request)
    {
        $user = Auth::user();

        $conversations = $user->conversations()
            ->orderByDesc('conversations.last_message_at')
            ->orderByDesc('conversations.updated_at')
            ->with([
                'project:id,title',
                'participants:id,name',
                'latestMessage' => function ($query) {
                    $query->limit(1)->with('sender:id,name');
                }
            ])
            ->get()
            ->map(function ($conversation) use ($user) {
                $latestMessage = $conversation->latestMessage->first();

                return [
                    'id' => $conversation->id,
                    'type' => $conversation->type,
                    'name' => $conversation->name ?? $conversation->project?->title ?? 'Conversation',
                    'project_id' => $conversation->project_id,
                    'last_message' => $latestMessage ? [
                        'text' => $latestMessage->message,
                        'sender' => $latestMessage->sender?->name,
                        'created_at' => $latestMessage->created_at,
                    ] : null,
                    'unread_count' => $conversation->pivot->unread_count,
                    'participants_count' => $conversation->participants->count(),
                    'last_message_at' => $conversation->last_message_at,
                ];
            });

        return response()->json([
            'conversations' => $conversations,
        ]);
    }

    /**
     * Display the specified conversation.
     */
    public function show(Conversation $conversation)
    {
        $user = Auth::user();

        // Check if user is a participant
        if (!$conversation->participants()->where('user_id', $user->id)->exists()) {
            abort(403, 'Unauthorized');
        }

        // Load conversation data
        $conversation->load([
            'project:id,title',
            'participants' => function ($query) {
                $query->select('users.id', 'users.name')
                    ->withPivot('role');
            }
        ]);

        // Get messages with pagination
        $messages = $conversation->messages()
            ->with('sender:id,name', 'reads.user:id,name')
            ->latest()
            ->take(50)
            ->get()
            ->reverse()
            ->values();

        // Reset unread count
        $conversation->resetUnreadCountFor($user);

        return response()->json([
            'conversation' => [
                'id' => $conversation->id,
                'type' => $conversation->type,
                'name' => $conversation->name ?? $conversation->project?->title ?? 'Conversation',
                'project_id' => $conversation->project_id,
                'participants' => $conversation->participants->map(function ($participant) {
                    return [
                        'id' => $participant->id,
                        'name' => $participant->name,
                        'role' => $participant->pivot->role,
                    ];
                }),
            ],
            'messages' => $messages,
        ]);
    }

    /**
     * Create a new project group conversation.
     */
    public function storeProjectChat(Request $request, Project $project)
    {
        $user = Auth::user();

        // Check if conversation already exists for this project
        $existingConversation = Conversation::where('project_id', $project->id)->first();

        if ($existingConversation) {
            return response()->json([
                'conversation' => $existingConversation,
                'message' => 'Conversation already exists',
            ]);
        }

        // Create conversation
        $conversation = Conversation::create([
            'type' => 'project_group',
            'project_id' => $project->id,
            'name' => $project->title . ' - Chat',
            'created_by' => $user->id,
        ]);

        // Add supervisor(s)
        foreach ($project->supervisors as $supervisor) {
            $conversation->addParticipant($supervisor, 'supervisor');
        }

        // Add students
        foreach ($project->students as $student) {
            $conversation->addParticipant($student, 'student');
        }

        // Post system message
        Message::create([
            'conversation_id' => $conversation->id,
            'sender_id' => null,
            'message' => 'Project chat created',
            'type' => 'system',
        ]);

        return response()->json([
            'conversation' => $conversation,
            'message' => 'Conversation created successfully',
        ], 201);
    }

    /**
     * Get or create admin support conversation.
     */
    public function getOrCreateAdminSupport()
    {
        $user = Auth::user();

        $conversation = Conversation::getOrCreateAdminSupport($user);

        // Load conversation data
        $conversation->load([
            'participants' => function ($query) {
                $query->select('users.id', 'users.name')
                    ->withPivot('role');
            }
        ]);

        return response()->json([
            'conversation' => [
                'id' => $conversation->id,
                'type' => $conversation->type,
                'name' => $conversation->name,
                'participants' => $conversation->participants->map(function ($participant) {
                    return [
                        'id' => $participant->id,
                        'name' => $participant->name,
                        'role' => $participant->pivot->role,
                    ];
                }),
            ],
        ]);
    }

    /**
     * Delete a conversation (Super Admin only).
     */
    public function destroy(Conversation $conversation)
    {
        $user = Auth::user();

        // Only Super Admins can delete conversations
        if (!$user->hasRole('Super Admin')) {
            abort(403, 'Unauthorized');
        }

        $conversation->delete();

        return response()->json([
            'message' => 'Conversation deleted successfully',
        ]);
    }
}
