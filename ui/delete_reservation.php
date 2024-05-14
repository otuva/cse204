<?php
include 'db.php';

if ($_SERVER["REQUEST_METHOD"] == "POST" && !empty($_POST['reservation_id'])) {
    $reservation_id = filter_var($_POST['reservation_id'], FILTER_SANITIZE_NUMBER_INT);

    $sql = "DELETE FROM reservations WHERE reservation_id = ?";
    $stmt = $conn->prepare($sql);

    if ($stmt->execute([$reservation_id])) {
        echo "Reservation deleted successfully.";
    } else {
        echo "Failed to delete reservation. Please check the reservation ID and try again.";
    }
} else {
    echo "No reservation ID provided.";
}
?>