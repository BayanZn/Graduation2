<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Support\Facades\DB;

return new class extends Migration
{
    /**
     * Run the migrations.
     */
    public function up(): void
    {
        // For MySQL, change ENUM to include 'code'
        DB::statement("ALTER TABLE defenses MODIFY discussion_type ENUM('proposal', 'seminar', 'code', 'final') NOT NULL");
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        // Remove 'code' from ENUM
        DB::statement("ALTER TABLE defenses MODIFY discussion_type ENUM('proposal', 'seminar', 'final') NOT NULL");
    }
};
