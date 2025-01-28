<?php
include('../SYS/db.php'); // Inclure la connexion à la base de données

$employeeId = $_GET['employeeId'];
$startDate = $_GET['startDate'];
$endDate = $_GET['endDate'];

$query = "
    SELECT o.*
    FROM orders o
    JOIN order_employees oe ON o.order_id = oe.order_id
    WHERE oe.employee_id = :employeeId
";

$params = [':employeeId' => $employeeId];

if (!empty($startDate)) {
    $query .= " AND o.order_date >= :startDate";
    $params[':startDate'] = $startDate;
}

if (!empty($endDate)) {
    $query .= " AND o.order_date <= :endDate";
    $params[':endDate'] = $endDate;
}

$stmt = $db->prepare($query);
$stmt->execute($params);

$orders = $stmt->fetchAll(PDO::FETCH_ASSOC);

echo json_encode(['orders' => $orders]);
?>