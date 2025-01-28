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
                                <strong>تقرير حسب التاريخ</strong>
                            </div>
                            <div class="card-block">
                                <div class="form-row align-items-center">
                                    <style>
                                        .form-row2 {
                                            display: flex;
                                            align-items: center;
                                        }
                                        .form-group2 {
                                            display: flex;
                                            align-items: center;
                                            gap: 40px;
                                        }
                                        table {
                                            direction: rtl;
                                        }
                                    </style>

                                    <div class="form-row2">
                                        <div class="form-group2 col-md-4">
                                            <label for="start_date">اختر تاريخ:</label>
                                            <input type="date" id="start_date" class="form-control">
                                        </div>
                                        <div class="form-group2 col-md-6">
                                            <button class="btn btn-danger" onclick="exportDatePDF()">تصدير PDF</button>
                                        </div>
                                    </div>

                                    <!-- Tableau des totaux -->
                                    <table class="table table-striped table-bordered" id="total-orders-table">
                                        <thead>
                                            <tr>
                                                <th>إجمالي عدد الطلبات</th>
                                                <th>إجمالي أسعار الطلبات</th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                            <tr>
                                                <td id="total-orders-count">0</td>
                                                <td id="total-orders-price">0.00</td>
                                            </tr>
                                        </tbody>
                                    </table>

                                    <h6>الطلبات</h6>
                                    <!-- Tableau des commandes -->
                                    <table class="table table-striped table-bordered" id="branch-report-table">
                                        <thead>
                                            <tr>
                                                <th>رقم الطلب</th>
                                                <th>المرسل</th>
                                                <th>تفاصيل الطلب</th>
                                                <th>السعر</th>
                                                <th>الكمية</th>
                                                <th>تاريخ الإنشاء</th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                            <td colspan="6"> </td>
                                        </tbody>
                                    </table>
                                </div>
                            </div>
                            <div class="card-footer">
                                <button class="btn btn-success" onclick="exportToExcel()">تصدير Excel</button>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </main>
    <?php include('footer.php'); ?>
</body>

<script src="https://cdnjs.cloudflare.com/ajax/libs/xlsx/0.18.5/xlsx.full.min.js"></script>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script>
function exportToExcel() {
    const startDate = document.getElementById('start_date').value;
    if (!startDate) {
        alert("يرجى اختيار تاريخ للتصدير.");
        return;
    }

    const totalOrdersTable = document.getElementById("total-orders-table");
    const ordersTable = document.getElementById("branch-report-table");

    if (!totalOrdersTable || !ordersTable) {
        alert("خطأ: الجداول غير متوفرة للتصدير.");
        return;
    }

    // Créer un classeur Excel
    const workbook = XLSX.utils.book_new();

    // Titre global
    const reportTitle = [["تقرير الطلبات ليوم " + startDate]];
    const combinedData = [...reportTitle, [""]];

    // Ajouter les données du tableau des totaux
    const totalOrdersData = XLSX.utils.sheet_to_json(
        XLSX.utils.table_to_sheet(totalOrdersTable), 
        { header: 1 }
    );
    combinedData.push(["إجمالي الطلبات"], ...totalOrdersData, [""]);

    // Ajouter les données du tableau des commandes
    const ordersData = XLSX.utils.sheet_to_json(
        XLSX.utils.table_to_sheet(ordersTable), 
        { header: 1 }
    );
    combinedData.push(["تفاصيل الطلبات"], ...ordersData);

    // Créer une feuille et appliquer les styles
    const sheet = XLSX.utils.aoa_to_sheet(combinedData);

    // Appliquer des styles personnalisés aux en-têtes
    const headerStyle = {
        font: { bold: true, color: { rgb: "FFFFFF" } },
        fill: { fgColor: { rgb: "4F81BD" } }, // Bleu
        alignment: { horizontal: "center", vertical: "center" }
    };

    const range = XLSX.utils.decode_range(sheet["!ref"]);
    for (let C = range.s.c; C <= range.e.c; ++C) {
        const cellAddress = XLSX.utils.encode_cell({ r: range.s.r, c: C });
        if (sheet[cellAddress]) sheet[cellAddress].s = headerStyle;
    }

    // Ajouter des métadonnées pour l'orientation RTL
    sheet["!margins"] = { right: 0.5, left: 0.5 };
    sheet["!cols"] = [{ wpx: 150 }, { wpx: 150 }];
    sheet["!rtl"] = false;
 
    XLSX.utils.book_append_sheet(workbook, sheet, "تقرير الطلبات");

    // Télécharger le fichier
    XLSX.writeFile(workbook, `تقرير_الطلبات_${startDate}.xlsx`);
}

function updateTotals(totals) {
    const totalOrdersCount = parseInt(totals.total_count) || 0;
    const totalOrdersPrice = parseFloat(totals.total_price) || 0;

    document.getElementById('total-orders-count').textContent = totalOrdersCount;
    document.getElementById('total-orders-price').textContent = totalOrdersPrice.toFixed(2);
}

function updateTable(data) {
    const tbody = document.querySelector('#branch-report-table tbody');
    tbody.innerHTML = '';

    if (!Array.isArray(data) || data.length === 0) {
        tbody.innerHTML = '<tr><td colspan="6">لا توجد بيانات متاحة للتاريخ المحدد.</td></tr>';
        return;
    }

    data.forEach(row => {
        const tr = document.createElement('tr');
        tr.innerHTML = `
            <td>${row.order_number}</td>
            <td>${row.sender}</td>
            <td>${row.details}</td>
            <td>${parseFloat(row.price).toFixed(2)}</td>
            <td>${row.execution_time}</td>
            <td>${row.created_at}</td>
        `;
        tbody.appendChild(tr);
    });
}

function fetchData() {
    const startDate = document.getElementById('start_date').value;

    $.ajax({
        url: '../AJAX/get_date_report.php',
        method: 'GET',
        data: { start_date: startDate },
        success: function(response) {
            let result;
            try {
                result = JSON.parse(response);
            } catch (e) {
                console.error('Erreur lors de l’analyse de la réponse JSON', e);
                result = { data: [], totals: { total_count: 0, total_price: 0 } };
            }

            updateTable(result.data);
            updateTotals(result.totals);
        },
        error: function(xhr, status, error) {
            console.error('Erreur AJAX :', status, error);
            updateTable([]);
            updateTotals({ total_count: 0, total_price: 0 });
        }
    });
}

function exportDatePDF() {
    const startDate = document.getElementById('start_date').value;
    window.location.href = `../AJAX/export_date_to_pdf.php?start_date=${startDate}`;
}

document.getElementById('start_date').addEventListener('change', fetchData);
</script>
