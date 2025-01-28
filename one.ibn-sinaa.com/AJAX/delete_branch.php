<?php
include_once("../SYS/db.php");

if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    if (isset($_POST['branch_id'])) {
        $branch_id = $_POST['branch_id'];

        try {
            // Suppression de la branche
            $query = $db->prepare("DELETE FROM branches WHERE branch_id = ?");
            $query->execute([$branch_id]);

            echo json_encode(['status' => 'success', 'message' => 'Branche supprimée avec succès.']);
        } catch (PDOException $e) {
            echo json_encode(['status' => 'error', 'message' => 'Erreur de suppression : ' . $e->getMessage()]);
        }
    } else {
        echo json_encode(['status' => 'error', 'message' => 'Identifiant de la branche manquant.']);
    }
} else {
    echo json_encode(['status' => 'error', 'message' => 'Requête invalide.']);
}
?>
