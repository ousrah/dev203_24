<?php
require 'config.php';

if (isset($_GET['id'])) {
    $filter = ['_id' => new MongoDB\BSON\ObjectId($_GET['id'])];
    $collection->deleteOne($filter);
}

header("Location: read.php");
exit;