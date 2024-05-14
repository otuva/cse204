<?php

$database_path = 'hotel.db';

try {
    $conn = new PDO("sqlite:$database_path");
    $conn->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);
} catch (PDOException $e) {
    echo "Connection failed: " . $e->getMessage();
    die();
}
?>
