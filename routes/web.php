<?php

use App\Http\Controllers\Admin\ActivityLogsController;
use App\Http\Controllers\Admin\Dashboard\DashboardController;
use App\Http\Controllers\Admin\ProjectRequestsController;
use App\Http\Controllers\Admin\Projects\AssignmentsController;
use App\Http\Controllers\Admin\Projects\DefensesController;
use App\Http\Controllers\Admin\Projects\DepartmentsController;
use App\Http\Controllers\Admin\Projects\ProjectsController;
use App\Http\Controllers\Admin\Projects\SpecializationsController;
use App\Http\Controllers\Admin\Settings\CurrenciesController;
use App\Http\Controllers\Admin\Settings\PaymentMethodsController;
use App\Http\Controllers\Admin\Settings\SettingsController;
use App\Http\Controllers\Admin\Users\RolesController;
use App\Http\Controllers\Admin\Users\StudentsController;
use App\Http\Controllers\Admin\Users\SupervisorsController;
use App\Http\Controllers\Admin\Users\UsersController;
use App\Http\Controllers\DashboardRedirectController;
use App\Http\Controllers\ProfileController;
use App\Http\Controllers\Student\AssignedProjectsController;
use App\Http\Controllers\Student\AvailableProjectsController;
use App\Http\Controllers\Student\Dashboard\DashboardController as StudentDashboardController;
use App\Http\Controllers\Student\ProjectSubmissionsController as StudentProjectSubmissionsController;
use App\Http\Controllers\Supervisor\Dashboard\DashboardController as SupervisorDashboardController;
use App\Http\Controllers\Supervisor\DefensesController as SupervisorDefensesController;
use App\Http\Controllers\Supervisor\ProjectsController as SupervisorProjectsController;
use App\Http\Controllers\Supervisor\ProjectSubmissionsController as SupervisorProjectSubmissionsController;
use App\Http\Controllers\Supervisor\StudentsController as SupervisorStudentsController;
use App\Http\Controllers\Supervisor\SupervisedProjectsController;
use App\Http\Controllers\UploadsController;
use Illuminate\Support\Facades\Route;
use Inertia\Inertia;

/*
|--------------------------------------------------------------------------
| Web Routes
|--------------------------------------------------------------------------
*/

require __DIR__.'/auth.php';

Route::get('/', function () {
    return Inertia::render('Auth/Login', [
        'canLogin' => Route::has('login'),
        'canRegister' => Route::has('register'),
    ]);
});

// Dashboard redirect based on role
Route::get('/dashboard', [DashboardRedirectController::class, 'redirect'])
    ->middleware('auth')
    ->name('dashboard');

// Notifications (for all authenticated users)
Route::group(['prefix' => 'notifications', 'middleware' => 'auth'], function () {
    Route::get('/', [\App\Http\Controllers\NotificationController::class, 'index'])
        ->name('notifications.index');
    Route::post('/{id}/read', [\App\Http\Controllers\NotificationController::class, 'markAsRead'])
        ->name('notifications.read');
    Route::post('/read-all', [\App\Http\Controllers\NotificationController::class, 'markAllAsRead'])
        ->name('notifications.read-all');
    Route::delete('/{id}', [\App\Http\Controllers\NotificationController::class, 'destroy'])
        ->name('notifications.destroy');
});

// Student
Route::group(['prefix' => 'student', 'middleware' => ['auth', 'role.student']], function () {
    // Dashboard
    Route::get('/dashboard', [StudentDashboardController::class, 'dashboard'])
        ->name('student.dashboard');
    Route::get('/assigned-projects', [AssignedProjectsController::class, 'index'])
        ->name('student.assigned-projects.index');
    Route::get('/assigned-projects/{project}', [AssignedProjectsController::class, 'show'])
        ->name('student.assigned-projects.show');
    Route::get('/available-projects', [AvailableProjectsController::class, 'index'])
        ->name('student.available-projects.index');
    Route::get('/available-projects/{project}', [AvailableProjectsController::class, 'show'])
        ->name('student.available-projects.show');
    Route::post('/available-projects/{project}/request', [AvailableProjectsController::class, 'requestProject'])
        ->name('student.available-projects.request');

    // Project Submissions
    Route::get('/project-submissions', [StudentProjectSubmissionsController::class, 'index'])
        ->name('student.project-submissions.index');
    Route::post('/project-submissions', [StudentProjectSubmissionsController::class, 'store'])
        ->name('student.project-submissions.store');
    Route::delete('/project-submissions/{projectSubmission}', [StudentProjectSubmissionsController::class, 'destroy'])
        ->name('student.project-submissions.destroy');
});

// Supervisor Dashboard
Route::group(['prefix' => 'supervisor', 'middleware' => ['auth', 'role.supervisor']], function () {
    Route::get('/dashboard', [SupervisorDashboardController::class, 'dashboard'])
        ->name('supervisor.dashboard');
    Route::get('/supervised-projects', [SupervisedProjectsController::class, 'index'])
        ->name('supervisor.supervised-projects.index');
    Route::get('/supervised-projects/{project}', [SupervisedProjectsController::class, 'show'])
        ->name('supervisor.supervised-projects.show');
    Route::patch('/supervised-projects/{project}/type', [SupervisedProjectsController::class, 'updateType'])
        ->name('supervisor.supervised-projects.update-type');
    Route::patch('/supervised-projects/submissions/{projectSubmission}/status', [SupervisedProjectsController::class, 'updateSubmissionStatus'])
        ->name('supervisor.supervised-projects.update-submission-status');
    Route::get('/students', [SupervisorStudentsController::class, 'index'])
        ->name('supervisor.students.index');
    Route::get('/defenses', [SupervisorDefensesController::class, 'index'])
        ->name('supervisor.defenses.index');
    Route::get('/defenses/{defense}', [SupervisorDefensesController::class, 'show'])
        ->name('supervisor.defenses.show');
    Route::patch('/defenses/{defense}/status', [SupervisorDefensesController::class, 'updateStatus'])
        ->name('supervisor.defenses.update-status');

    // Project Submissions
    Route::get('/project-submissions', [SupervisorProjectSubmissionsController::class, 'index'])
        ->name('supervisor.project-submissions.index');
    Route::get('/project-submissions/{projectSubmission}', [SupervisorProjectSubmissionsController::class, 'show'])
        ->name('supervisor.project-submissions.show');
    Route::patch('/project-submissions/{projectSubmission}/status', [SupervisorProjectSubmissionsController::class, 'updateStatus'])
        ->name('supervisor.project-submissions.update-status');

    Route::resource('projects', SupervisorProjectsController::class)
        ->names([
            'index' => 'supervisor.projects.index',
            'create' => 'supervisor.projects.create',
            'store' => 'supervisor.projects.store',
            'show' => 'supervisor.projects.show',
            'edit' => 'supervisor.projects.edit',
            'update' => 'supervisor.projects.update',
            'destroy' => 'supervisor.projects.destroy',
        ]);
});

// Admin
Route::group(['prefix' => 'admin'], function () {
    Route::middleware(['auth', 'role.admin'])->group(function () {
        // Dashboard
        Route::get('/dashboard', [DashboardController::class, 'dashboard'])
            ->name('admin.dashboard');

        // Profile
        Route::get('/profile', [ProfileController::class, 'edit'])->name('profile.edit');
        Route::patch('/profile', [ProfileController::class, 'update'])->name('profile.update');
        Route::delete('/profile', [ProfileController::class, 'destroy'])->name('profile.destroy');

        // Uploads
        Route::post('/filepond/upload', [UploadsController::class, 'filepondUpload'])
            ->name('filepond.upload');
        Route::delete('/filepond/revert/{filename}', [UploadsController::class, 'filepondRevert'])
            ->name('filepond.revert');
        Route::delete('/filepond/remove/{filename}', [UploadsController::class, 'filepondRemove'])
            ->name('filepond.remove');

        // Users
        Route::resource('users', UsersController::class)->except('show');

        // Students
        Route::get('students', [StudentsController::class, 'index'])->name('students.index');

        // Supervisors
        Route::get('supervisors', [SupervisorsController::class, 'index'])->name('supervisors.index');

        // Specializations
        Route::get('specializations/export', [SpecializationsController::class, 'export'])
            ->name('specializations.export');
        Route::post('specializations/import', [SpecializationsController::class, 'import'])
            ->name('specializations.import');
        Route::resource('specializations', SpecializationsController::class)
            ->except('show', 'create');

        // Departments
        Route::get('departments/export', [DepartmentsController::class, 'export'])
            ->name('departments.export');
        Route::post('departments/import', [DepartmentsController::class, 'import'])
            ->name('departments.import');
        Route::resource('departments', DepartmentsController::class)
            ->except('show', 'create');

        // Projects
        Route::get('/projects/export', [ProjectsController::class, 'export'])
            ->name('projects.export');
        Route::post('/projects/import', [ProjectsController::class, 'import'])
            ->name('projects.import');
        Route::get('/projects/proposed', [ProjectsController::class, 'proposed'])
            ->name('projects.proposed');
        Route::get('/projects/approved', [ProjectsController::class, 'approved'])
            ->name('projects.approved');
        Route::get('/projects/declined', [ProjectsController::class, 'declined'])
            ->name('projects.declined');
        Route::patch('/projects/{project}/status', [ProjectsController::class, 'updateStatus'])
            ->name('projects.update.status');
        Route::patch('/projects/{project}/type', [ProjectsController::class, 'updateType'])
            ->name('projects.update.type');
        Route::resource('projects', ProjectsController::class);

        // Assignments
        Route::delete('/assignments/{project}/supervisor/{user}', [AssignmentsController::class, 'removeSupervisor'])
            ->name('assignments.remove-supervisor');
        Route::delete('/assignments/{project}/student/{user}', [AssignmentsController::class, 'removeStudent'])
            ->name('assignments.remove-student');
        Route::resource('assignments', AssignmentsController::class)->parameters([
            'assignments' => 'project',
        ]);

        // Defenses
        Route::delete('/defenses/{defense}/member/{user}', [DefensesController::class, 'removeMember'])
            ->name('defenses.remove-member');
        Route::patch('/defenses/{defense}/status', [DefensesController::class, 'updateStatus'])
            ->name('defenses.update-status');
        Route::resource('defenses', DefensesController::class);

        // Project Requests
        Route::post('/project-requests/{projectRequest}/approve', [ProjectRequestsController::class, 'approve'])
            ->name('project.requests.approve');
        Route::post('/project-requests/{projectRequest}/reject', [ProjectRequestsController::class, 'reject'])
            ->name('project.requests.reject');
        Route::post('/project-requests/{projectRequest}/reset-to-pending', [ProjectRequestsController::class, 'resetToPending'])
            ->name('project.requests.reset-to-pending');
        Route::get('/project-requests', [ProjectRequestsController::class, 'index'])
            ->name('project.requests.index');
        Route::get('/project-requests/{projectRequest}', [ProjectRequestsController::class, 'show'])
            ->name('project.requests.show');

        /* --------------------------------------------------------------------------------------- */

        // Roles
        Route::resource('roles', RolesController::class)->except('show');

        // Currencies
        Route::resource('currencies', CurrenciesController::class)->except('show', 'create');

        // Payment Methods
        Route::resource('payment-methods', PaymentMethodsController::class)
            ->except('show', 'create');

        // Activity Logs
        Route::delete('/activity-logs/multiple', [ActivityLogsController::class, 'destroyMultiple'])
            ->name('activity-logs.destroy.multiple');
        Route::resource('/activity-logs', ActivityLogsController::class)
            ->only(['index', 'destroy']);

        // Settings
        Route::get('/settings', [SettingsController::class, 'edit'])->name('settings.edit');
        Route::post('/settings/{setting}', [SettingsController::class, 'update'])
            ->name('settings.update');
    });
});

// Chat Routes (for authenticated users - supervisors and students)
Route::group(['prefix' => 'chat', 'middleware' => ['auth']], function () {
    Route::get('/', function () {
        return inertia('Chat/Index');
    })->name('chat.index');

    Route::get('/conversations', [\App\Http\Controllers\ConversationsController::class, 'index'])
        ->name('conversations.index');
    Route::get('/conversations/{conversation}', [\App\Http\Controllers\ConversationsController::class, 'show'])
        ->name('conversations.show');
    Route::delete('/conversations/{conversation}', [\App\Http\Controllers\ConversationsController::class, 'destroy'])
        ->name('conversations.destroy');
    Route::post('/projects/{project}/chat', [\App\Http\Controllers\ConversationsController::class, 'storeProjectChat'])
        ->name('conversations.project.store');
    Route::post('/admin-support', [\App\Http\Controllers\ConversationsController::class, 'getOrCreateAdminSupport'])
        ->name('conversations.admin-support');

    Route::post('/conversations/{conversation}/messages', [\App\Http\Controllers\MessagesController::class, 'store'])
        ->name('messages.store');
    Route::post('/conversations/{conversation}/mark-as-read', [\App\Http\Controllers\MessagesController::class, 'markAsRead'])
        ->name('messages.mark-as-read');
    Route::get('/conversations/{conversation}/load-more', [\App\Http\Controllers\MessagesController::class, 'loadMore'])
        ->name('messages.load-more');
});
