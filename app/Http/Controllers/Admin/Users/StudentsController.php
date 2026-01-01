<?php

namespace App\Http\Controllers\Admin\Users;

use App\Http\Controllers\Controller;
use App\Models\User;
use Illuminate\Support\Facades\Gate;
use Inertia\Inertia;

class StudentsController extends Controller
{
    /**
     * Display a listing of the resource.
     */
    public function index()
    {
        abort_if(Gate::denies('view_students'), 403);

        $per_page = request()->input('per_page') ?? 10;

        $students = User::with(['roles', 'media'])
            ->whereHas('roles', function ($query) {
                $query->where('name', 'student');
            })
            ->when(request()->has('search'), function ($query) {
                return $query
                    ->where('name', 'LIKE', '%'.request()->input('search').'%')
                    ->orWhere('email', 'LIKE', '%'.request()->input('search').'%');
            })
            ->paginate($per_page)
            ->withQueryString();

        return Inertia::render('Admin/Users/Students/Index', [
            'students' => $students,
            'filters' => request()->all('search', 'per_page'),
        ]);
    }
}
