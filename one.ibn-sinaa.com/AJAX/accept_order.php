<?php
include('../SYS/db.php'); // Inclure la connexion à la base de données

if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    $orderId = $_POST['order_id'];
    $status = $_POST['status'];

    // Vérification des données reçues
    if (empty($orderId) || !isset($status)) {
        echo json_encode(['success' => false, 'message' => 'ID de commande ou statut manquant.']);
        exit;
    }

    try {
        // Mise à jour du statut de la commande
        $query = "UPDATE orders SET valid = :status WHERE order_id = :orderId";
        $stmt = $db->prepare($query);
        $stmt->bindParam(':status', $status, PDO::PARAM_INT);
        $stmt->bindParam(':orderId', $orderId, PDO::PARAM_INT);
        $stmt->execute();

        echo json_encode(['success' => true]);
    } catch (PDOException $e) {
        echo json_encode(['success' => false, 'message' => 'Erreur: ' . $e->getMessage()]);
    }
}
?>
