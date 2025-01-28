<?php
require '../BACKOFFICE/check_login.php'; // Inclure le fichier d'authentification

if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    // Lire les données JSON
    $input = json_decode(file_get_contents('php://input'), true);
    $orderId = $input['orderId'] ?? null;
    $employees = $input['employees'] ?? [];

    if (!$orderId || empty($employees)) {
        echo json_encode(['success' => false, 'message' => 'بيانات غير مكتملة.']);
        exit;
    }

    try {
        // Supprimer les associations existantes
        $stmt = $db->prepare("DELETE FROM order_employees WHERE order_id = :order_id");
        $stmt->execute(['order_id' => $orderId]);

        // Ajouter les nouvelles associations
        $stmt = $db->prepare("INSERT INTO order_employees (order_id, employee_id) VALUES (:order_id, :employee_id)");
        foreach ($employees as $employeeId) {
            $stmt->execute(['order_id' => $orderId, 'employee_id' => $employeeId]);
        }

        echo json_encode(['success' => true, 'message' => 'تم التحديث بنجاح.']);
    } catch (Exception $e) {
        echo json_encode(['success' => false, 'message' => 'حدث خطأ أثناء التحديث.']);
    }
}



?>