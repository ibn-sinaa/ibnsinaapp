<?php
require '../SYS/auth.php'; // Inclure le fichier d'authentification

header('Content-Type: application/json'); // Définir le type de contenu en JSON
ini_set('display_errors', 1);
ini_set('display_startup_errors', 1);
error_reporting(E_ALL);

// Récupérer les données envoyées
$data = json_decode(file_get_contents('php://input'), true);

$userId = $data['userId']; // ID de l'utilisateur à mettre à jour
$email = $data['email'];
$password = $data['password'] ?? null; // Le mot de passe est facultatif lors de la mise à jour
$username = $data['username'];
$role = $data['role']; // Récupère le rôle de l'utilisateur
$branch_id = $data['branch'] ?? null; // Récupère l'ID de la branche s'il est fourni

try {
    // Mettre à jour les informations de l'utilisateur
    $updateStmt = $db->prepare("UPDATE users SET email = :email, username = :username WHERE id = :userId");
    $updateStmt->bindParam(':email', $email);
    $updateStmt->bindParam(':username', $username);
    $updateStmt->bindParam(':userId', $userId, PDO::PARAM_INT);
    $updateStmt->execute();

    // Si un nouveau mot de passe est fourni, le mettre à jour
    if (!empty($password)) {
        $passwordHash = password_hash($password, PASSWORD_DEFAULT); // Hachage du mot de passe
        $passwordStmt = $db->prepare("UPDATE users SET password = :password WHERE id = :userId");
        $passwordStmt->bindParam(':password', $passwordHash);
        $passwordStmt->bindParam(':userId', $userId, PDO::PARAM_INT);
        $passwordStmt->execute();
    }

    // Mettre à jour le rôle de l'utilisateur
    // Suppression de l'ancien rôle avant d'en ajouter un nouveau
    $auth->admin()->removeRoleForUserById($userId, \Delight\Auth\Role::USER);
    $auth->admin()->removeRoleForUserById($userId, \Delight\Auth\Role::EMPLOYEE);
    $auth->admin()->removeRoleForUserById($userId, \Delight\Auth\Role::ADMIN);
    $auth->admin()->removeRoleForUserById($userId, \Delight\Auth\Role::EXTERN_USER);

    switch ($role) {
        case 8:
            $auth->admin()->addRoleForUserById($userId, \Delight\Auth\Role::EXTERN_USER); // Rôle utilisateur
            break;
        case 4:
            $auth->admin()->addRoleForUserById($userId, \Delight\Auth\Role::USER); // Rôle utilisateur
            break;
        case 2:
            $auth->admin()->addRoleForUserById($userId, \Delight\Auth\Role::EMPLOYEE); // Rôle employé
            break;
        case 1:
            $auth->admin()->addRoleForUserById($userId, \Delight\Auth\Role::ADMIN); // Rôle administrateur
            break;
        default:
            throw new Exception('Rôle invalide fourni.');
    }

    // Vérifie si un ID de branche a été fourni
if ($branch_id !== null) {
    // Supprimer l'ancienne branche associée à l'utilisateur, s'il en existe une
    $deleteBranchStmt = $db->prepare("DELETE FROM user_branches WHERE user_id = :user_id");
    $deleteBranchStmt->bindParam(':user_id', $userId, PDO::PARAM_INT);
    $deleteBranchStmt->execute();

    // Insertion de la nouvelle branche pour l'utilisateur
    $branchStmt = $db->prepare("INSERT INTO user_branches (user_id, branch_id) VALUES (:user_id, :branch_id)");
    $branchStmt->bindParam(':user_id', $userId, PDO::PARAM_INT);
    $branchStmt->bindParam(':branch_id', $branch_id, PDO::PARAM_INT);
    $branchStmt->execute();
}

    echo json_encode(['success' => true, 'message' => 'Utilisateur mis à jour avec succès']);
} catch (Exception $e) {
    echo json_encode(['success' => false, 'error' => 'Erreur lors de la mise à jour de l\'utilisateur: ' . $e->getMessage()]);
}
?>
