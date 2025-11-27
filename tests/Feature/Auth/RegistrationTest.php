<?php

namespace Tests\Feature\Auth;

use App\Providers\RouteServiceProvider;
use Illuminate\Foundation\Testing\RefreshDatabase;
use Spatie\Permission\Models\Role;
use Tests\TestCase;

class RegistrationTest extends TestCase
{
    use RefreshDatabase;

    public function test_registration_screen_can_be_rendered(): void
    {
        $this->seed(\Database\Seeders\CreatePermissionsSeeder::class);
        $response = $this->get('/register');

        $response->assertStatus(200);
    }

    public function test_new_users_can_register(): void
    {
        $this->seed(\Database\Seeders\CreatePermissionsSeeder::class);
        $role = Role::where('name', 'student')->first();

        $response = $this->post('/register', [
            'name' => 'Test User',
            'email' => 'test@example.com',
            'password' => 'password',
            'password_confirmation' => 'password',
            'role_id' => $role->id,
        ]);

        $this->assertAuthenticated();
        $response->assertRedirect(RouteServiceProvider::HOME);
    }

    public function test_users_can_register_as_student(): void
    {
        $this->seed(\Database\Seeders\CreatePermissionsSeeder::class);
        $role = Role::where('name', 'student')->first();

        $response = $this->post('/register', [
            'name' => 'Student User',
            'email' => 'student@example.com',
            'password' => 'password',
            'password_confirmation' => 'password',
            'role_id' => $role->id,
        ]);

        $this->assertAuthenticated();
        $user = $this->getAuthenticatedUser();
        $this->assertTrue($user->hasRole('student'));
    }

    public function test_users_can_register_as_supervisor(): void
    {
        $this->seed(\Database\Seeders\CreatePermissionsSeeder::class);
        $role = Role::where('name', 'supervisor')->first();

        $response = $this->post('/register', [
            'name' => 'Supervisor User',
            'email' => 'supervisor@example.com',
            'password' => 'password',
            'password_confirmation' => 'password',
            'role_id' => $role->id,
        ]);

        $this->assertAuthenticated();
        $user = $this->getAuthenticatedUser();
        $this->assertTrue($user->hasRole('supervisor'));
    }

    protected function getAuthenticatedUser()
    {
        return \Illuminate\Support\Facades\Auth::user();
    }

    public function test_registration_fails_without_role(): void
    {
        $this->seed(\Database\Seeders\CreatePermissionsSeeder::class);

        $response = $this->post('/register', [
            'name' => 'Test User',
            'email' => 'test@example.com',
            'password' => 'password',
            'password_confirmation' => 'password',
        ]);

        $response->assertSessionHasErrors('role_id');
        $this->assertGuest();
    }
}
