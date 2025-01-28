<?php include('header.php'); ?> 
<body class="navbar-fixed sidebar-nav fixed-nav">
    <main class="main">
        <ol class="breadcrumb">
            <li class="breadcrumb-item active">التقارير</li>
        </ol>
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
        <div class="container-fluid">
            <div class="animated fadeIn">
                <div class="row">
                    <div class="col-md-12">
                        <div class="card">
                            <div class="card-header">
                                <strong>تقرير حسب الموظف</strong>
                            </div>
                            <div class="card-block">
                                <div class="form-row">
                                    <div class="form-group row">
                                        <div class="col-md-3">
                                            <label>اختر الموظف :</label>
                                            <select id="employeeSelect" class="form-control">
                                                <option value="" disabled selected>اختر الموظف</option>
                                                <?php
                                                // Récupérer la liste des employés
                                                $stmt = $db->prepare("SELECT id, username FROM users WHERE roles_mask=2;");
                                                $stmt->execute();
                                                while ($employee = $stmt->fetch(PDO::FETCH_ASSOC)) {
                                                    echo "<option value='{$employee['id']}'>" . htmlspecialchars($employee['username']) . "</option>";
                                                }
                                                ?>
                                            </select>
                                        </div>
                                        <div class="col-md-3">
                                            <label for="startDate">تاريخ البدء :</label>
                                            <input type="date" class="form-control" id="startDate" name="startDate">
                                        </div>
                                        <div class="col-md-3">
                                            <label for="endDate">تاريخ الانتهاء :</label>
                                            <input type="date" class="form-control" id="endDate" name="endDate">
                                        </div>
                                    </div>
                                    <div class="form-row">
    <div class="form-group row">
        <div class="col-md-3">
            <button id="fetchReport" class="form-control mb-2 btn btn-primary">تحديث التقرير</button>
        </div>
        <div class="col-md-3">
            <button class="form-control mb-2 btn btn-danger" onclick="exportUserPDF()">تصدير PDF</button>
        </div>
        <div class="col-md-3">
            <button class="form-control mb-2 btn btn-success" onclick="exportUserExcel()">تصدير Excel</button>
        </div>
    </div>
</div>
                                </div>
                                <table class="table table-striped table-bordered" id="employeeReportTable">
                                    <thead>
                                        <tr>
                                            <th>رقم الطلب</th>
                                            <th>المرسل</th>
                                            <th>التفاصيل</th>
                                            <th>السعر</th>
                                            <th>وقت التنفيذ</th>
                                            <th>تاريخ الإنشاء</th>
                                        </tr>
                                    </thead>
                                    <tbody></tbody>
                                </table>
                                <canvas id="orderChart" width="400" height="200"></canvas>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </main>

    <footer class="footer"></footer>

    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/xlsx/0.17.1/xlsx.full.min.js"></script>
    <script src="js/libs/tether.min.js"></script>
    <script src="js/libs/bootstrap.min.js"></script>
    <script src="js/libs/pace.min.js"></script>
    <script src="js/app.js"></script>

    <script>
        function fetchEmployeeReport() {
            const employeeId = document.getElementById('employeeSelect').value;
            const startDate = document.getElementById('startDate').value;
            const endDate = document.getElementById('endDate').value;

            fetch(`../AJAX/get_employee_report.php?employeeId=${employeeId}&startDate=${startDate}&endDate=${endDate}`)
                .then(response => response.json())
                .then(data => {
                    const tbody = document.querySelector('#employeeReportTable tbody');
                    tbody.innerHTML = '';
                    if (data.orders && data.orders.length > 0) {
                        data.orders.forEach(order => {
                            const tr = document.createElement('tr');
                            tr.innerHTML = `
                                <td>${order.order_number}</td>
                                <td>${order.sender}</td>
                                <td>${order.details}</td>
                                <td>${parseFloat(order.price).toFixed(2)}</td>
                                <td>${order.execution_time}</td>
                                <td>${order.created_at}</td>
                            `;
                            tbody.appendChild(tr);
                        });
                    } else {
                        tbody.innerHTML = '<tr><td colspan="6">لا توجد بيانات متاحة.</td></tr>';
                    }
                })
                .catch(error => console.error('Erreur lors du chargement du rapport:', error));
        }

        document.getElementById('fetchReport').addEventListener('click', fetchEmployeeReport);
    </script>
<script>
    function fetchEmployeeReport() {
        const employeeId = document.getElementById('employeeSelect').value;
        const startDate = document.getElementById('startDate').value;
        const endDate = document.getElementById('endDate').value;

        fetch(`../AJAX/get_employee_orders.php?employeeId=${employeeId}&startDate=${startDate}&endDate=${endDate}`)
            .then(response => response.json())
            .then(data => {
                const tbody = document.querySelector('#employeeReportTable tbody');
                tbody.innerHTML = '';
                if (data.orders && data.orders.length > 0) {
                    data.orders.forEach(order => {
                        const tr = document.createElement('tr');
                        tr.innerHTML = `
                            <td>${order.order_number}</td>
                            <td>${order.sender}</td>
                            <td>${order.details}</td>
                            <td>${parseFloat(order.price).toFixed(2)}</td>
                            <td>${order.execution_time}</td>
                            <td>${order.created_at}</td>
                        `;
                        tbody.appendChild(tr);
                    });
                } else {
                    tbody.innerHTML = '<tr><td colspan="6">لا توجد بيانات متاحة.</td></tr>';
                }
            })
            .catch(error => console.error('Erreur lors du chargement du rapport:', error));
    }

    document.getElementById('fetchReport').addEventListener('click', fetchEmployeeReport);

    function exportUserExcel() {
        const table = document.getElementById('employeeReportTable');
        const wb = XLSX.utils.table_to_book(table, { sheet: "Rapport des employés" });
        XLSX.writeFile(wb, 'employee_report.xlsx');
    }
</script>
    <style>
        .form-control { border-radius: 0.25rem; border: 1px solid #ced4da; }
        #employeeReportTable { margin-top: 20px; }
        #orderChart { margin-top: 20px; max-width: 100%; }
    </style>
</body>