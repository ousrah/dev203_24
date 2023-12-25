<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>User Details</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/tailwindcss@2.2.19/dist/tailwind.min.css">
</head>

<body class="bg-gray-100 font-sans">
    <?php require "header.php" ?>


    <div class="container mx-auto my-8 p-8 bg-white rounded shadow-md">
        <h1 class="text-2xl font-bold mb-4">User Details</h1>

        <?php if ($user): ?>
        <p><strong>Name:</strong> <?= $user['name'] ?></p>
        <p><strong>Email:</strong> <?= $user['email'] ?></p>
        <a href="read.php" class="text-blue-500 mt-4">Back to User List</a>
        <?php else: ?>
        <p>User not found.</p>
        <?php endif; ?>
    </div>

</body>

</html>