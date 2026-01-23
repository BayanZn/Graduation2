<?php

namespace App\Http\Controllers\Admin\Users;

use App\Http\Controllers\Controller;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Gate;
use Illuminate\Support\Facades\Redirect;
use Inertia\Inertia;
use Spatie\Permission\Models\Permission;
use Spatie\Permission\Models\Role;

class RolesController extends Controller
{
    public function index()
    {
        abort_if(Gate::denies('access_user_management'), 403);

        $per_page = request()->input('per_page') ?? 10;

        $roles = Role::with('permissions')
            ->where('name', '!=', 'Super Admin')
            ->where('name', '!=', 'Developer')
            ->when(request()->has('search'), function ($query) {
                return $query
                    ->where('name', 'LIKE', '%'.request()->input('search').'%');
            })
            ->paginate($per_page)
            ->withQueryString();

        return Inertia::render('Admin/Users/Roles/Index', [
            'roles' => $roles,
            'filters' => request()->all('search', 'per_page'),
        ]);
    }

    public function create()
    {
        abort_if(Gate::denies('access_user_management'), 403);

        $permissions = Permission::get();

        return Inertia::render('Admin/Users/Roles/Create', [
            'permissions' => $permissions,
        ]);
    }

    public function store(Request $request)
    {
        abort_if(Gate::denies('access_user_management'), 403);

        $request->validate([
            'name' => 'required|string|max:255',
            'permissions' => 'required|array',
        ]);

        $role = Role::create([
            'name' => $request->name,
        ]);

        $role->givePermissionTo($request->permissions);

        cache()->clear();

        return Redirect::route('roles.index');
    }

    public function edit($id)
    {
        abort_if(Gate::denies('access_user_management'), 403);

        $role = Role::with('permissions')->find($id);
        $permissions = Permission::get();

        return Inertia::render('Admin/Users/Roles/Edit', [
            'role' => $role,
            'permissions' => $permissions,
        ]);
    }

    public function update(Request $request, Role $role)
    {
        abort_if(Gate::denies('access_user_management'), 403);

        $request->validate([
            'name' => 'required|string|max:255',
            'permissions' => 'required|array',
        ]);

        $role->update([
            'name' => $request->name,
        ]);

        $role->syncPermissions($request->permissions);

        cache()->clear();

        return Redirect::route('roles.index');
    }

    public function destroy(Role $role)
    {
        abort_if(Gate::denies('access_user_management'), 403);

        $role->delete();

        return Redirect::route('roles.index');
    }
}
