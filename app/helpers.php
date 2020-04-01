<?php
declare(strict_types = 1);

function view_path($path = '')
{
    return \realpath(\base_path() . '/src/' . $path);
}
