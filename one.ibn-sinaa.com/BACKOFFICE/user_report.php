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
                                <strong>تقرير حسب المستخدم</strong>
                            </div>
                            <div class="card-block">
                                <div class="form-row">
                                    <div class="form-group row">
                                    <div class="col-md-3">
                                        <label for="sender">المرسل :</label>
                                        <select class="form-control" id="sender" name="sender" required>
                                            <!-- Option de guide inaccessible -->
                                            <option value="" disabled selected>اختار المرسل</option>
                                            <!-- Les autres options seront ajoutées dynamiquement avec JavaScript -->
                                        </select>
                                    </div>

                                    <div class="col-md-3">
                                        <label for="status">نوع الطلبات</label>
                                        <select id="status" class="form-control mb-2">
                                            <option value="all">الكل</option>
                                            <option value="1">مقبولة</option> <!-- "مقبولة" means "accepted" -->
                                            <option value="-1">مرفوضة</option> <!-- "مرفوضة" means "refused" -->
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
                                             <button id="btn" class="form-control mb-2 btn btn-primary" onclick="fetchData()">تحديث التقرير</button>
                                        </div>
                                        <div class="col-md-3">

                                        <button class="form-control mb-2 btn btn-danger"  onclick="exportUserPDF()">تصدير PDF</button>
                                        </div>
                                        <div class="col-md-3">
    <button class="form-control mb-2 btn btn-success" onclick="exportUserExcel()">تصدير Excel</button>
</div>

                                    </div>
                                    </div>
                                <table class="table table-striped table-bordered" id="user-report-table">
                                    <thead>
                                        <tr>
                                            <th>رقم الطلب</th>
                                            <th>التاريخ </th>
                                            <th>السعر</th>
                                            <th>التفاصيل </th>
                                            <th>حاله الطلب</th>

                                        </tr>
                                    </thead>
                                    <tbody></tbody>
                                </table>
                                <table class="table table-striped table-bordered" id="summary-table">
                                    <thead>
                                        <tr>
                                            <th>إجمالي عدد الطلبات</th>
                                            <th>إجمالي الأسعار</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <tr>
                                            <td id="total-orders">0</td>
                                            <td id="total-price">0.00</td>
                                        </tr>
                                    </tbody>
                                </table>
                                <canvas id="orderChart" width="400" height="200"></canvas>
                                <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
                                <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/xlsx/0.17.1/xlsx.full.min.js"></script>

                                <script>
                                    function fetchUsers() {
                                        fetch('../AJAX/get_all_users.php')
                                            .then(response => response.json())
                                            .then(data => {
                                                const userSelect = document.getElementById('sender');
                                                data.forEach(user => {
                                                    const option = document.createElement('option');
                                                    option.value = user.id;
                                                    option.textContent = user.username;
                                                    userSelect.appendChild(option);
                                                });
                                            })
                                            .catch(error => console.error('Erreur lors du chargement des utilisateurs:', error));
                                    }

                                    fetchUsers();

                                    const ctx = document.getElementById('orderChart').getContext('2d');
                                    let orderChart;
                                    function updateChart(monthlyData, status) {
    const labels = monthlyData.map(row => row.month); // Using the month as label
    const acceptedCounts = monthlyData.map(row => row.accepted_orders); // Accepted orders count
    const rejectedCounts = monthlyData.map(row => row.rejected_orders); // Rejected orders count

    if (orderChart) {
        orderChart.destroy();
    }

    const datasets = [];

    // Create datasets based on the selected status
    if (status === 'all') {
        datasets.push({
            label: 'طلبات مقبولة',
            data: acceptedCounts,
            backgroundColor: 'rgba(75, 192, 75, 0.2)', // Green for accepted
            borderColor: 'rgba(75, 192, 75, 1)', // Green border
            borderWidth: 1
        }, {
            label: 'طلبات مرفوضة',
            data: rejectedCounts,
            backgroundColor: 'rgba(255, 99, 132, 0.2)', // Red for refused
            borderColor: 'rgba(255, 99, 132, 1)', // Red border
            borderWidth: 1
        });
    } else if (status === '1') { // Only accepted
        datasets.push({
            label: 'طلبات مقبولة',
            data: acceptedCounts,
            backgroundColor: 'rgba(75, 192, 75, 0.2)',
            borderColor: 'rgba(75, 192, 75, 1)',
            borderWidth: 1
        });
    } else if (status === '-1') { // Only refused
        datasets.push({
            label: 'طلبات مرفوضة',
            data: rejectedCounts,
            backgroundColor: 'rgba(255, 99, 132, 0.2)',
            borderColor: 'rgba(255, 99, 132, 1)',
            borderWidth: 1
        });
    }

    // Create the chart with the defined data and options
    orderChart = new Chart(ctx, {
        type: 'bar',
        data: {
            labels: labels, // Use the months as labels
            datasets: datasets
        },
        options: {
            responsive: true,
            scales: {
                y: {
                    beginAtZero: true,
                    title: {
                        display: true,
                        text: 'عدد الطلبات'  // Y-axis label (Number of orders)
                    }
                },
                x: {
                    title: {
                        display: true,
                        text: 'الشهور'  // X-axis label (Months)
                    }
                }
            },
            plugins: {
                legend: { display: true },
                title: { display: true, text: 'التقرير البياني حسب الشهر' }
            }
        }
    });
}


                                    function updateTable(orders) {
                                        const tbody = document.querySelector('#user-report-table tbody');
                                        tbody.innerHTML = '';
                                        let totalOrders = 0;
                                                let totalPrice = 0;

                                        if (orders.length === 0) {
                                            tbody.innerHTML = '<tr><td colspan="5">لا توجد بيانات متاحة.</td></tr>';
                                        } else {
                                            orders.forEach(order => {
                                                const tr = document.createElement('tr');
                                                tr.innerHTML = `
                                                    <td>${order.order_number}</td>
                                                    <td>${order.created_at}</td>
                                                     <td>${order.price}</td>  
                                                     <td>${order.details}</td>  
                                                     <td>${order.status}</td>  

                                                `;
                                                tbody.appendChild(tr);
                                                totalOrders++;
                                                totalPrice += parseFloat(order.price);
                                            });
                                        }
                                        document.getElementById('total-orders').innerText = totalOrders;
                                        document.getElementById('total-price').innerText = totalPrice.toFixed(2);
                                    }

                                 
                                    function exportUserPDF(){
                                        const userId = document.getElementById('sender').value;
                                        const status = document.getElementById('status').value;
                                        const startDate = document.getElementById('startDate').value;
                                        const endDate = document.getElementById('endDate').value;
                                        if (userId === "") {
                                            swal({
                                                title: "تنبيه",
                                                text: "الرجاء اختيار المرسل",
                                                icon: "warning",
                                                button: "حسناً"
                                            });
                                                                        
                                        return; // Empêche l'exécution du reste de la fonction si aucun utilisateur n'est sélectionné
                                        }

                                        $.ajax({
                                            url: '../AJAX/get_user_report.php',
                                            method: 'GET',
                                            data: {
                                                userId: userId,
                                                status: status,
                                                startDate: startDate,
                                                endDate: endDate
                                            }, 
                                                success: function(response) {
                                                // Vous pouvez ensuite récupérer les données et envoyer à PHP pour la génération du PDF
                                                // Exemple de données à envoyer (vous pouvez personnaliser cela selon votre réponse AJAX)
                                                const userData = JSON.parse(response);
                                                generatePDF(userData);
                                            },
                                            error: function(xhr, status, error) {
                                                console.error("Erreur lors de la requête AJAX:", error);
                                            }
                                        });
                                    }

                                    function generatePDF(userData) {

                                        // Créer un formulaire HTML temporaire pour envoyer les données via POST
                                        var form = document.createElement("form");
                                        form.method = "POST";
                                        form.action = "../AJAX/generate_pdf_report.php";

                                        // Ajouter un champ caché pour envoyer les données
                                        var input = document.createElement("input");
                                        input.type = "hidden";
                                        input.name = "userData";
                                        input.value = JSON.stringify(userData); // Sérialiser les données en JSON
                                        form.appendChild(input);

                                        // Ajouter le formulaire au DOM
                                        document.body.appendChild(form);

                                        // Soumettre le formulaire
                                        form.submit();

                                        // Supprimer le formulaire après envoi
                                        document.body.removeChild(form);
                                    }

                                    function fetchData() {
    const userId = document.getElementById('sender').value;
    const status = document.getElementById('status').value;
    const startDate = document.getElementById('startDate').value;
    const endDate = document.getElementById('endDate').value;

    if (userId === "") {
        alert("الرجاء اختيار المرسل");
        return; // Empêche l'exécution du reste de la fonction si aucun utilisateur n'est sélectionné
    }

    $.ajax({
        url: '../AJAX/get_user_report.php',
        method: 'GET',
        data: {
            userId: userId,
            status: status,
            startDate: startDate,
            endDate: endDate
        },
        success: function(response) {
            let data;
            try {
                data = typeof response === "string" ? JSON.parse(response) : response;
            } catch (error) {
                console.error("Erreur lors du parsing JSON:", error);
                return;
            }
            console.log(data);
            if (data.orders && data.monthlyData) {
                updateTable(data.orders);
                updateChart(data.monthlyData, status);
            } else {
                console.error("Données manquantes dans la réponse", data);
                updateTable([]);
                updateChart([]);
            }
        },
        error: function(xhr, status, error) {
            console.error("Erreur lors de la requête AJAX:", error);
        }
    });
}

// Add the "Export to Excel" functionality
function exportUserExcel() {
    // Collect table data
    const table = document.getElementById('user-report-table');
    const rows = table.querySelectorAll('tr');

    // Create an array for Excel data
    const excelData = [];

    // Extract headers
    const headers = [];
    rows[0].querySelectorAll('th').forEach(header => {
        headers.push(header.innerText);
    });
    excelData.push(headers);

    // Extract table rows
    rows.forEach((row, index) => {
        if (index > 0) { // Skip the header row
            const rowData = [];
            row.querySelectorAll('td').forEach(cell => {
                rowData.push(cell.innerText);
            });
            excelData.push(rowData);
}
    });
    const userId = document.getElementById('sender').selectedOptions[0].innerText;  // ou .textContent

    // Convert array to worksheet
    const ws = XLSX.utils.aoa_to_sheet(excelData);
    
    // Create a new workbook and append the worksheet
    const wb = XLSX.utils.book_new();
    XLSX.utils.book_append_sheet(wb, ws, 'User Report');
   // Créez un nom de fichier en ajoutant le texte de 'userId' avec le suffixe souhaité
    const fileName =  'تقرير المستخدم_' +userId +'.xlsx';

    // Utilisez XLSX.writeFile avec le nom de fichier corrigé
    XLSX.writeFile(wb, fileName);
}

                                </script>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </main>

    <footer class="footer"></footer>

    <script src="js/libs/tether.min.js"></script>
    <script src="js/libs/bootstrap.min.js"></script>
    <script src="js/libs/pace.min.js"></script>
    <script src="js/app.js"></script>

    <style>
        .form-control { border-radius: 0.25rem; border: 1px solid #ced4da; }
        #user-report-table { margin-top: 20px; }
        #orderChart { margin-top: 20px; max-width: 100%; }
    </style>
</body>
