<!DOCTYPE html>
<html lang="AR-ar" dir="rtl">

<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <meta name="description" content="قالب إدارة Bootstrap 4 CoreUI">
    <meta name="keyword" content="قالب إدارة Bootstrap 4 CoreUI">

    <!-- الأنماط الرئيسية لهذا التطبيق -->
    <link href="dest/style.css" rel="stylesheet">
    <link href="css/font-awesome.min.css" rel="stylesheet">
    <link href="css/simple-line-icons.css" rel="stylesheet">
    <!-- Main styles for this application -->
    <!-- CSS pour la barre de recherche -->
    <link href="css/main.css" rel="stylesheet" />

</head>

<body class="navbar-fixed fixed-nav">
    <header class="navbar">
        <div class="container container-nav">
            <button class="navbar-toggler mobile-toggler hidden-lg-up" type="button">&#9776;</button>

            <form class="form-inline nav navbar-nav pull-xs-right">
            <a href="./BACKOFFICE/login.php" class="btn btn-outline-primary">تسجيل الدخول</a>
            </form>
        </div>
    </header>

    <!-- Barre de recherche ajoutée -->
    <div class="s131">
        <form>
            <div class="inner-form">
                <div class="input-field first-wrap">
                    <input id="search" type="text" placeholder="ما الذي تبحث عنه؟" />
                </div>
                <div class="input-field second-wrap">
                    <div class="input-select">
                        <select id="branchSelect" class="choices__inner" data-trigger="" name="choices-single-defaul">
                            <option value="" class="choices__inner"  disabled selected>اختر الفئة</option> <!-- Ajout de disabled et selected -->
                            <!-- Les filiales seront ajoutées ici via JavaScript -->
                        </select>
                        
                    </div>
                </div>
                <div class="input-field third-wrap">
                    <button class="btn-search" type="button">ابحث</button>
                </div>
            </div>
        </form>
    </div>

    <!-- المحتوى الرئيسي -->
    <main class="main">
        <!-- جدول الطلبات -->
        <div class="row" id="commmandes" style="display: none;">
            <div class="col-lg-12">
                <div class="card">
                    <div class="card-header">
                        <i class="fa fa-align-justify"></i> قائمة الطلبات
                    </div>
                    <div class="card-block">
                        <table id="commandesTable" class="table table-bordered table-striped table-condensed" style="display:none;">
                            <thead>
                                <tr>
                                    <th>رقم الطلب</th>
                                    <th>المرسل</th>
                                    <th>تاريخ الطلب</th>
                                    <th>تاريخ التسليم</th>
                                    <th>التفاصيل</th>
                                    <th>السعر</th>
                                    <th>مدة التنفيذ</th>
                                    <th>الحالة</th>
                                </tr>
                            </thead>
                            <tbody id="commandesBody">
                                <!-- Les lignes des commandes seront insérées ici dynamiquement via JavaScript -->
                            </tbody>
                        </table>
                        <nav>
                            <ul class="pagination">
                                <li class="page-item">
                                    <a class="page-link" href="#" id="prevPage">السابق</a>
                                </li>
                                <li class="page-item active">
                                    <a class="page-link" href="#" id="currentPage">1</a>
                                </li>
                                <li class="page-item">
                                    <a class="page-link" href="#" id="nextPage">التالي</a>
                                </li>
                            </ul>
                        </nav>
                    </div>
                </div>
            </div>
            <!--/col-->
        </div>
        <!--/row-->

    </main>

    <footer class="footer">
        <span class="text-left">© 2024 </span>
        <span class="pull-right"> </span>
    </footer>

    <!-- JS pour la barre de recherche -->
    <script>
        // Variables pour la pagination
        let currentPage = 1;
        const pageSize = 10; // Nombre d'éléments par page

        // Récupérer les filiales et les ajouter dans le select
        document.addEventListener('DOMContentLoaded', () => {
            fetch('AJAX/get_branches.php')
                .then(response => response.json())
                .then(data => {
                    const selectElement = document.getElementById('branchSelect');
                    data.forEach(branch => {
                        const option = document.createElement('option');
                        option.value = branch.branch_id;
                        option.textContent = branch.branch_name;
                        selectElement.appendChild(option);
                    });
                })
                .catch(error => console.error('Erreur:', error));
        });

        // Fonction pour échapper les caractères HTML
        function escapeHtml(html) {
            const text = document.createElement('textarea');
            text.innerText = html;
            return text.innerHTML;
        }

        // Recherche des commandes par filiale
        document.querySelector('.btn-search').addEventListener('click', () => {
            const branchId = document.getElementById('branchSelect').value;

            if (branchId) {
                fetch(`AJAX/get_orders.php?branch_id=${branchId}`)  // Ajoutez le paramètre de la filiale dans l'URL
                    .then(response => {
                        if (!response.ok) {
                            throw new Error('Erreur lors du chargement des commandes');
                        }
                        return response.json();
                    })
                    .then(data => {
                        const commandesBody = document.getElementById('commandesBody');
                        commandesBody.innerHTML = '';  // Réinitialiser le contenu du tableau

                        // Calculer le nombre total de pages
                        const totalPages = Math.ceil(data.length / pageSize);
                        const start = (currentPage - 1) * pageSize;
                        const end = Math.min(start + pageSize, data.length);

                        for (let i = start; i < end; i++) {
                            const order = data[i];
                            const row = document.createElement('tr');
                            const statusClass = (order.status === 'ملغي') ? 'tag tag-danger' : '';

                            // Ajoutez les données dans le tableau
                            row.innerHTML = `
                                <td>${escapeHtml(order.order_number)}</td>
                                <td>${escapeHtml(order.sender)}</td>
                                <td>${escapeHtml(order.order_date)}</td>
                                <td>${escapeHtml(order.delivery_date)}</td>
                                <td>${escapeHtml(order.details)}</td>
                                <td>${escapeHtml(order.price)}</td>
                                <td>${escapeHtml(order.execution_time)}</td>
                                <td class="${statusClass}">${escapeHtml(order.status)}</td>
                            `;

                            commandesBody.appendChild(row);
                        }

                        // Afficher le tableau si des commandes existent
                        const commandesTable = document.getElementById('commandesTable');
                        const commandesRow = document.getElementById('commmandes');

                        commandesRow.style.display = data.length > 0 ? 'block' : 'none';  // Afficher ou masquer le div commandes
                        commandesTable.style.display = data.length > 0 ? 'table' : 'none';  // Afficher ou masquer le tableau

                        // Mettre à jour les liens de pagination
                        document.getElementById('currentPage').textContent = currentPage;

                        // Gérer la visibilité des liens de pagination
                        document.getElementById('prevPage').style.display = currentPage === 1 ? 'none' : 'block';
                        document.getElementById('nextPage').style.display = currentPage === totalPages ? 'none' : 'block';
                    })
                    .catch(error => {
                        console.error('Erreur lors de la récupération des commandes:', error);
                    });

            } else {
                alert("يرجى اختيار فرع.");
            }
        });

        // Gestion des événements de pagination
        document.getElementById('prevPage').addEventListener('click', (e) => {
            e.preventDefault();
            if (currentPage > 1) {
                currentPage--;
                document.querySelector('.btn-search').click(); // Rechercher à nouveau
            }
        });

        document.getElementById('nextPage').addEventListener('click', (e) => {
            e.preventDefault();
            currentPage++;
            document.querySelector('.btn-search').click(); // Rechercher à nouveau
        });
    </script>

</body>
</html>
