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
                                <strong>تقرير حسب الفرع</strong>
                            </div>
                            <div class="card-block">
                                <div class="form-row">
                                    <div class="form-group col-md-4">
                                        <label for="start_date">تاريخ البدء:</label>
                                        <input type="date" id="start_date" class="form-control mb-2">
                                    </div>

                                    <div class="form-group col-md-4">
                                        <label for="end_date">تاريخ الانتهاء:</label>
                                        <input type="date" id="end_date" class="form-control mb-2">
                                    </div>
                                    
                                    <div class="form-group col-md-4">
                                        <label for="branch">الفرع:</label>
                                        <select id="branch" class="form-control mb-2">
                                            <option value="">الكل</option>
                                            <!-- Options for branches will be added dynamically -->
                                        </select>
                                    </div>
                                </div>

                                <table class="table table-striped table-bordered" id="branch-report-table">
                                    <thead>
                                        <tr>
                                            <th class="export">الفرع</th>
                                            <th class="export">إجمالي الطلبات</th>
                                            <th class="export">إجمالي الأسعار</th>
                                            <th>تصدير PDF</th>
                                        </tr>
                                    </thead>
                                    <tbody></tbody>
                                </table>

                                <canvas id="branchChart" width="400" height="200"></canvas>
                                <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
                                <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
                                <script src="https://cdnjs.cloudflare.com/ajax/libs/xlsx/0.18.5/xlsx.full.min.js"></script>

                                <script>
                                    const ctx = document.getElementById('branchChart').getContext('2d');
                                    let branchChart;

                                    function updateChart(data) {
                                        const labels = data.map(row => row.branch_name);
                                        const totalPrices = data.map(row => row.total_price);

                                        if (branchChart) {
                                            branchChart.destroy();
                                        }

                                        branchChart = new Chart(ctx, {
                                            type: 'bar',
                                            data: {
                                                labels: labels,
                                                datasets: [{
                                                    label: 'إجمالي الأسعار حسب الفرع',
                                                    data: totalPrices,
                                                    backgroundColor: 'rgba(54, 162, 235, 0.2)',
                                                    borderColor: 'rgba(54, 162, 235, 1)',
                                                    borderWidth: 1
                                                }]
                                            },
                                            options: {
                                                responsive: true,
                                                scales: {
                                                    y: {
                                                        beginAtZero: true,
                                                        title: {
                                                            display: true,
                                                            text: 'إجمالي الأسعار'
                                                        }
                                                    },
                                                    x: {
                                                        title: {
                                                            display: true,
                                                            text: 'الفروع'
                                                        }
                                                    }
                                                },
                                                plugins: {
                                                    legend: {
                                                        display: true,
                                                        position: 'top'
                                                    },
                                                    title: {
                                                        display: true,
                                                        text: 'التقرير البياني حسب الفرع'
                                                    }
                                                }
                                            }
                                        });
                                    }

                                    function updateTable(data) {
                                        const tbody = document.querySelector('#branch-report-table tbody');
                                        tbody.innerHTML = '';

                                        if (data.length === 0) {
                                            tbody.innerHTML = '<tr><td colspan="4">لا توجد بيانات متاحة للفترة المحددة.</td></tr>';
                                        } else {
                                            data.forEach(row => {
                                                const tr = document.createElement('tr');
                                                tr.innerHTML = `
                                                    <td class="export">${row.branch_name}</td>
                                                    <td class="export">${row.total_orders}</td>
                                                    <td class="export" >${row.total_price}</td>
                                                    <td><button class="btn btn-danger" onclick="exportBranchPDF('${row.branch_id}')">تصدير PDF</button></td>
                                                `;
                                                tbody.appendChild(tr);
                                            });
                                        }
                                    }

                                    function exportBranchPDF(branchId) {
                                        const startDate = document.getElementById('start_date').value;
                                        const endDate = document.getElementById('end_date').value;

                                        window.location.href = `../AJAX/export_branch_to_pdf.php?start_date=${startDate}&end_date=${endDate}&branch_id=${branchId}`;
                                    }

                                    function fetchData() {
                                        const startDate = document.getElementById('start_date').value;
                                        const endDate = document.getElementById('end_date').value;
                                        const branchId = document.getElementById('branch').value;

                                        $.ajax({
                                            url: '../AJAX/get_branch_report.php',
                                            method: 'GET',
                                            data: { start_date: startDate, end_date: endDate, branch_id: branchId },
                                            success: function(response) {
                                                const data = JSON.parse(response);
                                                updateTable(data);
                                                updateChart(data);
                                            }
                                        });
                                    }

                                    document.getElementById('start_date').addEventListener('change', fetchData);
                                    document.getElementById('end_date').addEventListener('change', fetchData);
                                    document.getElementById('branch').addEventListener('change', fetchData);

                                    $(document).ready(function() {
                                        $.ajax({
                                            url: '../AJAX/get_branches.php',
                                            method: 'GET',
                                            success: function(response) {
                                                const branches = JSON.parse(response);
                                                const branchSelect = document.getElementById('branch');
                                                

                                                branches.forEach(branch => {
                                                    const option = document.createElement('option');
                                                    option.value = branch.branch_id;
                                                    option.textContent = branch.branch_name;
                                                    branchSelect.appendChild(option);
                                                });
                                            }
                                        });

                                        fetchData(); 
                                    });

                                    function exportToExcel() {
                                            const data = [];
                                            const rows = document.querySelectorAll('#branch-report-table tbody tr');
const selectElement = document.getElementById('branch');
const branch = selectElement.options[selectElement.selectedIndex].innerHTML;                                            // Ajouter l'en-tête
                                            data.push(['الفرع', 'إجمالي الطلبات', 'إجمالي الأسعار']);
                                
                                            // Ajouter les données des lignes
                                            rows.forEach(row => {
                                                const rowData = [];
                                                row.querySelectorAll('.export').forEach(cell => {
                                                    rowData.push(cell.innerText);
                                                });
                                                data.push(rowData);
                                            });
                                
                                            // Créer la feuille Excel
                                            const ws = XLSX.utils.aoa_to_sheet(data);
                                            const wb = XLSX.utils.book_new();
                                            XLSX.utils.book_append_sheet(wb, ws, 'تقرير');
                                            XLSX.writeFile(wb, 'تقرير حسب الفرع_' + branch +'.xlsx');
                                        }

                                    function exportToPDF() {
                                        const startDate = document.getElementById('start_date').value;
                                        const endDate = document.getElementById('end_date').value;
                                        const branchId = document.getElementById('branch').value;

                                        window.location.href = `../AJAX/export_to_pdf.php?start_date=${startDate}&end_date=${endDate}&branch_id=${branchId}`;
                                    }
                                </script>
                            </div>
                            <div class="card-footer">
                                 <div class="text-right mb-3">
                                    <button id="exportExcel" class="btn btn-success">تصدير إلى Excel</button>
                                    <!--<button id="exportPDF" class="btn btn-danger">تصدير إلى PDF</button>-->
                                </div>
                            </div>
                            <script>
                                document.getElementById('exportExcel').addEventListener('click', exportToExcel);
                                //document.getElementById('exportPDF').addEventListener('click', exportToPDF);
                            </script>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </main>

    <footer class="footer">
       
    </footer>

    <script src="js/libs/tether.min.js"></script>
    <script src="js/libs/bootstrap.min.js"></script>
    <script src="js/libs/pace.min.js"></script>
    <script src="js/app.js"></script>
    
    <style>
        .form-control {
            border-radius: 0.25rem;
            box-shadow: none;
            border: 1px solid #ced4da;
        }

        .form-control:focus {
            border-color: #80bdff;
            outline: none;
            box-shadow: 0 0 0 0.2rem rgba(0, 123, 255, 0.25);
        }

        #branch-report-table {
            margin-top: 20px;
        }

        #branchChart {
            margin-top: 20px;
            max-width: 100%;
        }

        button {
            margin: 5px;
        }
    </style>
</body>
