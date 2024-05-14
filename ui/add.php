<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Add New Guest</title>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
    <script>
        $(document).ready(function () {
            $('#addGuestForm').submit(function (event) {
                event.preventDefault();
                var formData = $(this).serialize();

                $.ajax({
                    type: "POST",
                    url: "add_guest.php",
                    data: formData,
                    success: function (response) {
                        $('#result').html(response);
                        $('#addGuestForm').trigger("reset");
                    },
                    error: function () {
                        $('#result').html('Error adding guest.');
                    }
                });
            });
        });
    </script>
</head>

<body>
    <h1>Add New Guest</h1>
    <form id="addGuestForm" method="POST">
        <label for="title">Title:</label>
        <input type="text" id="title" name="title" required><br>

        <label for="gender">Gender:</label>
        <select id="gender" name="gender" required>
            <option value="Male">Male</option>
            <option value="Female">Female</option>
            <option value="Other">Other</option>
        </select><br>

        <label for="first_name">First Name:</label>
        <input type="text" id="first_name" name="first_name" required><br>

        <label for="last_name">Last Name:</label>
        <input type="text" id="last_name" name="last_name" required><br>

        <label for="email">Email:</label>
        <input type="email" id="email" name="email" required><br>

        <label for="phone">Phone:</label>
        <input type="text" id="phone" name="phone"><br>

        <label for="address_id">Address ID:</label>
        <input type="number" id="address_id" name="address_id" required><br>

        <label for="date_of_birth">Date of Birth:</label>
        <input type="date" id="date_of_birth" name="date_of_birth" required><br>

        <label for="anniversary_date">Anniversary Date:</label>
        <input type="date" id="anniversary_date" name="anniversary_date"><br>

        <label for="id_name">ID Name:</label>
        <input type="text" id="id_name" name="id_name"><br>

        <label for="id_value">ID Value:</label>
        <input type="text" id="id_value" name="id_value"><br>

        <label for="nationality">Nationality:</label>
        <input type="text" id="nationality" name="nationality"><br>

        <button type="submit">Add Guest</button>
    </form>
    <div id="result"></div>
<a href="/"><h1>← Go back</h1></a>
</body>

</html>