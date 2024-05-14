<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Update Reservation Dates</title>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
</head>
<body>
    <h1>Update Reservation Dates</h1>
    <form id="updateForm">
        <label for="reservation_id">Select Reservation:</label>
        <select name="reservation_id" id="reservation_id" required>
            <!-- Options will be populated by jQuery -->
        </select>
        <br>
        <label for="start_date">New Start Date:</label>
        <input type="date" id="start_date" name="start_date" required>
        <br>
        <label for="end_date">New End Date:</label>
        <input type="date" id="end_date" name="end_date" required>
        <br>
        <button type="button" id="submitButton">Update Dates</button>
    </form>

    <div id="result">Result will be displayed here...</div>

    <script>
    $(document).ready(function() {
        fetchReservations(); // Call on page load to populate reservations

        $('#submitButton').click(function() {
            updateReservationDates();
        });

        function fetchReservations() {
            $.ajax({
                url: 'fetch_reservations.php', // PHP file to fetch reservations
                type: 'GET',
                dataType: 'json',
                success: function(reservations) {
                    var options = '';
                    reservations.forEach(function(reservation) {
                        options += '<option value="' + reservation.reservation_id + '">' +
                            reservation.reservation_id + ' / ' + reservation.first_name + ' ' + reservation.last_name + ' - ' +
                            reservation.hotel_name + ' (' + reservation.start_date + ' to ' + reservation.end_date + ')' +
                            '</option>';
                    });
                    $('#reservation_id').html(options);
                },
                error: function() {
                    $('#result').html('Failed to load reservations.');
                }
            });
        }

        function updateReservationDates() {
            var reservationId = $('#reservation_id').val();
            var startDate = $('#start_date').val();
            var endDate = $('#end_date').val();
            $.ajax({
                url: 'update_reservation.php', // PHP file to update reservations
                type: 'POST',
                data: {
                    reservation_id: reservationId,
                    start_date: startDate,
                    end_date: endDate
                },
                success: function(response) {
                    $('#result').html(response);
                },
                error: function() {
                    $('#result').html('Error updating reservation. Maybe it couldn\'t write');
                }
            });
        }
    });
    </script>
<a href="/"><h1>← Go back</h1></a>
</body>
</html>
