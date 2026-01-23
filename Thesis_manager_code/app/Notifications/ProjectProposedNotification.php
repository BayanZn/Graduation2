<?php

namespace App\Notifications;

use App\Models\Project;
use Illuminate\Bus\Queueable;
use Illuminate\Contracts\Queue\ShouldQueue;
use Illuminate\Notifications\Messages\MailMessage;
use Illuminate\Notifications\Notification;

class ProjectProposedNotification extends Notification implements ShouldQueue
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
        $supervisor = $this->project->creator;

        return (new MailMessage)
            ->subject('New Project Idea Proposed')
            ->line('A new project idea has been proposed by a supervisor.')
            ->line('Supervisor: '.$supervisor->name)
            ->line('Project: '.$this->project->title)
            ->line('Type: '.$this->project->project_type)
            ->action('Review Project', url('/admin/projects/proposed'))
            ->line('Please review and approve or decline the project proposal.');
    }

    /**
     * Get the array representation of the notification.
     *
     * @return array<string, mixed>
     */
    public function toArray(object $notifiable): array
    {
        $supervisor = $this->project->creator;

        return [
            'type' => 'project_proposed',
            'title' => 'New Project Idea Proposed',
            'message' => $supervisor->name.' proposed "'.$this->project->title.'" for approval',
            'project_id' => $this->project->id,
            'project_title' => $this->project->title,
            'project_type' => $this->project->project_type,
            'supervisor_name' => $supervisor->name,
            'supervisor_id' => $supervisor->id,
            'url' => '/admin/projects/proposed',
            'icon' => 'ri-lightbulb-line',
            'icon_color' => 'text-warning',
        ];
    }
}