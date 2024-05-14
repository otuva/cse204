<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Remove Reservation</title>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
    <script>
        $(document).ready(function() {
            $('#deleteForm').on('submit', function(e) {
                e.preventDefault(); // Prevent default form submission
                var reservationId = $('#reservation_id').val();
                if (reservationId) {
                    $.ajax({
                        url: 'delete_reservation.php',
                        type: 'POST',
                        data: { reservation_id: reservationId },
                        success: function(response) {
                            $('#result').html(response);
                            $('#deleteForm').trigger("reset");
                        },
                        error: function() {
                            $('#result').html('Error processing your request.');
                        }
                    });
                } else {
                    $('#result').html('Please enter a valid reservation ID.');
                }
            });
        });
    </script>
</head>
<body>
    <h1>Remove Reservation</h1>
    <form id="deleteForm">
        <label for="reservation_id">Reservation ID:</label>
        <input type="number" id="reservation_id" name="reservation_id" required>
        <button type="submit">Remove Reservation</button>
    </form>
    <div id="result"></div>
<a href="/"><h1>← Go back</h1></a>
</body>
</html>
