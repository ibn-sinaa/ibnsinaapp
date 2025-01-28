<?php
include_once '../SYS/auth.php';
// Vérifiez si l'utilisateur est connecté
if (!$auth->isLoggedIn()) {
    // Redirigez l'utilisateur vers la page de connexion
    header('Location: login.php'); // Changez ceci en fonction de votre page de connexion
    exit;
}
else {
    $userId = $_SESSION[$auth::SESSION_FIELD_USER_ID];
    $username = $_SESSION[$auth::SESSION_FIELD_USERNAME];
    $role=	$_SESSION[$auth::SESSION_FIELD_ROLES];  
}
 
?>
