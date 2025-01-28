<?php
include('../SYS/db.php'); // Inclure votre fichier de connexion à la base de données

if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    // Vérifier si l'ID du produit est fourni
    if (isset($_POST['product_id'])) {
        $product_id = $_POST['product_id'];

        // Préparer la requête pour supprimer le produit
        $stmt = $pdo->prepare("DELETE FROM product WHERE product_id = :product_id");
        $stmt->bindParam(':product_id', $product_id, PDO::PARAM_INT);

        // Exécuter la requête
        if ($stmt->execute()) {
            echo json_encode(['status' => 'success', 'message' => 'Produit supprimé avec succès.']);
        } else {
            echo json_encode(['status' => 'error', 'message' => 'Erreur lors de la suppression du produit.']);
        }
    } else {
        echo json_encode(['status' => 'error', 'message' => 'ID du produit manquant.']);
    }
} else {
    echo json_encode(['status' => 'error', 'message' => 'Méthode non autorisée.']);
}
?>
