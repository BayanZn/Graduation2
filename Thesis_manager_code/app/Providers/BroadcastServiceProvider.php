<?php

namespace App\Providers;

use Illuminate\Support\Facades\Broadcast;
use Illuminate\Support\ServiceProvider;

class BroadcastServiceProvider extends ServiceProvider
{
    /**
     * Bootstrap any application services.
     */
    public function boot(): void
    {
        Broadcast::routes(); // INCLUDE INTERNAL ROUTES SUCH PRIVATE CHANNELS INVITE OR AUTH

        require base_path('routes/channels.php'); // CONNECT WITH CHANNELS NAME, AND WHO CAN LISTEN TO THEM
    }
}
