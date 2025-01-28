<?php
include('header.php');

// Requêtes pour récupérer les données
try {
    $total_orders_stmt = $db->query("SELECT COUNT(*) as total FROM orders WHERE valid=1");
    $completed_orders_stmt = $db->query("SELECT COUNT(*) as total FROM orders WHERE status = 'جاهز' AND valid=1");
    $canceled_orders_stmt = $db->query("SELECT COUNT(*) as total FROM orders WHERE status = 'في الانتظار' AND valid=1");
    $in_progress_orders_stmt = $db->query("SELECT COUNT(*) as total FROM orders WHERE status = 'قيد التنفيذ' AND valid=1");
    $shipped_orders_stmt = $db->query("SELECT COUNT(*) as total FROM orders WHERE status = 'تم ارسال الطلب' AND valid=1");

    $total_orders_count = $total_orders_stmt->fetch(PDO::FETCH_ASSOC)['total'];
    $completed_orders_count = $completed_orders_stmt->fetch(PDO::FETCH_ASSOC)['total'];
    $canceled_orders_count = $canceled_orders_stmt->fetch(PDO::FETCH_ASSOC)['total'];
    $in_progress_orders_count = $in_progress_orders_stmt->fetch(PDO::FETCH_ASSOC)['total'];
    $shipped_orders_count = $shipped_orders_stmt->fetch(PDO::FETCH_ASSOC)['total'];
} catch (Exception $e) {
    echo 'Erreur : ' . $e->getMessage();
}
?>

<body class="navbar-fixed sidebar-nav fixed-nav">
   
    <!-- Main content -->
    <main class="main">

        <!-- Breadcrumb -->
        <ol class="breadcrumb">
            <li class="breadcrumb-item active">لوحة التحكم</li>
        </ol>

        <div class="container-fluid">
            <div class="animated fadeIn">
                <div class="row">
                    <!-- Carte pour les commandes prêtes -->
                   

                    <!-- Carte pour les commandes annulées -->
                    <div class="col-sm-6 col-lg-3">
                        <div class="card card-inverse card-danger">
                            <div class="card-block p-b-0">
                                <h4 class="m-b-0"><?php echo $canceled_orders_count; ?></h4>
                                <p>طلبات في الانتظار</p>
                            </div>
                        </div>
                    </div>

                    <!-- Carte pour les commandes en cours -->
                    <div class="col-sm-6 col-lg-3">
                        <div class="card card-inverse card-warning">
                            <div class="card-block p-b-0">
                                <h4 class="m-b-0"><?php echo $in_progress_orders_count; ?></h4>
                                <p>طلبات قيد التنفيذ</p>
                            </div>
                        </div>
                    </div>
                    <div class="col-sm-6 col-lg-3">
                        <div class="card card-inverse card-primary">
                            <div class="card-block p-b-0">
                                <h4 class="m-b-0"><?php echo $completed_orders_count; ?></h4>
                                <p>طلبات جاهزة</p>
                            </div>
                        </div>
                    </div>
                    <!-- Carte pour les commandes envoyées -->
                    <div class="col-sm-6 col-lg-3">
                        <div class="card card-inverse card-info">
                            <div class="card-block p-b-0">
                                <h4 class="m-b-0"><?php echo $shipped_orders_count; ?></h4>
                                <p>طلبات تم إرسالها</p>
                            </div>
                        </div>
                    </div>
                   
                </div>
                <!--/row-->

                <!-- Graphique des commandes -->
                <div class="row">
                    <div class="col-lg-12">
                        <div class="card">
                            <div class="card-header">
                                <strong>  احصائيات الطلبات</strong>
                            </div>
                            <div class="card-body">
                                <canvas id="ordersChart" style="width: 100%; height: 400px;"></canvas>
                            </div>
                        </div>
                    </div>
                </div>
                
                <!--/row-->

            </div>
        </div>
        <!--/.container-fluid-->
   <script src="js/libs/jquery.min.js"></script>
    <script src="js/libs/tether.min.js"></script>
    <script src="js/libs/bootstrap.min.js"></script>
    <script src="js/libs/pace.min.js"></script>
    <!-- Plugins and scripts required by all views -->
    <script src="js/libs/Chart.min.js"></script>
    <!-- CoreUI main scripts -->

    <script src="js/app.js"></script>
    <!-- Plugins and scripts required by this views -->
    <!-- Custom scripts required by this view -->
    <script src="js/views/widgets.js"></script>
    <!-- Grunt watch plugin -->

        <script>
            // Données pour le graphique
            var ctx = document.getElementById('ordersChart').getContext('2d');
            var ordersChart = new Chart(ctx, {
                type: 'bar', // Type de graphique à barres
                data: {
                    labels: ['طلبات جاهزة', 'طلبات في الانتظار', 'طلبات قيد التنفيذ', 'طلبات تم إرسالها', 'إجمالي الطلبات'], // Labels
                    datasets: [{
                        label: '  عدد الطلبات  ',
                        data: [
                            <?php echo $completed_orders_count; ?>,
                            <?php echo $canceled_orders_count; ?>,
                            <?php echo $in_progress_orders_count; ?>,
                            <?php echo $shipped_orders_count; ?>,
                            <?php echo $total_orders_count; ?> // Ajout de la barre pour le total
                        ],
                        backgroundColor: [
                            'rgba(0, 123, 255, 0.5)', // Couleur pour "طلبات جاهزة"
                            'rgba(255, 0, 0, 0.5)', // Couleur pour "طلبات ملغية"
                            'rgba(255, 193, 7, 0.5)', // Couleur pour "طلبات قيد التنفيذ"
                            'rgba(40, 167, 69, 0.5)', // Couleur pour "طلبات تم إرسالها"
                            'rgba(255, 165, 0, 0.5)' // Couleur pour "إجمالي الطلبات"
                        ],
                        borderColor: [
                            'rgba(0, 123, 255, 1)',
                            'rgba(255, 0, 0, 1)',
                            'rgba(255, 193, 7, 1)',
                            'rgba(40, 167, 69, 1)',
                            'rgba(255, 165, 0, 1)' // Couleur pour le total
                        ],
                        borderWidth: 1
                    }]
                },
                options: {
                    responsive: true,
                    scales: {
                        y: {
                            beginAtZero: true // Commencer à zéro sur l'axe Y
                        }
                    },
                    plugins: {
                        legend: {
                            display: true,
                            position: 'top',
                        },
                        tooltip: {
                            callbacks: {
                                label: function(tooltipItem) {
                                    return tooltipItem.label + ': ' + tooltipItem.raw; // Affiche le nombre de commandes
                                }
                            }
                        }
                    }
                }
            });
        </script>
    </main>

    <footer class="footer">
     </footer>
</body>
