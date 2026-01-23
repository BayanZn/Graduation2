<?php

namespace App\Notifications;

use App\Models\ProjectSubmission;
use Illuminate\Bus\Queueable;
use Illuminate\Contracts\Queue\ShouldQueue;
use Illuminate\Notifications\Messages\MailMessage;
use Illuminate\Notifications\Notification;

class ChapterSubmittedNotification extends Notification implements ShouldQueue
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
        // For now, only database. Mail can be enabled later via user preferences
        return ['database'];
    }

    /**
     * Get the mail representation of the notification.
     */
    public function toMail(object $notifiable): MailMessage
    {
        return (new MailMessage)
            ->subject('New Chapter Submission')
            ->line('A new chapter has been submitted for review.')
            ->line('Project: '.$this->submission->project->title)
            ->line('Chapter: '.$this->submission->chapter_type)
            ->line('Submitted by: '.$this->submission->uploadedBy->name)
            ->action('Review Submission', url('/supervisor/supervised-projects/'.$this->submission->project_id))
            ->line('Please review the submission at your earliest convenience.');
    }

    /**
     * Get the array representation of the notification.
     *
     * @return array<string, mixed>
     */
    public function toArray(object $notifiable): array
    {
        return [
            'type' => 'chapter_submitted',
            'title' => 'New Chapter Submission',
            'message' => $this->submission->uploadedBy->name.' submitted '.$this->submission->chapter_type.' for '.$this->submission->project->title,
            'submission_id' => $this->submission->id,
            'project_id' => $this->submission->project_id,
            'project_title' => $this->submission->project->title,
            'chapter_type' => $this->submission->chapter_type,
            'student_name' => $this->submission->uploadedBy->name,
            'url' => '/supervisor/supervised-projects/'.$this->submission->project_id,
            'icon' => 'ri-file-upload-line',
            'icon_color' => 'text-primary',
        ];
    }
}
