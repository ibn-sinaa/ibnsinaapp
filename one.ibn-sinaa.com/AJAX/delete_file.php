<?php
require '../SYS/db.php'; // Assurez-vous que votre connexion à la base de données est correctement configurée
  
header('Content-Type: application/json');

if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    $orderId = intval($_POST['order_id']);
    $fileName = $_POST['file_name'];

    try {
        // Vérification que le fichier existe pour cet order_id
        $stmt = $db->prepare("
            SELECT attachment_file 
            FROM ordre_files 
            WHERE order_id = :order_id AND attachment_file = :file_name
        ");
        $stmt->execute([
            'order_id' => $orderId,
            'file_name' => $fileName
        ]);
        $file = $stmt->fetch();

        if (!$file) {
            echo json_encode(['success' => false, 'message' => 'الملف غير موجود']);
            exit;
        }

        // Supprimer le fichier dans la base de données
        $stmt = $db->prepare("
            DELETE FROM ordre_files 
            WHERE order_id = :order_id AND attachment_file = :file_name
        ");
        $stmt->execute([
            'order_id' => $orderId,
            'file_name' => $fileName
        ]);

        echo json_encode(['success' => true]);
    } catch (Exception $e) {
        // Gestion d'erreur détaillée
        echo json_encode([
            'success' => false,
            'message' => 'خطأ أثناء محاولة الحذف',
            'data' => 'Order ID: ' . $orderId . ' - Error: ' . $e->getMessage()
        ]);
    }
    exit;
}

echo json_encode(['success' => false, 'message' => 'طلب غير صالح']);
exit;
