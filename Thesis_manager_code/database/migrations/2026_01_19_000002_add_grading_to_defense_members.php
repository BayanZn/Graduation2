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
        Schema::table('defense_members', function (Blueprint $table) {
            $table->decimal('grade', 5, 2)->nullable()->after('user_id')->comment('Individual grade from this member');
            $table->text('feedback')->nullable()->after('grade')->comment('Feedback from this member');
            $table->timestamp('graded_at')->nullable()->after('feedback');
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::table('defense_members', function (Blueprint $table) {
            $table->dropColumn(['grade', 'feedback', 'graded_at']);
        });
    }
};
