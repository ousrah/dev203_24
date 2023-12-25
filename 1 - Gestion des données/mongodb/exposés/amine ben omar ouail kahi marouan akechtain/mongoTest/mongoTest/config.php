<?php
require_once __DIR__ . '/vendor/autoload.php';


use MongoDB\Client;
$client = new MongoDB\Client('mongodb://0.0.0.0:27017');

$collection = $client->test->test;
    
    