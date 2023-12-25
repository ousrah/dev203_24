<?php
require 'config.php';

if ($_SERVER['REQUEST_METHOD'] === 'POST' && isset($_POST['create'])) {
    $document = [
        'name' => $_POST['name'],
        'email' => $_POST['email'],
    ];
    $collection->insertOne($document);
}

header("Location: read.php");
exit;