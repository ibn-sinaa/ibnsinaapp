<?php
require '../SYS/db.php'; // Connexion à la base de données

header('Content-Type: application/json'); // Définir le type MIME JSON

try {
    // Vérifier si un ID est passé en paramètre
    if (isset($_GET['id']) && !empty($_GET['id'])) {
        $notificationId = filter_var($_GET['id'], FILTER_VALIDATE_INT);

        if ($notificationId) {
            // Préparer la requête de mise à jour
            $query = "UPDATE notifications SET is_read = 1 WHERE id = :id";
            $stmt = $db->prepare($query);
            $stmt->bindValue(':id', $notificationId, PDO::PARAM_INT);

            $stmt->execute();

            if ($stmt->rowCount() > 0) {
                // Succès
                echo json_encode(['success' => true, 'message' => 'Notification marquée comme lue']);
            } else {
                // Aucun enregistrement mis à jour (par exemple, ID inexistant)
                echo json_encode(['success' => false, 'message' => 'ID introuvable ou déjà marqué comme lu']);
            }
        } else {
            // ID non valide
            echo json_encode(['success' => false, 'message' => 'ID de notification invalide']);
        }
    } else {
        // ID manquant
        echo json_encode(['success' => false, 'message' => 'ID de notification manquant']);
    }
} catch (PDOException $e) {
    // Gestion des erreurs PDO
    echo json_encode(['success' => false, 'message' => 'Erreur interne : ' . $e->getMessage()]);
    error_log("Erreur PDO : " . $e->getMessage()); // Loguer l'erreur (optionnel)
}
?>
