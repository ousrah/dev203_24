<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Create user</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/tailwindcss@2.2.19/dist/tailwind.min.css">

</head>

<body class="">
    <?php require "header.php" ?>

    <!-- create_form.php -->
    <div class="flex flex-col w-2/3 m-auto justify-center align-center p-5 bg-gray-100 rounded shadow-sm">
        <h1 class="text-3xl font-bold">Add a user :</h1>
        <form method="post" action="ceate.php" class="mb-4 mt-20">
            <label for="name" class="block text-sm font-medium text-gray-600">Name:</label>
            <input type="text" name="name" value="<?= $name ?? '' ?>" required
                class="mt-1 p-2 border border-gray-300 rounded-md w-full">
            <label for="email" class="block text-sm font-medium text-gray-600">Email:</label>
            <input type="email" name="email" value="<?= $email ?? '' ?>" required
                class="mt-1 p-2 border border-gray-300 rounded-md w-full">
            <button type="submit" name="create" class="mt-4 bg-green-500 text-white px-4 py-2 rounded">Create</button>
        </form>
    </div>
</body>

</html>