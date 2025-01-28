<?php
include('../SYS/db.php');

if ($_SERVER['REQUEST_METHOD'] == 'POST') {
    $order_id = $_POST['order_id'];
    $price = $_POST['price'];

    try {
        // Préparer la requête de mise à jour
        $query = "UPDATE orders SET price = :price WHERE order_id = :order_id";
        $stmt = $db->prepare($query);
        
        // Lier les paramètres
        $stmt->bindParam(':price', $price);
        $stmt->bindParam(':order_id', $order_id);

        // Exécuter la requête
        $stmt->execute();

        echo json_encode(['success' => true, 'message' => 'Prix mis à jour avec succès']);
    } catch (PDOException $e) {
        echo json_encode(['success' => false, 'message' => 'Erreur : ' . $e->getMessage()]);
    }
} else {
    echo json_encode(['success' => false, 'message' => 'Requête non valide']);
}
?>
