<?php

namespace Tests;

use Laravel\Lumen\Testing\TestCase as BaseCase;

abstract class TestCase extends BaseCase
{
    /**
     * Creates the application.
     *
     * @return \Laravel\Lumen\Application
     */
    public function createApplication()
    {
        return require __DIR__ . '/../bootstrap/app.php';
    }
}
