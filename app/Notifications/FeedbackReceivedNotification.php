<?php

namespace App\Notifications;

use App\Models\ProjectSubmission;
use Illuminate\Bus\Queueable;
use Illuminate\Contracts\Queue\ShouldQueue;
use Illuminate\Notifications\Messages\MailMessage;
use Illuminate\Notifications\Notification;

class FeedbackReceivedNotification extends Notification implements ShouldQueue
{
    use Queueable;

    /**
     * Create a new notification instance.
     */
    public function __construct(
        public ProjectSubmission $submission
    ) {
    }

    /**
     * Get the notification's delivery channels.
     *
     * @return array<int, string>
     */
    public function via(object $notifiable): array
    {
        return ['database', 'mail'];
    }

    /**
     * Get the mail representation of the notification.
     */
    public function toMail(object $notifiable): MailMessage
    {
        $statusColor = match ($this->submission->status) {
            'approved' => 'success',
            'rejected' => 'error',
            default => 'info',
        };

        return (new MailMessage)
            ->subject('Supervisor Feedback Received')
            ->line('Your supervisor has reviewed your submission.')
            ->line('Project: '.$this->submission->project->title)
            ->line('Chapter: '.$this->submission->chapter_type)
            ->line('Status: '.ucfirst($this->submission->status))
            ->line('Reviewer: '.$this->submission->reviewer->name)
            ->action('View Feedback', url('/student/project-submissions?project_id='.$this->submission->project_id))
            ->line('Check the detailed feedback to improve your work.');
    }

    /**
     * Get the array representation of the notification.
     *
     * @return array<string, mixed>
     */
    public function toArray(object $notifiable): array
    {
        return [
            'type' => 'feedback_received',
            'title' => 'Supervisor Feedback Received',
            'message' => $this->submission->reviewer->name.' reviewed your '.$this->submission->chapter_type.' submission',
            'submission_id' => $this->submission->id,
            'project_id' => $this->submission->project_id,
            'project_title' => $this->submission->project->title,
            'chapter_type' => $this->submission->chapter_type,
            'status' => $this->submission->status,
            'supervisor_name' => $this->submission->reviewer->name,
            'url' => '/student/project-submissions?project_id='.$this->submission->project_id,
            'icon' => 'ri-message-3-line',
            'icon_color' => $this->submission->status === 'approved' ? 'text-success' : ($this->submission->status === 'rejected' ? 'text-danger' : 'text-warning'),
        ];
    }
}
