<?php 
include('header.php');
?>

<body class="navbar-fixed sidebar-nav fixed-nav">
    <!-- Main content -->
    <main class="main">
        <ol class="breadcrumb">
            <li class="breadcrumb-item active">إنشاء تذكرة جديدة</li>
        </ol>

        <div class="container-fluid">
            <div class="animated fadeIn">
                <div class="row">
                <div class="card mt-4">
                            <div class="card-header">
                                إضافة تذكرة جديدة
                            </div>
                            <div class="card-block">
                                <form id="new-ticket-form">
                                    <div class="form-group">
                                        <label for="title">العنوان</label>
                                        <input type="text" id="title" name="title" class="form-control" placeholder="أدخل عنوان التذكرة" required>
                                    </div>
                                    <div class="form-group">
                                        <label for="description">الوصف</label>
                                        <textarea id="description" name="description" class="form-control" placeholder="أدخل وصفًا للتذكرة" required></textarea>
                                    </div>
                                    <button type="submit" class="btn btn-primary">اضافة</button>
                                </form>
                            </div>
                        </div>
                    <div class="col-md-12">
                        <div class="card">
                            <div class="card-header">
                                التذاكر المفتوحة
                            </div>
                            <div class="card-block">
                                <table class="table table-bordered table-striped">
                                    <thead>
                                        <tr>
                                            <th>رقم التذكرة</th>
                                            <th>العنوان</th>
                                            <th>تاريخ الإنشاء</th>
                                            <th>الحالة</th>
                                            <th>الأنشطة</th> <!-- Colonne ajoutée pour les liens -->
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <?php
                                        try {
                                            $query = " SELECT id, title, created_at, status 
                                            FROM tickets 
                                            WHERE user_id = :user_id
                                            ORDER BY 
                                                CASE 
                                                    WHEN status = 'open' THEN 1
                                                     WHEN status = 'closed' THEN 3
                                                END ASC, 
                                                id ASC";
                                            $stmt = $db->prepare($query);
                                            $stmt->bindParam(':user_id', $userId, PDO::PARAM_INT);
                                            $stmt->execute();

                                            if ($stmt->rowCount() > 0) {
                                                while ($row = $stmt->fetch(PDO::FETCH_ASSOC)) {
                                                    // Traduire le statut en arabe
                                                    $status = $row['status'];
                                                    if ($status == 'open') {
                                                        $status = 'مفتوحة';
                                                    } elseif ($status == 'closed') {
                                                        $status = 'مغلقة';
                                                    } elseif ($status == 'in_progress') {
                                                        $status = 'قيد التنفيذ';
                                                    }

                                                    echo "<tr>";
                                                    echo "<td>" . htmlspecialchars($row['id']) . "</td>";
                                                    echo "<td>" . htmlspecialchars($row['title']) . "</td>";
                                                    echo "<td>" . htmlspecialchars($row['created_at']) . "</td>";
                                                    echo "<td>" . $status . "</td>"; // Affichage du statut traduit
                                                    // Ajout d'un lien vers la page de discussion du ticket
                                                    echo "<td><a href='ticket_messages.php?ticket_id=" . htmlspecialchars($row['id']) . "' class='btn btn-info'>عرض المناقشة</a></td>";
                                                    echo "</tr>";
                                                }
                                            } else {
                                                echo "<tr><td colspan='5'>لا توجد تذاكر مفتوحة.</td></tr>";
                                            }
                                        } catch (PDOException $e) {
                                            echo "Erreur : " . $e->getMessage();
                                        }
                                        ?>
                                    </tbody>
                                </table>
                            </div>
                        </div>

                        <!-- Formulaire pour ajouter un nouveau ticket -->
                       

                    </div>
                </div>
            </div>
        </div>
    </main>

    <footer class="footer"></footer>

    <!-- JavaScript -->
    <script src="js/libs/jquery.min.js"></script>
    <script src="js/libs/tether.min.js"></script>
    <script src="js/libs/bootstrap.min.js"></script>
    <script src="js/app.js"></script>
    <script>
        $(document).ready(function () {
            $('#new-ticket-form').on('submit', function (e) {
                e.preventDefault(); // Empêche le rechargement de la page

                const formData = {
                    title: $('#title').val(),
                    description: $('#description').val(),
                    user_id: <?php echo json_encode($userId); ?>
                };

                $.ajax({
                    url: '../AJAX/add_ticket.php', // Script qui traite le formulaire
                    type: 'POST',
                    data: formData,
                    success: function (response) {
                        if (response.success) {
                            // Utiliser SweetAlert2 pour l'alerte de succès et la confirmation dans une seule fenêtre
                            Swal.fire({
                                icon: 'success',
                                title: 'تم إنشاء التذكرة بنجاح!',
                                text: 'هل تريد الانتقال إلى صفحة الرسائل الخاصة بهذه التذكرة؟',
                                showDenyButton: true,
                                confirmButtonText: 'نعم',
                                denyButtonText: 'لا',
                            }).then((result) => {
                                // Vérifier si l'utilisateur confirme pour aller à la page des messages
                                if (result.isConfirmed) {
                                    window.location.href = 'ticket_messages.php?ticket_id=' + response.ticket_id;
                                } else {
                                    // Si l'utilisateur ne veut pas se rediriger, actualiser la page
                                    location.reload();
                                }
                            });
                        } else {
                            // Utiliser SweetAlert2 pour l'alerte d'erreur
                            Swal.fire({
                                icon: 'error',
                                title: 'حدث خطأ أثناء إنشاء التذكرة',
                                text: 'حدث خطأ أثناء إنشاء التذكرة. حاول مرة أخرى.',
                                confirmButtonText: 'موافق'
                            });
                        }
                    },
                    error: function () {
                        // Utiliser SweetAlert2 pour l'alerte d'erreur de serveur
                        Swal.fire({
                            icon: 'error',
                            title: 'حدث خطأ في الاتصال بالخادم',
                            text: 'يرجى التحقق من الاتصال بالخادم.',
                            confirmButtonText: 'موافق'
                        });
                    }
                });
            });
        });
    </script>
</body>

</html>
