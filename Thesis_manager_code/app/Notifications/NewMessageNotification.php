<?php

namespace App\Notifications;

use App\Models\Conversation;
use App\Models\Message;
use Illuminate\Bus\Queueable;
use Illuminate\Contracts\Queue\ShouldQueue;
use Illuminate\Notifications\Messages\MailMessage;
use Illuminate\Notifications\Notification;

class NewMessageNotification extends Notification implements ShouldQueue
{
    use Queueable;

    /**
     * Create a new notification instance.
     */
    public function __construct(
        public Message $message,
        public Conversation $conversation
    ) {
    }

    /**
     * Get the notification's delivery channels.
     *
     * @return array<int, string>
     */
    public function via(object $notifiable): array
    {
        return ['database'];
    }

    /**
     * Get the mail representation of the notification.
     */
    public function toMail(object $notifiable): MailMessage
    {
        $sender = $this->message->sender;
        $conversationName = $this->conversation->name 
            ?? $this->conversation->project?->title 
            ?? 'Conversation';

        return (new MailMessage)
            ->subject('New Message from '.$sender->name)
            ->line('You have a new message in '.$conversationName)
            ->line('From: '.$sender->name)
            ->line('Message: '.substr($this->message->message, 0, 100).'...')
            ->action('View Message', url('/chat?conversation='.$this->conversation->id))
            ->line('Reply to continue the conversation.');
    }

    /**
     * Get the array representation of the notification.
     *
     * @return array<string, mixed>
     */
    public function toArray(object $notifiable): array
    {
        $sender = $this->message->sender;
        $conversationName = $this->conversation->name 
            ?? $this->conversation->project?->title 
            ?? 'Conversation';

        // Determine conversation type label
        $conversationType = match($this->conversation->type) {
            'project_group' => 'Project Chat',
            'admin_support' => 'Admin Support',
            'direct' => 'Direct Message',
            default => 'Chat',
        };

        return [
            'type' => 'new_message',
            'title' => 'New Message',
            'message' => $sender->name.' sent a message in '.$conversationName,
            'conversation_id' => $this->conversation->id,
            'conversation_name' => $conversationName,
            'conversation_type' => $conversationType,
            'message_id' => $this->message->id,
            'message_preview' => substr($this->message->message, 0, 100),
            'sender_id' => $sender->id,
            'sender_name' => $sender->name,
            'url' => '/chat?conversation='.$this->conversation->id,
            'icon' => 'ri-message-2-line',
            'icon_color' => 'text-primary',
        ];
    }
}