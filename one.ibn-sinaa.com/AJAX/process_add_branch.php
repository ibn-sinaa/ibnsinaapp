<?php
// Inclure le fichier de connexion à la base de données
include_once("../SYS/db.php");
// Vérification que la requête est bien envoyée via AJAX
if ($_SERVER['REQUEST_METHOD'] === 'POST') {

    // Vérifier que les données nécessaires sont présentes
    if (isset($_POST['branch_name']) && !empty($_POST['branch_name'])) {
        
        // Récupérer et sécuriser les données envoyées depuis le formulaire
        $branch_name = htmlspecialchars(trim($_POST['branch_name']));  // Suppression des espaces et sécurisation
        $location = isset($_POST['location']) ? htmlspecialchars(trim($_POST['location'])) : ' ';

        try {
            // Préparer la requête d'insertion
            $query = $db->prepare("INSERT INTO branches (branch_name, location) VALUES (?, ?)");
            
            // Exécuter la requête préparée
            $query->execute([$branch_name, $location]);

            // Réponse JSON en cas de succès
            echo json_encode(['status' => 'success', 'message' => 'Branche ajoutée avec succès.']);
        
        } catch (PDOException $e) {
            // Réponse JSON en cas d'erreur de base de données
            echo json_encode(['status' => 'error', 'message' => 'Erreur de base de données : Une erreur est survenue.']);
            // En mode développement, vous pouvez utiliser $e->getMessage() pour plus de détails
        }

    } else {
        echo json_encode(['status' => 'error', 'message' => 'Nom de la branche est requis.']);
    }

} else {
    echo json_encode(['status' => 'error', 'message' => 'Requête invalide.']);
}
?>
