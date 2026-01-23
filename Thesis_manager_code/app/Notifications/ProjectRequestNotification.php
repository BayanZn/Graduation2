<?php

namespace App\Notifications;

use App\Models\ProjectRequest;
use Illuminate\Bus\Queueable;
use Illuminate\Contracts\Queue\ShouldQueue;
use Illuminate\Notifications\Messages\MailMessage;
use Illuminate\Notifications\Notification;

class ProjectRequestNotification extends Notification implements ShouldQueue
{
    use Queueable;

    /**
     * Create a new notification instance.
     */
    public function __construct(
        public ProjectRequest $projectRequest
    ) {
    }

    /**
     * Get the notification's delivery channels.
     *
     * @return array<int, string>
     */
    public function via(object $notifiable): array
    {
        return ['database', 'broadcast'];
    }

    /**
     * Get the broadcast representation of the notification.
     *
     * @return array<string, mixed>
     */
    public function toBroadcast(object $notifiable): array
    {
        return $this->toArray($notifiable);
    }

    /**
     * Get the mail representation of the notification.
     */
    public function toMail(object $notifiable): MailMessage
    {
        $requestType = ucfirst($this->projectRequest->request_type);
        $student = $this->projectRequest->student;

        return (new MailMessage)
            ->subject('New Project Request')
            ->line('A new project request has been submitted.')
            ->line('Student: '.$student->name)
            ->line('Project: '.$this->projectRequest->project->title)
            ->line('Request Type: '.$requestType)
            ->action('View Request', url('/admin/project-requests'))
            ->line('Please review the request at your earliest convenience.');
    }

    /**
     * Get the array representation of the notification.
     *
     * @return array<string, mixed>
     */
    public function toArray(object $notifiable): array
    {
        $groupSize = $this->projectRequest->request_type === 'group'
            ? (count($this->projectRequest->group_members ?? []) + 1)
            : 1;

        return [
            'type' => 'project_request',
            'title' => 'New Project Request',
            'message' => $this->projectRequest->student->name.' requested '.$this->projectRequest->project->title.' ('.$this->projectRequest->request_type.')',
            'request_id' => $this->projectRequest->id,
            'project_id' => $this->projectRequest->project_id,
            'project_title' => $this->projectRequest->project->title,
            'student_name' => $this->projectRequest->student->name,
            'request_type' => $this->projectRequest->request_type,
            'group_size' => $groupSize,
            'url' => '/admin/project-requests',
            'icon' => 'ri-user-add-line',
            'icon_color' => 'text-info',
        ];
    }
}
