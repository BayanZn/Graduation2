<?php

namespace App\Http\Controllers;

use App\Events\MessageSent;
use App\Models\Conversation;
use App\Models\Message;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;

class MessagesController extends Controller
{
    /**
     * Store a new message.
     */
    public function store(Request $request, Conversation $conversation)
    {
        $user = Auth::user();

        // Check if user is a participant
        if (!$conversation->participants()->where('user_id', $user->id)->exists()) {
            abort(403, 'Unauthorized');
        }

        $validated = $request->validate([
            'message' => 'required|string|max:5000',
            'type' => 'sometimes|in:text,file,system',
        ]);

        // Create message
        $message = Message::create([
            'conversation_id' => $conversation->id,
            'sender_id' => $user->id,
            'message' => $validated['message'],
            'type' => $validated['type'] ?? 'text',
        ]);

        // Update conversation last_message_at
        $conversation->update([
            'last_message_at' => now(),
        ]);

        // Increment unread count for other participants
        $conversation->incrementUnreadCountExcept($user);

        // Load sender relationship for response / broadcasting
        $message->load('sender:id,name');

        // Broadcast the message to other participants
        broadcast(new MessageSent($message))->toOthers();

        return response()->json([
            'message' => $message,
        ], 201);
    }

    /**
     * Mark messages as read.
     */
    public function markAsRead(Request $request, Conversation $conversation)
    {
        $user = Auth::user();

        // Check if user is a participant
        if (!$conversation->participants()->where('user_id', $user->id)->exists()) {
            abort(403, 'Unauthorized');
        }

        // Reset unread count
        $conversation->resetUnreadCountFor($user);

        // For group chats, mark individual messages as read
        if ($conversation->isProjectGroup()) {
            $messageIds = $request->input('message_ids', []);

            if (!empty($messageIds)) {
                $messages = Message::whereIn('id', $messageIds)
                    ->where('conversation_id', $conversation->id)
                    ->where('sender_id', '!=', $user->id)
                    ->get();

                foreach ($messages as $message) {
                    $message->markAsReadBy($user);
                }
            }
        }

        return response()->json([
            'message' => 'Messages marked as read',
        ]);
    }

    /**
     * Get older messages (pagination).
     */
    public function loadMore(Request $request, Conversation $conversation)
    {
        $user = Auth::user();

        // Check if user is a participant
        if (!$conversation->participants()->where('user_id', $user->id)->exists()) {
            abort(403, 'Unauthorized');
        }

        $beforeMessageId = $request->input('before_message_id');

        $messages = $conversation->messages()
            ->with('sender:id,name', 'reads.user:id,name')
            ->where('id', '<', $beforeMessageId)
            ->latest()
            ->take(50)
            ->get()
            ->reverse()
            ->values();

        return response()->json([
            'messages' => $messages,
        ]);
    }
}
