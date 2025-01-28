<?php
session_start();
require '../SYS/auth.php';
// Déconnexion de l'utilisateur
if ($auth->isLoggedIn()) {
    $auth->logOut();
    session_destroy(); // Détruire la session
}

// Redirection vers la page de connexion ou la page d'accueil
header('Location: login.php'); // Changez ceci en fonction de votre page de connexion
exit;
?>
