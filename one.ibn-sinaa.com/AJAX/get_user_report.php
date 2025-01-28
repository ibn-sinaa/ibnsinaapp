<?php
// Database connection
require '../SYS/db.php'; // Ensure this points to your database connection file

// Check if required parameters are provided
if (isset($_GET['userId']) && isset($_GET['status'])) {
    $userId = intval($_GET['userId']);
    $status = $_GET['status']; // Can be "all", -1 (rejected), or 1 (accepted)
    $startDate = isset($_GET['startDate']) ? $_GET['startDate'] : null; // Start date, if provided
    $endDate = isset($_GET['endDate']) ? $_GET['endDate'] : null; // End date, if provided

    try {
        // Base SQL query to fetch order details with optional status filter
        $sql = "
            SELECT 
                orders.order_number, 
                orders.user_id,
                orders.price,
                users.username,
                orders.status, 
                orders.valid,
                DATE_FORMAT(orders.created_at, '%Y-%m') AS order_month, 
                orders.price,
                orders.details,
                orders.created_at,
                branches.branch_name
            FROM 
                orders
            JOIN
                branches 
            ON
                branches.branch_id = orders.branch_id
            JOIN users 
            ON  orders.user_id = users.id 
            WHERE 
                orders.user_id = :userId
        ";

        // Add date filters if dates are provided
        if ($startDate && $endDate) {
            $sql .= " AND orders.created_at BETWEEN :startDate AND :endDate";
        } elseif ($startDate) {
            $sql .= " AND orders.created_at >= :startDate";
        } elseif ($endDate) {
            $sql .= " AND orders.created_at <= :endDate";
        }

        // Add status condition if 'all' is not selected
        if ($status !== 'all') {
            $sql .= " AND orders.valid = :status";
        } else {
            $sql .= " AND (orders.valid = 1 OR orders.valid = -1)";
        }

        $sql .= " ORDER BY orders.created_at";  // Order by creation date

        // Prepare query
        $query = $db->prepare($sql);

        // Bind parameters
        $params = [':userId' => $userId];

        // Bind date parameters if they are set
        if ($startDate) {
            $params[':startDate'] = $startDate;
        }
        if ($endDate) {
            $params[':endDate'] = $endDate;
        }

        // Bind status only if it is not 'all'
        if ($status !== 'all') {
            $params[':status'] = intval($status); // '-1' for rejected, '1' for accepted
        }

        // Execute query with parameters
        $query->execute($params);

        // Fetch results
        $orders = $query->fetchAll(PDO::FETCH_ASSOC);

        // Prepare monthly data for the chart
        $monthlyOrders = [];
        $acceptedOrders = [];
        $rejectedOrders = [];
        $tot_acceptedOrders = [];
        $tot_rejectedOrders = [];
  

        // Count accepted and rejected orders per month
        foreach ($orders as $order) {
            $username = $order['username'];
            $month = $order['order_month'];

            if (!isset($monthlyOrders[$month])) {
                $monthlyOrders[$month] = 0;
                $acceptedOrders[$month] = 0;
                $rejectedOrders[$month] = 0;
                $tot_acceptedOrders[$month] = 0;
                $tot_rejectedOrders[$month] = 0;
            }

            $monthlyOrders[$month] += 1;

            // Count accepted and rejected orders based on the corrected logic
            if ($order['valid'] == 1) {
                $acceptedOrders[$month] += 1;  // valid = 1 means accepted
                $tot_acceptedOrders[$month]+=$order['price'];
            } elseif ($order['valid'] == -1) {
                $rejectedOrders[$month] += 1;  // valid = -1 means rejected
                $tot_rejectedOrders[$month]+=$order['price'];

            }
        }

        // Format data for response (table and chart)
        $response = [
            'username' => $username ?? null,
            'orders' => $orders,
            'status'=>$status,
            'monthlyData' => array_map(function($month) use ($monthlyOrders, $acceptedOrders, $rejectedOrders, $tot_acceptedOrders, $tot_rejectedOrders) {
                return [
                    'month' => $month,
                    'total_orders' => $monthlyOrders[$month],
                    'accepted_orders' => $acceptedOrders[$month],
                    'rejected_orders' => $rejectedOrders[$month],
                    'total_price' => $tot_acceptedOrders[$month]+$tot_rejectedOrders[$month],
                    'accepted_price' => $tot_acceptedOrders[$month],
                    'rejected_price' => $tot_rejectedOrders[$month]
                ];
            }, array_keys($monthlyOrders))
        ];

        // Send JSON response
        echo json_encode($response);

    } catch (PDOException $e) {
        echo json_encode(['error' => 'Error retrieving data: ' . $e->getMessage()]);
    }
} else {
    echo json_encode(['error' => 'Missing parameters']);
}
?>
