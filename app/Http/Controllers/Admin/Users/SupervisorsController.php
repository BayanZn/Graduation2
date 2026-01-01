<?php

namespace App\Http\Controllers\Admin\Users;

use App\Http\Controllers\Controller;
use App\Models\User;
use Illuminate\Support\Facades\Gate;
use Inertia\Inertia;

class SupervisorsController extends Controller
{
    /**
     * Display a listing of the resource.
     */
    public function index()
    {
        abort_if(Gate::denies('view_supervisors'), 403);

        $per_page = request()->input('per_page') ?? 10;

        $supervisors = User::with(['roles', 'media'])
            ->whereHas('roles', function ($query) {
                $query->where('name', 'supervisor');
            })
            ->when(request()->has('search'), function ($query) {
                return $query
                    ->where('name', 'LIKE', '%'.request()->input('search').'%')
                    ->orWhere('email', 'LIKE', '%'.request()->input('search').'%');
            })
            ->paginate($per_page)
            ->withQueryString();

        return Inertia::render('Admin/Users/Supervisors/Index', [
            'supervisors' => $supervisors,
            'filters' => request()->all('search', 'per_page'),
        ]);
    }
}
