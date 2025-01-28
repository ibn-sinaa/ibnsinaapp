<?php
session_start();
include 'db_connection.php'; // Inclut la connexion à la base de données

if (isset($_SESSION['user_id'])) {
    $user_id = $_SESSION['user_id'];

    $stmt = $conn->prepare("SELECT id, status, created_at FROM tickets WHERE user_id = ? AND status = 'open'");
    $stmt->bind_param("i", $user_id);
    $stmt->execute();
    $result = $stmt->get_result();

    $tickets = [];
    while ($row = $result->fetch_assoc()) {
        $tickets[] = $row;
    }

    echo json_encode(["status" => "success", "tickets" => $tickets]);
} else {
    echo json_encode(["status" => "error", "message" => "Utilisateur non connecté."]);
}
?>
