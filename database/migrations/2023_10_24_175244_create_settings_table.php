<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    /**
     * Run the migrations.
     */
    public function up(): void
    {
        Schema::create('settings', function (Blueprint $table) {
            $table->id();
            $table->unsignedBigInteger('currency_id')->nullable();
            $table->string('company_name')->nullable();
            $table->string('company_email')->nullable();
            $table->string('company_email_2')->nullable();
            $table->string('company_mobile')->nullable();
            $table->string('company_mobile_2')->nullable();
            $table->string('currency_position')->nullable();
            $table->string('notification_email')->nullable();
            $table->text('footer_text')->nullable();
            $table->text('company_address')->nullable();
            $table->string('vat_id')->nullable();
            $table->integer('tax_percentage')->nullable();
            $table->boolean('decimal_point')->default(1);
            $table->string('date_format')->nullable();
            $table->string('time_zone')->nullable();
            $table->string('time_format')->nullable();
            $table->foreign('currency_id')->references('id')->on('currencies')
                ->nullOnDelete();
            $table->timestamps();
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('settings');
    }
};
