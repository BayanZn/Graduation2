# API Documentation

## Project: laravel/laravel

Laravel Version: v12.42.0

Generated: 12/19/2025, 8:44:52 PM

## Table of Contents

- [auth](#auth)
- [web](#web)

## auth

| Method | Endpoint | Handler | Description |
|--------|----------|---------|-------------|
| GET | register | RegisteredUserController::class, 'create' | List register |
| POST | register | RegisteredUserController::class, 'store' | Create a new register |
| GET | login | AuthenticatedSessionController::class, 'create' | List login |
| POST | login | AuthenticatedSessionController::class, 'store' | Create a new login |
| GET | forgot-password | PasswordResetLinkController::class, 'create' | List forgot-password |
| POST | forgot-password | PasswordResetLinkController::class, 'store' | Create a new forgot-password |
| GET | reset-password/{token} | NewPasswordController::class, 'create' | Retrieve a specific {token} |
| POST | reset-password | NewPasswordController::class, 'store' | Create a new reset-password |
| GET | verify-email | EmailVerificationPromptController::class)
        ->name('verification.notice');

    Route::get('verify-email/{id}/{hash}', VerifyEmailController::class)
        ->middleware(['signed', 'throttle:6,1' | List verify-email |
| POST | email/verification-notification | EmailVerificationNotificationController::class, 'store' | Create a new verification-notification |
| GET | confirm-password | ConfirmablePasswordController::class, 'show' | List confirm-password |
| POST | confirm-password | ConfirmablePasswordController::class, 'store' | Create a new confirm-password |
| PUT | password | PasswordController::class, 'update' | Update a specific password |
| POST | logout | AuthenticatedSessionController::class, 'destroy' | Create a new logout |

### GET register

**Handler:** RegisteredUserController::class, 'create'

**Description:** List register

---

### POST register

**Handler:** RegisteredUserController::class, 'store'

**Description:** Create a new register

---

### GET login

**Handler:** AuthenticatedSessionController::class, 'create'

**Description:** List login

---

### POST login

**Handler:** AuthenticatedSessionController::class, 'store'

**Description:** Create a new login

---

### GET forgot-password

**Handler:** PasswordResetLinkController::class, 'create'

**Description:** List forgot-password

---

### POST forgot-password

**Handler:** PasswordResetLinkController::class, 'store'

**Description:** Create a new forgot-password

---

### GET reset-password/{token}

**Handler:** NewPasswordController::class, 'create'

**Description:** Retrieve a specific {token}

---

### POST reset-password

**Handler:** NewPasswordController::class, 'store'

**Description:** Create a new reset-password

---

### GET verify-email

**Handler:** EmailVerificationPromptController::class)
        ->name('verification.notice');

    Route::get('verify-email/{id}/{hash}', VerifyEmailController::class)
        ->middleware(['signed', 'throttle:6,1'

**Description:** List verify-email

---

### POST email/verification-notification

**Handler:** EmailVerificationNotificationController::class, 'store'

**Description:** Create a new verification-notification

---

### GET confirm-password

**Handler:** ConfirmablePasswordController::class, 'show'

**Description:** List confirm-password

---

### POST confirm-password

**Handler:** ConfirmablePasswordController::class, 'store'

**Description:** Create a new confirm-password

---

### PUT password

**Handler:** PasswordController::class, 'update'

**Description:** Update a specific password

---

### POST logout

**Handler:** AuthenticatedSessionController::class, 'destroy'

**Description:** Create a new logout

---

## web

| Method | Endpoint | Handler | Description |
|--------|----------|---------|-------------|
| GET | / | function () {
    return Inertia::render('Auth/Login', [
        'canLogin' => Route::has('login'),
        'canRegister' => Route::has('register'),
     | List resource |
| GET | /dashboard | DashboardRedirectController::class, 'redirect' | List dashboard |
| GET | / | \App\Http\Controllers\NotificationController::class, 'index' | List resource |
| POST | /{id}/read | \App\Http\Controllers\NotificationController::class, 'markAsRead' | Create a new read |
| POST | /read-all | \App\Http\Controllers\NotificationController::class, 'markAllAsRead' | Create a new read-all |
| DELETE | /{id} | \App\Http\Controllers\NotificationController::class, 'destroy' | Delete a specific {id} |
| GET | /dashboard | StudentDashboardController::class, 'dashboard' | List dashboard |
| GET | /assigned-projects | AssignedProjectsController::class, 'index' | List assigned-projects |
| GET | /assigned-projects/{project} | AssignedProjectsController::class, 'show' | Retrieve a specific {project} |
| GET | /available-projects | AvailableProjectsController::class, 'index' | List available-projects |
| GET | /available-projects/{project} | AvailableProjectsController::class, 'show' | Retrieve a specific {project} |
| POST | /available-projects/{project}/request | AvailableProjectsController::class, 'requestProject' | Create a new request |
| GET | /project-submissions | StudentProjectSubmissionsController::class, 'index' | List project-submissions |
| POST | /project-submissions | StudentProjectSubmissionsController::class, 'store' | Create a new project-submissions |
| DELETE | /project-submissions/{projectSubmission} | StudentProjectSubmissionsController::class, 'destroy' | Delete a specific {projectSubmission} |
| GET | /dashboard | SupervisorDashboardController::class, 'dashboard' | List dashboard |
| GET | /supervised-projects | SupervisedProjectsController::class, 'index' | List supervised-projects |
| GET | /supervised-projects/{project} | SupervisedProjectsController::class, 'show' | Retrieve a specific {project} |
| PATCH | /supervised-projects/{project}/type | SupervisedProjectsController::class, 'updateType' | Update a specific type |
| PATCH | /supervised-projects/submissions/{projectSubmission}/status | SupervisedProjectsController::class, 'updateSubmissionStatus' | Update a specific status |
| GET | /defenses | SupervisorDefensesController::class, 'index' | List defenses |
| GET | /defenses/{defense} | SupervisorDefensesController::class, 'show' | Retrieve a specific {defense} |
| PATCH | /defenses/{defense}/status | SupervisorDefensesController::class, 'updateStatus' | Update a specific status |
| GET | /project-submissions | SupervisorProjectSubmissionsController::class, 'index' | List project-submissions |
| GET | /project-submissions/{projectSubmission} | SupervisorProjectSubmissionsController::class, 'show' | Retrieve a specific {projectSubmission} |
| PATCH | /project-submissions/{projectSubmission}/status | SupervisorProjectSubmissionsController::class, 'updateStatus' | Update a specific status |
| GET | /dashboard | DashboardController::class, 'dashboard' | List dashboard |
| GET | /profile | ProfileController::class, 'edit' | List profile |
| PATCH | /profile | ProfileController::class, 'update' | Update a specific profile |
| DELETE | /profile | ProfileController::class, 'destroy' | Delete a specific profile |
| POST | /filepond/upload | UploadsController::class, 'filepondUpload' | Create a new upload |
| DELETE | /filepond/revert/{filename} | UploadsController::class, 'filepondRevert' | Delete a specific {filename} |
| DELETE | /filepond/remove/{filename} | UploadsController::class, 'filepondRemove' | Delete a specific {filename} |
| GET | students | StudentsController::class, 'index' | List students |
| GET | supervisors | SupervisorsController::class, 'index' | List supervisors |
| GET | specializations/export | SpecializationsController::class, 'export' | List export |
| POST | specializations/import | SpecializationsController::class, 'import' | Create a new import |
| GET | departments/export | DepartmentsController::class, 'export' | List export |
| POST | departments/import | DepartmentsController::class, 'import' | Create a new import |
| GET | /projects/export | ProjectsController::class, 'export' | List export |
| POST | /projects/import | ProjectsController::class, 'import' | Create a new import |
| GET | /projects/proposed | ProjectsController::class, 'proposed' | List proposed |
| GET | /projects/approved | ProjectsController::class, 'approved' | List approved |
| GET | /projects/declined | ProjectsController::class, 'declined' | List declined |
| PATCH | /projects/{project}/status | ProjectsController::class, 'updateStatus' | Update a specific status |
| PATCH | /projects/{project}/type | ProjectsController::class, 'updateType' | Update a specific type |
| DELETE | /assignments/{project}/supervisor/{user} | AssignmentsController::class, 'removeSupervisor' | Delete a specific {user} |
| DELETE | /assignments/{project}/student/{user} | AssignmentsController::class, 'removeStudent' | Delete a specific {user} |
| DELETE | /defenses/{defense}/member/{user} | DefensesController::class, 'removeMember' | Delete a specific {user} |
| PATCH | /defenses/{defense}/status | DefensesController::class, 'updateStatus' | Update a specific status |
| POST | /project-requests/{projectRequest}/approve | ProjectRequestsController::class, 'approve' | Create a new approve |
| POST | /project-requests/{projectRequest}/reject | ProjectRequestsController::class, 'reject' | Create a new reject |
| POST | /project-requests/{projectRequest}/reset-to-pending | ProjectRequestsController::class, 'resetToPending' | Create a new reset-to-pending |
| GET | /project-requests | ProjectRequestsController::class, 'index' | List project-requests |
| GET | /project-requests/{projectRequest} | ProjectRequestsController::class, 'show' | Retrieve a specific {projectRequest} |
| DELETE | /activity-logs/multiple | ActivityLogsController::class, 'destroyMultiple' | Delete a specific multiple |
| GET | /settings | SettingsController::class, 'edit' | List settings |
| POST | /settings/{setting} | SettingsController::class, 'update' | Create a new {setting} |
| GET | / | function () {
        return inertia('Chat/Index');
    })->name('chat.index');

    Route::get('/conversations', [\App\Http\Controllers\ConversationsController::class, 'index' | List resource |
| GET | /conversations/{conversation} | \App\Http\Controllers\ConversationsController::class, 'show' | Retrieve a specific {conversation} |
| DELETE | /conversations/{conversation} | \App\Http\Controllers\ConversationsController::class, 'destroy' | Delete a specific {conversation} |
| POST | /projects/{project}/chat | \App\Http\Controllers\ConversationsController::class, 'storeProjectChat' | Create a new chat |
| POST | /conversations/{conversation}/messages | \App\Http\Controllers\MessagesController::class, 'store' | Create a new messages |
| POST | /conversations/{conversation}/mark-as-read | \App\Http\Controllers\MessagesController::class, 'markAsRead' | Create a new mark-as-read |
| GET | /conversations/{conversation}/load-more | \App\Http\Controllers\MessagesController::class, 'loadMore' | Retrieve a specific load-more |

### GET /

**Handler:** function () {
    return Inertia::render('Auth/Login', [
        'canLogin' => Route::has('login'),
        'canRegister' => Route::has('register'),
    

**Description:** List resource

---

### GET /dashboard

**Handler:** DashboardRedirectController::class, 'redirect'

**Description:** List dashboard

---

### GET /

**Handler:** \App\Http\Controllers\NotificationController::class, 'index'

**Description:** List resource

---

### POST /{id}/read

**Handler:** \App\Http\Controllers\NotificationController::class, 'markAsRead'

**Description:** Create a new read

---

### POST /read-all

**Handler:** \App\Http\Controllers\NotificationController::class, 'markAllAsRead'

**Description:** Create a new read-all

---

### DELETE /{id}

**Handler:** \App\Http\Controllers\NotificationController::class, 'destroy'

**Description:** Delete a specific {id}

---

### GET /dashboard

**Handler:** StudentDashboardController::class, 'dashboard'

**Description:** List dashboard

---

### GET /assigned-projects

**Handler:** AssignedProjectsController::class, 'index'

**Description:** List assigned-projects

---

### GET /assigned-projects/{project}

**Handler:** AssignedProjectsController::class, 'show'

**Description:** Retrieve a specific {project}

---

### GET /available-projects

**Handler:** AvailableProjectsController::class, 'index'

**Description:** List available-projects

---

### GET /available-projects/{project}

**Handler:** AvailableProjectsController::class, 'show'

**Description:** Retrieve a specific {project}

---

### POST /available-projects/{project}/request

**Handler:** AvailableProjectsController::class, 'requestProject'

**Description:** Create a new request

---

### GET /project-submissions

**Handler:** StudentProjectSubmissionsController::class, 'index'

**Description:** List project-submissions

---

### POST /project-submissions

**Handler:** StudentProjectSubmissionsController::class, 'store'

**Description:** Create a new project-submissions

---

### DELETE /project-submissions/{projectSubmission}

**Handler:** StudentProjectSubmissionsController::class, 'destroy'

**Description:** Delete a specific {projectSubmission}

---

### GET /dashboard

**Handler:** SupervisorDashboardController::class, 'dashboard'

**Description:** List dashboard

---

### GET /supervised-projects

**Handler:** SupervisedProjectsController::class, 'index'

**Description:** List supervised-projects

---

### GET /supervised-projects/{project}

**Handler:** SupervisedProjectsController::class, 'show'

**Description:** Retrieve a specific {project}

---

### PATCH /supervised-projects/{project}/type

**Handler:** SupervisedProjectsController::class, 'updateType'

**Description:** Update a specific type

---

### PATCH /supervised-projects/submissions/{projectSubmission}/status

**Handler:** SupervisedProjectsController::class, 'updateSubmissionStatus'

**Description:** Update a specific status

---

### GET /defenses

**Handler:** SupervisorDefensesController::class, 'index'

**Description:** List defenses

---

### GET /defenses/{defense}

**Handler:** SupervisorDefensesController::class, 'show'

**Description:** Retrieve a specific {defense}

---

### PATCH /defenses/{defense}/status

**Handler:** SupervisorDefensesController::class, 'updateStatus'

**Description:** Update a specific status

---

### GET /project-submissions

**Handler:** SupervisorProjectSubmissionsController::class, 'index'

**Description:** List project-submissions

---

### GET /project-submissions/{projectSubmission}

**Handler:** SupervisorProjectSubmissionsController::class, 'show'

**Description:** Retrieve a specific {projectSubmission}

---

### PATCH /project-submissions/{projectSubmission}/status

**Handler:** SupervisorProjectSubmissionsController::class, 'updateStatus'

**Description:** Update a specific status

---

### GET /dashboard

**Handler:** DashboardController::class, 'dashboard'

**Description:** List dashboard

---

### GET /profile

**Handler:** ProfileController::class, 'edit'

**Description:** List profile

---

### PATCH /profile

**Handler:** ProfileController::class, 'update'

**Description:** Update a specific profile

---

### DELETE /profile

**Handler:** ProfileController::class, 'destroy'

**Description:** Delete a specific profile

---

### POST /filepond/upload

**Handler:** UploadsController::class, 'filepondUpload'

**Description:** Create a new upload

---

### DELETE /filepond/revert/{filename}

**Handler:** UploadsController::class, 'filepondRevert'

**Description:** Delete a specific {filename}

---

### DELETE /filepond/remove/{filename}

**Handler:** UploadsController::class, 'filepondRemove'

**Description:** Delete a specific {filename}

---

### GET students

**Handler:** StudentsController::class, 'index'

**Description:** List students

---

### GET supervisors

**Handler:** SupervisorsController::class, 'index'

**Description:** List supervisors

---

### GET specializations/export

**Handler:** SpecializationsController::class, 'export'

**Description:** List export

---

### POST specializations/import

**Handler:** SpecializationsController::class, 'import'

**Description:** Create a new import

---

### GET departments/export

**Handler:** DepartmentsController::class, 'export'

**Description:** List export

---

### POST departments/import

**Handler:** DepartmentsController::class, 'import'

**Description:** Create a new import

---

### GET /projects/export

**Handler:** ProjectsController::class, 'export'

**Description:** List export

---

### POST /projects/import

**Handler:** ProjectsController::class, 'import'

**Description:** Create a new import

---

### GET /projects/proposed

**Handler:** ProjectsController::class, 'proposed'

**Description:** List proposed

---

### GET /projects/approved

**Handler:** ProjectsController::class, 'approved'

**Description:** List approved

---

### GET /projects/declined

**Handler:** ProjectsController::class, 'declined'

**Description:** List declined

---

### PATCH /projects/{project}/status

**Handler:** ProjectsController::class, 'updateStatus'

**Description:** Update a specific status

---

### PATCH /projects/{project}/type

**Handler:** ProjectsController::class, 'updateType'

**Description:** Update a specific type

---

### DELETE /assignments/{project}/supervisor/{user}

**Handler:** AssignmentsController::class, 'removeSupervisor'

**Description:** Delete a specific {user}

---

### DELETE /assignments/{project}/student/{user}

**Handler:** AssignmentsController::class, 'removeStudent'

**Description:** Delete a specific {user}

---

### DELETE /defenses/{defense}/member/{user}

**Handler:** DefensesController::class, 'removeMember'

**Description:** Delete a specific {user}

---

### PATCH /defenses/{defense}/status

**Handler:** DefensesController::class, 'updateStatus'

**Description:** Update a specific status

---

### POST /project-requests/{projectRequest}/approve

**Handler:** ProjectRequestsController::class, 'approve'

**Description:** Create a new approve

---

### POST /project-requests/{projectRequest}/reject

**Handler:** ProjectRequestsController::class, 'reject'

**Description:** Create a new reject

---

### POST /project-requests/{projectRequest}/reset-to-pending

**Handler:** ProjectRequestsController::class, 'resetToPending'

**Description:** Create a new reset-to-pending

---

### GET /project-requests

**Handler:** ProjectRequestsController::class, 'index'

**Description:** List project-requests

---

### GET /project-requests/{projectRequest}

**Handler:** ProjectRequestsController::class, 'show'

**Description:** Retrieve a specific {projectRequest}

---

### DELETE /activity-logs/multiple

**Handler:** ActivityLogsController::class, 'destroyMultiple'

**Description:** Delete a specific multiple

---

### GET /settings

**Handler:** SettingsController::class, 'edit'

**Description:** List settings

---

### POST /settings/{setting}

**Handler:** SettingsController::class, 'update'

**Description:** Create a new {setting}

---

### GET /

**Handler:** function () {
        return inertia('Chat/Index');
    })->name('chat.index');

    Route::get('/conversations', [\App\Http\Controllers\ConversationsController::class, 'index'

**Description:** List resource

---

### GET /conversations/{conversation}

**Handler:** \App\Http\Controllers\ConversationsController::class, 'show'

**Description:** Retrieve a specific {conversation}

---

### DELETE /conversations/{conversation}

**Handler:** \App\Http\Controllers\ConversationsController::class, 'destroy'

**Description:** Delete a specific {conversation}

---

### POST /projects/{project}/chat

**Handler:** \App\Http\Controllers\ConversationsController::class, 'storeProjectChat'

**Description:** Create a new chat

---

### POST /conversations/{conversation}/messages

**Handler:** \App\Http\Controllers\MessagesController::class, 'store'

**Description:** Create a new messages

---

### POST /conversations/{conversation}/mark-as-read

**Handler:** \App\Http\Controllers\MessagesController::class, 'markAsRead'

**Description:** Create a new mark-as-read

---

### GET /conversations/{conversation}/load-more

**Handler:** \App\Http\Controllers\MessagesController::class, 'loadMore'

**Description:** Retrieve a specific load-more

---

### student

| Method | Endpoint | Handler | Description |
|--------|----------|---------|-------------|
| GET | /students | SupervisorStudentsController::class, 'index' | List students |

### GET /students

**Handler:** SupervisorStudentsController::class, 'index'

**Description:** List students

---

### admin

| Method | Endpoint | Handler | Description |
|--------|----------|---------|-------------|
| POST | /admin-support | \App\Http\Controllers\ConversationsController::class, 'getOrCreateAdminSupport' | Create a new admin-support |

### POST /admin-support

**Handler:** \App\Http\Controllers\ConversationsController::class, 'getOrCreateAdminSupport'

**Description:** Create a new admin-support

---

### Resource

| Method | Endpoint | Handler | Description |
|--------|----------|---------|-------------|
| GET | /projects | SupervisorProjectsController::class@index | List all projects |
| GET | /projects/create | SupervisorProjectsController::class@create | Show form to create a new project |
| POST | /projects | SupervisorProjectsController::class@store | Store a new project |
| GET | /projects/{id} | SupervisorProjectsController::class@show | Show a specific project |
| GET | /projects/{id}/edit | SupervisorProjectsController::class@edit | Show form to edit project |
| PUT/PATCH | /projects/{id} | SupervisorProjectsController::class@update | Update a specific project |
| DELETE | /projects/{id} | SupervisorProjectsController::class@destroy | Delete a specific project |
| GET | /users | UsersController::class@index | List all users |
| GET | /users/create | UsersController::class@create | Show form to create a new user |
| POST | /users | UsersController::class@store | Store a new user |
| GET | /users/{id} | UsersController::class@show | Show a specific user |
| GET | /users/{id}/edit | UsersController::class@edit | Show form to edit user |
| PUT/PATCH | /users/{id} | UsersController::class@update | Update a specific user |
| DELETE | /users/{id} | UsersController::class@destroy | Delete a specific user |
| GET | /specializations | SpecializationsController::class@index | List all specializations |
| GET | /specializations/create | SpecializationsController::class@create | Show form to create a new specialization |
| POST | /specializations | SpecializationsController::class@store | Store a new specialization |
| GET | /specializations/{id} | SpecializationsController::class@show | Show a specific specialization |
| GET | /specializations/{id}/edit | SpecializationsController::class@edit | Show form to edit specialization |
| PUT/PATCH | /specializations/{id} | SpecializationsController::class@update | Update a specific specialization |
| DELETE | /specializations/{id} | SpecializationsController::class@destroy | Delete a specific specialization |
| GET | /departments | DepartmentsController::class@index | List all departments |
| GET | /departments/create | DepartmentsController::class@create | Show form to create a new department |
| POST | /departments | DepartmentsController::class@store | Store a new department |
| GET | /departments/{id} | DepartmentsController::class@show | Show a specific department |
| GET | /departments/{id}/edit | DepartmentsController::class@edit | Show form to edit department |
| PUT/PATCH | /departments/{id} | DepartmentsController::class@update | Update a specific department |
| DELETE | /departments/{id} | DepartmentsController::class@destroy | Delete a specific department |
| GET | /projects | ProjectsController::class@index | List all projects |
| GET | /projects/create | ProjectsController::class@create | Show form to create a new project |
| POST | /projects | ProjectsController::class@store | Store a new project |
| GET | /projects/{id} | ProjectsController::class@show | Show a specific project |
| GET | /projects/{id}/edit | ProjectsController::class@edit | Show form to edit project |
| PUT/PATCH | /projects/{id} | ProjectsController::class@update | Update a specific project |
| DELETE | /projects/{id} | ProjectsController::class@destroy | Delete a specific project |
| GET | /assignments | AssignmentsController::class@index | List all assignments |
| GET | /assignments/create | AssignmentsController::class@create | Show form to create a new assignment |
| POST | /assignments | AssignmentsController::class@store | Store a new assignment |
| GET | /assignments/{id} | AssignmentsController::class@show | Show a specific assignment |
| GET | /assignments/{id}/edit | AssignmentsController::class@edit | Show form to edit assignment |
| PUT/PATCH | /assignments/{id} | AssignmentsController::class@update | Update a specific assignment |
| DELETE | /assignments/{id} | AssignmentsController::class@destroy | Delete a specific assignment |
| GET | /defenses | DefensesController::class@index | List all defenses |
| GET | /defenses/create | DefensesController::class@create | Show form to create a new defense |
| POST | /defenses | DefensesController::class@store | Store a new defense |
| GET | /defenses/{id} | DefensesController::class@show | Show a specific defense |
| GET | /defenses/{id}/edit | DefensesController::class@edit | Show form to edit defense |
| PUT/PATCH | /defenses/{id} | DefensesController::class@update | Update a specific defense |
| DELETE | /defenses/{id} | DefensesController::class@destroy | Delete a specific defense |
| GET | /roles | RolesController::class@index | List all roles |
| GET | /roles/create | RolesController::class@create | Show form to create a new role |
| POST | /roles | RolesController::class@store | Store a new role |
| GET | /roles/{id} | RolesController::class@show | Show a specific role |
| GET | /roles/{id}/edit | RolesController::class@edit | Show form to edit role |
| PUT/PATCH | /roles/{id} | RolesController::class@update | Update a specific role |
| DELETE | /roles/{id} | RolesController::class@destroy | Delete a specific role |
| GET | /currencies | CurrenciesController::class@index | List all currencies |
| GET | /currencies/create | CurrenciesController::class@create | Show form to create a new currencie |
| POST | /currencies | CurrenciesController::class@store | Store a new currencie |
| GET | /currencies/{id} | CurrenciesController::class@show | Show a specific currencie |
| GET | /currencies/{id}/edit | CurrenciesController::class@edit | Show form to edit currencie |
| PUT/PATCH | /currencies/{id} | CurrenciesController::class@update | Update a specific currencie |
| DELETE | /currencies/{id} | CurrenciesController::class@destroy | Delete a specific currencie |
| GET | /payment-methods | PaymentMethodsController::class@index | List all payment-methods |
| GET | /payment-methods/create | PaymentMethodsController::class@create | Show form to create a new payment-method |
| POST | /payment-methods | PaymentMethodsController::class@store | Store a new payment-method |
| GET | /payment-methods/{id} | PaymentMethodsController::class@show | Show a specific payment-method |
| GET | /payment-methods/{id}/edit | PaymentMethodsController::class@edit | Show form to edit payment-method |
| PUT/PATCH | /payment-methods/{id} | PaymentMethodsController::class@update | Update a specific payment-method |
| DELETE | /payment-methods/{id} | PaymentMethodsController::class@destroy | Delete a specific payment-method |
| GET | //activity-logs | ActivityLogsController::class@index | List all /activity-logs |
| GET | //activity-logs/create | ActivityLogsController::class@create | Show form to create a new /activity-log |
| POST | //activity-logs | ActivityLogsController::class@store | Store a new /activity-log |
| GET | //activity-logs/{id} | ActivityLogsController::class@show | Show a specific /activity-log |
| GET | //activity-logs/{id}/edit | ActivityLogsController::class@edit | Show form to edit /activity-log |
| PUT/PATCH | //activity-logs/{id} | ActivityLogsController::class@update | Update a specific /activity-log |
| DELETE | //activity-logs/{id} | ActivityLogsController::class@destroy | Delete a specific /activity-log |

### GET /projects

**Handler:** SupervisorProjectsController::class@index

**Description:** List all projects

---

### GET /projects/create

**Handler:** SupervisorProjectsController::class@create

**Description:** Show form to create a new project

---

### POST /projects

**Handler:** SupervisorProjectsController::class@store

**Description:** Store a new project

---

### GET /projects/{id}

**Handler:** SupervisorProjectsController::class@show

**Description:** Show a specific project

---

### GET /projects/{id}/edit

**Handler:** SupervisorProjectsController::class@edit

**Description:** Show form to edit project

---

### PUT/PATCH /projects/{id}

**Handler:** SupervisorProjectsController::class@update

**Description:** Update a specific project

---

### DELETE /projects/{id}

**Handler:** SupervisorProjectsController::class@destroy

**Description:** Delete a specific project

---

### GET /users

**Handler:** UsersController::class@index

**Description:** List all users

---

### GET /users/create

**Handler:** UsersController::class@create

**Description:** Show form to create a new user

---

### POST /users

**Handler:** UsersController::class@store

**Description:** Store a new user

---

### GET /users/{id}

**Handler:** UsersController::class@show

**Description:** Show a specific user

---

### GET /users/{id}/edit

**Handler:** UsersController::class@edit

**Description:** Show form to edit user

---

### PUT/PATCH /users/{id}

**Handler:** UsersController::class@update

**Description:** Update a specific user

---

### DELETE /users/{id}

**Handler:** UsersController::class@destroy

**Description:** Delete a specific user

---

### GET /specializations

**Handler:** SpecializationsController::class@index

**Description:** List all specializations

---

### GET /specializations/create

**Handler:** SpecializationsController::class@create

**Description:** Show form to create a new specialization

---

### POST /specializations

**Handler:** SpecializationsController::class@store

**Description:** Store a new specialization

---

### GET /specializations/{id}

**Handler:** SpecializationsController::class@show

**Description:** Show a specific specialization

---

### GET /specializations/{id}/edit

**Handler:** SpecializationsController::class@edit

**Description:** Show form to edit specialization

---

### PUT/PATCH /specializations/{id}

**Handler:** SpecializationsController::class@update

**Description:** Update a specific specialization

---

### DELETE /specializations/{id}

**Handler:** SpecializationsController::class@destroy

**Description:** Delete a specific specialization

---

### GET /departments

**Handler:** DepartmentsController::class@index

**Description:** List all departments

---

### GET /departments/create

**Handler:** DepartmentsController::class@create

**Description:** Show form to create a new department

---

### POST /departments

**Handler:** DepartmentsController::class@store

**Description:** Store a new department

---

### GET /departments/{id}

**Handler:** DepartmentsController::class@show

**Description:** Show a specific department

---

### GET /departments/{id}/edit

**Handler:** DepartmentsController::class@edit

**Description:** Show form to edit department

---

### PUT/PATCH /departments/{id}

**Handler:** DepartmentsController::class@update

**Description:** Update a specific department

---

### DELETE /departments/{id}

**Handler:** DepartmentsController::class@destroy

**Description:** Delete a specific department

---

### GET /projects

**Handler:** ProjectsController::class@index

**Description:** List all projects

---

### GET /projects/create

**Handler:** ProjectsController::class@create

**Description:** Show form to create a new project

---

### POST /projects

**Handler:** ProjectsController::class@store

**Description:** Store a new project

---

### GET /projects/{id}

**Handler:** ProjectsController::class@show

**Description:** Show a specific project

---

### GET /projects/{id}/edit

**Handler:** ProjectsController::class@edit

**Description:** Show form to edit project

---

### PUT/PATCH /projects/{id}

**Handler:** ProjectsController::class@update

**Description:** Update a specific project

---

### DELETE /projects/{id}

**Handler:** ProjectsController::class@destroy

**Description:** Delete a specific project

---

### GET /assignments

**Handler:** AssignmentsController::class@index

**Description:** List all assignments

---

### GET /assignments/create

**Handler:** AssignmentsController::class@create

**Description:** Show form to create a new assignment

---

### POST /assignments

**Handler:** AssignmentsController::class@store

**Description:** Store a new assignment

---

### GET /assignments/{id}

**Handler:** AssignmentsController::class@show

**Description:** Show a specific assignment

---

### GET /assignments/{id}/edit

**Handler:** AssignmentsController::class@edit

**Description:** Show form to edit assignment

---

### PUT/PATCH /assignments/{id}

**Handler:** AssignmentsController::class@update

**Description:** Update a specific assignment

---

### DELETE /assignments/{id}

**Handler:** AssignmentsController::class@destroy

**Description:** Delete a specific assignment

---

### GET /defenses

**Handler:** DefensesController::class@index

**Description:** List all defenses

---

### GET /defenses/create

**Handler:** DefensesController::class@create

**Description:** Show form to create a new defense

---

### POST /defenses

**Handler:** DefensesController::class@store

**Description:** Store a new defense

---

### GET /defenses/{id}

**Handler:** DefensesController::class@show

**Description:** Show a specific defense

---

### GET /defenses/{id}/edit

**Handler:** DefensesController::class@edit

**Description:** Show form to edit defense

---

### PUT/PATCH /defenses/{id}

**Handler:** DefensesController::class@update

**Description:** Update a specific defense

---

### DELETE /defenses/{id}

**Handler:** DefensesController::class@destroy

**Description:** Delete a specific defense

---

### GET /roles

**Handler:** RolesController::class@index

**Description:** List all roles

---

### GET /roles/create

**Handler:** RolesController::class@create

**Description:** Show form to create a new role

---

### POST /roles

**Handler:** RolesController::class@store

**Description:** Store a new role

---

### GET /roles/{id}

**Handler:** RolesController::class@show

**Description:** Show a specific role

---

### GET /roles/{id}/edit

**Handler:** RolesController::class@edit

**Description:** Show form to edit role

---

### PUT/PATCH /roles/{id}

**Handler:** RolesController::class@update

**Description:** Update a specific role

---

### DELETE /roles/{id}

**Handler:** RolesController::class@destroy

**Description:** Delete a specific role

---

### GET /currencies

**Handler:** CurrenciesController::class@index

**Description:** List all currencies

---

### GET /currencies/create

**Handler:** CurrenciesController::class@create

**Description:** Show form to create a new currencie

---

### POST /currencies

**Handler:** CurrenciesController::class@store

**Description:** Store a new currencie

---

### GET /currencies/{id}

**Handler:** CurrenciesController::class@show

**Description:** Show a specific currencie

---

### GET /currencies/{id}/edit

**Handler:** CurrenciesController::class@edit

**Description:** Show form to edit currencie

---

### PUT/PATCH /currencies/{id}

**Handler:** CurrenciesController::class@update

**Description:** Update a specific currencie

---

### DELETE /currencies/{id}

**Handler:** CurrenciesController::class@destroy

**Description:** Delete a specific currencie

---

### GET /payment-methods

**Handler:** PaymentMethodsController::class@index

**Description:** List all payment-methods

---

### GET /payment-methods/create

**Handler:** PaymentMethodsController::class@create

**Description:** Show form to create a new payment-method

---

### POST /payment-methods

**Handler:** PaymentMethodsController::class@store

**Description:** Store a new payment-method

---

### GET /payment-methods/{id}

**Handler:** PaymentMethodsController::class@show

**Description:** Show a specific payment-method

---

### GET /payment-methods/{id}/edit

**Handler:** PaymentMethodsController::class@edit

**Description:** Show form to edit payment-method

---

### PUT/PATCH /payment-methods/{id}

**Handler:** PaymentMethodsController::class@update

**Description:** Update a specific payment-method

---

### DELETE /payment-methods/{id}

**Handler:** PaymentMethodsController::class@destroy

**Description:** Delete a specific payment-method

---

### GET //activity-logs

**Handler:** ActivityLogsController::class@index

**Description:** List all /activity-logs

---

### GET //activity-logs/create

**Handler:** ActivityLogsController::class@create

**Description:** Show form to create a new /activity-log

---

### POST //activity-logs

**Handler:** ActivityLogsController::class@store

**Description:** Store a new /activity-log

---

### GET //activity-logs/{id}

**Handler:** ActivityLogsController::class@show

**Description:** Show a specific /activity-log

---

### GET //activity-logs/{id}/edit

**Handler:** ActivityLogsController::class@edit

**Description:** Show form to edit /activity-log

---

### PUT/PATCH //activity-logs/{id}

**Handler:** ActivityLogsController::class@update

**Description:** Update a specific /activity-log

---

### DELETE //activity-logs/{id}

**Handler:** ActivityLogsController::class@destroy

**Description:** Delete a specific /activity-log

---

