<?php
declare(strict_types = 1);

namespace Duran;

use Duran\Random;
use Exception;
use Tests\TestCase;

class RandomTest extends TestCase
{
    public function testCanSolveTheFormulaForLifeIDK()
    {
        $this->expectException(Exception::class);

        $random = new Random();

        $random->doSomething();
    }
}
