<?php
require '../SYS/db.php'; // Ensure your database connection is correctly set up

// Vérifier si l'ID du ticket est passé en paramètre
if (isset($_GET['ticket_id']) && is_numeric($_GET['ticket_id'])) {
    $ticket_id = $_GET['ticket_id'];

    // Préparer la requête pour mettre à jour le statut du ticket
    $query = "UPDATE tickets SET status = 'closed' WHERE id = :ticket_id";
    $stmt = $db->prepare($query);
    
    // Exécuter la requête avec l'ID du ticket
    if ($stmt->execute([':ticket_id' => $ticket_id])) {
        // Rediriger vers la page des tickets après la mise à jour
        header('Location: ../BACKOFFICE/opend_tickets.php'); // Remplace ticket_list.php par le nom de ta page des tickets
        exit;
    } else {
        echo "Une erreur est survenue lors de la fermeture du ticket.";
    }
} else {
    echo "Ticket non valide.";
}
?>
