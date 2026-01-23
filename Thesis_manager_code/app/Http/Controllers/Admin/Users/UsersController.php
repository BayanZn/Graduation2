<?php

namespace App\Http\Controllers\Admin\Users;

use App\Http\Controllers\Controller;
use App\Http\Services\UploadService;
use App\Models\Specialization;
use App\Models\User;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\Gate;
use Illuminate\Support\Facades\Hash;
use Illuminate\Support\Facades\Redirect;
use Inertia\Inertia;
use Spatie\Permission\Models\Role;

class UsersController extends Controller
{
    public function index()
    {
        abort_if(Gate::denies('access_user_management'), 403);

        $per_page = request()->input('per_page') ?? 10;

        $users = User::with(['roles', 'media', 'specialization'])
            ->when(request()->has('search'), function ($query) {
                return $query
                    ->where('id', '!=', Auth::id())
                    ->where('id', '!=', 1)
                    ->where('name', '!=', 'Developer')
                    ->where('name', 'LIKE', '%'.request()->input('search').'%')
                    ->orWhere('email', 'LIKE', '%'.request()->input('search').'%');
            })
            ->where('id', '!=', Auth::id())
            ->where('id', '!=', 1)
            ->where('name', '!=', 'Developer')
            ->paginate($per_page)
            ->withQueryString();

        return Inertia::render('Admin/Users/Index', [
            'users' => $users,
            'filters' => request()->all('search', 'per_page'),
        ]);
    }

    public function create()
    {
        abort_if(Gate::denies('access_user_management'), 403);

        $roles = Role::where('name', '!=', 'Super Admin')->where('name', '!=', 'Developer')->get();
        $specializations = Specialization::all();

        return Inertia::render('Admin/Users/Create', [
            'roles' => $roles,
            'specializations' => $specializations,
        ]);
    }

    public function store(Request $request, UploadService $upload)
    {
        abort_if(Gate::denies('access_user_management'), 403);

        $request->validate([
            'name' => 'required|string|max:255',
            'email' => 'required|email|max:255|unique:users,email',
            'password' => 'required|string|min:8|max:255|confirmed',
            'specialization_id' => 'nullable|exists:specializations,id',
            'role' => 'required',
        ]);

        $user = User::create([
            'name' => $request->name,
            'email' => $request->email,
            'password' => Hash::make($request->password),
            'specialization_id' => $request->specialization_id,
        ]);

        $user->assignRole($request->role);

        if ($request->input('images')) {
            $upload->uploadImage($user, $request->input('images'), 'avatar');
        }

        return Redirect::route('users.index');
    }

    public function edit(User $user)
    {
        abort_if(Gate::denies('access_user_management'), 403);

        return Inertia::render('Admin/Users/Edit', [
            'user' => $user,
            'roles' => Role::where('name', '!=', 'Super Admin')->get(),
            'specializations' => Specialization::all(),
        ]);
    }

    public function update(Request $request, User $user, UploadService $upload)
    {
        abort_if(Gate::denies('access_user_management'), 403);

        $request->validate([
            'name' => 'required|string|max:255',
            'email' => 'required|email|max:255|unique:users,email,'.$user->id,
            'specialization_id' => 'nullable|exists:specializations,id',
            'role' => 'required',
        ]);

        $user->update([
            'name' => $request->name,
            'email' => $request->email,
            'specialization_id' => $request->specialization_id,
        ]);

        $user->syncRoles($request->role);

        if ($request->input('images')) {
            $upload->uploadImage($user, $request->input('images'), 'avatar');
        }

        return Redirect::route('users.index');
    }

    public function destroy(User $user)
    {
        abort_if(Gate::denies('access_user_management'), 403);

        $user->delete();

        return Redirect::route('users.index');
    }
}
