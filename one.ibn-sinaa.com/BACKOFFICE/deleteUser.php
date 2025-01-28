<?php
// Inclure le fichier de configuration de la base de données
include('../SYS/db.php'); // Assurez-vous que ce fichier contient les informations de connexion à votre base de données

// Vérifiez si l'ID de l'utilisateur est passé dans l'URL
if (isset($_GET['id']) && !empty($_GET['id'])) {
    // Récupérer l'ID de l'utilisateur à supprimer
    $userId = $_GET['id'];

    // Préparer la requête de suppression
    $query = "DELETE FROM users WHERE id = :userId";
    $stmt = $db->prepare($query);

    // Lier l'ID de l'utilisateur et exécuter la requête
    $stmt->bindParam(':userId', $userId, PDO::PARAM_INT);

    try {
        $stmt->execute();
        // Rediriger vers la page des utilisateurs avec un message de succès
        header("Location: users.php?success_delete=true");
        exit();
    } catch (PDOException $e) {
        // En cas d'erreur, redirigez avec un message d'erreur
        header("Location: users.php?error=Erreur lors de la suppression de l'utilisateur");
        exit();
    }
} else {
    // Rediriger si l'ID de l'utilisateur n'est pas valide
    header("Location: users.php?error=ID utilisateur invalide");
    exit();
}
?>
