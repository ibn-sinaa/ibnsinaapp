<?php
require '../BACKOFFICE/check_login.php'; // Inclure le fichier d'authentification

 
// Afficher les erreurs pour faciliter le débogage
displayErrors();

function getNewOrderNumber() {
    global $db;

    // Récupérer le dernier numéro de compteur
    $query = $db->prepare("SELECT order_counter FROM counters ORDER BY id DESC LIMIT 1");
    $query->execute();
    $counter = $query->fetchColumn();

    // Créer un nouveau numéro de commande avec format AAAA-MM-XXX (ex: 2024-10-001)
    $newOrderNumber = $counter;

    return $newOrderNumber;
}

// Vérification que la requête est bien envoyée via AJAX
if ($_SERVER['REQUEST_METHOD'] === 'POST') {

    // Récupérer et sécuriser les données envoyées depuis le formulaire
    $branch_id = (isset($_POST['branch']) && !empty($_POST['branch'])) ? intval($_POST['branch']) : 0;
    $sender = (isset($_POST['sender']) && !empty($_POST['sender'])) ? $_POST['sender'] : '';
    $details = (isset($_POST['order-details']) && !empty($_POST['order-details'])) ? $_POST['order-details'] : '';
    $price = (isset($_POST['price']) && !empty($_POST['price'])) ? floatval($_POST['price']) : 0;    
    $execution_time = (isset($_POST['execution-time']) && !empty($_POST['execution-time'])) ? $_POST['execution-time'] : 0;
    $status = (isset($_POST['status']) && !empty($_POST['status'])) ? $_POST['status'] : 'pending';
    $delivery_date = isset($_POST['delivery_date']) && !empty($_POST['delivery_date']) ? $_POST['delivery_date'] : null;
    $order_date = isset($_POST['order_date']) && !empty($_POST['order_date']) ? $_POST['order_date'] : null;
    $repeated = (isset($_POST['repeated']) && !empty($_POST['repeated'])) ? $_POST['repeated'] : 0;
    $notes = (isset($_POST['notes']) && !empty($_POST['notes'])) ? $_POST['notes'] : '';
    
// Transformer la valeur en arabe
    switch ($status) {
        case 'pending':
            $status_arabic = 'في الانتظار';
            break;
      
        case 'in_progress':
            $status_arabic = 'قيد التنفيذ';
            break;
        case 'ready':
            $status_arabic = 'جاهز';
            break;
        case 'order_sent':
            $status_arabic = 'تم إرسال الطلب';
            break;
        case 'waiting':
            $status_arabic = 'في انتظار التعميد';
            break;
        default:
            $status_arabic = 'في الانتظار';
    }
    // Récupérer les étapes sélectionnées par l'administrateur
    $order_steps= array();
    $order_steps = isset($_POST['order_steps']) ? $_POST['order_steps'] : [];

    // Gérer l'upload de fichiers
    $uploaded_files = [];

    if (!empty($_FILES['files']['name'][0])) {
        $target_dir = "../uploads/";
        $uploaded_files = []; // Tableau pour stocker les chemins des fichiers uploadés
        $allowed_types = ['image/jpeg', 'image/png', 'application/pdf']; // Types autorisés
        $errors = []; // Tableau pour stocker les erreurs
    
        foreach ($_FILES['files']['tmp_name'] as $key => $tmp_name) {
            $file_type = mime_content_type($tmp_name);
            $filename = basename($_FILES['files']['name'][$key]);
    
           
            // Générer un nom de fichier unique pour éviter les conflits
           // $unique_name = uniqid() . '-' . preg_replace('/[^a-zA-Z0-9_\.-]/', '_', $filename);
            $unique_name =basename($filename);

            $target_file = $target_dir . $unique_name;

    
            // Upload du fichier
            if (move_uploaded_file($tmp_name, $target_file)) {
                $uploaded_files[] = $target_file;
            } else {
                $errors[] = "Erreur lors du téléchargement du fichier {$filename}.";
            }
        }
     
        // Retourner le statut sous forme de JSON
        if (!empty($uploaded_files)) {
            echo json_encode([
                'status' => 'success',
                'message' => 'Fichiers uploadés avec succès.',
                'files' => $uploaded_files,
                'errors' => $errors // Retourne aussi les erreurs pour les fichiers échoués
            ]);
        } else {
            echo json_encode([
                'status' => 'error',
                'message' => 'Aucun fichier n\'a été uploadé.',
                'errors' => $errors
            ]);
        }
    }
    

    // Joindre les chemins des fichiers dans une chaîne

    try {
        $db->beginTransaction();

        // Générer un nouveau numéro de commande
        $newOrderNumber = getNewOrderNumber();
        if ($auth->hasRole(\Delight\Auth\Role::ADMIN)) {
            $valid=1;
        }
        else if ($auth->hasRole(\Delight\Auth\Role::USER) ||$auth->hasRole(\Delight\Auth\Role::EXTERN_USER)) {
            $valid=0;
        }

        // Insérer la commande dans la table `orders`
     $query = $db->prepare("INSERT INTO orders (order_number, branch_id, sender, details, price, execution_time, status, valid, user_id, delivery_date, repeated, order_date,notes)
                        VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, NOW(),?)");


        // Exécuter la requête préparée
        if ($query->execute([$newOrderNumber, $branch_id, $sender, $details, $price, $execution_time, $status_arabic,$valid,$userId,$delivery_date,$repeated,$notes])) {
            // Récupérer l'ID de la commande récemment créée
            $order_id = $db->lastInsertId();

            if (!empty($uploaded_files)) {
                foreach ($uploaded_files as $filename) {
                    $fileQuery = $db->prepare("INSERT INTO ordre_files (order_id, attachment_file) VALUES (?, ?)");
                    $fileQuery->execute([$order_id, $filename]);
                    if ($fileQuery->rowCount() === 0) {
                        throw new Exception("Échec de l'insertion des fichiers.");
                    }
                }
            }
            
            if (!empty($order_steps)) {
                $step_num=1;
                $stepsArray = explode(',', $order_steps);
                foreach ($stepsArray as $stepId) {
                    $insertStep = $db->prepare("INSERT INTO order_steps (order_id, step_id,step_num) VALUES (?, ?,?)");
                    $insertStep->execute([$order_id, intval($stepId),$step_num]);
                    $step_num++;
                    if ($insertStep->rowCount() === 0) {
                        throw new Exception("Échec de l'insertion des étapes.");
                    }
                }
            }
            if($auth->hasRole(\Delight\Auth\Role::EXTERN_USER)){
                $insertStep = $db->prepare("INSERT INTO order_steps (order_id, step_id,step_num) VALUES (?, ?,?)");
                $insertStep->execute([$order_id, 0,1]);
                $insertStep->execute([$order_id, 40,2]);
                // Insérer l'étape actuelle dans order_steps_log
                $stepLogQuery = $db->prepare("INSERT INTO order_steps_log ( `order_id`, `step_id`, `start_date`) VALUES (?, ?, NOW())");
                $stepLogQuery->execute([$order_id, 0]);

            }
            $statusLogQuery = $db->prepare("INSERT INTO order_status_logs (`order_id`, `status`,`changed_by`, `changed_at`) VALUES (?, ?, ?, NOW())");
            $statusLogQuery->execute([$order_id, $status_arabic, $userId]); // userId doit être défini au préalable
            if ($statusLogQuery->rowCount() === 0) {
                throw new Exception("Échec de l'insertion du journal des statuts.");
            }
            // Insérer uniquement la première étape dans order_steps_log
            if (!empty($order_steps)) {
                $stepsArray = explode(',', $order_steps);
                $firstStepId = intval($stepsArray[0]); // Obtenir le premier ID d'étape

          
                // Insérer l'étape actuelle dans order_steps_log
                $stepLogQuery = $db->prepare("INSERT INTO order_steps_log ( `order_id`, `step_id`, `start_date`, `changed_by`) VALUES (?, ?, NOW(),?)");
                $stepLogQuery->execute([$order_id, $firstStepId,$userId]);
            }

            // Mettre à jour le compteur
            $query = $db->prepare("UPDATE counters SET order_counter = order_counter + 1");
            $query->execute();
            $db->commit();

            echo json_encode(['status' => 'success', 'message' => 'Commande ajoutée avec succès avec les étapes sélectionnées !']);
        } else {
            echo json_encode(['status' => 'error', 'message' => 'Erreur lors de l\'ajout de la commande.']);
        }
    } catch (PDOException $e) {
        $db->rollBack();

        echo json_encode(['status' => 'error', 'message' => 'Erreur de base de données : ' . $e->getMessage()]);

    }

} else {
    echo json_encode(['status' => 'error', 'message' => 'Requête invalide.']);
}
?>
