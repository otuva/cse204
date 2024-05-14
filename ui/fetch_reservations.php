<?php
include 'db.php';

$sql = "SELECT r.reservation_id, g.first_name, g.last_name, h.hotel_name, r.start_date, r.end_date
        FROM reservations r
        JOIN reservation_guests rg ON r.reservation_id = rg.reservation_id
        JOIN guests g ON rg.guest_id = g.guest_id
        JOIN hotels h ON r.hotel_id = h.hotel_id
        WHERE rg.is_primary_guest = 1
        ORDER BY r.start_date ASC";

$statement = $conn->prepare($sql);
$statement->execute();
$reservations = $statement->fetchAll(PDO::FETCH_ASSOC);

echo json_encode($reservations);
?>
