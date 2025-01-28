<?php
require '../BACKOFFICE/check_login.php'; // Inclure le fichier d'authentification

// Verify if data is sent via POST
if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    // Check if required fields are provided
    if (isset($_POST['order_id'], $_POST['price'], $_POST['status'])) {
        $orderId = isset($_POST['order_id']) ? $_POST['order_id'] : null;

        $details = isset($_POST['order-details']) ? $_POST['order-details'] : '';
        $price = isset($_POST['price']) ? floatval($_POST['price']) : 0;
        $execution_time = (isset($_POST['execution-time']) && !empty($_POST['execution-time'])) ? $_POST['execution-time'] : 0;
        $status = (isset($_POST['status']) && !empty($_POST['status'])) ? $_POST['status'] : '';
        $delivery_date = isset($_POST['delivery_date']) && !empty($_POST['delivery_date']) ? $_POST['delivery_date'] : null;
        $order_date = isset($_POST['order_date']) && !empty($_POST['order_date']) ? $_POST['order_date'] : null;
        $repeated = isset($_POST['repeated']) ? $_POST['repeated'] : 0;
        $notes= isset($_POST['notes']) ? $_POST['notes'] : '';
        $selectedSteps = json_decode($_POST['order_steps'], true); // Récupération des étapes
        $current_step = isset($_POST['current_step']) ? $_POST['current_step'] : null; // Check if 'current_step' is set, otherwise set it to null
        {

            if (isset($_FILES['order-files']) && !empty($_FILES['order-files']['name'][0])) {
                foreach ($_FILES['order-files']['name'] as $index => $file_name) {
    
           
                    // Générer un nom de fichier unique pour éviter les conflits
                    //$unique_name = uniqid() . '-' . preg_replace('/[^a-zA-Z0-9_\.-]/', '_', basename($file_name));
                    $unique_name =basename($file_name);

                    // Récupérer les informations du fichier
                    $tmp_name = $_FILES['order-files']['tmp_name'][$index];
                    $file_size = $_FILES['order-files']['size'][$index];
                    $file_type = $_FILES['order-files']['type'][$index];
            
                    // Vérification du type MIME si nécessaire
                    $allowed_types = ['image/png', 'image/jpeg']; // Types MIME autorisés
                   
            
                    // Déplacer le fichier vers la destination finale
                    $upload_dir = '../uploads/'; // Répertoire où vous voulez stocker les fichiers
                    if (!file_exists($upload_dir)) {
                        mkdir($upload_dir, 0777, true); // Crée le répertoire si nécessaire
                    }
                    
                    $file_path = $upload_dir . basename($unique_name);
            
                    if (move_uploaded_file($tmp_name, $file_path)) {
                        // Insérer les informations du fichier dans la base de données
                        $stmt = $db->prepare("INSERT INTO ordre_files (order_id, attachment_file) VALUES (?, ?)");
 
                         $stmt->bindParam(1, $orderId, PDO::PARAM_INT); // Lier l'ID de la commande (entier)
                        $stmt->bindParam(2, $file_path, PDO::PARAM_STR); // Lier le nom du fichier (chaîne de caractères)
                                    
                        if ($stmt->execute()) {
                            echo json_encode([
                                "status" => "success",
                                "message" => "File uploaded and saved to database successfully."
                            ]);
                        } else {
                            echo json_encode([
                                "status" => "error",
                                "message" => "Error inserting file into database."
                            ]);
                        }
            
                    } else {
                        echo json_encode([
                            "status" => "error",
                            "message" => "Error uploading file."
                        ]);
                    }
                }
            } else {
                echo json_encode([
                    "status" => "error",
                    "message" => "No files uploaded.",
                    "errors" => []
                ]);
            }
            
            
    }
    
        // Start a transaction to ensure data integrity
        $db->beginTransaction();

        try {
            
          
            if ($auth->hasRole(\Delight\Auth\Role::ADMIN)) {
                // Récupérer le statut actuel
                $currentStatusQuery = $db->prepare("SELECT status FROM orders WHERE order_id = :order_id");
                $currentStatusQuery->bindParam(':order_id', $orderId);
                $currentStatusQuery->execute();
                $currentStatus = $currentStatusQuery->fetchColumn();
                // Update order price and status for admin
                $stmt = $db->prepare("UPDATE orders SET delivery_date = :delivery_date,  status = :status, price = :price,  repeated = :repeated ,execution_time = :execution_time, details = :details, notes = :notes WHERE order_id = :order_id");
                $stmt->bindParam(':price', $price);
                $stmt->bindParam(':delivery_date', $delivery_date);
                $stmt->bindParam(':repeated', $repeated);
                $stmt->bindParam(':details', $details);
                $stmt->bindParam(':status', $status);
                $stmt->bindParam(':notes', $notes);
                $stmt->bindParam(':order_id', $orderId);
                $stmt->bindParam(':execution_time', $execution_time);
            
                if ($stmt->execute()) {
                    echo "Order updated successfully.";
                } else {
                    echo "Error updating order.";
                }


             
                 if ($currentStatus !== $status) {
                    // Insérer le log seulement si le statut a changé
                    $statusLogQuery = $db->prepare("INSERT INTO order_status_logs (order_id, status, changed_by, changed_at) VALUES (?, ?, ?, NOW())");
                    $statusLogQuery->execute([$orderId, $status, $userId]);
                }

                // $statusLogQuery = $db->prepare("INSERT INTO order_status_logs (`order_id`, `status`,`changed_by`, `changed_at`) VALUES (?, ?, ?, NOW())");
                // $statusLogQuery->execute([$orderId, $status, $userId]); // userId doit être défini au préalable
                
            }
            if (!$auth->hasRole(\Delight\Auth\Role::ADMIN)) {
          
                // Update order price and status for admin
                $stmt = $db->prepare("UPDATE orders SET details = :details, notes = :notes WHERE order_id = :order_id");
                $stmt->bindParam(':details', $details);
                $stmt->bindParam(':notes', $notes);
                $stmt->bindParam(':order_id', $orderId);
            
                if ($stmt->execute()) {
                    echo "Order updated successfully.";
                } else {
                    echo "Error updating order.";
                }
            }
         
            if (!$auth->hasRole(\Delight\Auth\Role::EXTERN_USER)) {

               // Insérer uniquement la première étape dans order_steps_log
               if (!empty($current_step)) {
      
          
                // Insérer l'étape actuelle dans order_steps_log
                $stepLogQuery = $db->prepare("INSERT INTO order_steps_log ( `order_id`, `step_id`, `start_date`, `changed_by`) VALUES (?, ?, NOW(),?)");
                $stepLogQuery->execute([$orderId, $current_step,$userId]);
            }
            // Delete existing steps for the order
            $deleteStepsStmt = $db->prepare("DELETE FROM order_steps WHERE order_id = :order_id");
            $deleteStepsStmt->bindParam(':order_id', $orderId);
            if (!$deleteStepsStmt->execute()) {
                throw new Exception('Failed to delete old order steps.');
            }
            
            if ($selectedSteps) {
                $step_num=1;
                foreach ($selectedSteps as $step) {
                    // Exemple d'insertion dans la base de données
                    $stepId = $step['step_id'];
                    $query = "INSERT INTO order_steps (order_id, step_id,step_num) VALUES (?, ?,?)";
                    $stmt = $db->prepare($query);
                    $stmt->execute([$orderId, $stepId,$step_num]);
                    $step_num++;
                }
            }
           

        }
        $db->commit();

            // Commit the transaction if all operations are successful
            echo json_encode(['success' => true, 'message' => 'Order and steps updated successfully.']);
        } catch (Exception $e) {
            // Roll back the transaction in case of error
             echo json_encode(['success' => false, 'message' => $e->getMessage()]);
        }

    } else {
        echo json_encode(['success' => false, 'message' => 'Invalid input data.']);
    }
} else {
    echo json_encode(['success' => false, 'message' => 'Invalid request method.']);
}
?>
