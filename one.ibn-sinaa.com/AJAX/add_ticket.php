<?php
// Inclure le fichier de connexion à la base de données
require '../SYS/auth.php'; // Inclure le fichier d'authentification

// Vérifier que la méthode est POST
if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    $title = $_POST['title'] ?? ''; // Titre du ticket
    $description = $_POST['description'] ?? ''; // Description du problème (pour un ticket créé par un utilisateur)
    $user_id = $_POST['user_id'] ?? ''; // ID de l'utilisateur qui ouvre le ticket
    $status = 'open'; // Par défaut, le ticket est ouvert

    // Initialiser la réponse JSON
    $response = ['success' => false, 'message' => ''];

    // Vérifier que les champs nécessaires sont remplis
    if ( !empty($user_id)) {
        // Vérifier si l'utilisateur existe dans la base de données
        $query = "SELECT id,username FROM users WHERE id = :user_id";
        $stmt = $db->prepare($query);
        $stmt->bindParam(':user_id', $user_id);
        $stmt->execute();
        if ($stmt->rowCount() === 0) {
            $response['message'] = 'المستخدم غير موجود.';
        } else {
            // Récupérer les données de l'utilisateur
        $user = $stmt->fetch(PDO::FETCH_ASSOC);
        $username = $user['username']; // Accès correct au nom d'utilisateur


             // Préparer la requête d'insertion du ticket
            $query = "INSERT INTO tickets (title, user_id, status, created_at) VALUES (:title, :user_id, :status, NOW())";
            $stmt = $db->prepare($query);
            $stmt->bindParam(':title', $title);
            $stmt->bindParam(':user_id', $user_id);
            $stmt->bindParam(':status', $status);

            // Exécuter la requête
            if ($stmt->execute()) {
                $ticket_id = $db->lastInsertId(); // ID du ticket créé

                // Insérer la description dans la table ticket_messages si elle est fournie (par exemple, pour un utilisateur)
                if (!empty($description)) {
                    // Insert the message
                    $query = "INSERT INTO messages (ticket_id, sender, content, sent_at, isAdmin) 
                              VALUES (:ticket_id, :user_id, :message, NOW(), 0)";
                    $stmt = $db->prepare($query);
                    $stmt->bindParam(':ticket_id', $ticket_id);
                    $stmt->bindParam(':user_id', $user_id); // User opening the ticket
                    $stmt->bindParam(':message', $description); // Problem description
                    $stmt->execute();
                
                    // Notification for admins
                    $message = "قام " . $username . " بفتح تذكرة جديدة";
                    $query = "INSERT INTO notifications (recipient_id, recipient_type, message,ticket_id) 
                              VALUES (NULL, 'admin', :message,:ticket_id)";
                    $stmt = $db->prepare($query);
                    $stmt->bindParam(':message', $message);
                    $stmt->bindParam(':ticket_id', $ticket_id);

                    $stmt->execute();
                } else {
                    // Notification for the user
                    $message = "قام الأدمن بفتح تذكرة جديدة";
                    $query = "INSERT INTO notifications (recipient_id, recipient_type, message,ticket_id) 
                              VALUES (:user_id, 'user', :message,:ticket_id)";
                    $stmt = $db->prepare($query);
                    $stmt->bindParam(':user_id', $user_id); // Notify the user
                    $stmt->bindParam(':message', $message);
                    $stmt->bindParam(':ticket_id', $ticket_id);

                    $stmt->execute();
                }
                
             

                // Répondre avec succès
                $response['success'] = true;
                $response['message'] = 'التذكرة تم إنشاؤها بنجاح.';
                $response['ticket_id'] = $ticket_id; // ID du ticket créé
            } else {
                $response['message'] = 'حدث خطأ أثناء إنشاء التذكرة.';
            }
        }
    } else {
        $response['message'] = 'الرجاء ملء جميع الحقول.';
    }
} else {
    $response['message'] = 'طلب غير صالح.';
}

// Envoyer les en-têtes avant toute sortie
header('Content-Type: application/json');

// Envoyer la réponse JSON
echo json_encode($response);
?>
