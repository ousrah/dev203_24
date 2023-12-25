<?php
require 'config.php';

if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    $filter = ['_id' => new MongoDB\BSON\ObjectId($_POST['id'])];

    $update = ['$set' => ['name' => $_POST['name'], 'email' => $_POST['email']]];
    print_r($update);
    $collection->updateOne($filter, $update);
}

header("Location: read.php");
exit;