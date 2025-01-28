<?php
require '../SYS/db.php'; // Assurez-vous d'avoir le fichier de connexion à la base de données
// Ajoutez la fonction pour récupérer les filiales
function getBranches($db) {
    $sql = "SELECT id, name FROM branches"; // Supposons que votre table de filiales s'appelle 'branches'
    $stmt = $db->prepare($sql);
    $stmt->execute();
    return $stmt->fetchAll(PDO::FETCH_ASSOC);
}

// Récupération des données pour le rapport
$start_date = isset($_GET['start_date']) ? $_GET['start_date'] : null;
$end_date = isset($_GET['end_date']) ? $_GET['end_date'] : null;
$branch_id = isset($_GET['branch_id']) ? $_GET['branch_id'] : null;

function getBranchReport($db, $start_date = null, $end_date = null, $branch_id = null) {
    // Construction de la requête de base
    $sql = "SELECT 
                orders.branch_id, 
                branches.branch_name AS branch_name, 
                COUNT(orders.order_id) AS total_orders, 
                SUM(orders.price) AS total_price
            FROM orders
            JOIN branches ON branches.branch_id = orders.branch_id";
    
    // Conditions supplémentaires selon les filtres
    $conditions = [];
    if (!empty($start_date) && !empty($end_date)) {
        $conditions[] = "orders.order_date BETWEEN :start_date AND :end_date";
    } elseif (!empty($start_date)) {
        $conditions[] = "orders.order_date >= :start_date";
    } elseif (!empty($end_date)) {
        $conditions[] = "orders.order_date <= :end_date";
    }

    if (!empty($branch_id)) {
        $conditions[] = "orders.branch_id = :branch_id";
    }

    // Si des conditions existent, ajouter une clause WHERE
    if (!empty($conditions)) {
        $sql .= " WHERE " . implode(' AND ', $conditions);
    }

    // Ajouter un GROUP BY correct pour les colonnes agrégées
    $sql .= " GROUP BY orders.branch_id, branches.branch_name";  // Assurez-vous que tout ce qui n'est pas agrégé soit dans le GROUP BY

    // Préparer et exécuter la requête
    $stmt = $db->prepare($sql);

    // Lier les paramètres dynamiquement
    if (!empty($start_date) && !empty($end_date)) {
        $stmt->bindParam(':start_date', $start_date, PDO::PARAM_STR);
        $stmt->bindParam(':end_date', $end_date, PDO::PARAM_STR);
    }
    if (!empty($start_date) && empty($end_date)) {
        $stmt->bindParam(':start_date', $start_date, PDO::PARAM_STR);
    }
    if (empty($start_date) && !empty($end_date)) {
        $stmt->bindParam(':end_date', $end_date, PDO::PARAM_STR);
    }
    if (!empty($branch_id)) {
        $stmt->bindParam(':branch_id', $branch_id, PDO::PARAM_INT);
    }

    // Exécuter la requête
    $stmt->execute();
    return $stmt->fetchAll(PDO::FETCH_ASSOC);
}


// Récupérer les données des branches pour le sélecteur
if (isset($_GET['action']) && $_GET['action'] == 'getBranches') {
    $branches = getBranches($db);
    echo json_encode($branches);
    exit();
}

$branch_data = getBranchReport($db, $start_date, $end_date, $branch_id);
echo json_encode($branch_data);
