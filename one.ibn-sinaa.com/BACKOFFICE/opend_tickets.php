<?php
include('header.php');

$message = null; // Variable pour stocker les messages
$message_type = ''; // Variable pour le type de message

// Traitement du formulaire si soumis
if ($_SERVER['REQUEST_METHOD'] === 'POST' && isset($_POST['create_ticket'])) {
    $title = $_POST['title'];
    $user_id = $_POST['user_id']; // ID de l'utilisateur associé
    $status = 'open'; // Le ticket est ouvert par défaut

    if (!empty($title) && !empty($user_id)) {
        $query = "INSERT INTO tickets (title, user_id, status, created_at) VALUES (:title, :user_id, :status, NOW())";
        $stmt = $db->prepare($query);
        $stmt->bindParam(':title', $title);
        $stmt->bindParam(':user_id', $user_id);
        $stmt->bindParam(':status', $status);
        if ($stmt->execute()) {
            $message = "التذكرة تم إنشاؤها بنجاح.";
            $message_type = 'success'; // Type success
        } else {
            $message = "حدث خطأ أثناء إنشاء التذكرة.";
            $message_type = 'error'; // Type error
        }
    } else {
        $message = "الرجاء ملء جميع الحقول.";
        $message_type = 'warning'; // Type warning
    }
}

// Récupérer tous les utilisateurs pour la liste déroulante
$query_users = "SELECT id, username FROM users";
$stmt_users = $db->prepare($query_users);
$stmt_users->execute();
$users = $stmt_users->fetchAll(PDO::FETCH_ASSOC);

// Récupérer tous les tickets avec les informations sur l'utilisateur
$query_tickets = "SELECT t.id, t.title, t.created_at, t.status, u.username 
                  FROM tickets t
                  JOIN users u ON t.user_id = u.id";
$stmt_tickets = $db->prepare($query_tickets);
$stmt_tickets->execute();
$tickets = $stmt_tickets->fetchAll(PDO::FETCH_ASSOC);
?>

<body class="navbar-fixed sidebar-nav fixed-nav">
    <main class="main">
        <ol class="breadcrumb">
            <li class="breadcrumb-item active">إدارة التذاكر</li>
        </ol>

        <div class="container-fluid">
            <div class="animated fadeIn">
                <div class="row">
                    <!-- Formulaire de création de ticket -->
                    <div class="col-md-12">
                        <div class="card">
                            <div class="card-header">
                                إنشاء تذكرة جديدة
                            </div>
                            <div class="card-block">
                                <form method="POST" action="" id="addTicketForm">
                                    <div class="form-group">
                                        <label for="title">عنوان التذكرة</label>
                                        <input type="text" name="title" id="title" class="form-control" required>
                                    </div>
                                    <div class="form-group">
                                        <label for="user_id">المستخدم</label>
                                        <select name="user_id" id="user_id" class="form-control" required>
                                            <option value="">اختر المستخدم</option>
                                            <?php foreach ($users as $user) { ?>
                                                <option value="<?= htmlspecialchars($user['id']); ?>"><?= htmlspecialchars($user['username']); ?></option>
                                            <?php } ?>
                                        </select>
                                    </div>
                                    <button type="submit" name="create_ticket" class="btn btn-primary">إنشاء التذكرة</button>
                                </form>
                            </div>
                        </div>
                    </div>

                    <!-- Liste des tickets -->
                    <div class="col-md-12">
                        <div class="card">
                            <div class="card-header">
                                جميع التذاكر
                            </div>
                            <div class="card-block">
                                <table class="table table-bordered table-striped">
                                    <thead>
                                        <tr>
                                            <th>رقم التذكرة</th>
                                            <th>العنوان</th>
                                            <th>تاريخ الإنشاء</th>
                                            <th>الحالة</th>
                                            <th>المستخدم</th> <!-- Ajouter le nom de l'utilisateur -->
                                            <th>الرسائل</th>
                                            <th>الإجراءات</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <?php
                                        if (count($tickets) > 0) {
                                            foreach ($tickets as $ticket) {
                                                echo "<tr>";
                                                echo "<td>" . htmlspecialchars($ticket['id']) . "</td>";
                                                echo "<td>" . htmlspecialchars($ticket['title']) . "</td>";
                                                echo "<td>" . htmlspecialchars($ticket['created_at']) . "</td>";
                                                echo "<td>" . ($ticket['status'] === 'open' ? 'مفتوح' : 'مغلق') . "</td>";
                                                echo "<td>" . htmlspecialchars($ticket['username']) . "</td>"; // Afficher le nom de l'utilisateur
                                                echo "<td><a href='ticket_messages.php?ticket_id=" . htmlspecialchars($ticket['id']) . "' class='btn btn-info'>عرض الرسائل</a></td>";
                                                
                                                // Afficher le bouton de fermeture uniquement si le ticket est ouvert
                                                if ($ticket['status'] === 'open') {
                                                    echo "<td><a href='../AJAX/close_ticket.php?ticket_id=" . htmlspecialchars($ticket['id']) . "' class='btn btn-danger'>اغلاق التذكرة</a></td>";
                                                } else {
                                                    echo "<td>-</td>";
                                                }
                                                echo "</tr>";
                                            }
                                        } else {
                                            echo "<tr><td colspan='7'>لا توجد تذاكر.</td></tr>";
                                        }
                                        ?>
                                    </tbody>
                                </table>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </main>
  <script src="js/libs/jquery.min.js"></script>
    <script src="js/libs/tether.min.js"></script>
    <script src="js/libs/bootstrap.min.js"></script>
    <script src="js/app.js"></script>
    <script>
    document.addEventListener('DOMContentLoaded', function () {
        const addTicketForm = document.getElementById('addTicketForm'); // Assurez-vous que l'ID correspond

        addTicketForm.addEventListener('submit', function (e) {
            e.preventDefault(); // Empêche le rechargement de la page

            // Récupération des données du formulaire
            const formData = new FormData(addTicketForm);

            // Envoi de la requête AJAX avec Fetch API
            fetch('../AJAX/add_ticket.php', {
                method: 'POST',
                body: formData
            })
            .then(response => response.json()) // Analyse de la réponse JSON
            .then(result => {
                if (result.success) {
                    Swal.fire({
                        title: 'نجاح!',
                        text: result.message,
                        icon: 'success',
                        timer: 3000,
                        timerProgressBar: true,
                        toast: true,
                        position: 'top-end',
                        showConfirmButton: false,
                    });

                    // Réinitialiser le formulaire
                    addTicketForm.reset();

                    // Recharger la liste des tickets
                    location.reload();
                } else {
                    Swal.fire({
                        title: 'خطأ!',
                        text: result.message,
                        icon: 'error',
                        timer: 3000,
                        timerProgressBar: true,
                        toast: true,
                        position: 'top-end',
                        showConfirmButton: false,
                    });
                }
            })
            .catch(() => {
                Swal.fire({
                    title: 'خطأ!',
                    text: 'حدث خطأ أثناء معالجة الطلب.',
                    icon: 'error',
                    timer: 3000,
                    timerProgressBar: true,
                    toast: true,
                    position: 'top-end',
                    showConfirmButton: false,
                });
            });
        });
    });
    </script>
</body>
