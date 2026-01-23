<?php

namespace App\Http\Controllers\Admin\Dashboard;

use App\Http\Controllers\Controller;
use App\Models\Defense;
use App\Models\Project;
use App\Models\ProjectAssignment;
use Illuminate\Support\Facades\DB;
use Inertia\Inertia;

class DashboardController extends Controller
{
    public function dashboard()
    {
        // Overview Statistics
        $overview = [
            'total_projects' => Project::count(),
            'total_students' => ProjectAssignment::where('role', 'student')->distinct('user_id')->count('user_id'),
            'total_supervisors' => ProjectAssignment::where('role', 'supervisor')->distinct('user_id')->count('user_id'),
            'pending_defenses' => Defense::where('status', 'scheduled')->count(),
        ];

        // Projects by Status
        $projectsByStatus = Project::select('status', DB::raw('count(*) as count'))
            ->groupBy('status')
            ->pluck('count', 'status')
            ->toArray();

        // Projects by Type/Level
        $projectsByType = Project::select('project_type', DB::raw('count(*) as count'))
            ->groupBy('project_type')
            ->pluck('count', 'project_type')
            ->toArray();

        // Projects by Specialization
        $projectsBySpecialization = Project::join('specializations', 'projects.specialization_id', '=', 'specializations.id')
            ->select('specializations.short_name', 'specializations.name', DB::raw('count(*) as count'))
            ->groupBy('specializations.id', 'specializations.short_name', 'specializations.name')
            ->get()
            ->toArray();

        // Projects by Department
        $projectsByDepartment = Project::join('departments', 'projects.department_id', '=', 'departments.id')
            ->select('departments.short_name', 'departments.name', DB::raw('count(*) as count'))
            ->groupBy('departments.id', 'departments.short_name', 'departments.name')
            ->get()
            ->toArray();

        // Defense Statistics
        $defenseStats = Defense::select('status', DB::raw('count(*) as count'))
            ->groupBy('status')
            ->pluck('count', 'status')
            ->toArray();

        // Defense Types
        $defensesByType = Defense::select('discussion_type', DB::raw('count(*) as count'))
            ->groupBy('discussion_type')
            ->pluck('count', 'discussion_type')
            ->toArray();

        // Recent Projects (last 5)
        $recentProjects = Project::with(['department', 'specialization', 'creator'])
            ->latest()
            ->take(5)
            ->get()
            ->toArray();

        // Upcoming Defenses (next 5)
        $upcomingDefenses = Defense::with(['project', 'creator'])
            ->where('status', 'scheduled')
            ->where('discussion_date', '>=', now())
            ->orderBy('discussion_date')
            ->take(5)
            ->get()
            ->toArray();

        // Supervisor Workload (top 10)
        $supervisorWorkload = ProjectAssignment::join('users', 'project_assignments.user_id', '=', 'users.id')
            ->where('project_assignments.role', 'supervisor')
            ->select('users.name', DB::raw('count(*) as count'))
            ->groupBy('users.id', 'users.name')
            ->orderByDesc('count')
            ->take(10)
            ->get()
            ->toArray();

        // Project Status by Specialization
        $statusBySpecialization = Project::join('specializations', 'projects.specialization_id', '=', 'specializations.id')
            ->select('specializations.short_name', 'projects.status', DB::raw('count(*) as count'))
            ->groupBy('specializations.short_name', 'projects.status')
            ->get()
            ->groupBy('short_name')
            ->map(function ($items) {
                return $items->pluck('count', 'status')->toArray();
            })
            ->toArray();

        // Project Type by Specialization
        $typeBySpecialization = Project::join('specializations', 'projects.specialization_id', '=', 'specializations.id')
            ->select('specializations.short_name', 'projects.project_type', DB::raw('count(*) as count'))
            ->groupBy('specializations.short_name', 'projects.project_type')
            ->get()
            ->groupBy('short_name')
            ->map(function ($items) {
                return $items->pluck('count', 'project_type')->toArray();
            })
            ->toArray();

        return Inertia::render('Admin/Dashboard', [
            'overview' => $overview,
            'projectsByStatus' => $projectsByStatus,
            'projectsByType' => $projectsByType,
            'projectsBySpecialization' => $projectsBySpecialization,
            'projectsByDepartment' => $projectsByDepartment,
            'defenseStats' => $defenseStats,
            'defensesByType' => $defensesByType,
            'recentProjects' => $recentProjects,
            'upcomingDefenses' => $upcomingDefenses,
            'statusBySpecialization' => $statusBySpecialization,
            'typeBySpecialization' => $typeBySpecialization,
            'supervisorWorkload' => $supervisorWorkload,
        ]);
    }
}
