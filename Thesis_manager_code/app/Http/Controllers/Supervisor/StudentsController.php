<?php

namespace App\Http\Controllers\Supervisor;

use App\Http\Controllers\Controller;
use App\Models\User;
use App\Models\ProjectAssignment;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;
use Inertia\Inertia;

class StudentsController extends Controller
{
    public function index(Request $request)
    {
        $user = Auth::user();

        // Get all projects where this user is a supervisor
        $supervisedProjectIds = ProjectAssignment::where('user_id', $user->id)
            ->where('role', 'supervisor')
            ->pluck('project_id');

        // Get all students assigned to these projects
        $students = User::whereHas('assignments', function ($query) use ($supervisedProjectIds) {
            $query->whereIn('project_id', $supervisedProjectIds)
                  ->where('role', 'student');
        })
        ->with(['assignments' => function ($query) use ($supervisedProjectIds) {
            $query->whereIn('project_id', $supervisedProjectIds)
                  ->where('role', 'student')
                  ->with('project:id,title,project_type,status');
        }])
        ->when($request->search, function ($query, $search) {
            $query->where('name', 'like', "%{$search}%")
                  ->orWhere('email', 'like', "%{$search}%");
        })
        ->latest()
        ->paginate($request->per_page ?? 10)
        ->withQueryString();

        return Inertia::render('Supervisor/Students/Index', [
            'students' => $students,
            'filters' => $request->only(['search', 'per_page']),
        ]);
    }
}
