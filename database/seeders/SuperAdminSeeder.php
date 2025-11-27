<?php

namespace Database\Seeders;

use App\Models\User;
use Illuminate\Database\Seeder;
use Illuminate\Support\Facades\Hash;
use Spatie\Permission\Models\Role;

class SuperAdminSeeder extends Seeder
{
    /**
     * Run the database seeds.
     */
    public function run(): void
    {
        $user = User::create([
            'name' => 'Administrator',
            'email' => 'super.admin@test.com',
            'password' => Hash::make(1234),
        ]);

        $developer = User::create([
            'name' => 'Developer',
            'email' => 'developer@test.com',
            'password' => Hash::make(1234),
        ]);

        $superAdmin = Role::create([
            'name' => 'Super Admin',
        ]);

        $dev = Role::create([
            'name' => 'Developer',
        ]);

        $user->assignRole($superAdmin);
        $developer->assignRole($dev);
    }
}
