<?php

namespace App\Console;

use Illuminate\Console\Scheduling\Schedule;
use Laravel\Lumen\Console\Kernel as ConsoleKernel;

class Kernel extends ConsoleKernel
{
    /**
     * The Artisan commands provided by your application.
     *
     * @var array
     */
    protected $commands = [
        'App\Console\Commands\KeyGenerate',
    ];

    /**
     * Define the application's command schedule.
     *
     * @param  \Illuminate\Console\Scheduling\Schedule  $schedule
     * @return void
     */
    protected function schedule(Schedule $schedule)
    {
        // $output = '/proc/1/fd/1';
        // $timezone = 'America/New_York';
        // $sleep = function () {
        //     \sleep(60);
        // };

        // $schedule->command('command:action')
        //     ->timezone($timezone)
        //     ->appendOutputTo($output)
        //     ->daily()
        //     ->after($sleep) // used to prevent multiple runs
        //     ->withoutOverlapping(); // also used to prevent multiple runs
    }
}
