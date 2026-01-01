<?php

namespace App\Http\Controllers\Admin;

use App\Http\Controllers\Controller;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Gate;
use Illuminate\Support\Facades\Redirect;
use Inertia\Inertia;
use Spatie\Activitylog\Models\Activity;

class ActivityLogsController extends Controller
{
    public function index()
    {
        abort_if(Gate::denies('access_activity_logs'), 403);

        request()->validate([
            'direction' => ['in:asc,desc'],
            'field' => ['in:created_at'],
        ]);

        $per_page = request()->input('per_page') ?? 10;

        $start_date = get_start_end_date(request()->input('date_range'))[0];
        $end_date = get_start_end_date(request()->input('date_range'))[1];

        $logs = Activity::query()
            ->when(request()->has('field'), function ($query) {
                return $query
                    ->orderBy(request()->input('field'), request()->input('direction'));
            })
            ->when(request()->has('search'), function ($query) {
                $query
                    ->where('log_name', 'LIKE', '%'.request()->input('search').'%')
                    ->orWhere('description', 'LIKE', '%'.request()->input('search').'%')
                    ->orWhere('subject_type', 'LIKE', '%'.request()->input('search').'%');
            })
            ->when(request()->input('date_range'), function ($query) use ($start_date, $end_date) {
                $query->whereBetween(DB::raw('DATE(created_at)'), [$start_date, $end_date])
                    ->when(request()->has('search'), function ($query) {
                        $query
                            ->where('log_name', 'LIKE', '%'.request()->input('search').'%')
                            ->orWhere('description', 'LIKE', '%'.request()->input('search').'%')
                            ->orWhere('subject_type', 'LIKE', '%'.request()->input('search').'%');
                    });
            })
            ->latest()
            ->paginate($per_page)
            ->withQueryString();

        return Inertia::render('Admin/ActivityLogs/Index', [
            'logs' => $logs,
            'filters' => request()->all('per_page', 'search', 'date_range', 'field', 'direction'),
        ]);
    }

    public function destroy(Activity $activity_log)
    {
        abort_if(Gate::denies('access_activity_logs'), 403);

        $activity_log->delete();

        return Redirect::route('activity-logs.index');
    }

    /**
     * Delete multiple activity logs
     */
    public function destroyMultiple(Request $request)
    {
        abort_if(Gate::denies('access_activity_logs'), 403);

        Activity::whereIn('id', $request->selected_ids)->delete();

        return Redirect::route('activity-logs.index');
    }
}
