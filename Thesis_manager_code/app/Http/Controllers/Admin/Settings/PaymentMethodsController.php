<?php

namespace App\Http\Controllers\Admin\Settings;

use App\Http\Controllers\Controller;
use App\Models\PaymentMethod;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Gate;
use Illuminate\Support\Facades\Redirect;
use Inertia\Inertia;

class PaymentMethodsController extends Controller
{
    /**
     * Display a listing of the resource.
     */
    public function index()
    {
        abort_if(Gate::denies('access_payment_methods'), 403);

        $per_page = request()->input('per_page') ?? 10;

        $payment_methods = PaymentMethod::query()
            ->when(request()->has('search'), function ($query) {
                return $query
                    ->where('method_name', 'LIKE', '%'.request()->input('search').'%')
                    ->orWhere('short_code', 'LIKE', '%'.request()->input('search').'%');
            })
            ->paginate($per_page)
            ->withQueryString();

        return Inertia::render('Admin/Settings/PaymentMethods/Index', [
            'payment_methods' => $payment_methods,
            'filters' => request()->all('search', 'per_page'),
        ]);
    }

    /**
     * Store a newly created resource in storage.
     */
    public function store(Request $request)
    {
        abort_if(Gate::denies('access_payment_methods'), 403);

        $request->validate([
            'method_name' => 'required|string|max:255|unique:payment_methods,method_name',
            'short_code' => 'required|max:255|unique:payment_methods,short_code',
        ]);

        PaymentMethod::create($request->all());

        return Redirect::route('payment-methods.index');
    }

    /**
     * Show the form for editing the specified resource.
     */
    public function edit(string $id)
    {
        abort_if(Gate::denies('access_payment_methods'), 403);

        $payment_method = PaymentMethod::findOrFail($id);

        return response()->json($payment_method);
    }

    /**
     * Update the specified resource in storage.
     */
    public function update(Request $request, PaymentMethod $payment_method)
    {
        abort_if(Gate::denies('access_payment_methods'), 403);

        $request->validate([
            'method_name' => 'required|string|max:255|unique:payment_methods,method_name,'.$payment_method->id,
            'short_code' => 'required|max:255|unique:payment_methods,short_code,'.$payment_method->id,
        ]);

        $payment_method->update($request->all());

        return Redirect::route('payment-methods.index');
    }

    /**
     * Remove the specified resource from storage.
     */
    public function destroy(PaymentMethod $payment_method)
    {
        abort_if(Gate::denies('access_payment_methods'), 403);

        $payment_method->delete();

        return Redirect::route('payment-methods.index');
    }
}
