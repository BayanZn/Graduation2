<?php

namespace App\Notifications;

use App\Models\Defense;
use Illuminate\Bus\Queueable;
use Illuminate\Contracts\Queue\ShouldQueue;
use Illuminate\Notifications\Messages\MailMessage;
use Illuminate\Notifications\Notification;

class DefenseScheduledNotification extends Notification implements ShouldQueue
{
    use Queueable;

    /**
     * Create a new notification instance.
     */
    public function __construct(
        public Defense $defense
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
        return (new MailMessage)
            ->subject('Defense Scheduled')
            ->line('A defense has been scheduled for your project.')
            ->line('Project: '.$this->defense->project->title)
            ->line('Type: '.$this->defense->discussion_type)
            ->line('Hall: '.$this->defense->discussion_hall)
            ->line('Date: '.$this->defense->discussion_date->format('F d, Y H:i'))
            ->action('View Details', url('/defenses/'.$this->defense->id))
            ->line('Please prepare accordingly.');
    }

    /**
     * Get the array representation of the notification.
     *
     * @return array<string, mixed>
     */
    public function toArray(object $notifiable): array
    {
        return [
            'type' => 'defense_scheduled',
            'title' => 'Defense Scheduled',
            'message' => $this->defense->discussion_type.' defense scheduled for "'.$this->defense->project->title.'" on '.$this->defense->discussion_date->format('M d, Y'),
            'defense_id' => $this->defense->id,
            'project_id' => $this->defense->project_id,
            'project_title' => $this->defense->project->title,
            'discussion_type' => $this->defense->discussion_type,
            'discussion_date' => $this->defense->discussion_date->format('Y-m-d H:i:s'),
            'discussion_hall' => $this->defense->discussion_hall,
            'url' => '/defenses/'.$this->defense->id,
            'icon' => 'ri-calendar-event-line',
            'icon_color' => 'text-info',
        ];
    }
}
