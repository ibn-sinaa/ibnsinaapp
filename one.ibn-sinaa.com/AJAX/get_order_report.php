<?php
require '../BACKOFFICE/check_login.php'; // Include authentication file

// Verify if data is sent via POST
if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    // Check if required fields are provided
    if (isset($_POST['order_number'])) {
        $order_number = $_POST['order_number'];

        // Start a transaction to ensure data integrity
        $db->beginTransaction();

        try {
            // Query to get the order details
            $stmt = $db->prepare("SELECT * FROM `orders` WHERE order_number = :order_number");
            $stmt->bindParam(':order_number', $order_number);
            $stmt->execute();
            
            // Fetch the order data
            $order = $stmt->fetch(PDO::FETCH_ASSOC);
            
            // Check if the order exists
            if (!$order) {
                throw new Exception('Order not found.');
            }

            // Get order_id from the fetched order
            $order_id = $order['order_id'];

            // Fetch the status logs for the order
            $stmt = $db->prepare("SELECT  order_status_logs.*, users.username FROM `order_status_logs`  JOIN users ON users.id=order_status_logs.changed_by WHERE order_id = :order_id");
            $stmt->bindParam(':order_id', $order_id);
            $stmt->execute();
            $status_logs = $stmt->fetchAll(PDO::FETCH_ASSOC);

            // Fetch the steps logs for the order
            $stmt = $db->prepare("SELECT * FROM `order_steps_log` JOIN steps ON order_steps_log.step_id = steps.step_id  JOIN users ON users.id=order_steps_log.changed_by WHERE order_id = :order_id");
            $stmt->bindParam(':order_id', $order_id);
            $stmt->execute();
            $steps_logs = $stmt->fetchAll(PDO::FETCH_ASSOC);

            // Commit the transaction if all operations are successful
            $db->commit();

            // Return the combined result
            echo json_encode(['success' => true, 'order' => $order, 'status_logs' => $status_logs, 'steps_logs' => $steps_logs]);
        } catch (Exception $e) {
            // Roll back the transaction in case of error
            $db->rollBack();
            echo json_encode(['success' => false, 'message' => $e->getMessage()]);
        }

    } else {
        echo json_encode(['success' => false, 'message' => 'Invalid input data.']);
    }
} else {
    echo json_encode(['success' => false, 'message' => 'Invalid request method.']);
}
?>
