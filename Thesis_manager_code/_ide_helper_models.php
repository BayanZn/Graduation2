<?php

// @formatter:off
// phpcs:ignoreFile
/**
 * A helper file for your Eloquent Models
 * Copy the phpDocs from this file to the correct Model,
 * And remove them from this file, to prevent double declarations.
 *
 * @author Barry vd. Heuvel <barryvdh@gmail.com>
 */


namespace App\Models{
/**
 * @property int $id
 * @property string $type
 * @property int|null $project_id
 * @property string|null $name
 * @property \Illuminate\Support\Carbon|null $last_message_at
 * @property int $created_by
 * @property \Illuminate\Support\Carbon|null $created_at
 * @property \Illuminate\Support\Carbon|null $updated_at
 * @property-read \App\Models\User $creator
 * @property-read \Illuminate\Database\Eloquent\Collection<int, \App\Models\Message> $latestMessage
 * @property-read int|null $latest_message_count
 * @property-read \Illuminate\Database\Eloquent\Collection<int, \App\Models\Message> $messages
 * @property-read int|null $messages_count
 * @property-read \Illuminate\Database\Eloquent\Collection<int, \App\Models\User> $participants
 * @property-read int|null $participants_count
 * @property-read \App\Models\Project|null $project
 * @method static \Illuminate\Database\Eloquent\Builder<static>|Conversation adminSupport()
 * @method static \Illuminate\Database\Eloquent\Builder<static>|Conversation direct()
 * @method static \Illuminate\Database\Eloquent\Builder<static>|Conversation newModelQuery()
 * @method static \Illuminate\Database\Eloquent\Builder<static>|Conversation newQuery()
 * @method static \Illuminate\Database\Eloquent\Builder<static>|Conversation projectGroup()
 * @method static \Illuminate\Database\Eloquent\Builder<static>|Conversation query()
 * @method static \Illuminate\Database\Eloquent\Builder<static>|Conversation whereCreatedAt($value)
 * @method static \Illuminate\Database\Eloquent\Builder<static>|Conversation whereCreatedBy($value)
 * @method static \Illuminate\Database\Eloquent\Builder<static>|Conversation whereId($value)
 * @method static \Illuminate\Database\Eloquent\Builder<static>|Conversation whereLastMessageAt($value)
 * @method static \Illuminate\Database\Eloquent\Builder<static>|Conversation whereName($value)
 * @method static \Illuminate\Database\Eloquent\Builder<static>|Conversation whereProjectId($value)
 * @method static \Illuminate\Database\Eloquent\Builder<static>|Conversation whereType($value)
 * @method static \Illuminate\Database\Eloquent\Builder<static>|Conversation whereUpdatedAt($value)
 */
	class Conversation extends \Eloquent {}
}

namespace App\Models{
/**
 * @property int $id
 * @property int $conversation_id
 * @property int $user_id
 * @property string $role
 * @property int $unread_count
 * @property \Illuminate\Support\Carbon|null $last_read_at
 * @property \Illuminate\Support\Carbon $joined_at
 * @property \Illuminate\Support\Carbon|null $created_at
 * @property \Illuminate\Support\Carbon|null $updated_at
 * @property-read \App\Models\Conversation $conversation
 * @property-read \App\Models\User $user
 * @method static \Illuminate\Database\Eloquent\Builder<static>|ConversationParticipant newModelQuery()
 * @method static \Illuminate\Database\Eloquent\Builder<static>|ConversationParticipant newQuery()
 * @method static \Illuminate\Database\Eloquent\Builder<static>|ConversationParticipant query()
 * @method static \Illuminate\Database\Eloquent\Builder<static>|ConversationParticipant whereConversationId($value)
 * @method static \Illuminate\Database\Eloquent\Builder<static>|ConversationParticipant whereCreatedAt($value)
 * @method static \Illuminate\Database\Eloquent\Builder<static>|ConversationParticipant whereId($value)
 * @method static \Illuminate\Database\Eloquent\Builder<static>|ConversationParticipant whereJoinedAt($value)
 * @method static \Illuminate\Database\Eloquent\Builder<static>|ConversationParticipant whereLastReadAt($value)
 * @method static \Illuminate\Database\Eloquent\Builder<static>|ConversationParticipant whereRole($value)
 * @method static \Illuminate\Database\Eloquent\Builder<static>|ConversationParticipant whereUnreadCount($value)
 * @method static \Illuminate\Database\Eloquent\Builder<static>|ConversationParticipant whereUpdatedAt($value)
 * @method static \Illuminate\Database\Eloquent\Builder<static>|ConversationParticipant whereUserId($value)
 */
	class ConversationParticipant extends \Eloquent {}
}

namespace App\Models{
/**
 * @property int $id
 * @property string $currency_name
 * @property string $code
 * @property string $symbol
 * @property string $thousand_separator
 * @property string $decimal_separator
 * @property int|null $exchange_rate
 * @property \Illuminate\Support\Carbon|null $created_at
 * @property \Illuminate\Support\Carbon|null $updated_at
 * @method static \Illuminate\Database\Eloquent\Builder<static>|Currency newModelQuery()
 * @method static \Illuminate\Database\Eloquent\Builder<static>|Currency newQuery()
 * @method static \Illuminate\Database\Eloquent\Builder<static>|Currency query()
 * @method static \Illuminate\Database\Eloquent\Builder<static>|Currency whereCode($value)
 * @method static \Illuminate\Database\Eloquent\Builder<static>|Currency whereCreatedAt($value)
 * @method static \Illuminate\Database\Eloquent\Builder<static>|Currency whereCurrencyName($value)
 * @method static \Illuminate\Database\Eloquent\Builder<static>|Currency whereDecimalSeparator($value)
 * @method static \Illuminate\Database\Eloquent\Builder<static>|Currency whereExchangeRate($value)
 * @method static \Illuminate\Database\Eloquent\Builder<static>|Currency whereId($value)
 * @method static \Illuminate\Database\Eloquent\Builder<static>|Currency whereSymbol($value)
 * @method static \Illuminate\Database\Eloquent\Builder<static>|Currency whereThousandSeparator($value)
 * @method static \Illuminate\Database\Eloquent\Builder<static>|Currency whereUpdatedAt($value)
 */
	class Currency extends \Eloquent {}
}

namespace App\Models{
/**
 * @property int $id
 * @property int $project_id
 * @property string $discussion_hall
 * @property \Illuminate\Support\Carbon $discussion_date
 * @property string $discussion_type
 * @property string $status
 * @property string|null $notes
 * @property int|null $created_by
 * @property \Illuminate\Support\Carbon|null $created_at
 * @property \Illuminate\Support\Carbon|null $updated_at
 * @property-read \Illuminate\Database\Eloquent\Collection<int, \Spatie\Activitylog\Models\Activity> $activities
 * @property-read int|null $activities_count
 * @property-read \App\Models\User|null $creator
 * @property-read \Illuminate\Database\Eloquent\Collection<int, \App\Models\User> $members
 * @property-read int|null $members_count
 * @property-read \App\Models\Project $project
 * @method static \Illuminate\Database\Eloquent\Builder<static>|Defense cancelled()
 * @method static \Illuminate\Database\Eloquent\Builder<static>|Defense completed()
 * @method static \Illuminate\Database\Eloquent\Builder<static>|Defense newModelQuery()
 * @method static \Illuminate\Database\Eloquent\Builder<static>|Defense newQuery()
 * @method static \Illuminate\Database\Eloquent\Builder<static>|Defense ofType($type)
 * @method static \Illuminate\Database\Eloquent\Builder<static>|Defense query()
 * @method static \Illuminate\Database\Eloquent\Builder<static>|Defense scheduled()
 * @method static \Illuminate\Database\Eloquent\Builder<static>|Defense whereCreatedAt($value)
 * @method static \Illuminate\Database\Eloquent\Builder<static>|Defense whereCreatedBy($value)
 * @method static \Illuminate\Database\Eloquent\Builder<static>|Defense whereDiscussionDate($value)
 * @method static \Illuminate\Database\Eloquent\Builder<static>|Defense whereDiscussionHall($value)
 * @method static \Illuminate\Database\Eloquent\Builder<static>|Defense whereDiscussionType($value)
 * @method static \Illuminate\Database\Eloquent\Builder<static>|Defense whereId($value)
 * @method static \Illuminate\Database\Eloquent\Builder<static>|Defense whereNotes($value)
 * @method static \Illuminate\Database\Eloquent\Builder<static>|Defense whereProjectId($value)
 * @method static \Illuminate\Database\Eloquent\Builder<static>|Defense whereStatus($value)
 * @method static \Illuminate\Database\Eloquent\Builder<static>|Defense whereUpdatedAt($value)
 */
	class Defense extends \Eloquent {}
}

namespace App\Models{
/**
 * @property int $id
 * @property string $short_name
 * @property string $name
 * @property \Illuminate\Support\Carbon|null $created_at
 * @property \Illuminate\Support\Carbon|null $updated_at
 * @property-read \Illuminate\Database\Eloquent\Collection<int, \Spatie\Activitylog\Models\Activity> $activities
 * @property-read int|null $activities_count
 * @property-read \Illuminate\Database\Eloquent\Collection<int, \App\Models\Specialization> $specializations
 * @property-read int|null $specializations_count
 * @method static \Illuminate\Database\Eloquent\Builder<static>|Department newModelQuery()
 * @method static \Illuminate\Database\Eloquent\Builder<static>|Department newQuery()
 * @method static \Illuminate\Database\Eloquent\Builder<static>|Department query()
 * @method static \Illuminate\Database\Eloquent\Builder<static>|Department whereCreatedAt($value)
 * @method static \Illuminate\Database\Eloquent\Builder<static>|Department whereId($value)
 * @method static \Illuminate\Database\Eloquent\Builder<static>|Department whereName($value)
 * @method static \Illuminate\Database\Eloquent\Builder<static>|Department whereShortName($value)
 * @method static \Illuminate\Database\Eloquent\Builder<static>|Department whereUpdatedAt($value)
 */
	class Department extends \Eloquent {}
}

namespace App\Models{
/**
 * @property int $id
 * @property int $conversation_id
 * @property int|null $sender_id
 * @property string $message
 * @property string $type
 * @property \Illuminate\Support\Carbon|null $read_at
 * @property \Illuminate\Support\Carbon|null $created_at
 * @property \Illuminate\Support\Carbon|null $updated_at
 * @property-read \App\Models\Conversation $conversation
 * @property-read \Illuminate\Database\Eloquent\Collection<int, \App\Models\MessageRead> $reads
 * @property-read int|null $reads_count
 * @property-read \App\Models\User|null $sender
 * @method static \Illuminate\Database\Eloquent\Builder<static>|Message newModelQuery()
 * @method static \Illuminate\Database\Eloquent\Builder<static>|Message newQuery()
 * @method static \Illuminate\Database\Eloquent\Builder<static>|Message query()
 * @method static \Illuminate\Database\Eloquent\Builder<static>|Message whereConversationId($value)
 * @method static \Illuminate\Database\Eloquent\Builder<static>|Message whereCreatedAt($value)
 * @method static \Illuminate\Database\Eloquent\Builder<static>|Message whereId($value)
 * @method static \Illuminate\Database\Eloquent\Builder<static>|Message whereMessage($value)
 * @method static \Illuminate\Database\Eloquent\Builder<static>|Message whereReadAt($value)
 * @method static \Illuminate\Database\Eloquent\Builder<static>|Message whereSenderId($value)
 * @method static \Illuminate\Database\Eloquent\Builder<static>|Message whereType($value)
 * @method static \Illuminate\Database\Eloquent\Builder<static>|Message whereUpdatedAt($value)
 */
	class Message extends \Eloquent {}
}

namespace App\Models{
/**
 * @property int $id
 * @property int $message_id
 * @property int $user_id
 * @property \Illuminate\Support\Carbon $read_at
 * @property \Illuminate\Support\Carbon|null $created_at
 * @property \Illuminate\Support\Carbon|null $updated_at
 * @property-read \App\Models\Message $message
 * @property-read \App\Models\User $user
 * @method static \Illuminate\Database\Eloquent\Builder<static>|MessageRead newModelQuery()
 * @method static \Illuminate\Database\Eloquent\Builder<static>|MessageRead newQuery()
 * @method static \Illuminate\Database\Eloquent\Builder<static>|MessageRead query()
 * @method static \Illuminate\Database\Eloquent\Builder<static>|MessageRead whereCreatedAt($value)
 * @method static \Illuminate\Database\Eloquent\Builder<static>|MessageRead whereId($value)
 * @method static \Illuminate\Database\Eloquent\Builder<static>|MessageRead whereMessageId($value)
 * @method static \Illuminate\Database\Eloquent\Builder<static>|MessageRead whereReadAt($value)
 * @method static \Illuminate\Database\Eloquent\Builder<static>|MessageRead whereUpdatedAt($value)
 * @method static \Illuminate\Database\Eloquent\Builder<static>|MessageRead whereUserId($value)
 */
	class MessageRead extends \Eloquent {}
}

namespace App\Models{
/**
 * @property int $id
 * @property string $method_name
 * @property string $short_code
 * @property \Illuminate\Support\Carbon|null $created_at
 * @property \Illuminate\Support\Carbon|null $updated_at
 * @method static \Illuminate\Database\Eloquent\Builder<static>|PaymentMethod newModelQuery()
 * @method static \Illuminate\Database\Eloquent\Builder<static>|PaymentMethod newQuery()
 * @method static \Illuminate\Database\Eloquent\Builder<static>|PaymentMethod query()
 * @method static \Illuminate\Database\Eloquent\Builder<static>|PaymentMethod whereCreatedAt($value)
 * @method static \Illuminate\Database\Eloquent\Builder<static>|PaymentMethod whereId($value)
 * @method static \Illuminate\Database\Eloquent\Builder<static>|PaymentMethod whereMethodName($value)
 * @method static \Illuminate\Database\Eloquent\Builder<static>|PaymentMethod whereShortCode($value)
 * @method static \Illuminate\Database\Eloquent\Builder<static>|PaymentMethod whereUpdatedAt($value)
 */
	class PaymentMethod extends \Eloquent {}
}

namespace App\Models{
/**
 * @property int $id
 * @property int|null $specialization_id
 * @property int|null $department_id
 * @property string $title
 * @property string $description
 * @property string $project_type Semester, Graduation 1, Graduation 2
 * @property int|null $created_by
 * @property string $status Pending, Approved, Rejected
 * @property \Illuminate\Support\Carbon|null $created_at
 * @property \Illuminate\Support\Carbon|null $updated_at
 * @property-read \Illuminate\Database\Eloquent\Collection<int, \Spatie\Activitylog\Models\Activity> $activities
 * @property-read int|null $activities_count
 * @property-read \Illuminate\Database\Eloquent\Collection<int, \App\Models\ProjectAssignment> $assignments
 * @property-read int|null $assignments_count
 * @property-read \App\Models\User|null $creator
 * @property-read \Illuminate\Database\Eloquent\Collection<int, \App\Models\Defense> $defenses
 * @property-read int|null $defenses_count
 * @property-read \App\Models\Department|null $department
 * @property-read \App\Models\Specialization|null $specialization
 * @property-read \Illuminate\Database\Eloquent\Collection<int, \App\Models\User> $students
 * @property-read int|null $students_count
 * @property-read \Illuminate\Database\Eloquent\Collection<int, \App\Models\ProjectSubmission> $submissions
 * @property-read int|null $submissions_count
 * @property-read \Illuminate\Database\Eloquent\Collection<int, \App\Models\User> $supervisors
 * @property-read int|null $supervisors_count
 * @method static \Illuminate\Database\Eloquent\Builder<static>|Project newModelQuery()
 * @method static \Illuminate\Database\Eloquent\Builder<static>|Project newQuery()
 * @method static \Illuminate\Database\Eloquent\Builder<static>|Project query()
 * @method static \Illuminate\Database\Eloquent\Builder<static>|Project whereCreatedAt($value)
 * @method static \Illuminate\Database\Eloquent\Builder<static>|Project whereCreatedBy($value)
 * @method static \Illuminate\Database\Eloquent\Builder<static>|Project whereDepartmentId($value)
 * @method static \Illuminate\Database\Eloquent\Builder<static>|Project whereDescription($value)
 * @method static \Illuminate\Database\Eloquent\Builder<static>|Project whereId($value)
 * @method static \Illuminate\Database\Eloquent\Builder<static>|Project whereProjectType($value)
 * @method static \Illuminate\Database\Eloquent\Builder<static>|Project whereSpecializationId($value)
 * @method static \Illuminate\Database\Eloquent\Builder<static>|Project whereStatus($value)
 * @method static \Illuminate\Database\Eloquent\Builder<static>|Project whereTitle($value)
 * @method static \Illuminate\Database\Eloquent\Builder<static>|Project whereUpdatedAt($value)
 */
	class Project extends \Eloquent {}
}

namespace App\Models{
/**
 * @property int $id
 * @property int $project_id
 * @property int $user_id
 * @property string $role
 * @property int|null $assigned_by
 * @property \Illuminate\Support\Carbon $assigned_at
 * @property \Illuminate\Support\Carbon|null $created_at
 * @property \Illuminate\Support\Carbon|null $updated_at
 * @property-read \Illuminate\Database\Eloquent\Collection<int, \Spatie\Activitylog\Models\Activity> $activities
 * @property-read int|null $activities_count
 * @property-read \App\Models\User|null $assignedBy
 * @property-read \App\Models\Project $project
 * @property-read \App\Models\User $user
 * @method static \Illuminate\Database\Eloquent\Builder<static>|ProjectAssignment forProject($projectId)
 * @method static \Illuminate\Database\Eloquent\Builder<static>|ProjectAssignment newModelQuery()
 * @method static \Illuminate\Database\Eloquent\Builder<static>|ProjectAssignment newQuery()
 * @method static \Illuminate\Database\Eloquent\Builder<static>|ProjectAssignment query()
 * @method static \Illuminate\Database\Eloquent\Builder<static>|ProjectAssignment students()
 * @method static \Illuminate\Database\Eloquent\Builder<static>|ProjectAssignment supervisors()
 * @method static \Illuminate\Database\Eloquent\Builder<static>|ProjectAssignment whereAssignedAt($value)
 * @method static \Illuminate\Database\Eloquent\Builder<static>|ProjectAssignment whereAssignedBy($value)
 * @method static \Illuminate\Database\Eloquent\Builder<static>|ProjectAssignment whereCreatedAt($value)
 * @method static \Illuminate\Database\Eloquent\Builder<static>|ProjectAssignment whereId($value)
 * @method static \Illuminate\Database\Eloquent\Builder<static>|ProjectAssignment whereProjectId($value)
 * @method static \Illuminate\Database\Eloquent\Builder<static>|ProjectAssignment whereRole($value)
 * @method static \Illuminate\Database\Eloquent\Builder<static>|ProjectAssignment whereUpdatedAt($value)
 * @method static \Illuminate\Database\Eloquent\Builder<static>|ProjectAssignment whereUserId($value)
 */
	class ProjectAssignment extends \Eloquent {}
}

namespace App\Models{
/**
 * @property int $id
 * @property int $project_id
 * @property int $student_id
 * @property string $request_type
 * @property array<array-key, mixed>|null $group_members
 * @property string $status
 * @property string|null $message
 * @property int|null $reviewed_by
 * @property \Illuminate\Support\Carbon|null $reviewed_at
 * @property \Illuminate\Support\Carbon|null $created_at
 * @property \Illuminate\Support\Carbon|null $updated_at
 * @property-read \Illuminate\Database\Eloquent\Collection<int, \Spatie\Activitylog\Models\Activity> $activities
 * @property-read int|null $activities_count
 * @property-read \App\Models\Project $project
 * @property-read \App\Models\User|null $reviewer
 * @property-read \App\Models\User $student
 * @method static \Illuminate\Database\Eloquent\Builder<static>|ProjectRequest newModelQuery()
 * @method static \Illuminate\Database\Eloquent\Builder<static>|ProjectRequest newQuery()
 * @method static \Illuminate\Database\Eloquent\Builder<static>|ProjectRequest query()
 * @method static \Illuminate\Database\Eloquent\Builder<static>|ProjectRequest whereCreatedAt($value)
 * @method static \Illuminate\Database\Eloquent\Builder<static>|ProjectRequest whereGroupMembers($value)
 * @method static \Illuminate\Database\Eloquent\Builder<static>|ProjectRequest whereId($value)
 * @method static \Illuminate\Database\Eloquent\Builder<static>|ProjectRequest whereMessage($value)
 * @method static \Illuminate\Database\Eloquent\Builder<static>|ProjectRequest whereProjectId($value)
 * @method static \Illuminate\Database\Eloquent\Builder<static>|ProjectRequest whereRequestType($value)
 * @method static \Illuminate\Database\Eloquent\Builder<static>|ProjectRequest whereReviewedAt($value)
 * @method static \Illuminate\Database\Eloquent\Builder<static>|ProjectRequest whereReviewedBy($value)
 * @method static \Illuminate\Database\Eloquent\Builder<static>|ProjectRequest whereStatus($value)
 * @method static \Illuminate\Database\Eloquent\Builder<static>|ProjectRequest whereStudentId($value)
 * @method static \Illuminate\Database\Eloquent\Builder<static>|ProjectRequest whereUpdatedAt($value)
 */
	class ProjectRequest extends \Eloquent {}
}

namespace App\Models{
/**
 * @property int $id
 * @property int $project_id
 * @property int $uploaded_by
 * @property string $chapter_type
 * @property string $file_path
 * @property string|null $code_link
 * @property string $status
 * @property string|null $supervisor_feedback
 * @property int|null $reviewed_by
 * @property \Illuminate\Support\Carbon|null $reviewed_at
 * @property \Illuminate\Support\Carbon|null $created_at
 * @property \Illuminate\Support\Carbon|null $updated_at
 * @property-read \Illuminate\Database\Eloquent\Collection<int, \Spatie\Activitylog\Models\Activity> $activities
 * @property-read int|null $activities_count
 * @property-read \App\Models\Project $project
 * @property-read \App\Models\User|null $reviewer
 * @property-read \App\Models\User $uploadedBy
 * @method static \Illuminate\Database\Eloquent\Builder<static>|ProjectSubmission approved()
 * @method static \Illuminate\Database\Eloquent\Builder<static>|ProjectSubmission forProject($projectId)
 * @method static \Illuminate\Database\Eloquent\Builder<static>|ProjectSubmission newModelQuery()
 * @method static \Illuminate\Database\Eloquent\Builder<static>|ProjectSubmission newQuery()
 * @method static \Illuminate\Database\Eloquent\Builder<static>|ProjectSubmission pending()
 * @method static \Illuminate\Database\Eloquent\Builder<static>|ProjectSubmission query()
 * @method static \Illuminate\Database\Eloquent\Builder<static>|ProjectSubmission rejected()
 * @method static \Illuminate\Database\Eloquent\Builder<static>|ProjectSubmission whereChapterType($value)
 * @method static \Illuminate\Database\Eloquent\Builder<static>|ProjectSubmission whereCodeLink($value)
 * @method static \Illuminate\Database\Eloquent\Builder<static>|ProjectSubmission whereCreatedAt($value)
 * @method static \Illuminate\Database\Eloquent\Builder<static>|ProjectSubmission whereFilePath($value)
 * @method static \Illuminate\Database\Eloquent\Builder<static>|ProjectSubmission whereId($value)
 * @method static \Illuminate\Database\Eloquent\Builder<static>|ProjectSubmission whereProjectId($value)
 * @method static \Illuminate\Database\Eloquent\Builder<static>|ProjectSubmission whereReviewedAt($value)
 * @method static \Illuminate\Database\Eloquent\Builder<static>|ProjectSubmission whereReviewedBy($value)
 * @method static \Illuminate\Database\Eloquent\Builder<static>|ProjectSubmission whereStatus($value)
 * @method static \Illuminate\Database\Eloquent\Builder<static>|ProjectSubmission whereSupervisorFeedback($value)
 * @method static \Illuminate\Database\Eloquent\Builder<static>|ProjectSubmission whereUpdatedAt($value)
 * @method static \Illuminate\Database\Eloquent\Builder<static>|ProjectSubmission whereUploadedBy($value)
 */
	class ProjectSubmission extends \Eloquent {}
}

namespace App\Models{
/**
 * @property int $id
 * @property int|null $currency_id
 * @property string|null $company_name
 * @property string|null $company_email
 * @property string|null $company_email_2
 * @property string|null $company_mobile
 * @property string|null $company_mobile_2
 * @property string|null $currency_position
 * @property string|null $notification_email
 * @property string|null $footer_text
 * @property string|null $company_address
 * @property string|null $vat_id
 * @property int|null $tax_percentage
 * @property int $decimal_point
 * @property string|null $date_format
 * @property string|null $time_zone
 * @property string|null $time_format
 * @property \Illuminate\Support\Carbon|null $created_at
 * @property \Illuminate\Support\Carbon|null $updated_at
 * @property-read \App\Models\Currency|null $currency
 * @property-read \Spatie\MediaLibrary\MediaCollections\Models\Collections\MediaCollection<int, \Spatie\MediaLibrary\MediaCollections\Models\Media> $media
 * @property-read int|null $media_count
 * @method static \Illuminate\Database\Eloquent\Builder<static>|Setting newModelQuery()
 * @method static \Illuminate\Database\Eloquent\Builder<static>|Setting newQuery()
 * @method static \Illuminate\Database\Eloquent\Builder<static>|Setting query()
 * @method static \Illuminate\Database\Eloquent\Builder<static>|Setting whereCompanyAddress($value)
 * @method static \Illuminate\Database\Eloquent\Builder<static>|Setting whereCompanyEmail($value)
 * @method static \Illuminate\Database\Eloquent\Builder<static>|Setting whereCompanyEmail2($value)
 * @method static \Illuminate\Database\Eloquent\Builder<static>|Setting whereCompanyMobile($value)
 * @method static \Illuminate\Database\Eloquent\Builder<static>|Setting whereCompanyMobile2($value)
 * @method static \Illuminate\Database\Eloquent\Builder<static>|Setting whereCompanyName($value)
 * @method static \Illuminate\Database\Eloquent\Builder<static>|Setting whereCreatedAt($value)
 * @method static \Illuminate\Database\Eloquent\Builder<static>|Setting whereCurrencyId($value)
 * @method static \Illuminate\Database\Eloquent\Builder<static>|Setting whereCurrencyPosition($value)
 * @method static \Illuminate\Database\Eloquent\Builder<static>|Setting whereDateFormat($value)
 * @method static \Illuminate\Database\Eloquent\Builder<static>|Setting whereDecimalPoint($value)
 * @method static \Illuminate\Database\Eloquent\Builder<static>|Setting whereFooterText($value)
 * @method static \Illuminate\Database\Eloquent\Builder<static>|Setting whereId($value)
 * @method static \Illuminate\Database\Eloquent\Builder<static>|Setting whereNotificationEmail($value)
 * @method static \Illuminate\Database\Eloquent\Builder<static>|Setting whereTaxPercentage($value)
 * @method static \Illuminate\Database\Eloquent\Builder<static>|Setting whereTimeFormat($value)
 * @method static \Illuminate\Database\Eloquent\Builder<static>|Setting whereTimeZone($value)
 * @method static \Illuminate\Database\Eloquent\Builder<static>|Setting whereUpdatedAt($value)
 * @method static \Illuminate\Database\Eloquent\Builder<static>|Setting whereVatId($value)
 */
	class Setting extends \Eloquent implements \Spatie\MediaLibrary\HasMedia {}
}

namespace App\Models{
/**
 * @property int $id
 * @property int|null $department_id
 * @property string $short_name
 * @property string $name
 * @property \Illuminate\Support\Carbon|null $created_at
 * @property \Illuminate\Support\Carbon|null $updated_at
 * @property-read \Illuminate\Database\Eloquent\Collection<int, \Spatie\Activitylog\Models\Activity> $activities
 * @property-read int|null $activities_count
 * @property-read \App\Models\Department|null $department
 * @method static \Illuminate\Database\Eloquent\Builder<static>|Specialization newModelQuery()
 * @method static \Illuminate\Database\Eloquent\Builder<static>|Specialization newQuery()
 * @method static \Illuminate\Database\Eloquent\Builder<static>|Specialization query()
 * @method static \Illuminate\Database\Eloquent\Builder<static>|Specialization whereCreatedAt($value)
 * @method static \Illuminate\Database\Eloquent\Builder<static>|Specialization whereDepartmentId($value)
 * @method static \Illuminate\Database\Eloquent\Builder<static>|Specialization whereId($value)
 * @method static \Illuminate\Database\Eloquent\Builder<static>|Specialization whereName($value)
 * @method static \Illuminate\Database\Eloquent\Builder<static>|Specialization whereShortName($value)
 * @method static \Illuminate\Database\Eloquent\Builder<static>|Specialization whereUpdatedAt($value)
 */
	class Specialization extends \Eloquent {}
}

namespace App\Models{
/**
 * @property int $id
 * @property string|null $folder
 * @property string $filename
 * @property \Illuminate\Support\Carbon|null $created_at
 * @property \Illuminate\Support\Carbon|null $updated_at
 * @property-read \Spatie\MediaLibrary\MediaCollections\Models\Collections\MediaCollection<int, \Spatie\MediaLibrary\MediaCollections\Models\Media> $media
 * @property-read int|null $media_count
 * @method static \Illuminate\Database\Eloquent\Builder<static>|Upload newModelQuery()
 * @method static \Illuminate\Database\Eloquent\Builder<static>|Upload newQuery()
 * @method static \Illuminate\Database\Eloquent\Builder<static>|Upload query()
 * @method static \Illuminate\Database\Eloquent\Builder<static>|Upload whereCreatedAt($value)
 * @method static \Illuminate\Database\Eloquent\Builder<static>|Upload whereFilename($value)
 * @method static \Illuminate\Database\Eloquent\Builder<static>|Upload whereFolder($value)
 * @method static \Illuminate\Database\Eloquent\Builder<static>|Upload whereId($value)
 * @method static \Illuminate\Database\Eloquent\Builder<static>|Upload whereUpdatedAt($value)
 */
	class Upload extends \Eloquent implements \Spatie\MediaLibrary\HasMedia {}
}

namespace App\Models{
/**
 * @property int $id
 * @property int|null $specialization_id
 * @property string $name
 * @property string $email
 * @property \Illuminate\Support\Carbon|null $email_verified_at
 * @property string $password
 * @property string|null $remember_token
 * @property \Illuminate\Support\Carbon|null $created_at
 * @property \Illuminate\Support\Carbon|null $updated_at
 * @property string|null $first_name
 * @property string|null $last_name
 * @property string|null $mobile
 * @property string|null $gender Male/Female
 * @property string|null $date_of_birth
 * @property string|null $address
 * @property-read \Illuminate\Database\Eloquent\Collection<int, \Spatie\Activitylog\Models\Activity> $actions
 * @property-read int|null $actions_count
 * @property-read \Illuminate\Database\Eloquent\Collection<int, \App\Models\ProjectAssignment> $assignments
 * @property-read int|null $assignments_count
 * @property-read \Illuminate\Database\Eloquent\Collection<int, \App\Models\Conversation> $conversations
 * @property-read int|null $conversations_count
 * @property-read \Spatie\MediaLibrary\MediaCollections\Models\Collections\MediaCollection<int, \Spatie\MediaLibrary\MediaCollections\Models\Media> $media
 * @property-read int|null $media_count
 * @property-read \Illuminate\Database\Eloquent\Collection<int, \App\Models\Message> $messages
 * @property-read int|null $messages_count
 * @property-read \Illuminate\Notifications\DatabaseNotificationCollection<int, \Illuminate\Notifications\DatabaseNotification> $notifications
 * @property-read int|null $notifications_count
 * @property-read \Illuminate\Database\Eloquent\Collection<int, \Spatie\Permission\Models\Permission> $permissions
 * @property-read int|null $permissions_count
 * @property-read \Illuminate\Database\Eloquent\Collection<int, \Spatie\Permission\Models\Role> $roles
 * @property-read int|null $roles_count
 * @property-read \App\Models\Specialization|null $specialization
 * @property-read \Illuminate\Database\Eloquent\Collection<int, \Laravel\Sanctum\PersonalAccessToken> $tokens
 * @property-read int|null $tokens_count
 * @method static \Database\Factories\UserFactory factory($count = null, $state = [])
 * @method static \Illuminate\Database\Eloquent\Builder<static>|User newModelQuery()
 * @method static \Illuminate\Database\Eloquent\Builder<static>|User newQuery()
 * @method static \Illuminate\Database\Eloquent\Builder<static>|User permission($permissions, $without = false)
 * @method static \Illuminate\Database\Eloquent\Builder<static>|User query()
 * @method static \Illuminate\Database\Eloquent\Builder<static>|User role($roles, $guard = null, $without = false)
 * @method static \Illuminate\Database\Eloquent\Builder<static>|User whereAddress($value)
 * @method static \Illuminate\Database\Eloquent\Builder<static>|User whereCreatedAt($value)
 * @method static \Illuminate\Database\Eloquent\Builder<static>|User whereDateOfBirth($value)
 * @method static \Illuminate\Database\Eloquent\Builder<static>|User whereEmail($value)
 * @method static \Illuminate\Database\Eloquent\Builder<static>|User whereEmailVerifiedAt($value)
 * @method static \Illuminate\Database\Eloquent\Builder<static>|User whereFirstName($value)
 * @method static \Illuminate\Database\Eloquent\Builder<static>|User whereGender($value)
 * @method static \Illuminate\Database\Eloquent\Builder<static>|User whereId($value)
 * @method static \Illuminate\Database\Eloquent\Builder<static>|User whereLastName($value)
 * @method static \Illuminate\Database\Eloquent\Builder<static>|User whereMobile($value)
 * @method static \Illuminate\Database\Eloquent\Builder<static>|User whereName($value)
 * @method static \Illuminate\Database\Eloquent\Builder<static>|User wherePassword($value)
 * @method static \Illuminate\Database\Eloquent\Builder<static>|User whereRememberToken($value)
 * @method static \Illuminate\Database\Eloquent\Builder<static>|User whereSpecializationId($value)
 * @method static \Illuminate\Database\Eloquent\Builder<static>|User whereUpdatedAt($value)
 * @method static \Illuminate\Database\Eloquent\Builder<static>|User withoutPermission($permissions)
 * @method static \Illuminate\Database\Eloquent\Builder<static>|User withoutRole($roles, $guard = null)
 */
	class User extends \Eloquent implements \Spatie\MediaLibrary\HasMedia {}
}

