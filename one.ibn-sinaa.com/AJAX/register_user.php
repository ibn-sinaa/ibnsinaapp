<?php
require '../SYS/auth.php'; // Inclure le fichier d'authentification

header('Content-Type: application/json'); // Définir le type de contenu en JSON

// Récupérer les données envoyées
$data = json_decode(file_get_contents('php://input'), true);

$email = $data['email'];
$password = $data['password'];
$username = $data['username']; // Assurez-vous que le nom d'utilisateur est inclus dans les données envoyées

try {
    // Enregistrer un nouvel utilisateur avec PHP-Auth
    $userId = $auth->register($email, $password, function ($selector, $token) use ($email) {
        // Ici, vous pouvez envoyer un email de vérification si nécessaire avec le `$selector` et `$token`
    });

    // Ajouter le nom d'utilisateur à la table de l'utilisateur (si nécessaire dans votre base de données)
    // Exemple de code SQL :
    // $db->exec("UPDATE users SET username = '$username' WHERE id = $userId");

    echo json_encode(['success' => true, 'message' => 'Inscription réussie']);
} catch (\Delight\Auth\InvalidEmailException $e) {
    echo json_encode(['success' => false, 'error' => 'Adresse email invalide']);
} catch (\Delight\Auth\InvalidPasswordException $e) {
    echo json_encode(['success' => false, 'error' => 'Mot de passe invalide']);
} catch (\Delight\Auth\UserAlreadyExistsException $e) {
    echo json_encode(['success' => false, 'error' => 'Cet utilisateur existe déjà']);
} catch (\Delight\Auth\TooManyRequestsException $e) {
    echo json_encode(['success' => false, 'error' => 'Trop de tentatives, veuillez réessayer plus tard']);
}
