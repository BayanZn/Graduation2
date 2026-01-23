<?php

namespace App\Notifications;

use App\Models\ProjectSubmission;
use Illuminate\Bus\Queueable;
use Illuminate\Contracts\Queue\ShouldQueue;
use Illuminate\Notifications\Messages\MailMessage;
use Illuminate\Notifications\Notification;

class SubmissionFeedbackNotification extends Notification implements ShouldQueue
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
        return ['database'];
    }

    /**
     * Get the mail representation of the notification.
     */
    public function toMail(object $notifiable): MailMessage
    {
        return (new MailMessage)
            ->subject('Feedback Received on Your Submission')
            ->line('Your supervisor has provided feedback on your submission.')
            ->line('Project: '.$this->submission->project->title)
            ->line('Chapter: '.$this->submission->chapter_type)
            ->line('Status: '.$this->submission->status)
            ->action('View Feedback', url('/student/project-submissions'))
            ->line('Please review the feedback and make necessary improvements.');
    }

    /**
     * Get the array representation of the notification.
     *
     * @return array<string, mixed>
     */
    public function toArray(object $notifiable): array
    {
        return [
            'type' => 'submission_feedback',
            'title' => 'Feedback Received',
            'message' => 'Your '.$this->submission->chapter_type.' submission for "'.$this->submission->project->title.'" has been reviewed',
            'submission_id' => $this->submission->id,
            'project_id' => $this->submission->project_id,
            'project_title' => $this->submission->project->title,
            'chapter_type' => $this->submission->chapter_type,
            'status' => $this->submission->status,
            'url' => '/student/project-submissions?project_id='.$this->submission->project_id,
            'icon' => 'ri-message-2-line',
            'icon_color' => $this->submission->status === 'approved' ? 'text-success' : ($this->submission->status === 'rejected' ? 'text-danger' : 'text-warning'),
        ];
    }
}
