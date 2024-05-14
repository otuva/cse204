<?php
include 'db.php';

$sql = "SELECT r.room_number, rt.room_type_name, COUNT(res.reservation_id) AS booking_count 
        FROM rooms r
        LEFT JOIN room_types rt ON r.room_type_id = rt.room_type_id
        LEFT JOIN reservations res ON r.room_id = res.room_id
        GROUP BY r.room_id
        ORDER BY r.room_number ASC";

$statement = $conn->prepare($sql);
$statement->execute();
$rooms = $statement->fetchAll(PDO::FETCH_ASSOC);
?>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Room Booking Counts</title>
</head>
<body>
    <h1>Room Booking Counts</h1>
    <table>
        <thead>
            <tr>
                <th>Room Number</th>
                <th>Room Type</th>
                <th>Booking Count</th>
            </tr>
        </thead>
        <tbody>
            <?php foreach ($rooms as $room): ?>
                <tr>
                    <td><?php echo htmlspecialchars($room['room_number']); ?></td>
                    <td><?php echo htmlspecialchars($room['room_type_name']); ?></td>
                    <td><?php echo htmlspecialchars($room['booking_count']); ?></td>
                </tr>
            <?php endforeach; ?>
        </tbody>
    </table>
<a href="/"><h1>\u2190 Go back</h1></a>
</body>
</html>
