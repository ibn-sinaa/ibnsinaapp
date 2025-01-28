<?php
// Démarrer le tampon de sortie
ob_start();
session_start(); // Démarrage de la session

require '../vendor/autoload.php'; // Ensure this path is correct
require '../SYS/db.php';

use Delight\Auth\Auth;

$auth = new Auth($db);

// Handle the POST request
if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    // Retrieve JSON data sent in the request
    $data = json_decode(file_get_contents('php://input'), true);

    $email = $data['email'] ?? '';
    $password = $data['password'] ?? '';

    // Validate fields
    if (empty($email) || empty($password)) {
        echo json_encode(['error' => 'Veuillez remplir tous les champs']);
        exit;
    }

    try {
        // Attempt to log in the user
        $auth->login($email, $password);
  

        // Respond with JSON containing a success message and redirect URL
        echo json_encode([
            'success' => true,
            'message' => 'Connexion réussie',
            'redirect' =>( $auth->hasRole(\Delight\Auth\Role::USER) || $auth->hasRole(\Delight\Auth\Role::EXTERN_USER) )? 'orders.php' : 'dashboard.php'
        ]);
    } catch (\Delight\Auth\InvalidEmailException $e) {
        echo json_encode(['error' => 'Email invalide']);
    } catch (\Delight\Auth\InvalidPasswordException $e) {
        echo json_encode(['error' => 'Mot de passe incorrect']);
    } catch (\Delight\Auth\TooManyRequestsException $e) {
        echo json_encode(['error' => 'Trop de tentatives de connexion. Réessayez plus tard.']);
    }
} else {
    echo json_encode(['error' => 'Méthode non autorisée']);
}
ob_end_flush();
?>