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
        justify-content: space-between;
        gap: 10px;
    }
    #searchForm {
        margin-bottom: 20px;
    }
    #searchForm input {
        margin-right: 10px;
    }

    .cancelled-order {
        background-color: #cb1818;
        color: white;
        padding: 2px 4px;
        border-radius: 4px;
    }
    .action-buttons {
        display: flex;
        justify-content: space-between;
        gap: 10px;
    }
    #searchForm {
        margin-bottom: 20px;
    }
    #searchForm input {
        margin-right: 10px;
    }
    .desc{
        min-width: 250px;
    }
    /* Custom responsive adjustments */
  

    .truncate {
         white-space: nowrap;
        overflow: hidden;
        text-overflow: ellipsis;
        max-width: 200px; /* Limite de largeur ajustable pour la colonne */
    }

    /* Optionnel: pour assurer que le texte est bien dans une cellule de tableau */
    table th, table td {
        word-wrap: break-word;
        max-width: 250px; /* Ajuster si nécessaire pour la largeur de la cellule */
    }

    .table {
    table-layout: auto; /* Permet aux colonnes de s'adapter au contenu */
    width: 100%; /* Pour occuper tout l'espace disponible */
    word-wrap: break-word; /* Évite le débordement des longues chaînes */
}

</style>

<body class="navbar-fixed sidebar-nav fixed-nav">
<main class="main">
    <ol class="breadcrumb">
        <li class="breadcrumb-item active">الطلبات المنتظرة</li>
    </ol>
    <div class="container-fluid">
        <div class="animated fadeIn">
            <div class="row">
                <div class="col-md-12">
                    <div class="card">
                        <div class="card-header">قائمة الطلبات المنتظرة</div>
                        <div class="card-block">
                            <div class="container">
                                <form id="searchForm" class="form-inline">
                                    <div class="form-group mb-2 mr-sm-2">
                                        <label for="orderNumberSearch">رقم الطلب:</label>
                                        <input type="text" id="orderNumberSearch" class="form-control" placeholder="رقم الطلب">
                                    </div>
                                    <div class="form-group mb-2 mr-sm-2">
                                        <label for="senderSearch">المرسل:</label>
                                        <input type="text" id="senderSearch" class="form-control" placeholder="المرسل">
                                    </div>
                                    <div class="form-group mb-2 mr-sm-2">
                                        <label for="orderDateSearch">تاريخ الطلب:</label>
                                        <input type="date" id="orderDateSearch" class="form-control">
                                    </div>
                                    <div class="form-group mb-2 mr-sm-2">
                                        <label for="deliveryDateSearch">تاريخ التسليم:</label>
                                        <input type="date" id="deliveryDateSearch" class="form-control">
                                    </div>
                                    <button type="button" class="btn btn-primary mb-2 mr-sm-2" onclick="filterOrders()">بحث</button>
                                    <button type="button" class="btn btn-secondary mb-2" onclick="resetSearch()">تحديث</button>
                                </form>
                            </div>
                            <div class="table-responsive">

                            <table class="table table-bordered table-striped table-condensed">
                                <thead>
                                    <tr>
                                        <th>رقم الطلب</th>
                                        <th>الفرع</th>
                                        <th>المرسل</th>
                                        <th>يوم</th> 
                                        <th>تاريخ الانشاء</th>
                                        <th>تاريخ التسليم</th>
                                        <th class="desc">التفاصيل</th>
                                        <th>السعر</th>
                                        <th> الكمية</th>
                                        <th>الحالة</th>
                                        <th>ملفات المرفقة</th>
                                        <?php 
                                         if (isset($role) && $role === \Delight\Auth\Role::ADMIN) {

                                        ?>
                                         <th>اجراءات</th>

                                        <?php
                                            
                                            }   else if (isset($role) && $role === \Delight\Auth\Role::USER || $role === \Delight\Auth\Role::EXTERN_USER) {
                                        ?>
                                        <th>ملاحظات</th>

                                        <?php } ?>

                                    </tr>
                                </thead>
                                <tbody>
                                    <?php
                                    try {
                                        if (isset($role) && $role === \Delight\Auth\Role::ADMIN) {

                                        $query = "SELECT order_id, order_number, branch_name, sender, order_date, delivery_date, details, price, execution_time, status, created_at FROM orders JOIN branches b on orders.branch_id=b.branch_id WHERE valid=-1 order by created_at DESC";
                                        
                                        }
                                        else if (isset($role) && $role === \Delight\Auth\Role::USER || $role === \Delight\Auth\Role::EXTERN_USER) {
                                        $query = "SELECT order_id, order_number, branch_name, sender, order_date, delivery_date, details, price, execution_time, status, notes,created_at FROM orders JOIN branches b on orders.branch_id=b.branch_id WHERE valid=-1 AND user_id=$userId order by created_at DESC";

                                        }
                                        $stmt = $db->prepare($query);
                                        $stmt->execute();

                                        if ($stmt->rowCount() > 0) {
                                            while ($row = $stmt->fetch(PDO::FETCH_ASSOC)) {
                                                $orderDate = new DateTime($row['order_date']);
                                                $arabicDays = ['الأحد', 'الاثنين', 'الثلاثاء', 'الأربعاء', 'الخميس', 'الجمعة', 'السبت'];
                                                $dayOfWeek = $arabicDays[$orderDate->format('w')];
                                                $fileLinks = 'لا توجد ملفات مرفقة';
                                                $fileQuery = "
                                                    SELECT attachment_file 
                                                    FROM ordre_files 
                                                    WHERE order_id = :orderId
                                                ";
                                                $fileStmt = $db->prepare($fileQuery);
                                                $fileStmt->execute(['orderId' => $row['order_id']]);
                                        
                                                // Vérifiez si des fichiers existent
                                                if ($fileStmt->rowCount() > 0) {
                                                    $fileLinks = '';
                                                    while ($file = $fileStmt->fetch(PDO::FETCH_ASSOC)) {
                                                        $filePath = "../uploads/" . ($file['attachment_file']);
                                                        // Afficher le lien de téléchargement du fichier
                                                        if (file_exists($filePath)) {
                                                            $fileLinks .= "<a href='$filePath' download>" . (basename($file['attachment_file'])) . "</a><br>";
                                                        } else {
                                                            $fileLinks .= "<span style='color: red;'>الملف غير موجود: " . htmlspecialchars(basename($file['attachment_file'])) . "</span><br>";
                                                        }
                                                    }
                                                }
                                                echo "<tr>";
                                                echo "<td>" . ($row['order_number']) . "</td>";
                                                echo "<td>" . ($row['branch_name']) . "</td>";
                                                echo "<td>" . ($row['sender']) . "</td>";
                                                echo "<td>" . ($dayOfWeek) . "</td>";
                                                echo "<td>" . ($row['created_at']) . "</td>";
                                                echo "<td>" . ($row['delivery_date']) . "</td>";
                                                echo "<td>" . ($row['details']) . "</td>";
                                                echo "<td>" . ($row['price']) . "</td>";
                                                echo "<td>" . ($row['execution_time']) . "</td>";

                                                $statusClass = ($row['status'] == 'ملغي') ? 'cancelled-order' : '';
                                                echo "<td class='$statusClass'>" . ($row['status']) . "</td>";

                                                echo "<td>" . $fileLinks . "</td>";
                                                if (isset($role) && $role === \Delight\Auth\Role::ADMIN) {
                                                echo "<td class='action-buttons'>
                                                <a href='edit_order.php?id=" . ($row['order_id']) . "' class='btn btn-warning'>تعديل</a>
                                                ";
                                                                                  
                                                    echo"
                                                <button onclick='updateOrderStatus(" . ($row['order_id']) . ",1)' class='btn btn-info'>قبول</button>
                                                </td>";
                                                }
                                                else if (isset($role) && $role === \Delight\Auth\Role::USER || $role === \Delight\Auth\Role::EXTERN_USER) {
                                                    echo "<td>" . ($row['notes']) . "</td>";

                                                }
                                              
                                        
                                                echo "</tr>";
                                            }
                                        } else {
                                            echo "<tr><td colspan='13'>لا توجد أي طلبات  مرفوضة في قاعدة البيانات </td></tr>";
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
        </div>
    </div>
</main>

<?php include('footer.php'); ?>

<script>
 function updateOrderStatus(orderId, status) {
      // Ajoutez un console.log pour vérifier la valeur de statut avant l'appel AJAX
      console.log("Statut envoyé :", status); // Ceci permettra de voir si la valeur de statut est correcte
    
    $.ajax({
        url: '../AJAX/accept_order.php',
        type: 'POST',
        data: {
            order_id: orderId,
            status: status
        },
        success: function(response) {
             if (response.success) {
                 location.reload(); // Recharge la page pour voir les changements
            } else {
                                 location.reload(); // Recharge la page pour voir les changements

             }
        },
        error: function() {
            alert("Une erreur est survenue lors de l'envoi de la requête.");
        }
    });
}
 
    function filterOrders() {
        var orderNumber = document.getElementById('orderNumberSearch').value.toLowerCase();
        var sender = document.getElementById('senderSearch').value.toLowerCase();
        var orderDate = document.getElementById('orderDateSearch').value;
        var deliveryDate = document.getElementById('deliveryDateSearch').value;
        var table = document.querySelector('table tbody');
        var rows = table.getElementsByTagName('tr');

        for (var i = 0; i < rows.length; i++) {
            var orderNumberCell = rows[i].getElementsByTagName('td')[0].textContent.toLowerCase();
            var senderCell = rows[i].getElementsByTagName('td')[2].textContent.toLowerCase();
            var orderDateCell = rows[i].getElementsByTagName('td')[4].textContent;
            var deliveryDateCell = rows[i].getElementsByTagName('td')[5].textContent;

            var showRow = true;
            
            if (orderNumber && !orderNumberCell.includes(orderNumber)) {
                showRow = false;
            }
            if (sender && !senderCell.includes(sender)) {
                showRow = false;
            }
            if (orderDate && orderDateCell !== orderDate) {
                showRow = false;
            }
            if (deliveryDate && deliveryDateCell !== deliveryDate) {
                showRow = false;
            }
            rows[i].style.display = showRow ? '' : 'none';
        }
    }

    function resetSearch() {
        document.getElementById('orderNumberSearch').value = '';
        document.getElementById('senderSearch').value = '';
        document.getElementById('orderDateSearch').value = '';
        document.getElementById('deliveryDateSearch').value = '';
        filterOrders();
    }
</script>
</body>
</html>
