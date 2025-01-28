<?php
require '../SYS/db.php'; // Connexion à la base de données

// Récupération des données des commandes
$start_date = isset($_GET['start_date']) ? $_GET['start_date'] : null;

function getBranchReport($db, $start_date = null) {
    $sql = "SELECT orders.*, branches.branch_name 
            FROM orders 
            JOIN branches ON branches.branch_id = orders.branch_id 
            WHERE delivery_date = :start_date";

    $stmt = $db->prepare($sql);
    $stmt->bindParam(':start_date', $start_date);
    $stmt->execute();
    return $stmt->fetchAll(PDO::FETCH_ASSOC);
}

// Calcul des totaux
function getTotals($db, $start_date = null) {
    $sql = "SELECT 
                COUNT(*) AS total_count, 
                COALESCE(SUM(price), 0) AS total_price 
            FROM orders 
            WHERE delivery_date = :start_date";

    $stmt = $db->prepare($sql);
    $stmt->bindParam(':start_date', $start_date);
    $stmt->execute();
    return $stmt->fetch(PDO::FETCH_ASSOC);
}


if ($start_date) {
    $branch_data = getBranchReport($db, $start_date);
    $totals = getTotals($db, $start_date);

    echo json_encode([
        'data' => $branch_data,
        'totals' => $totals,
    ]);
} else {
    echo json_encode([
        'data' => [],
        'totals' => ['total_count' => 0, 'total_price' => 0],
    ]);
}
?>
