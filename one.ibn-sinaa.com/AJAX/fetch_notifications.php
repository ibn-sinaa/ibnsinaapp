<?php
require '../BACKOFFICE/check_login.php'; // Inclure le fichier d'authentification
header('Content-Type: application/json');

try {
    if ($auth->hasRole(\Delight\Auth\Role::ADMIN)) {
        $query = "SELECT * FROM notifications WHERE    is_read = '0' AND recipient_type='admin'";
        $stmt = $db->prepare($query);

    }

    else {
        $query = "SELECT * FROM notifications WHERE recipient_id = :userId AND is_read = '0' AND recipient_type='user'";
        $stmt = $db->prepare($query);
        $userId = isset($userId) ? $userId : null; // Assurez-vous que $userId est initialisé
        if ($userId) {  
        $stmt->bindParam(':userId', $userId, PDO::PARAM_INT);
        }
        else {
            echo json_encode(['status' => 'error', 'message' => 'User not logged in']);
        }
    
         
        
    }
    $stmt->execute();
        $notifications = $stmt->fetchAll(PDO::FETCH_ASSOC);
        echo json_encode(['status' => 'success', 'data' => $notifications]);
} catch (Exception $e) {
    echo json_encode(['status' => 'error', 'message' => $e->getMessage()]);
}
?>
