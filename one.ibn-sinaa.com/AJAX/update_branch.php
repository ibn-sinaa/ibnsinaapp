<?php
// Inclure le fichier de connexion à la base de données
include_once("../SYS/db.php");

if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    if (isset($_POST['branch_id'], $_POST['branch_name'], $_POST['location'])) {
        $branch_id = $_POST['branch_id'];
        $branch_name = htmlspecialchars(trim($_POST['branch_name']));
        $location = htmlspecialchars(trim($_POST['location']));

        try {
            // Mise à jour des informations de la branche
            $query = $db->prepare("UPDATE branches SET branch_name = ?, location = ? WHERE branch_id = ?");
            $query->execute([$branch_name, $location, $branch_id]);

            echo json_encode(['status' => 'success', 'message' => 'Branche mise à jour avec succès.']);
        } catch (PDOException $e) {
            echo json_encode(['status' => 'error', 'message' => 'Erreur de mise à jour : ' . $e->getMessage()]);
        }
    } else {
        echo json_encode(['status' => 'error', 'message' => 'Données manquantes.']);
    }
} else {
    echo json_encode(['status' => 'error', 'message' => 'Requête invalide.']);
}
?>
