<?php

namespace App\Notifications;

use App\Models\Project;
use Illuminate\Bus\Queueable;
use Illuminate\Contracts\Queue\ShouldQueue;
use Illuminate\Notifications\Messages\MailMessage;
use Illuminate\Notifications\Notification;

class SupervisorAssignedNotification extends Notification implements ShouldQueue
{
    use Queueable;

    /**
     * Create a new notification instance.
     */
    public function __construct(
        public Project $project
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
            ->subject('You Have Been Assigned as Supervisor')
            ->line('You have been assigned as a supervisor to a project.')
            ->line('Project: '.$this->project->title)
            ->line('Type: '.$this->project->project_type)
            ->action('View Project', url('/supervisor/supervised-projects/'.$this->project->id))
            ->line('Please monitor student submissions and provide feedback.');
    }

    /**
     * Get the array representation of the notification.
     *
     * @return array<string, mixed>
     */
    public function toArray(object $notifiable): array
    {
        return [
            'type' => 'supervisor_assigned',
            'title' => 'New Supervision Assignment',
            'message' => 'You have been assigned as supervisor for "'.$this->project->title.'"',
            'project_id' => $this->project->id,
            'project_title' => $this->project->title,
            'project_type' => $this->project->project_type,
            'url' => '/supervisor/supervised-projects/'.$this->project->id,
            'icon' => 'ri-user-star-line',
            'icon_color' => 'text-primary',
        ];
    }
}
