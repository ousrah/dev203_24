<?php
include('connection.php');

echo("<h1>start</h1>");



$collection = $client->dblp->dblp;
$cursor = $collection->find(["year"=>2011]);

// Iterate over the cursor
foreach ($cursor as $doc) {
    echo $doc->title .'<br>';
}
echo("<h1>The end</h1>");



?>