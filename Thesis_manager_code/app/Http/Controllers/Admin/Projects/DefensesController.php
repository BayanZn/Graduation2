<?php

namespace App\Http\Controllers\Admin\Projects;

use App\Http\Controllers\Controller;
use App\Models\Defense;
use App\Models\Project;
use App\Models\User;
use App\Notifications\DefenseScheduledNotification;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\Gate;
use Illuminate\Support\Facades\Redirect;
use Inertia\Inertia;

class DefensesController extends Controller
{
    /**
     * Display a listing of the resource.
     */
    public function index(Request $request)
    {
        abort_if(Gate::denies('view_defenses'), 403);

        $defenses = Defense::with(['project.department', 'project.specialization', 'project.students', 'members', 'creator'])
            ->when($request->search, function ($query, $search) {
                $query->whereHas('project', function ($q) use ($search) {
                    $q->where('title', 'like', "%{$search}%");
                })->orWhere('discussion_hall', 'like', "%{$search}%");
            })
            ->latest('discussion_date')
            ->paginate($request->per_page ?? 10)
            ->withQueryString();

        return Inertia::render('Admin/Projects/Defenses/Index', [
            'defenses' => $defenses,
            'filters' => request()->all('search', 'per_page'),
        ]);
    }

    /**
     * Show the form for creating a new resource.
     */
    public function create()
    {
        abort_if(Gate::denies('create_defenses'), 403);

        $projects = Project::where('status', 'Approved')
            ->with(['department', 'specialization', 'supervisors'])
            ->get();

        $supervisors = User::whereHas('roles', function ($query) {
            $query->where('name', 'supervisor');
        })->get();

        return Inertia::render('Admin/Projects/Defenses/Create', [
            'projects' => $projects,
            'supervisors' => $supervisors,
        ]);
    }

    /**
     * Store a newly created resource in storage.
     */
    public function store(Request $request)
    {
        abort_if(Gate::denies('create_defenses'), 403);

        $request->validate([
            'project_id' => 'required|exists:projects,id',
            'discussion_hall' => 'required|string|max:255',
            'discussion_date' => 'required|date',
            'discussion_type' => 'required|in:proposal,seminar,code,final',
            'members' => 'required|array|min:1',
            'members.*' => 'exists:users,id',
            'notes' => 'nullable|string',
        ]);

        $defense = Defense::create([
            'project_id' => $request->project_id,
            'discussion_hall' => $request->discussion_hall,
            'discussion_date' => $request->discussion_date,
            'discussion_type' => $request->discussion_type,
            'status' => 'scheduled',
            'notes' => $request->notes,
            'created_by' => Auth::id(),
        ]);

        // Add members
        foreach ($request->members as $memberId) {
            $defense->addMember($memberId);
        }

        // Load relationships for notification
        $defense->load(['project', 'members']);

        // Get the project
        $project = Project::with(['students', 'supervisors'])->find($request->project_id);

        // Notify all students assigned to this project
        foreach ($project->students as $student) {
            $student->notify(new DefenseScheduledNotification($defense));
        }

        // Notify all supervisors assigned to this project
        foreach ($project->supervisors as $supervisor) {
            $supervisor->notify(new DefenseScheduledNotification($defense));
        }

        // Notify defense committee members
        foreach ($defense->members as $member) {
            $member->notify(new DefenseScheduledNotification($defense));
        }

        return Redirect::route('defenses.index');
    }

    /**
     * Display the specified resource.
     */
    public function show(Defense $defense)
    {
        abort_if(Gate::denies('view_defenses'), 403);

        $defense->load([
            'project.department',
            'project.specialization',
            'project.students',
            'project.supervisors',
            'members',
            'creator',
        ]);

        return Inertia::render('Admin/Projects/Defenses/Show', [
            'defense' => $defense,
        ]);
    }

    /**
     * Show the form for editing the specified resource.
     */
    public function edit(Defense $defense)
    {
        abort_if(Gate::denies('edit_defenses'), 403);

        $defense->load(['project.department', 'project.specialization', 'members']);

        $supervisors = User::whereHas('roles', function ($query) {
            $query->where('name', 'supervisor');
        })->get();

        return Inertia::render('Admin/Projects/Defenses/Edit', [
            'defense' => $defense,
            'supervisors' => $supervisors,
        ]);
    }

    /**
     * Update the specified resource in storage.
     */
    public function update(Request $request, Defense $defense)
    {
        abort_if(Gate::denies('edit_defenses'), 403);

        $request->validate([
            'discussion_hall' => 'required|string|max:255',
            'discussion_date' => 'required|date',
            'discussion_type' => 'required|in:proposal,seminar,code,final',
            'members' => 'required|array|min:1',
            'members.*' => 'exists:users,id',
            'notes' => 'nullable|string',
        ]);

        $defense->update([
            'discussion_hall' => $request->discussion_hall,
            'discussion_date' => $request->discussion_date,
            'discussion_type' => $request->discussion_type,
            'notes' => $request->notes,
        ]);

        // Sync members
        $currentMembers = $defense->members->pluck('id')->toArray();
        $newMembers = $request->members;

        // Remove members not in the new list
        foreach ($currentMembers as $memberId) {
            if (! in_array($memberId, $newMembers)) {
                $defense->removeMember($memberId);
            }
        }

        // Add new members
        foreach ($newMembers as $memberId) {
            $defense->addMember($memberId);
        }

        return Redirect::route('defenses.index');
    }

    /**
     * Remove the specified resource from storage.
     */
    public function destroy(Defense $defense)
    {
        abort_if(Gate::denies('delete_defenses'), 403);

        $defense->delete();

        return Redirect::route('defenses.index');
    }

    /**
     * Remove a member from a defense.
     */
    public function removeMember(Defense $defense, User $user)
    {
        abort_if(Gate::denies('edit_defenses'), 403);

        $defense->removeMember($user->id);

        return Redirect::back();
    }

    /**
     * Update the status of a defense.
     */
    public function updateStatus(Request $request, Defense $defense)
    {
        abort_if(Gate::denies('edit_defenses'), 403);

        $request->validate([
            'status' => 'required|in:scheduled,completed,cancelled',
        ]);

        $defense->update(['status' => $request->status]);

        return Redirect::back();
    }
}
