<?php include_once 'check_login.php'; 
// Exemple pour afficher une notification à l'utilisateur lors de la connexion

function getOrderCount($valid = null, $status = null, $specificUserId = null) {
    global $db, $role, $userId;

    $query = "SELECT COUNT(*) AS count FROM orders";
    $conditions = [];
    $params = [];
    // Ajouter la condition de statut
   
    if ($status !== null) {
        $conditions[] = "status = :status";
        $params[':status'] = $status;
    }
    // Ajouter la condition pour "valid"
    if ($valid !== null) {
        $conditions[] = "valid = :valid";
        $params[':valid'] = (int)$valid;
    }

    // Ajouter la condition pour "user_id"
    if ($specificUserId) {
        $conditions[] = "user_id = :userId";
        $params[':userId'] = (int)$specificUserId;
    } elseif (isset($role) && ( $role === \Delight\Auth\Role::USER ||  $role === \Delight\Auth\Role::EXTERN_USER) ) {
        $conditions[] = "user_id = :userId";
        $params[':userId'] = (int)$userId;
    }

    // Construire la clause WHERE si nécessaire
    if ($conditions) {
        $query .= " WHERE " . implode(" AND ", $conditions);
    }

    $stmt = $db->prepare($query);

    // Lier les paramètres
    foreach ($params as $key => $value) {
        $stmt->bindValue($key, $value, is_int($value) ? PDO::PARAM_INT : PDO::PARAM_STR);
    }

    // Exécuter la requête
    $stmt->execute();
    $result = $stmt->fetch(PDO::FETCH_ASSOC);
    return $result['count'] ?? 0;
}


 
 function getOrderCountUser($valid){

    global $db, $role, $userId; // Assurez-vous que ces variables sont correctement initialisées

    // Base de la requête
    $query = "SELECT COUNT(*) AS count FROM orders where valid=0 and user_id=$userId ";
     

    // Préparation de la requête
    $stmt = $db->prepare($query);
  

    // Exécution et récupération des résultats
    $stmt->execute();
    $result = $stmt->fetch(PDO::FETCH_ASSOC);

    // Retourne le résultat ou 0 si aucune correspondance
    return $result['count'] ?? 0;
 }

?>
<style>

.badge {
    font-size: 12px;
    padding: 5px 10px;
    border-radius: 50%;
    color: #fff;
    
}
@media (max-width: 768px) {
    .badge {
        font-size: 10px;
        padding: 3px 8px;
    }
    .nav-link {
        font-size: 14px;
    }
}

.badge-primary {
    background-color: #007bff;
}

.badge-warning {
    background-color: #ffc107;
}

.badge-danger {
    background-color: #dc3545;
}
.badge-green {
    background-color: #64c244;
}
.dropdown-menu {
    max-height: 300px;
    overflow-y: auto;
}
.dropdown-item a {
    text-decoration: none;
    color: inherit;
}


</style>

<!DOCTYPE html>
<html lang="IR-fa" dir="rtl">

<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
 
    <title>ابن سينا للطباعة والدعاية والاعلان</title>
    <!-- Icons -->
    <link href="css/font-awesome.min.css" rel="stylesheet">
    <link href="css/simple-line-icons.css" rel="stylesheet">
    <!-- Main styles for this application -->
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Tajawal:wght@200;300;400;500;700;800;900&display=swap" rel="stylesheet">
    <link href="dest/style.css" rel="stylesheet">
    <!-- Code HTML pour le formulaire d'édition -->
    <!-- SweetAlert2 CSS -->
    <link href="https://cdn.jsdelivr.net/npm/sweetalert2@11/dist/sweetalert2.min.css" rel="stylesheet">
    <link rel="icon" href="img/favicon.png" type="image/png">

    <!-- SweetAlert2 JS -->
    <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
    <!-- Select2 CSS -->
    <link href="https://cdn.jsdelivr.net/npm/select2@4.1.0/dist/css/select2.min.css" rel="stylesheet" />

    <!-- Select2 JS -->
    <script src="https://cdn.jsdelivr.net/npm/select2@4.1.0/dist/js/select2.min.js"></script>
</head>
 

<body class="navbar-fixed sidebar-nav fixed-nav">
    <header class="navbar">
        <div class="container-fluid">
             <a class="navbar-brand" href="#"></a>

            <button class="navbar-toggler mobile-toggler hidden-lg-up" type="button">&#9776;</button>
            <ul class="nav navbar-nav hidden-md-down">
                
                <li class="nav-item">
                    <a class="nav-link navbar-toggler layout-toggler" href="#">&#9776;</a>
                </li>

              
            </ul>
            <ul class="nav navbar-nav pull-left hidden-md-down">
            <li class="nav-item dropdown">
            <a class="nav-link dropdown-toggle nav-link"  id="notificationsDropdown" data-toggle="dropdown" href="#" role="button" aria-haspopup="true" aria-expanded="false">
            الاشعارات
        <span class="badge badge-danger">0</span>
    </a>
    <ul class="dropdown-menu dropdown-menu-right" id="notificationList">
        <a class="dropdown-item">لا توجد اية اشعارات </a>
    </ul>
</li>

                <li class="nav-item dropdown">
                    <a class="nav-link dropdown-toggle nav-link" data-toggle="dropdown" href="#" role="button" aria-haspopup="true" aria-expanded="false">
                        <!-- <img src="img/avatars/6.jpg" class="img-avatar" alt="admin@bootstrapmaster.com"> -->
                        <span class="hidden-md-down"><?php echo htmlspecialchars($username); ?></span>
                        </a>
                    <div class="dropdown-menu dropdown-menu-right">
            
                        <div class="dropdown-header text-xs-center">
                            <strong>Settings</strong>
                        </div>
                        <a class="dropdown-item" href="#"><i class="fa fa-user"></i> Profile</a>
                         
                        <a class="dropdown-item" href="logout.php"><i class="fa fa-lock"></i> تسجيل الخروج</a> <!-- Lien de déconnexion -->
                        </div>
                </li>
            
                <li class="nav-item">
                 </li>

            </ul>
        </div>
    </header>
    <div class="sidebar">
        <nav class="sidebar-nav .tajawal-bold">
            <ul class="nav">
                <?php if (!$auth->hasRole(\Delight\Auth\Role::USER) && !$auth->hasRole(\Delight\Auth\Role::EXTERN_USER) ) { ?>

                <li class="nav-item">
                    <a class="nav-link" href="dashboard.php"><i class="fa fa-dashboard "></i> لوحة التحكم  </a>
                </li>
                <?php } ?>

                <?php if ($auth->hasRole(\Delight\Auth\Role::ADMIN)) { ?>
                <li class="nav-item">
                    <a class="nav-link" href="users.php"><i class="fa fa-users"></i>المستخدمين</a>
                </li>
                <?php } ?>
                   
                 <!-- <li class="nav-item">
                    <a class="nav-link" href="products.php"><i class="icon-pie-chart"></i> المنتجات</a>
                </li> -->
                <li class="nav-item">
                <a class="nav-link" href="orders.php">
                    <i class="fa fa-list"></i> الطلبات
                    <span class="badge badge-pill badge-warning">
                        <?php echo getOrderCount(1,'قيد التنفيذ'); ?>
                    </span>
                </a> 
                           </li>
                <?php if (!$auth->hasRole(\Delight\Auth\Role::EMPLOYEE)) { ?>
                <li class="nav-item">
                <a class="nav-link" href="pending_orders.php">
                    <i class="fa fa-hourglass-1"></i> الطلبات المنتظرة
                    <span class="badge badge-pill badge-green">
                        <?php 
                        if ($auth->hasRole(\Delight\Auth\Role::ADMIN))
                        echo getOrderCount(0,'في الانتظار');
                        else  if ($auth->hasRole(\Delight\Auth\Role::USER) || $auth->hasRole(\Delight\Auth\Role::EXTERN_USER))
                        echo getOrderCountUser(0);
                         ?>
                    </span>
                </a>                </li>
                                <?php } ?>
                
                <?php if (!$auth->hasRole(\Delight\Auth\Role::EMPLOYEE)) { ?>

                <li class="nav-item">
                <a class="nav-link" href="regected_orders.php"><i class="fa fa-ban"></i> الطلبات المرفوضة</a>
                </li>
                                              <?php } ?>

                <!-- <li class="nav-item">
                    <a class="nav-link" href="addClient.php"><i class="icon-pie-chart"></i> اضافة عميل جديد</a>
                </li> -->
                <!-- <li class="nav-item">
                    <a class="nav-link" href="addProduct.php"><i class="icon-pie-chart"></i> اضافة منتج جديد</a>
                </li> -->
                <?php if( !$auth->hasRole(\Delight\Auth\Role::EMPLOYEE)) { ?>

                <li class="nav-item">
                    <a class="nav-link" href="addOrder.php"><i class="fa fa-plus"></i> اضافة طلب جديد</a>
                </li>
                <?php } ?>

            </li>
                <?php if( $auth->hasRole(\Delight\Auth\Role::ADMIN)) { ?>

            <li class="nav-item nav-dropdown">
                    <a class="nav-link nav-dropdown-toggle" href="#"><i class="fa fa-line-chart "></i>التقارير</a>
                    <ul class="nav-dropdown-items">
                        <li class="nav-item">
                            <a class="nav-link" href="filial_report.php" target="_top"> <i class="fa fa-arrow-left"></i>  تقرير حسب الفرع</a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link" href="order_report.php" target="_top"><i class="fa fa-arrow-left"></i> تقرير حسب الطلب</a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link" href="user_report.php" target="_top"><i class="fa fa-arrow-left"></i>  تقرير حسب المستخدم</a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link" href="date_report.php" target="_top"><i class="fa fa-arrow-left"></i> تقرير حسب التاريخ</a>
                        </li>
                         <li class="nav-item">
                            <a class="nav-link" href="employee_report.php" target="_top"><i class="fa fa-arrow-left"></i> تقرير حسب الموظف</a>
                        </li>
                    </ul>
                </li> 
                <li class="nav-item">
                    <a class="nav-link" href="branches.php"><i class="fa fa-map"></i>الفروع </a>
                </li>
                <li class="nav-item">
                <a class="nav-link" href="opend_tickets.php"><i class="fa fa-map"></i>التذاكر </a>
                </li>
             <?php } ?>
             
             <?php if( $auth->hasRole(\Delight\Auth\Role::USER) || $auth->hasRole(\Delight\Auth\Role::EXTERN_USER)) { ?>

                 <li class="nav-item">
                    <a class="nav-link" href="create_ticket.php"><i class="fa fa-map"></i>  التذاكر </a>
                </li>
                <?php } ?>

            </ul>
        </nav>
    </div>
    <script>

document.addEventListener('DOMContentLoaded', function () {
    var dropdownElementList = [].slice.call(document.querySelectorAll('.dropdown-toggle'))
    var dropdownList = dropdownElementList.map(function (dropdownToggleEl) {
        return new bootstrap.Dropdown(dropdownToggleEl)
    })
});

 </script>
<!-- Inclusion de Bootstrap JS -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js"></script>
<script>



document.addEventListener("DOMContentLoaded", function () {
    // Initialize dropdown
    var dropdownElementList = [].slice.call(document.querySelectorAll('.dropdown-toggle'));
    var dropdownList = dropdownElementList.map(function (dropdownToggleEl) {
        return new bootstrap.Dropdown(dropdownToggleEl);
    });

    // Function to fetch notifications
    function fetchNotifications() {
        fetch('../AJAX/fetch_notifications.php')
            .then(response => response.json())
            .then(data => {
                if (data.status === 'success') {
                    const notificationDropdown = document.getElementById('notificationsDropdown');
                    const notificationBadge = notificationDropdown.querySelector('.badge');
                    
                    // Update the badge with the number of notifications
                    notificationBadge.textContent = data.data.length;

                    // Build the content for the dropdown with data-id attribute
                    let dropdownContent = '';
                    if (data.data.length > 0) {
                        data.data.forEach(function(notification) {
                            dropdownContent += `
                                <li class="dropdown-item" id="clickli" data-id="${notification.id}">
                                    <a href="ticket_messages.php?ticket_id=${notification.ticket_id}">
                                        ${notification.message}
                                    </a>
                                </li>`;
                        });
                    } else {
                        dropdownContent = '<li id="clickli" class="dropdown-item">لا توجد اية اشعارات</li>';
                    }
                    document.getElementById('notificationList').innerHTML = dropdownContent;

                    // Attach event listeners to each notification item
                    document.querySelectorAll('#clickli').forEach(item => {
                        item.addEventListener('click', function(event) {
                            event.preventDefault(); // Prevent default link behavior

                            // Retrieve the notification ID from data-id attribute
                            const ticketId = item.getAttribute('data-id');
                            
                            if (ticketId) {
                                // Send AJAX request to mark the notification as read
                                fetch('../AJAX/mark_as_read.php?id=' + ticketId)
                                    .then(response => response.json())
                                    .then(data => {
                                        if (data.success) {
                                        } else {
                                            console.log('Error marking notification as read');
                                        }
                                    });
                            } else {
                                console.log('Notification ID is missing');
                            }

                            // Optionally redirect after marking as read
                            const link = item.querySelector('a');
                            if (link && link.getAttribute('href') ) {
                                window.location.href = link.getAttribute('href');
                            }                        });
                    });
                }
            })
            .catch(error => console.error('Error fetching notifications:', error));
    }


    // Fetch notifications when the page loads
    fetchNotifications();

    // Periodically fetch notifications every 30 seconds
    setInterval(fetchNotifications, 3000); // 30 seconds
});

</script>