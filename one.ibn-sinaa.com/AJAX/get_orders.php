<?php
// Connexion à la base de données
require '../SYS/db.php'; // Assurez-vous d'avoir le fichier de connexion à la base de données

// Récupération des commandes par filiale
function getOrdersByBranch($db, $branch_id) {
    $sql = "SELECT order_id, order_number, branch_id, sender, order_date, delivery_date, details, price, execution_time, status, attachment_files, created_at FROM orders";
    $stmt = $db->prepare($sql);
    $stmt->bindParam(':branch_id', $branch_id, PDO::PARAM_INT);
    $stmt->execute();
    return $stmt->fetchAll(PDO::FETCH_ASSOC);
}

// Gestion de la demande d'API
if ($_SERVER['REQUEST_METHOD'] === 'GET' && isset($_GET['branch_id'])) {
    $branch_id = $_GET['branch_id'];
    $orders = getOrdersByBranch($db, $branch_id);
    echo json_encode($orders);
    exit();
}
?>
