<?php

namespace Database\Seeders;

use Illuminate\Database\Seeder;
use Spatie\Permission\Models\Permission;
use Spatie\Permission\Models\Role;

class PermissionsSeeder extends Seeder
{
    /**
     * Run the database seeds.
     */
    public function run(): void
    {
        $permissions = [
            // Dashboard
            'access_dashboard',
            // User Management
            'user_can_edit_own_profile',
            'access_user_management',
            // Currencies
            'access_currencies',
            // Reports
            'access_reports',
            // Activity Logs
            'access_activity_logs',
            // Settings
            'access_settings',
            // Payment Methods
            'access_payment_methods',
            // Specializations
            'access_specializations',
            // Departments
            'access_departments',
            // Support Chats
            'access_support_chats',
            // Projects
            'view_projects',
            'create_projects',
            'edit_projects',
            'delete_projects',
            // Project Requests
            'view_project_requests',
            // Supervisors
            'view_supervisors',
            // Students
            'view_students',
            // Project Assignments
            'view_assignments',
            'create_assignments',
            'edit_assignments',
            'delete_assignments',
            'assign_supervisors',
            'assign_students',
            // Defense Scheduling
            'view_defenses',
            'create_defenses',
            'edit_defenses',
            'delete_defenses',
        ];

        foreach ($permissions as $permission) {
            Permission::create([
                'name' => $permission,
            ]);
        }

        $role = Role::create([
            'name' => 'Admin',
        ]);

        $role->givePermissionTo($permissions);
        $role->revokePermissionTo('access_user_management');
    }
}
