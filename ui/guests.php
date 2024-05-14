<?php
include 'db.php';  // Include the database connection file

// Fetch hotels from the database
function fetchHotels() {
    global $conn;  // Use the PDO connection
    $sql = "SELECT hotel_id, hotel_name FROM hotels ORDER BY hotel_name ASC";
    $statement = $conn->prepare($sql);
    $statement->execute();

    $hotels = $statement->fetchAll(PDO::FETCH_ASSOC);
    return $hotels;
}

$hotels = fetchHotels();
?>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Select a Hotel and Date</title>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
</head>
<body>
    <form id="hotelForm">
        <label for="hotel">Choose a Hotel:</label>
        <select name="hotel_id" id="hotel">
            <?php foreach ($hotels as $hotel): ?>
                <option value="<?php echo htmlspecialchars($hotel['hotel_id']); ?>">
                    <?php echo htmlspecialchars($hotel['hotel_name']); ?>
                </option>
            <?php endforeach; ?>
        </select>
        <label for="date">Select Date:</label>
        <input type="date" id="date" name="date" required>
        <button type="button" onclick="fetchGuests()">Submit</button>
    </form>

    <div id="guestList">Guests will be listed here...</div>

    <script>
    function fetchGuests() {
        var hotelId = $('#hotel').val();
        var date = $('#date').val();
        if (!date) {
            alert('Please select a date.');
            return;
        }

        // AJAX call to server to get guests
        $.ajax({
            url: 'fetch_guests.php',
            type: 'POST',
            data: { hotel_id: hotelId, date: date },
            success: function(response) {
                $('#guestList').html(response);
            },
            error: function() {
                $('#guestList').html('Error loading guests.');
            }
        });
    }
    </script>

<a href="/"><h1>← Go back</h1></a>
</body>
</html>
