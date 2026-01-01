classDiagram
  class Conversation {
    +type
    +project_id
    +name
    +last_message_at: datetime
    +created_by
  }
  class ConversationParticipant {
    +conversation_id
    +user_id
    +role
    +unread_count
    +last_read_at: datetime
    +joined_at: datetime
  }
  class Currency {
  }
  class Defense {
  }
  class Department {
  }
  class Message {
    +conversation_id
    +sender_id
    +message
    +type
    +read_at: datetime
  }
  class MessageRead {
    +message_id
    +user_id
    +read_at: datetime
  }
  class PaymentMethod {
  }
  class Project {
  }
  class ProjectAssignment {
  }
  class ProjectRequest {
  }
  class ProjectSubmission {
  }
  class Setting {
  }
  class Specialization {
  }
  class Upload {
  }
  class User {
    +name
    +email
    +password: hashed
    +mobile
    +address
    +gender
    +first_name
    +last_name
    +date_of_birth
  }
  class ActivityLogsController {
    <<Controller>>
    +index()
    +destroy(Activity $activity_log)
    +destroyMultiple(Request $request)
  }
  class DashboardController {
    <<Controller>>
    +dashboard()
  }
  class ProjectRequestsController {
    <<Controller>>
    +index()
    +show(ProjectRequest $projectRequest)
    +approve(Request $request, ProjectRequest $projectRequest)
    +reject(Request $request, ProjectRequest $projectRequest)
    +resetToPending(ProjectRequest $projectRequest)
  }
  class AssignmentsController {
    <<Controller>>
    +index()
    +create()
    +store(Request $request)
    +show(Project $project)
    +edit(Project $project)
    +update(Request $request, Project $project)
    +destroy(Project $project)
    +removeSupervisor(Project $project, User $user)
    +removeStudent(Project $project, User $user)
  }
  class DefensesController {
    <<Controller>>
    +index(Request $request)
    +create()
    +store(Request $request)
    +show(Defense $defense)
    +edit(Defense $defense)
    +update(Request $request, Defense $defense)
    +destroy(Defense $defense)
    +removeMember(Defense $defense, User $user)
    +updateStatus(Request $request, Defense $defense)
  }
  class DepartmentsController {
    <<Controller>>
    +index()
    +store(Request $request)
    +edit(string $id)
    +update(Request $request, Department $department)
    +destroy(Department $department)
    +export()
    +import(Request $request)
  }
  class ProjectsController {
    <<Controller>>
    +index()
    +proposed()
    +approved()
    +declined()
    +create()
    +store(Request $request)
    +show(Project $project)
    +edit(Project $project)
    +update(Request $request, Project $project)
    +updateStatus(Request $request, Project $project)
    +updateType(Request $request, Project $project)
    +destroy(Project $project)
    +export()
    +import(Request $request)
  }
  class SpecializationsController {
    <<Controller>>
    +index()
    +store(Request $request)
    +edit(string $id)
    +update(Request $request, Specialization $specialization)
    +destroy(Specialization $specialization)
    +export()
    +import(Request $request)
  }
  class CurrenciesController {
    <<Controller>>
    +index()
    +store(Request $request)
    +edit(Currency $currency)
    +update(Request $request, Currency $currency)
    +destroy(Currency $currency)
  }
  class PaymentMethodsController {
    <<Controller>>
    +index()
    +store(Request $request)
    +edit(string $id)
    +update(Request $request, PaymentMethod $payment_method)
    +destroy(PaymentMethod $payment_method)
  }
  class SettingsController {
    <<Controller>>
    +edit()
    +update(Request $request, Setting $setting)
  }
  class RolesController {
    <<Controller>>
    +index()
    +create()
    +store(Request $request)
    +edit($id)
    +update(Request $request, Role $role)
    +destroy(Role $role)
  }
  class StudentsController {
    <<Controller>>
    +index()
  }
  class SupervisorsController {
    <<Controller>>
    +index()
  }
  class UsersController {
    <<Controller>>
    +index()
    +create()
    +store(Request $request, UploadService $upload)
    +edit(User $user)
    +update(Request $request, User $user, UploadService $upload)
    +destroy(User $user)
  }
  class AuthenticatedSessionController {
    <<Controller>>
    +create()
    +store(LoginRequest $request)
    +destroy(Request $request)
  }
  class ConfirmablePasswordController {
    <<Controller>>
    +show()
    +store(Request $request)
  }
  class EmailVerificationNotificationController {
    <<Controller>>
    +store(Request $request)
  }
  class EmailVerificationPromptController {
    <<Controller>>
    +__invoke(Request $request)
  }
  class NewPasswordController {
    <<Controller>>
    +create(Request $request)
    +store(Request $request)
  }
  class PasswordController {
    <<Controller>>
    +update(Request $request)
  }
  class PasswordResetLinkController {
    <<Controller>>
    +create()
    +store(Request $request)
  }
  class RegisteredUserController {
    <<Controller>>
    +create()
    +store(Request $request)
  }
  class VerifyEmailController {
    <<Controller>>
    +__invoke(EmailVerificationRequest $request)
  }
  class Controller {
    <<Controller>>
  }
  class ConversationsController {
    <<Controller>>
    +index(Request $request)
    +show(Conversation $conversation)
    +storeProjectChat(Request $request, Project $project)
    +getOrCreateAdminSupport()
    +destroy(Conversation $conversation)
  }
  class DashboardRedirectController {
    <<Controller>>
    +redirect()
  }
  class MessagesController {
    <<Controller>>
    +store(Request $request, Conversation $conversation)
    +markAsRead(Request $request, Conversation $conversation)
    +loadMore(Request $request, Conversation $conversation)
  }
  class NotificationController {
    <<Controller>>
    +index()
    +markAsRead($id)
    +markAllAsRead()
    +destroy($id)
  }
  class ProfileController {
    <<Controller>>
    +edit(Request $request)
    +update(ProfileUpdateRequest $request, UploadService $upload)
    +destroy(Request $request)
  }
  class AssignedProjectsController {
    <<Controller>>
    +index()
    +show(Project $project)
  }
  class AvailableProjectsController {
    <<Controller>>
    +index()
    +show(Project $project)
    +requestProject(Request $request, Project $project)
  }
  class DashboardController {
    <<Controller>>
    +dashboard()
  }
  class ProjectSubmissionsController {
    <<Controller>>
    +index()
    +store(Request $request)
    +destroy(ProjectSubmission $projectSubmission)
  }
  class DashboardController {
    <<Controller>>
    +dashboard()
  }
  class StudentsController {
    <<Controller>>
    +index(Request $request)
  }
  class DefensesController {
    <<Controller>>
    +index(Request $request)
    +show(Defense $defense)
    +updateStatus(Request $request, Defense $defense)
  }
  class ProjectsController {
    <<Controller>>
    +index()
    +create()
    +store(Request $request)
    +show(Project $project)
    +edit(Project $project)
    +update(Request $request, Project $project)
    +destroy(Project $project)
  }
  class ProjectSubmissionsController {
    <<Controller>>
    +index()
    +show(ProjectSubmission $projectSubmission)
    +updateStatus(Request $request, ProjectSubmission $projectSubmission)
  }
  class StudentsController {
    <<Controller>>
    +index(Request $request)
  }
  class SupervisedProjectsController {
    <<Controller>>
    +index(Request $request)
    +show(Project $project)
    +updateType(Request $request, Project $project)
    +updateSubmissionStatus(Request $request, ProjectSubmission $projectSubmission)
  }
  class UploadsController {
    <<Controller>>
    +filepondUpload(Request $request)
    +filepondRevert(Request $request, $filename)
    +filepondRemove(Request $request, $filename)
  }
  Setting <-- Currency : currency
  User --* ProjectAssignment : assignments
  User --* Message : messages
  User <--* Conversation : conversations
