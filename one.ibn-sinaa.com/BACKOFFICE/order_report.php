<?php include('header.php'); ?> 
<body class="navbar-fixed sidebar-nav fixed-nav">
    <main class="main">
        <ol class="breadcrumb">
            <li class="breadcrumb-item active">التقارير</li>
        </ol>

        <div class="container-fluid">
            <div class="animated fadeIn">
                <div class="row">
                    <div class="col-md-12">
                        <div class="card">
                            <div class="card-header">
                                <strong>تقرير الطلب</strong>
                            </div>
                            <div class="card-block">
                            <div class="form-group d-flex align-items-center">
                            <div class="form-group row align-items-center">
                                <label for="order_number" class="col-form-label col-sm-1">رقم الطلب:</label>
                                <div class="col-sm-4">
                                    <input type="text" id="order_number" class="form-control" placeholder="أدخل رقم الطلب">
                                </div>
                                <div class="col-sm-4">
                                    <button id="fetchOrder" class="btn btn-primary">استرجاع التقرير</button>
                                </div>
                            </div>

                            <h5> معلومات الطلب</h5>

                                <table class="table table-striped table-bordered" id="order-report-table">
                                    <thead>
                                        <tr>
                                            <th>رقم الطلب</th>
                                            <th>تاريخ الطلب</th>
                                            <th>المرسل</th>
                                            <th>تفاصيل</th>
                                            <th>إجمالي السعر</th>
                                           
                                         </tr>
                                    </thead>
                                    <tbody></tbody>
                                </table>

                                <!-- Tableau des statuts de la commande -->
                                <h5> الحالة</h5>
                                <table class="table table-striped table-bordered" id="order-status-table">
                                    <thead>
                                        <tr>
                                            <th>الحالة</th>
                                            <th>تاريخ الحالة</th>
                                            <th>تم التعديل من طرف</th>
                                        </tr>
                                    </thead>
                                    <tbody></tbody>
                                </table>

                                <!-- Tableau des étapes de la commande -->
                                <h5> الخطوات</h5>
                                <table class="table table-striped table-bordered" id="order-steps-table">
                                    <thead>
                                        <tr>
                                            <th>الخطوة</th>
                                            <th>تاريخ الخطوة</th>
                                            <th>تم التعديل من طرف</th>
                                        </tr>
                                    </thead>
                                    <tbody></tbody>
                                </table>

                                <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
                                <script>
                                    function fetchOrderData() {
                                        const orderNumber = document.getElementById('order_number').value;

                                        $.ajax({
                                            url: '../AJAX/get_order_report.php',
                                            method: 'POST', // Changed to POST to match the server-side implementation
                                            data: { order_number: orderNumber },
                                            success: function(response) {
                                                const data = JSON.parse(response);
                                                if (data.success) {
                                                    updateTable(data.order);
                                                    updateStatusTable(data.status_logs); // Update the status table
                                                    updateStepsTable(data.steps_logs); // Update the steps table
                                                } else {
                                                    alert(data.message); // Alert on failure
                                                }
                                            },
                                            error: function() {
                                                alert("Erreur lors de la récupération des données.");
                                            }
                                        });
                                    }

                                    function updateTable(order) {
                                        const tbody = document.querySelector('#order-report-table tbody');
                                        tbody.innerHTML = '';

                                        if (!order) {
                                            tbody.innerHTML = '<tr><td colspan="11">لا توجد بيانات متاحة لهذا الطلب.</td></tr>';
                                        } else {
                                            const tr = document.createElement('tr');
                                            tr.innerHTML = `
                                                <td>${order.order_number}</td>
                                                <td>${order.order_date}</td>
                                                <td>${order.sender}</td>
                                                <td>${order.details}</td>
                                                <td>${order.price}</td>
                                             
                                             `;
                                            tbody.appendChild(tr);
                                        }
                                    }

                                    function updateStatusTable(statusLogs) {
                                        const tbody = document.querySelector('#order-status-table tbody');
                                        tbody.innerHTML = '';

                                        if (statusLogs.length === 0) {
                                            tbody.innerHTML = '<tr><td colspan="3">لا توجد تغييرات حالة متاحة.</td></tr>';
                                        } else {
                                            statusLogs.forEach(change => {
                                                const tr = document.createElement('tr');
                                                tr.innerHTML = `
                                                    <td>${change.status}</td>
                                                    <td>${change.changed_at}</td>
                                                    <td>${change.username}</td>
                                                `;
                                                tbody.appendChild(tr);
                                            });
                                        }
                                    }

                                    function updateStepsTable(stepsLogs) {
                                        const tbody = document.querySelector('#order-steps-table tbody');
                                        tbody.innerHTML = '';

                                        if (stepsLogs.length === 0) {
                                            tbody.innerHTML = '<tr><td colspan="3">لا توجد تغييرات للخطوات متاحة.</td></tr>';
                                        } else {
                                            stepsLogs.forEach(change => {
                                                const tr = document.createElement('tr');
                                                tr.innerHTML = `
                                                     <td>${change.step_name}</td>
                                                    <td>${change.start_date}</td>
                                                    <td>${change.username}</td>
                                                `;
                                                tbody.appendChild(tr);
                                            });
                                        }
                                    }

                                    function exportOrderPDF(orderId) {
                                        window.location.href = `../AJAX/export_order_to_pdf.php?order_id=${orderId}`;
                                    }

                                    document.getElementById('fetchOrder').addEventListener('click', fetchOrderData);
                                </script>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </main>

    <footer class="footer">
       <!-- Footer content here -->
    </footer>

    <script src="js/libs/tether.min.js"></script>
    <script src="js/libs/bootstrap.min.js"></script>
    <script src="js/libs/pace.min.js"></script>
    <script src="js/app.js"></script>

    <style>
        /* Styles pour le tableau et d'autres éléments */
        table {
            width: 100%;
            margin: 20px 0;
            border-collapse: collapse;
        }
        th, td {
            padding: 10px;
            text-align: center;
            border: 1px solid #ddd;
        }
        th {
            background-color: #f2f2f2;
        }
        tr:hover {
            background-color: #f1f1f1;
        }
    </style>
</body>
