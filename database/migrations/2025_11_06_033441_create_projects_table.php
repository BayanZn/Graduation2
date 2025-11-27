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
        Schema::create('projects', function (Blueprint $table) {
            $table->id();
            $table->unsignedBigInteger('specialization_id')->nullable();
            $table->unsignedBigInteger('department_id')->nullable();
            $table->string('title');
            $table->text('description');
            $table->string('project_type', 20)->comment('Semester, Graduation 1, Graduation 2');
            $table->unsignedBigInteger('created_by')->nullable();
            $table->foreign('specialization_id')->references('id')->on('specializations')->onDelete('set null');
            $table->foreign('department_id')->references('id')->on('departments')->onDelete('set null');
            $table->foreign('created_by')->references('id')->on('users')->onDelete('set null');
            $table->string('status', 20)->comment('Proposed, Approved, Rejected, Completed');
            $table->timestamps();
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('projects');
    }
};
