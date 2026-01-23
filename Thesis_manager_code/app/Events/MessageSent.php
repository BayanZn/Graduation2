<?php

namespace App\Events;

use App\Models\Conversation;
use App\Models\Message;
use Illuminate\Broadcasting\InteractsWithSockets;
use Illuminate\Broadcasting\PrivateChannel;
use Illuminate\Contracts\Broadcasting\ShouldBroadcast;
use Illuminate\Foundation\Events\Dispatchable;
use Illuminate\Queue\SerializesModels;

class MessageSent implements ShouldBroadcast
{
    use Dispatchable, InteractsWithSockets, SerializesModels;

    public function __construct(public Message $message)
    {
        $this->message->loadMissing('sender:id,name', 'conversation');
    }

    public function broadcastOn(): array
    {
        $conversation = $this->message->conversation;

        if (!$conversation instanceof Conversation) {
            return [];
        }

        if ($conversation->isProjectGroup()) {
            return [
                new PrivateChannel("project-chat.{$conversation->project_id}"),
            ];
        }

        if ($conversation->isAdminSupport()) {
            return [
                new PrivateChannel("admin-support.{$conversation->id}"),
            ];
        }

        return [
            new PrivateChannel("conversation.{$conversation->id}"),
        ];
    }

    public function broadcastWith(): array
    {
        return [
            'id' => $this->message->id,
            'conversation_id' => $this->message->conversation_id,
            'sender_id' => $this->message->sender_id,
            'message' => $this->message->message,
            'type' => $this->message->type,
            'created_at' => $this->message->created_at?->toISOString(),
            'sender' => $this->message->sender ? [
                'id' => $this->message->sender->id,
                'name' => $this->message->sender->name,
            ] : null,
        ];
    }

    public function broadcastAs(): string
    {
        return 'MessageSent';
    }
}
