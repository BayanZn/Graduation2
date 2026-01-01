<?php

namespace App\Http\Controllers\Admin\Settings;

use App\Http\Controllers\Controller;
use App\Models\Currency;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Gate;
use Illuminate\Support\Facades\Redirect;
use Inertia\Inertia;

class CurrenciesController extends Controller
{
    /**
     * Display a listing of the resource.
     */
    public function index()
    {
        abort_if(Gate::denies('access_currencies'), 403);

        $per_page = request()->input('per_page') ?? 10;

        $currencies = Currency::query()
            ->when(request()->has('search'), function ($query) {
                return $query
                    ->where('currency_name', 'LIKE', '%'.request()->input('search').'%')
                    ->orWhere('code', 'LIKE', '%'.request()->input('search').'%')
                    ->orWhere('symbol', 'LIKE', '%'.request()->input('search').'%');
            })
            ->paginate($per_page)
            ->withQueryString();

        return Inertia::render('Admin/Settings/Currencies/Index', [
            'currencies' => $currencies,
            'filters' => request()->all('search', 'per_page'),
        ]);
    }

    // No longer needed: handled by modal in index

    /**
     * Store a newly created resource in storage.
     */
    public function store(Request $request)
    {
        abort_if(Gate::denies('access_currencies'), 403);

        $request->validate([
            'currency_name' => ['required', 'string', 'max:255'],
            'code' => ['required', 'string', 'max:255'],
            'symbol' => ['required', 'string', 'max:255'],
            'thousand_separator' => ['required', 'string', 'max:255'],
            'decimal_separator' => ['required', 'string', 'max:255'],
        ]);

        Currency::create($request->all());

        cache()->clear();

        return Redirect::route('currencies.index');
    }

    /**
     * Show the form for editing the specified resource.
     */
    public function edit(Currency $currency)
    {
        abort_if(Gate::denies('access_currencies'), 403);

        return response()->json($currency);
    }

    /**
     * Update the specified resource in storage.
     */
    public function update(Request $request, Currency $currency)
    {
        abort_if(Gate::denies('access_currencies'), 403);

        $request->validate([
            'currency_name' => ['required', 'string', 'max:255'],
            'code' => ['required', 'string', 'max:255'],
            'symbol' => ['required', 'string', 'max:255'],
            'thousand_separator' => ['required', 'string', 'max:255'],
            'decimal_separator' => ['required', 'string', 'max:255'],
        ]);

        $currency->update($request->all());

        cache()->clear();

        return Redirect::back();
    }

    /**
     * Remove the specified resource from storage.
     */
    public function destroy(Currency $currency)
    {
        abort_if(Gate::denies('access_currencies'), 403);

        $currency->delete();

        return Redirect::route('currencies.index');
    }
}
