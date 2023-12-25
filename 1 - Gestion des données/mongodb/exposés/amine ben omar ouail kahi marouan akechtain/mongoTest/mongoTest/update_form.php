<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Update user</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/tailwindcss@2.2.19/dist/tailwind.min.css">

</head>

<body class="">
    <!-- update_form.php -->
    <?php
require "config.php";
if($_GET["id"]){
       $filter = ['_id' => new MongoDB\BSON\ObjectId($_GET['id'])];


       $user=$collection->findOne($filter);
}
?>
    <?php require "header.php" ?>

    <div class="flex flex-col w-2/3 m-auto justify-center align-center p-5 bg-gray-100 rounded shadow-sm">

        <h1 class="text-3xl font-bold">Update the user :</h1>
        <form method="post" action="update.php" class="mb-4 mt-20">
            <input type="hidden" name="id" value="<?= $user["_id"] ?? '' ?>" class="hidden">
            <label for="name" class="block text-sm font-medium text-gray-600">Name:</label>
            <input type="text" name="name" value="<?= $user["name"] ?? '' ?>" required
                class="mt-1 p-2 border border-gray-300 rounded-md w-full">
            <label for="email" class="block text-sm font-medium text-gray-600">Email:</label>
            <input type="email" name="email" value="<?= $user["email"] ?? '' ?>" required
                class="mt-1 p-2 border border-gray-300 rounded-md w-full">
            <button type="submit" name="update" class="mt-4 bg-blue-500 text-white px-4 py-2 rounded">Update</button>
        </form>
    </div>
</body>

</html>