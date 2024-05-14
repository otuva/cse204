<?php
include 'db.php';

$hotel_id = $_POST['hotel_id'];
$date = $_POST['date'];

// Query to fetch guests based on hotel_id and date
$sql = "SELECT g.first_name, g.last_name FROM guests g
        JOIN reservation_guests rg ON g.guest_id = rg.guest_id
        JOIN reservations r ON rg.reservation_id = r.reservation_id
        WHERE r.hotel_id = ? AND r.start_date <= ? AND r.end_date >= ?";

$statement = $conn->prepare($sql);
$statement->execute([$hotel_id, $date, $date]);
$guests = $statement->fetchAll(PDO::FETCH_ASSOC);

if (count($guests) > 0) {
    foreach ($guests as $guest) {
        echo "<p>" . htmlspecialchars($guest['first_name']) . " " . htmlspecialchars($guest['last_name']) . "</p>";
    }
} else {
    echo "<p>No guests found for the selected hotel on the specified date.</p>";
}
?>
