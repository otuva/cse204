<?php
include 'db.php';

if ($_SERVER["REQUEST_METHOD"] == "POST") {

    $title = htmlspecialchars($_POST['title']);
    $gender = htmlspecialchars($_POST['gender']);
    $first_name = htmlspecialchars($_POST['first_name']);
    $last_name = htmlspecialchars($_POST['last_name']);
    $email = filter_var($_POST['email'], FILTER_SANITIZE_EMAIL);
    $phone = htmlspecialchars($_POST['phone']);
    $address_id = filter_var($_POST['address_id'], FILTER_SANITIZE_NUMBER_INT);
    $date_of_birth = htmlspecialchars($_POST['date_of_birth']);
    $anniversary_date = htmlspecialchars($_POST['anniversary_date']);
    $id_name = htmlspecialchars($_POST['id_name']);
    $id_value = htmlspecialchars($_POST['id_value']);
    $nationality = htmlspecialchars($_POST['nationality']);

    $sql = "INSERT INTO guests (title, gender, first_name, last_name, email, phone, address_id, date_of_birth, anniversary_date, id_name, id_value, nationality) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
    $stmt = $conn->prepare($sql);

    try {
        $stmt->execute([$title, $gender, $first_name, $last_name, $email, $phone, $address_id, $date_of_birth, $anniversary_date, $id_name, $id_value, $nationality]);
        echo "New guest added successfully.";
    } catch (PDOException $e) {
        echo "Error: " . $e->getMessage();
    }
}
?>
