<?php include('header.php'); ?>
<style>
    .cancelled-order {
        background-color: #cb1818;
        color: white;
        padding: 2px 4px;
        border-radius: 4px;
    }
    .action-buttons {
        display: flex;
        gap: 5px;
    }
    #searchForm {
        margin-bottom: 20px;
    }
    #searchForm input {
        margin-right: 10px;
    }
</style>

<body class="navbar-fixed sidebar-nav fixed-nav">
    <main class="main">
        <ol class="breadcrumb">
            <li class="breadcrumb-item active">الفروع</li>
        </ol>

    <div class="container-fluid">
        <div class="animated fadeIn">
            <div class="row">
                <div class="col-md-12">
                        <div class="card">
                            <div class="card-header">قائمة الفروع</div>
                            <br/>
                            <div class="card-block">

                            <?php
                                if ($auth->hasRole(\Delight\Auth\Role::ADMIN)) {
                                ?>
                                    <a href="addBranch.php" class="btn btn-primary" style="float: left;"><i class="fa fa-plus"></i> إضافة فرع جديد </a>
                                <?php
                                }
                                ?>
                            </div>
                            <table class="table table-bordered table-striped  table-condensed">
                                <thead>
                                    <tr>
                                        <th>اسم الفرع</th>
                                        <th>عنوان الفرع</th>
                                        <th>اجراءات</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <?php
                                    try {
                                        $query = "SELECT * FROM branches";
                                        $stmt = $db->prepare($query);
                                        $stmt->execute();

                                        if ($stmt->rowCount() > 0) {
                                            while ($row = $stmt->fetch(PDO::FETCH_ASSOC)) {
                                                echo "<tr data-branch-id='" . htmlspecialchars($row['branch_id']) . "'>";
                                                echo "<td contenteditable='true' class='editable branch-name'>" . $row['branch_name'] . "</td>";
                                                echo "<td contenteditable='true' class='editable location'>" . $row['location'] . "</td>";
                                                echo "<td class='action-buttons'>
                                                      <button class='btn btn-warning btn-save'>تعديل</button>
                                                      <button class='btn btn-danger btn-delete'>حذف</button>
                                                      </td>";
                                                echo "</tr>";
                                            }
                                        } else {
                                            echo "<tr><td colspan='11'>لا توجد أي فروع في قاعدة البيانات</td></tr>";
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
            </div>
        </div>
    </main>

    <footer class="footer"></footer>

    <script src="js/libs/jquery.min.js"></script>
    <script src="js/libs/tether.min.js"></script>
    <script src="js/libs/bootstrap.min.js"></script>
    <script src="js/app.js"></script>
    <script src="js/views/main.js"></script>

    <script>
        $(document).ready(function() {
            // Enregistrement des modifications
            $('.btn-save').on('click', function() {
                let row = $(this).closest('tr');
                let branchId = row.data('branch-id');
                let branchName = row.find('.branch-name').text();
                let location = row.find('.location').text();

                $.ajax({
                    url: '../AJAX/update_branch.php',
                    type: 'POST',
                    dataType: 'json',
                    data: {
                        branch_id: branchId,
                        branch_name: branchName,
                        location: location
                    },
                    success: function(response) {
                        if (response.status === 'success') {
                            Swal.fire({
                                icon: 'success', // Icône (success, error, warning, info, question)
                                title: 'تم التعديل بنجاح',
                                text: 'تم تعديل الفرع بنجاح',
                                icon: 'success',
                                confirmButtonText: 'حسنًا',
                                timer: 3000,
                                timerProgressBar: true,
                                toast: true,
                                position: 'top-end',
                                showConfirmButton: false,
                            });
                            location.reload();
                        } else {
                            alert("حدث خطأ");
                        }
                    },
                    error: function() {
                            alert("حدث خطأ");
                    }
                });
            });

            // Suppression d'une branche
            $('.btn-delete').on('click', function() {
                if (confirm("هل أنت متأكد من حذف هذا الفرع ?")) {
                    let branchId = $(this).closest('tr').data('branch-id');

                    $.ajax({
                        url: '../AJAX/delete_branch.php',
                        type: 'POST',
                        dataType: 'json',
                        data: { branch_id: branchId },
                        success: function(response) {
                            if (response.status === 'success') {
                                Swal.fire({
                                    icon: 'success', // Icône pour indiquer le succès
                                    title: 'تم الحذف بنجاح',
                                    text: 'تم حذف الفرع بنجاح',
                                    icon: 'success',
                                    confirmButtonText: 'حسنًا',
                                    timer: 3000,
                                    timerProgressBar: true,
                                    toast: true,
                                    position: 'top-end',
                                    showConfirmButton: false,
                                });
                                location.reload();
                            } else {
                                alert(response.message);
                            }
                        },
                        error: function() {
                            alert("Erreur lors de la suppression.");
                        }
                    });
                }
            });
        });
    </script>
</body>
</html>
