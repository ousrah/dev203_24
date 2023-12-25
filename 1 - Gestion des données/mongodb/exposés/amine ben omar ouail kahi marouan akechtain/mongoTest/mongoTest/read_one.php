<?php
require 'config.php';

// Check if the view parameter is set in the query string
if (isset($_GET['id'])) {
    $userId = $_GET['id'];
    $user = $collection->findOne(['_id' => new MongoDB\BSON\ObjectId($userId)]);

    // Display user details in the view_one.php file
    require 'view_one.php';
} else {
    // Redirect to the main page if the view parameter is not set
    header("Location: read.php");
    exit;
}