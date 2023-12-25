<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>MongoDB CRUD</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/tailwindcss@2.2.19/dist/tailwind.min.css">
</head>

<body class="bg-gray-100 font-sans">
    <?php require "header.php" ?>
    <!-- view.php -->
    <div class="container mx-auto my-8 p-8 bg-white rounded shadow-md">
        <h1 class="text-2xl font-bold mb-4">MongoDB CRUD</h1>


        <button class="p-3 rounded bg-green-500 text-gray-200"><a href="create_form.php">Add a user</a></button>
        <!-- User List -->
        <div class="mt-5">
            <h2 class="text-xl font-bold mb-2">Users</h2>
            <ul>
                <?php foreach ($documents as $document): ?>

                <li class="mb-2 border-b pb-2">
                    <span class="text-lg font-semibold"><?= $document['name'] ?></span>
                    <span class="text-gray-600 ml-2"><?= $document['email'] ?></span>
                    <div class="mt-2">
                        <a href="delete.php?id=<?= $document['_id'] ?>" class="text-red-500">Delete</a>
                        <a href="update_form.php?id=<?= $document['_id'] ?>" class="text-blue-500 ml-2">Edit</a>
                        <a href="read_one.php?id=<?= $document['_id'] ?>" class="text-green-500 ml-2">View</a>
                    </div>
                </li>
                <?php endforeach; ?>
            </ul>
        </div>
    </div>

    <?php require "footer.php" ?>
</body>

</html>