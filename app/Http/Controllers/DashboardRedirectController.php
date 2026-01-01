<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;

class DashboardRedirectController extends Controller
{
    public function redirect()
    {
        $user = Auth::user();

        // Check user roles and redirect accordingly
        if ($user->hasRole('student')) {
            return redirect()->route('student.dashboard');
        } elseif ($user->hasRole('supervisor')) {
            return redirect()->route('supervisor.dashboard');
        } else {
            return redirect()->route('admin.dashboard');
        }
    }
}
