<?php
include 'db_connection.php';

if ($_SERVER['REQUEST_METHOD'] === 'GET') {
    $ticket_id = $_GET['ticket_id'];

    $stmt = $conn->prepare("SELECT sender, content, sent_at FROM messages WHERE ticket_id = ? ORDER BY sent_at ASC");
    $stmt->bind_param("i", $ticket_id);
    $stmt->execute();

    $result = $stmt->get_result();
    $messages = $result->fetch_all(MYSQLI_ASSOC);

    echo json_encode($messages);
}
?>
