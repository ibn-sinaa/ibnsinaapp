<?php
// Connexion à la base de données
require '../SYS/db.php'; // Assurez-vous d'avoir le fichier de connexion à la base de données

// Récupération des filiales
function getBranches($db) {
    $sql = "SELECT branch_id, branch_name FROM branches"; // Changez 'branches' selon le nom de votre table
    $stmt = $db->prepare($sql);
    $stmt->execute();
    return $stmt->fetchAll(PDO::FETCH_ASSOC);
}

// Gestion de la demande d'API
if ($_SERVER['REQUEST_METHOD'] === 'GET') {
    $branches = getBranches($db);
    echo json_encode($branches);
    exit();
}
?>
