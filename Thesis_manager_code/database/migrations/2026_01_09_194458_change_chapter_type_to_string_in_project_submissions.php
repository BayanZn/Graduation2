<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;
use Illuminate\Support\Facades\DB;

return new class extends Migration
{
    public function up(): void
    {
        // For MySQL, change ENUM to VARCHAR
        DB::statement("ALTER TABLE project_submissions MODIFY chapter_type VARCHAR(255) NOT NULL");
        
        // Also need to add the missing 'code_link' column if it doesn't exist
        if (!Schema::hasColumn('project_submissions', 'code_link')) {
            Schema::table('project_submissions', function (Blueprint $table) {
                $table->string('code_link', 500)->nullable()->after('file_path');
            });
        }
    }

    public function down(): void
    {
        // Revert to ENUM
        DB::statement("ALTER TABLE project_submissions MODIFY chapter_type ENUM(
            'Introduction',
            'Literature Review',
            'Methodology',
            'Result & Analysis',
            'Conclusion',
            'Abstract',
            'Full Draft'
        ) NOT NULL");
        
        // Remove code_link column if reverting
        if (Schema::hasColumn('project_submissions', 'code_link')) {
            Schema::table('project_submissions', function (Blueprint $table) {
                $table->dropColumn('code_link');
            });
        }
    }
};