<?php
include 'db.php';

error_reporting(E_ALL);
ini_set('display_errors', 1);

$reservation_id = $_POST['reservation_id'];
$start_date = $_POST['start_date'];
$end_date = $_POST['end_date'];

if (!$reservation_id || !$start_date || !$end_date) {
    echo "All input fields are required.";
    exit;
}

if (new DateTime($start_date) > new DateTime($end_date)) {
    echo "End date must be after start date.";
    exit;
}

// Update the reservation in the database
$sql = "UPDATE reservations SET start_date = ?, end_date = ? WHERE reservation_id = ?";
$statement = $conn->prepare($sql);
$success = $statement->execute([$start_date, $end_date, $reservation_id]);

echo $success ? "Reservation dates updated successfully. Don't forget to refresh to see changes" : "Failed to update reservation dates.";
?>
