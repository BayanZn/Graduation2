<?php

namespace App\Http\Controllers\Supervisor;

use App\Http\Controllers\Controller;
use App\Models\Defense;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;
use Inertia\Inertia;

class DefensesController extends Controller
{
    public function index(Request $request)
    {
        $user = Auth::user();

        // Get defenses where user is a committee member
        $defenses = Defense::whereHas('members', function ($query) use ($user) {
            $query->where('user_id', $user->id);
        })
        ->with(['project.department', 'project.specialization', 'project.creator', 'members'])
        ->when($request->search, function ($query, $search) {
            $query->whereHas('project', function ($q) use ($search) {
                $q->where('title', 'like', "%{$search}%");
            });
        })
        ->when($request->status, function ($query, $status) {
            $query->where('status', $status);
        })
        ->when($request->type, function ($query, $type) {
            $query->where('discussion_type', $type);
        })
        ->latest('discussion_date')
        ->paginate($request->per_page ?? 10)
        ->withQueryString();

        return Inertia::render('Supervisor/Defenses/Index', [
            'defenses' => $defenses,
            'filters' => $request->only(['search', 'per_page', 'status', 'type']),
        ]);
    }

    public function show(Defense $defense)
    {
        $user = Auth::user();

        // Verify that the user is a committee member for this defense
        $isMember = $defense->members()
            ->where('user_id', $user->id)
            ->exists();

        abort_unless($isMember, 403, 'Unauthorized access to this defense.');

        $defense->load([
            'project.department',
            'project.specialization',
            'project.creator',
            'project.supervisors.media',
            'project.students.media',
            'members.media',
            'creator',
        ]);

        return Inertia::render('Supervisor/Defenses/Show', [
            'defense' => $defense,
        ]);
    }

    public function updateStatus(Request $request, Defense $defense)
    {
        $user = Auth::user();

        // Verify that the user is a committee member for this defense
        $isMember = $defense->members()
            ->where('user_id', $user->id)
            ->exists();

        abort_unless($isMember, 403, 'Unauthorized to update this defense.');

        $request->validate([
            'status' => 'required|in:scheduled,completed,cancelled',
        ]);

        $defense->update(['status' => $request->status]);

        return redirect()->back();
    }
}
