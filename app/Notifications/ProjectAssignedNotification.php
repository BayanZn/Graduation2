<?php

namespace App\Notifications;

use App\Models\Project;
use Illuminate\Bus\Queueable;
use Illuminate\Contracts\Queue\ShouldQueue;
use Illuminate\Notifications\Messages\MailMessage;
use Illuminate\Notifications\Notification;

class ProjectAssignedNotification extends Notification implements ShouldQueue
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
            ->subject('You Have Been Assigned to a Project')
            ->line('Congratulations! You have been assigned to a new project.')
            ->line('Project: '.$this->project->title)
            ->line('Type: '.$this->project->project_type)
            ->action('View Project', url('/student/assigned-projects/'.$this->project->id))
            ->line('You can now start working on your project and submit chapters.');
    }

    /**
     * Get the array representation of the notification.
     *
     * @return array<string, mixed>
     */
    public function toArray(object $notifiable): array
    {
        return [
            'type' => 'project_assigned',
            'title' => 'Project Assigned',
            'message' => 'You have been assigned to "'.$this->project->title.'"',
            'project_id' => $this->project->id,
            'project_title' => $this->project->title,
            'project_type' => $this->project->project_type,
            'url' => '/student/assigned-projects/'.$this->project->id,
            'icon' => 'ri-folder-add-line',
            'icon_color' => 'text-success',
        ];
    }
}
