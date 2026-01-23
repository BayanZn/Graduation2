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
        Schema::table('defenses', function (Blueprint $table) {
            $table->decimal('total_grade', 5, 2)->nullable()->after('status')->comment('Total average grade out of max for this discussion type');
            $table->timestamp('graded_at')->nullable()->after('total_grade')->comment('When all members completed grading');
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::table('defenses', function (Blueprint $table) {
            $table->dropColumn(['total_grade', 'graded_at']);
        });
    }
};
