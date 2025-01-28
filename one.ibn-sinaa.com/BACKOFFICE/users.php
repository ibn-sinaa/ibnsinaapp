<?php include('header.php'); ?>
<?php
// Vérifie si le paramètre success est présent dans l'URL
if (isset($_GET['success']) && $_GET['success'] == 'true') {
    echo "<script>
        Swal.fire({
            title: 'تمت الاضافة بنجاح !',
            text: 'تمت اضافة المستخدم بنجاح.',
            icon: 'success',
            confirmButtonText: 'حسنًا',
            timer: 3000,
            timerProgressBar: true,
            toast: true,
            position: 'top-end',
            showConfirmButton: false,
        });
    </script>";
}
if (isset($_GET['success_edit']) && $_GET['success_edit'] == 'true') {
    echo "<script>
        Swal.fire({
            title: 'تم التحديث بنجاح !',
            text: 'تم تعدبل المستخدم بنجاح.',
            icon: 'success',
            confirmButtonText: 'حسنًا',
            timer: 3000,
            timerProgressBar: true,
            toast: true,
            position: 'top-end',
            showConfirmButton: false,
        });
    </script>";
}
if (isset($_GET['success_delete']) && $_GET['success_delete'] == 'true') {
    echo "<script>
        Swal.fire({
            title: 'تم الحذف بنجاح !',
            text: 'تم حذف المستخدم بنجاح.',
            icon: 'success',
            confirmButtonText: 'حسنًا',
            timer: 3000,
            timerProgressBar: true,
            toast: true,
            position: 'top-end',
            showConfirmButton: false,
        });
    </script>";
}
?>
<style>
    .swal-custom-confirm {
    border: 2px solid #d33; /* Couleur du cadre */
    color: white; /* Couleur du texte */
    background-color: #d33; /* Couleur de fond */
}

</style>
<body class="navbar-fixed sidebar-nav fixed-nav">

    <!-- Main content -->
    <main class="main">

        <!-- Breadcrumb -->
        <ol class="breadcrumb">
            <li class="breadcrumb-item active">المستخدمين</li>
        </ol>

        <div class="container-fluid">
            <div class="animated fadeIn">
                <div class="row">
                    <div class="col-md-12">
                        <div class="card">
                            <div class="card-header">
                                قائمة المستخدمين 
                            </div>
                            <div class="card-block">
                                <?php
                                if ($auth->hasRole(\Delight\Auth\Role::ADMIN)) {
                                ?>
                                    <a href="addUser.php" class="btn btn-primary" style="float: left;"><i class="fa fa-plus"></i> إضافة مستخدم جديد </a>
                                <?php
                                }
                                ?>
                                <br/>

                                <br/>
                                <table class="table table-bordered table-striped table-condensed">
                                    <thead>
                                        <tr>
                                            <th>الاسم</th>
                                            <th>البريد الإلكتروني</th>
                                            <th>الدور</th>
                                            <th>تاريخ آخر تسجيل دخول</th>
                                            <th>الإجراءات</th> <!-- Colonne pour les actions -->
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <?php
                                        try {
                                            // ID de l'utilisateur connecté
                                            // Requête pour récupérer les utilisateurs sans l'utilisateur connecté
                                            $query = "SELECT * FROM users WHERE id != :currentUserId";
                                            $stmt = $db->prepare($query);
                                            $stmt->bindParam(':currentUserId', $userId, PDO::PARAM_INT);
                                            $stmt->execute();

                                            // Vérifier si des résultats sont retournés
                                            if ($stmt->rowCount() > 0) {
                                                // Récupérer les données et les afficher dans le tableau
                                                while ($row = $stmt->fetch(PDO::FETCH_ASSOC)) {
                                                    // Affichage du rôle en fonction du roles_mask
                                                    $role = '';
                                                    if ($row['roles_mask'] == 1) $role = 'ادمن';
                                                    elseif ($row['roles_mask'] == 2) $role = 'موظف';
                                                    elseif ($row['roles_mask'] == 4) $role = 'مستخدم';
                                                    elseif ($row['roles_mask'] == 8) $role = 'مستخدم خارجي';

                                                    echo "<tr>";
                                                    echo "<td>" . htmlspecialchars($row['username']) . "</td>";
                                                    echo "<td>" . htmlspecialchars($row['email']) . "</td>";
                                                    echo "<td>" . htmlspecialchars($role) . "</td>";
                                                    // Convertir last_login en date lisible
                                                    $lastLogin = $row['last_login'] ? date('Y-m-d H:i:s', $row['last_login']) : 'لم يسجل الدخول بعد';
                                                    echo "<td>" . htmlspecialchars($lastLogin) . "</td>";
                                                    echo "<td>";
                                                    
                                                    // Vérification du rôle d'admin pour afficher les boutons
                                                    if ($auth->hasRole(\Delight\Auth\Role::ADMIN)) {
                                                        echo "<a href='editUser.php?id=" . htmlspecialchars($row['id']) . "' class='btn btn-warning btn-sm'>تعديل</a> ";
                                                        echo "<a href='#' class='btn btn-danger btn-sm' onclick='confirmDelete(" . htmlspecialchars($row['id']) . ")'>حذف</a>";
                                                    }
                                                    echo "</td>";
                                                    echo "</tr>";
                                                }
                                            } else {
                                                echo "<tr><td colspan='5'> لا يوجد اي عميل في قاعدة البيانات</td></tr>";
                                            }
                                        } catch (PDOException $e) {
                                            echo "Erreur : " . $e->getMessage();
                                        }
                                        ?>
                                    </tbody>
                                </table>
                            </div>
                        </div>
                    </div>
                    <!--/.col-->
                </div>
                <!--/.row-->
            </div>
        </div>
        <!--/.container-fluid-->
    </main>

    <?php include('footer.php'); ?>

</body>

</html>
<script>
 function confirmDelete(userId) {
    Swal.fire({
        title: 'هل أنت متأكد؟',
        text: 'لن تتمكن من التراجع عن هذا الإجراء!',
        icon: 'warning',
        showCancelButton: true,
        confirmButtonColor: '#d33',
        cancelButtonColor: '#3085d6',
        confirmButtonText: 'نعم، احذف!',
        cancelButtonText: 'إلغاء',
        customClass: {
            confirmButton: 'swal-custom-confirm'
        }
    }).then((result) => {
        if (result.isConfirmed) {
            // Rediriger vers la page de suppression si confirmé
            window.location.href = 'deleteUser.php?id=' + userId;
        }
    });
}


if (window.location.href.includes('success=true')) {
    // Supprime le paramètre success de l'URL
    const newUrl = window.location.href.split('?')[0];
    window.history.replaceState(null, '', newUrl);
}
if (window.location.href.includes('success_edit=true')) {
    // Supprime le paramètre success de l'URL
    const newUrl = window.location.href.split('?')[0];
    window.history.replaceState(null, '', newUrl);
}
if (window.location.href.includes('success_delete=true')) {
    // Supprime le paramètre success de l'URL
    const newUrl = window.location.href.split('?')[0];
    window.history.replaceState(null, '', newUrl);
}
</script>

