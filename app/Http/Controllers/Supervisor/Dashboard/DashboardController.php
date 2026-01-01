<?php

namespace App\Http\Controllers\Supervisor\Dashboard;

use App\Http\Controllers\Controller;
use App\Models\Project;
use App\Models\Defense;
use App\Models\ProjectAssignment;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;
use Inertia\Inertia;

class DashboardController extends Controller
{
    public function dashboard()
    {
        $user = Auth::user();

        // Get projects supervised by this user
        $supervisedProjectIds = ProjectAssignment::where('user_id', $user->id)
            ->where('role', 'supervisor')
            ->pluck('project_id');

        $supervisedProjects = Project::whereIn('id', $supervisedProjectIds)
            ->with(['department', 'specialization', 'creator'])
            ->latest()
            ->get();

        // Get defenses where supervisor is a discussion member
        $supervisedDefenses = Defense::whereHas('members', function ($query) use ($user) {
            $query->where('user_id', $user->id);
        })
        ->with(['project.department', 'project.creator'])
        ->latest()
        ->get();

        // Calculate statistics
        $statistics = [
            'total_supervised_projects' => $supervisedProjects->count(),
            'approved_projects' => Project::where('created_by', $user->id)->where('status', 'Approved')->count(),
            'pending_projects' => Project::where('created_by', $user->id)->where('status', 'Proposed')->count(),
            'declined_projects' => $supervisedProjects->where('status', 'declined')->count(),
            'total_defenses' => $supervisedDefenses->count(),
            'completed_defenses' => $supervisedDefenses->where('status', 'completed')->count(),
            'scheduled_defenses' => $supervisedDefenses->where('status', 'scheduled')->count(),
        ];

        return Inertia::render('Supervisor/Dashboard', [
            'statistics' => $statistics,
            'supervisedProjects' => $supervisedProjects->take(5), // Latest 5 projects
            'supervisedDefenses' => $supervisedDefenses->take(5), // Latest 5 defenses
        ]);
    }
}
