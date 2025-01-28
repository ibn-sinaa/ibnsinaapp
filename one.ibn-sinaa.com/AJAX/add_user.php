<?php
require '../SYS/auth.php'; // Inclure le fichier d'authentification

header('Content-Type: application/json'); // Définir le type de contenu en JSON

// Récupérer les données envoyées par la requête POST
$data = json_decode(file_get_contents('php://input'), true);

// Initialisation du tableau des erreurs
$errors = [];

// Vérification des données requises
if (empty($data['email'])) {
    $errors[] = 'Email manquant';
} elseif (!filter_var($data['email'], FILTER_VALIDATE_EMAIL)) {
    $errors[] = 'Adresse email invalide';
}

if (empty($data['password'])) {
    $errors[] = 'Mot de passe manquant';
}

if (empty($data['username'])) {
    $errors[] = 'Nom d’utilisateur manquant';
}

if (empty($data['role'])) {
    $errors[] = 'Rôle manquant';
}

// Vérifie s'il y a des erreurs avant de continuer
if (!empty($errors)) {
    echo json_encode(['success' => false, 'errors' => $errors]);
    exit();
}

// Assigner les valeurs des données reçues à des variables
$email = $data['email'];
$password = $data['password'];
$username = $data['username'];
$role = $data['role'];
$branch_id = isset($data['branch']) ? $data['branch'] : null;

try {
    // Enregistrer un nouvel utilisateur sans la fonction de rappel
    $userId = $auth->register($email, $password);

    // Ajouter le rôle pour l'utilisateur enregistré
    switch ($role) {
        case 1:
            $auth->admin()->addRoleForUserById($userId, \Delight\Auth\Role::ADMIN);
            break;
        case 2:
            $auth->admin()->addRoleForUserById($userId, \Delight\Auth\Role::EMPLOYEE);
            break;
        case 4:
            $auth->admin()->addRoleForUserById($userId, \Delight\Auth\Role::USER);
            break;
        case 8:
            $auth->admin()->addRoleForUserById($userId, \Delight\Auth\Role::EXTERN_USER);
            break;
        default:
            throw new Exception('Rôle invalide fourni.');
    }

    // Mise à jour du nom d'utilisateur
    $updateStmt = $db->prepare("UPDATE users SET username = :username WHERE id = :userId");
    $updateStmt->bindParam(':username', $username, PDO::PARAM_STR);
    $updateStmt->bindParam(':userId', $userId, PDO::PARAM_INT);
    $updateStmt->execute();

    // Insertion de la relation avec la branche si fournie
    if ($branch_id !== null) {
        $branchStmt = $db->prepare("INSERT INTO user_branches (user_id, branch_id) VALUES (:user_id, :branch_id)");
        $branchStmt->bindParam(':user_id', $userId, PDO::PARAM_INT);
        $branchStmt->bindParam(':branch_id', $branch_id, PDO::PARAM_INT);
        $branchStmt->execute();
    }

    echo json_encode(['success' => true, 'message' => 'Inscription réussie']);
} catch (\Delight\Auth\InvalidEmailException $e) {
    $errors[] = 'Adresse email invalide';
} catch (\Delight\Auth\InvalidPasswordException $e) {
    $errors[] = 'Mot de passe invalide';
} catch (\Delight\Auth\UserAlreadyExistsException $e) {
    $errors[] = 'Cet utilisateur existe déjà';
} catch (\Delight\Auth\TooManyRequestsException $e) {
    $errors[] = 'Trop de tentatives, veuillez réessayer plus tard';
} catch (Exception $e) {
    $errors[] = 'Erreur serveur : ' . $e->getMessage();
}

// Affiche les erreurs si elles existent
if (!empty($errors)) {
    echo json_encode(['success' => false, 'errors' => $errors]);
}
