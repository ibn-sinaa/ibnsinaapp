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

    .status-waiting {
        background-color: #b4fd9f; /* Vert clair */
    }

    .status-in-progress {
        background-color: #fbffa4; /* Jaune clair */
    }

    .status-ready {
        background-color: #82ccff; /* Bleu clair */
    }


    .status-pending {
        background-color:rgb(189, 33, 49);
        color: white;
    }
</style>

<body class="navbar-fixed sidebar-nav fixed-nav">
<main class="main">
    <ol class="breadcrumb">
        <li class="breadcrumb-item active">الطلبات</li>
    </ol>

    <div class="container-fluid">
        <div class="animated fadeIn">
            <div class="row">
                <div class="col-md-12">
                    <div class="card">
                        <div class="card-header">قائمة الطلبات</div>
                        <div class="card-block">
                        <div class="container">
                        <div class="row">
                            <div class="col-md-12">
                                <form id="searchForm" class="form-row align-items-center">
                                    <div class="form-group col-lg-3 col-md-3 mb-2">
                                        <label for="orderNumberSearch">رقم الطلب:</label>
                                        <input type="text" id="orderNumberSearch" class="form-control" placeholder="رقم الطلب" oninput="filterOrders()">
                                    </div>
                                    <div class="form-group col-lg-3 col-md-3 mb-2">
                                        <label for="senderSearch">المرسل:</label>
                                        <input type="text" id="senderSearch" class="form-control" placeholder="المرسل" oninput="filterOrders()">
                                    </div>
                                    <div class="form-group col-lg-3 col-md-3 mb-2">
                                        <label for="orderDateSearch">تاريخ الانشاء:</label>
                                        <input type="date" id="orderDateSearch" class="form-control" onchange="filterOrders()">
                                    </div>
                                    <div class="form-group col-lg-3 col-md-3 mb-2">
                                        <label for="orderstatus"> حالة الطلب:</label>
                                         <select id="orderstatus"  class="form-control"  onchange="filterOrders()">
                                            <option value="">الكل</option>
                                            <option value="في الانتظار">في الانتظار</option>
                                            <option value="قيد التنفيذ">قيد التنفيذ</option>
                                            <option value="جاهز">جاهز</option>
                                            <option value="تم ارسال الطلب">تم ارسال الطلب</option>

                                        </select> 
                                   </div>
                                </form>
                            </div>
                        </div>

                        </div>


                            <br/>
                            <div class="table-responsive">

                            <table class="table table-bordered  table-condensed">
                                <thead>
                                    <tr>
                                        <th>رقم الطلب</th>
                                        <th>الفرع</th>
                                        <th>المرسل</th>
                                        <th>يوم</th> 
                                        <th>تاريخ الانشاء</th>
                                        <th>تاريخ التسليم</th>
                                        <?php if ($role !== \Delight\Auth\Role::EXTERN_USER) { ?>
                                                <th>الخطوة الحالية</th>
                                            <?php } ?>

                                        <th class="desc">التفاصيل</th>
                                        <th>السعر</th>
                                        <th> الكمية</th>
                                        <th>الحالة</th>
                                        <th>الملفات المرفقة</th>
                                         <th style="text-align: center;">اجراءات</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <?php
                                    try {
                                        $query = "";
                                        if (isset($role) && ( $role === \Delight\Auth\Role::USER || $role === \Delight\Auth\Role::EXTERN_USER )) {
                                            $query = "
                                                SELECT 
                                                    o.order_id, 
                                                    o.order_number, 
                                                    o.branch_id, 
                                                    o.sender, 
                                                    o.order_date, 
                                                    o.delivery_date, 
                                                    o.details, 
                                                    o.price, 
                                                    o.execution_time, 
                                                    o.status, 
                                                     o.created_at,
                                                    b.branch_name
                                                FROM orders o
                                                JOIN branches b on o.branch_id=b.branch_id
                                                WHERE o.user_id = :userId
                                                AND o.valid = 1
                                                GROUP BY o.order_id  
                                                ORDER BY o.created_at DESC
                                            ";
                                        } else  if (isset($role) && $role === \Delight\Auth\Role::ADMIN) {
                                            $query = "
                                                SELECT 
                                                    o.order_id, 
                                                    o.order_number, 
                                                    o.branch_id, 
                                                    o.sender, 
                                                    o.order_date, 
                                                    o.delivery_date, 
                                                    o.details, 
                                                    o.price, 
                                                    o.execution_time, 
                                                    o.status, 
                                                     o.created_at,
                                                    b.branch_name
                                                FROM orders o
                                                JOIN branches b on o.branch_id=b.branch_id
                                                WHERE o.valid = 1
                                                GROUP BY o.order_id  
                                                ORDER BY o.created_at DESC
                                            ";
                                        }
                                          else if (isset($role) && $role === \Delight\Auth\Role::EMPLOYEE) {

                                        $query = "
                                              SELECT 
                                                o.order_id, 
                                                o.order_number, 
                                                o.branch_id, 
                                                o.sender, 
                                                o.order_date, 
                                                o.delivery_date, 
                                                o.details, 
                                                o.price, 
                                                o.execution_time, 
                                                o.status, 
                                                o.created_at,
                                                b.branch_name
                                            FROM orders o
                                            JOIN branches b ON o.branch_id = b.branch_id
                                            JOIN (
                                                SELECT 
                                                    order_steps_log.order_id, 
                                                    MAX(steps.step_name) AS step_name,  -- Fonction d'agrégation appliquée ici
                                                    MAX(order_steps_log.start_date) AS last_step_date
                                                FROM order_steps_log
                                                JOIN steps ON order_steps_log.step_id = steps.step_id
                                                GROUP BY order_steps_log.order_id
                                                HAVING MAX(order_steps_log.step_id) != 40  
                                            ) last_step ON last_step.order_id = o.order_id
                                            JOIN order_employees oe ON oe.order_id = o.order_id  
                                            WHERE o.valid = 1
                                            AND o.status = 'قيد التنفيذ'
                                            AND oe.employee_id = $userId   
                                            GROUP BY o.order_id  
                                            ORDER BY o.created_at DESC
                                        ";
                                    }

                                        $stmt = $db->prepare($query);
                                        if (isset($role) && ( $role === \Delight\Auth\Role::USER || $role === \Delight\Auth\Role::EXTERN_USER ) && isset($userId)) {
                                            $stmt->bindParam(':userId', $userId, PDO::PARAM_INT);
                                        }
                                        $stmt->execute();

                                        if ($stmt->rowCount() > 0) {
                                            while ($row = $stmt->fetch(PDO::FETCH_ASSOC)) {
                                                $orderDate = !empty($row['order_date']) ? new DateTime($row['order_date']) : null;
                                                $dayOfWeek = $orderDate ? ['الأحد', 'الاثنين', 'الثلاثاء', 'الأربعاء', 'الخميس', 'الجمعة', 'السبت'][$orderDate->format('w')] : 'غير متوفر';
                                                $stepStmt = $db->prepare("
                                                    SELECT order_steps_log.step_id, order_steps_log.start_date, steps.step_name, 
                                                           order_steps_log.changed_by, order_steps_log.end_date, order_steps.step_num
                                                    FROM order_steps_log 
                                                    JOIN order_steps ON order_steps_log.order_id = order_steps.order_id  
                                                                     AND order_steps_log.step_id = order_steps.step_id 
                                                    JOIN steps ON steps.step_id = order_steps_log.step_id
                                                    WHERE order_steps_log.order_id = :orderId
                                                    ORDER BY order_steps_log.start_date DESC 
                                                    LIMIT 1
                                                ");
                                                $stepStmt->execute(['orderId' => $row['order_id']]);
                                                $lastStep = $stepStmt->fetch(PDO::FETCH_ASSOC);
                                                
                                                         if (isset($lastStep['step_name'])) {
                                                            $lastStep= htmlspecialchars($lastStep['step_name']); 
                                                        } else {
                                                            $lastStep= ""; // or any appropriate default message
                                                        }

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
                                                                $filePath = "../uploads/" . htmlspecialchars($file['attachment_file']);
                                                                // Afficher le lien de téléchargement du fichier
                                                                if (file_exists($filePath)) {
                                                                    $fileLinks .= "<a href='$filePath' download>" . htmlspecialchars(basename($file['attachment_file'])) . "</a><br>";
                                                                } else {
                                                                    $fileLinks .= "<a href='$filePath' download>" . htmlspecialchars(basename($file['attachment_file'])) . "</span><br>";
                                                                }
                                                            }
                                                        }
                                                          // Appliquer une classe CSS selon le statut
                                                $statusClass = '';
                                                switch ($row['status']) {
                                                    case 'في الانتظار':
                                                        $statusClass = 'status-waiting'; // Classe pour "في الانتظار"
                                                        break;
                                                    case 'قيد التنفيذ':
                                                        $statusClass = 'status-in-progress'; // Classe pour "قيد التنفيذ"
                                                        break;
                                                    case 'جاهز':
                                                        $statusClass = 'status-ready'; // Classe pour "جاهز"
                                                        break;
                                                    case 'في انتظار التعميد':
                                                        $statusClass = 'status-pending'; // Classe pour "جاهز"
                                                        break;
                                                }

                                                echo "<tr class='$statusClass'>";
                                                echo "<td>" . htmlspecialchars($row['order_number'] ?? '') . "</td>";
                                                echo "<td>" . htmlspecialchars($row['branch_name'] ?? '') . "</td>";
                                                echo "<td>" . htmlspecialchars($row['sender'] ?? '') . "</td>";
                                                echo "<td>" . htmlspecialchars($dayOfWeek) . "</td>";
                                                echo "<td>" . htmlspecialchars($row['created_at'] ?? '') . "</td>";
                                                echo "<td>" . htmlspecialchars($row['delivery_date'] ?? '') . "</td>";
                                                 if ($role !== \Delight\Auth\Role::EXTERN_USER) { 
                                                echo "<td>" .$lastStep . "</td>";}  
                                                echo "<td>" . htmlspecialchars($row['details'] ?? '') . "</td>";
                                                echo "<td>" . htmlspecialchars($row['price'] ?? '') . "</td>";
                                                echo "<td>" . htmlspecialchars($row['execution_time'] ?? '') . "</td>";

                                                $statusClass = ($row['status'] == 'ملغي') ? 'cancelled-order' : '';
                                                echo "<td class='$statusClass'>" . htmlspecialchars($row['status'] ?? '') . "</td>";

                                             
                                                echo "<td class=\"truncate\">$fileLinks</td>";
                                                if (isset($role) && $role === \Delight\Auth\Role::USER) {
                                                    echo "<td class='action-buttons'>
                                                     <button onclick='generatePDF(" . htmlspecialchars($row['order_id'] ?? '') . ")' class='btn btn-info'>تصدير PDF</button>
                                                  </td>";
                                                }   
                                                else{
                                                    echo "<td class='action-buttons'>
                                                    <a href='edit_order.php?id=" . htmlspecialchars($row['order_id'] ?? '') . "' class='btn btn-warning'>تعديل</a>
                                                    <button onclick='generatePDF(" . htmlspecialchars($row['order_id'] ?? '') . ")' class='btn btn-info'>تصدير PDF</button>
                                                  </td>";
                                                }
                                                echo "</tr>";
                                            }
                                        } else {
                                            echo "<tr><td colspan='13'>لا توجد أي طلبات في قاعدة البيانات</td></tr>";
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
    </main>
    <?php include('footer.php'); ?>
<script>
    document.addEventListener('DOMContentLoaded', function() {
        const urlParams = new URLSearchParams(window.location.search);
        if (urlParams.has('success') && urlParams.get('success') === 'true') {
            Swal.fire({
            title: 'تمت الاضافة بنجاح !',
            text: 'تمت اضافة الطلب بنجاح.',
            icon: 'success',
            confirmButtonText: 'حسنًا',
            timer: 3000,
            timerProgressBar: true,
            toast: true,
            position: 'top-end',
            showConfirmButton: false,
        });            // Retirer le paramètre 'success' de l'URL
            urlParams.delete('success');
            const newUrl = window.location.pathname + '?' + urlParams.toString();
            window.history.replaceState(null, '', newUrl);
        }
    });
</script>

<script>
    document.addEventListener('DOMContentLoaded', function() {
        const urlParams = new URLSearchParams(window.location.search);
        // Vérifie si l'édition a réussi et si le paramètre existe dans l'URL
        if (urlParams.has('edit_success') && urlParams.get('edit_success') === 'true') {
            Swal.fire({
            title: 'تم التحديث بنجاح !',
            text: 'تم تعدبل الطلب بنجاح.',
            icon: 'success',
            confirmButtonText: 'حسنًا',
            timer: 3000,
            timerProgressBar: true,
            toast: true,
            position: 'top-end',
            showConfirmButton: false,
        });              // Supprimer le paramètre 'edit_success' de l'URL après affichage
            urlParams.delete('edit_success');
            const newUrl = window.location.pathname + '?' + urlParams.toString();
            window.history.replaceState(null, '', newUrl); // Mise à jour de l'URL sans le paramètre
        }
    });
</script>

    <script>
        function generatePDF(order_id) {
            window.location.href = `../AJAX/generate_order_pdf.php?order_id=${order_id}`;
        }

        function filterOrders() {
            // Récupérer les valeurs des champs de recherche
            var orderNumber = document.getElementById('orderNumberSearch').value.toLowerCase();
            var sender = document.getElementById('senderSearch').value.toLowerCase();
            var orderDate = document.getElementById('orderDateSearch').value;
            var orderstatus = document.getElementById('orderstatus').value;

            // Filtrer les lignes de la table
            var rows = document.querySelectorAll('tbody tr');
            rows.forEach(row => {
                var cells = row.getElementsByTagName('td');
                var match = true;

                if (orderNumber && !cells[0].textContent.toLowerCase().includes(orderNumber)) {
                    match = false;
                }
                if (sender && !cells[2].textContent.toLowerCase().includes(sender)) {
                    match = false;
                }
              // Vérification du statut
                if (orderstatus && cells[10].textContent.trim() !== orderstatus) {
                    match = false;
                }

                if (orderDate && new Date(cells[4].textContent).toDateString() !== new Date(orderDate).toDateString()) {
                    match = false;
                }

                row.style.display = match ? '' : 'none';
            });
        }

        function resetSearch() {
            document.getElementById('orderNumberSearch').value = '';
            document.getElementById('senderSearch').value = '';
            document.getElementById('orderDateSearch').value = '';
            document.getElementById('orderstatus').value = '';
            filterOrders(); // Reset the table to show all rows
        }
    </script>
</body>
</html>
