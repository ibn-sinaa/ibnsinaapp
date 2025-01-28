<?php
// Connexion à la base de données
require '../SYS/db.php'; // Assurez-vous d'avoir le fichier de connexion à la base de données

// Récupération des filiales
function getUsers($db) {
    $sql = "SELECT id , username  FROM users where   roles_mask=4 "; // Changez 'Users' selon le nom de votre table
    $stmt = $db->prepare($sql);
    $stmt->execute();
    return $stmt->fetchAll(PDO::FETCH_ASSOC);
}

// Gestion de la demande d'API
if ($_SERVER['REQUEST_METHOD'] === 'GET') {
    $Users = getUsers($db);
    echo json_encode($Users);
    exit();
}
?>
