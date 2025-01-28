<?php
require '../SYS/auth.php'; // Inclure le fichier d'authentification

$response = ['success' => false];

if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    $ticket_id = $_POST['ticket_id'] ?? null;
    $message = trim($_POST['message'] ?? '');
    $userId = $_POST['userId'] ?? null;
    $isAdmin = $_POST['isAdmin'] ?? null;
    
    // Gérer l'upload de fichier
    $filePath = null;
    if (isset($_FILES['file']) && $_FILES['file']['error'] === UPLOAD_ERR_OK) {
        $fileTmpPath = $_FILES['file']['tmp_name'];
        $fileName = $_FILES['file']['name'];
        $fileSize = $_FILES['file']['size'];
        $fileType = $_FILES['file']['type'];
        
        // Définir un dossier pour les fichiers
        $uploadDir = '../uploads/';
        $destPath = $uploadDir . basename($fileName);

        // Vérifier si le fichier peut être déplacé
        if (move_uploaded_file($fileTmpPath, $destPath)) {
            $filePath = $destPath; // Enregistrer le chemin du fichier
        } else {
            $response['error'] = 'Erreur lors de l\'upload du fichier.';
            echo json_encode($response);
            exit();
        }
    }

    if ($ticket_id && !empty($message)) {
        try {
            // Insertion du message dans la table 'messages' avec ou sans fichier
            $query = "INSERT INTO messages (ticket_id, sender, content, sent_at, isAdmin, file_path) 
                      VALUES (:ticket_id, :id, :message, NOW(), :isAdmin, :file_path)";
            $stmt = $db->prepare($query);
            $stmt->bindParam(':id', $userId, PDO::PARAM_INT);
            $stmt->bindParam(':ticket_id', $ticket_id, PDO::PARAM_INT);
            $stmt->bindParam(':message', $message, PDO::PARAM_STR);
            $stmt->bindParam(':isAdmin', $isAdmin, PDO::PARAM_STR);
            $stmt->bindParam(':file_path', $filePath, PDO::PARAM_STR); // Enregistrer le chemin du fichier

            if ($stmt->execute()) {
                // Récupérer l'ID du message inséré
                $messageId = $db->lastInsertId();
                $query = "SELECT  username FROM users WHERE id = :user_id";
                $stmt = $db->prepare($query);
                $stmt->bindParam(':user_id', $userId);
                $stmt->execute();
                $user = $stmt->fetch(PDO::FETCH_ASSOC);
                $username = $user['username']; // Accès correct au nom d'utilisateur
        



                // Logique d'envoi de notification
                $recipientType = ($isAdmin == '1') ? 'user' : 'admin';
                $recipientId = ($isAdmin == '1') ? $userId : null;

                // Créer le message de notification
                $notificationMessage = ($isAdmin == '1') 
                ? "أضاف الادمن ردا جديدا على التذكرة رقم " . $ticket_id 
                : "أضاف " . $username . " ردا جديدا على التذكرة رقم " . $ticket_id;
            
                // Insertion de la notification dans la table 'notifications'
                $notifQuery = "INSERT INTO notifications (recipient_id, recipient_type, message,ticket_id) 
                               VALUES (:recipient_id, :recipient_type, :message,:ticket_id)";
                $notifStmt = $db->prepare($notifQuery);
                $notifStmt->bindParam(':recipient_id', $recipientId, PDO::PARAM_INT);
                $notifStmt->bindParam(':recipient_type', $recipientType, PDO::PARAM_STR);
                $notifStmt->bindParam(':message', $notificationMessage, PDO::PARAM_STR);
                $notifStmt->bindParam(':ticket_id', $ticket_id, PDO::PARAM_STR);

                if ($notifStmt->execute()) {
                    $response['success'] = true;
                    $response['filePath'] = $filePath;  // Inclure le chemin du fichier dans la réponse
                    $response['message'] = $message;   // Inclure le message
                    $response['sender'] = $userId;     // Inclure l'ID de l'expéditeur
                    $response['isAdmin'] = $isAdmin;   // Inclure le rôle de l'expéditeur
                    $response['sentAt'] = date('H:i'); // Inclure l'heure d'envoi du message
                } else {
                    $response['error'] = 'Erreur lors de l\'envoi de la notification.';
                }
            } else {
                $response['error'] = 'Erreur lors de l\'envoi du message.';
            }
        } catch (PDOException $e) {
            $response['error'] = "Erreur : " . $e->getMessage();
        }
    } else {
        $response['error'] = 'رقم التذكرة أو الرسالة غير صالح.';
    }
}

header('Content-Type: application/json');
echo json_encode($response);
?>
