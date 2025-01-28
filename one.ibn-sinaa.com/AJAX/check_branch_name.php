<?php
require '../SYS/db.php'; // Ensure your database connection is correctly set up

header('Content-Type: application/json'); // Ensure JSON response format

if (isset($_POST['branch_name'])) {
    $branch_name = trim($_POST['branch_name']);

    try {
        // Prepare and execute the query with PDO
        $stmt = $db->prepare("SELECT COUNT(*) FROM branches WHERE branch_name = :branch_name");
        $stmt->bindParam(':branch_name', $branch_name, PDO::PARAM_STR);
        $stmt->execute();
        
        // Fetch the result
        $count = $stmt->fetchColumn();

        // Output JSON response
        echo json_encode(['exists' => $count > 0]);
    } catch (PDOException $e) {
        // If an error occurs, output a JSON error message
        echo json_encode(['error' => 'Database error: ' . $e->getMessage()]);
    }
    exit;
} else {
    // In case of no branch_name in POST request, respond with an error
    echo json_encode(['error' => 'Branch name not provided']);
    exit;
}
?>
