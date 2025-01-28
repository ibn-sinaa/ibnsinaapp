<?php
include('header.php');

// Vérifier si un ID de commande est fourni pour la modification
if (!isset($_GET['id'])) {
    echo "No order ID specified!";
    exit;
}

// Récupérer les détails de la commande depuis la base de données
$orderId = $_GET['id'];
$stmt = $db->prepare("
    SELECT orders.* , branches.* FROM orders 
    JOIN users ON users.id = orders.user_id 
    JOIN user_branches ON users.id = user_branches.user_id 
    JOIN branches ON branches.branch_id = user_branches.branch_id 
    WHERE order_id = :id
");
$stmt->execute(['id' => $orderId]);
$order = $stmt->fetch();


if (!$order) {
    echo "Order not found!";
    exit;
}

// Assurez-vous que $userId est défini (ajoutez la logique de récupération si nécessaire)
$userId = $order['user_id'];
$sql = "
    SELECT branch_name, branches.branch_id 
    FROM users 
    JOIN user_branches ON users.id = user_branches.user_id 
    JOIN branches ON branches.branch_id = user_branches.branch_id 
    WHERE users.id = :userId
";
$stmt = $db->prepare($sql);
$stmt->execute(['userId' => $userId]);
$row = $stmt->fetch(PDO::FETCH_ASSOC);

// Récupérer les étapes de la commande
$stepStmt = $db->prepare("
    SELECT step_name, order_steps.step_id, step_num 
    FROM order_steps 
    INNER JOIN steps ON steps.step_id = order_steps.step_id 
    WHERE order_id = :orderId
");
$stepStmt->execute(['orderId' => $orderId]);
$steps = $stepStmt->fetchAll(PDO::FETCH_ASSOC);

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
$stepStmt->execute(['orderId' => $orderId]);
$lastStep = $stepStmt->fetch(PDO::FETCH_ASSOC);

// Récupérer les IDs des étapes sélectionnées
$selectedSteps = [];
foreach ($steps as $step) {
    $selectedSteps[] = ['step_id' => $step['step_id'], 'step_name' => $step['step_name'], 'step_num' => $step['step_num']];
}
//////////////
// Récupérer les fichiers depuis la base de données
$existingFiles = [];
$fileIndex = 0;

$fileQuery = "
    SELECT attachment_file 
    FROM ordre_files 
    WHERE order_id = :orderId
";
$fileStmt = $db->prepare($fileQuery);
$fileStmt->execute(['orderId' => $orderId]);

while ($row = $fileStmt->fetch(PDO::FETCH_ASSOC)) {
    $existingFiles[] = [
        'index' => $fileIndex++, // Index incrémental pour chaque fichier
        'name' => '<a href="' . htmlspecialchars($row['attachment_file']) . '" target="_blank">' . htmlspecialchars($row['attachment_file']) . '</a>' ,
        'file_name'=> htmlspecialchars($row['attachment_file']),
    ];
}
// Passer les fichiers à JavaScript
echo "<script>let selectedFiles = " . json_encode($existingFiles) . ";</script>";
?>
<!-- Code HTML pour le formulaire d'édition -->
<!-- SweetAlert2 CSS -->
<link href="https://cdn.jsdelivr.net/npm/sweetalert2@11/dist/sweetalert2.min.css" rel="stylesheet">

<!-- SweetAlert2 JS -->
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
<!-- Select2 CSS -->
<link href="https://cdn.jsdelivr.net/npm/select2@4.1.0/dist/css/select2.min.css" rel="stylesheet" />

<!-- Select2 JS -->
<script src="https://cdn.jsdelivr.net/npm/select2@4.1.0/dist/js/select2.min.js"></script>
<style>
    select {
        width: 100%;
        padding: 10px;
        border: 1px solid #ccc;
        border-radius: 5px;
        font-size: 16px;
        background: #f9f9f9;
        box-shadow: inset 0 1px 3px rgba(0, 0, 0, 0.1);
    }

    select:focus {
        outline: none;
        border-color: #007bff;
        background: #fff;
    }

    button {
        margin-top: 10px;
        padding: 10px 20px;
        background-color: #007bff;
        color: white;
        border: none;
        border-radius: 5px;
        cursor: pointer;
    }

    button:hover {
        background-color: #0056b3;
    }
 
/* Nom de l'étape aligné à gauche */
#selected-steps li span.step-name {
    flex-grow: 1; /* Permet à l'élément de s'étendre et occuper l'espace disponible */
    text-align: left; /* Aligner le texte à gauche */
}

/* Boutons de déplacement */
button.move-up, button.move-down {
    font-size: 12px; /* Réduire la taille des flèches */
    margin-right: 5px; /* Espacement entre les boutons de déplacement */
    padding: 2px 5px; /* Petits boutons */
}

 
/* Ajouter un effet de survol sur le bouton de suppression */
button.remove-step:hover {
    background-color: darkred;
}

/* Espacement entre les boutons de déplacement et le bouton de suppression */
#selected-steps li button {
    margin-right: 5px;
}

.but{

    display: flex;
    justify-content: flex-end; /* Aligner les éléments à droite (les boutons) */
    align-items: center;
   
}
</style>

<style>
    .form-control {
        margin-bottom: 10px;
    }
    .steps-container {
        margin-top: 20px;
    }
    .selected-steps {
        list-style-type: none;
        padding: 0;
    }
    .selected-steps li {
        background-color: #f8f9fa;
        padding: 10px;
        margin: 5px 0;
        border: 1px solid #ced4da;
        border-radius: 4px;
        display: flex;
        justify-content: space-between;
        align-items: center;
    }
    
    .step-name {
        font-weight: bold;
            color: #ff6600;
            font-style: bold;
            padding-right: 10px;
        }
    .remove-step {
        background-color: #ff4d4d;
        color: white;
        border: none;
        padding: 5px;
        cursor: pointer;
        border-radius: 50%;
        width: 25px;
        height: 25px;
        display: flex;
        justify-content: center;
        align-items: center;
    }

    .disabled-option {
    background-color: #F95454;
    color: white; /* Facultatif : pour ajuster la couleur du texte */
}

</style>
<style>
        /* Conteneur des employés sélectionnés */
        .selected-employees {
            display: flex;
            flex-wrap: wrap;
            gap: 10px;
            margin-top: 10px;
            margin-bottom: 10px;

        }

        /* Style des tags d'employés */
        .employee-tag {
            display: flex;
            align-items: center; /* Centrer verticalement */
            background-color: #17a2b8; /* Couleur bleue agréable */
            color: white;
            padding: 5px 10px;
            border-radius: 20px;
            font-size: 14px;
            box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
        }

        /* Style du nom de l'employé */
        .employee-tag span {
            margin-right: 8px;
        }

        /* Bouton de suppression */
        .employee-tag .remove-btn {
            background: rgba(255, 255, 255, 0.2);
            border: none;
            border-radius: 50%;
            cursor: pointer;
            width: 10px;
            height: 20px;
            display: flex;
            align-items: center;
            justify-content: center;
         }

        .employee-tag .remove-btn:hover {
            background: rgba(255, 255, 255, 0.4);
        }

        .employee-tag .remove-btn::before {
            content: '×';
            font-size: 14px;
            line-height: 1;
        }

        /* Style du formulaire */
       
        label {
            display: block;
            margin-bottom: 5px;
            font-weight: bold;
        }

        select {
            width: 100%;
            padding: 10px;
            border: 1px solid #ccc;
            border-radius: 5px;
            font-size: 16px;
            background: #fff;
            box-shadow: inset 0 1px 3px rgba(0, 0, 0, 0.1);
            margin-bottom: 10px;
        }

        button {
            padding: 10px 20px;
            background-color: #28a745; /* Vert pour "حفظ" */
            color: white;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            font-size: 16px;
            transition: background-color 0.3s;
        }

        button:hover {
            background-color: #218838;
        }
    </style>
<body class="navbar-fixed sidebar-nav fixed-nav">
    <main class="main">
        <ol class="breadcrumb">
            <li class="breadcrumb-item active">تعديل الطلب</li>
        </ol>

        <div class="container-fluid">
            <div class="animated fadeIn">
                <div class="row">
                    <div class="col-md-12">
                        <div class="card">
                            <div class="card-header">
                                <strong>تعديل الطلب</strong>
                            </div>
                            <div class="card-block">
                            <?php if($auth->hasRole(\Delight\Auth\Role::ADMIN)) {
                                $orderId = htmlspecialchars($orderId); // ID de la commande
                                $stmt = $db->prepare("
                                    SELECT  u.username 
                                    FROM order_employees ue
                                    JOIN users u ON ue.employee_id = u.id
                                    WHERE ue.order_id = :orderId
                                ");
                                $stmt->execute([':orderId' => $orderId]);
                                $assignedEmployees = $stmt->fetchAll(PDO::FETCH_ASSOC);
                                 ?>

                                <div id="assignedEmployeesList" class="selected-employees">
    <?php if (!empty($assignedEmployees)) : ?>
        <?php foreach ($assignedEmployees as $employee) : ?>
            <div class="employee-tag">
                <?= htmlspecialchars($employee['username']) ?>
                <!-- <button type="button" class="remove-employee btn btn-danger btn-sm" data-employee-id="<?=$employee['id'] ?>">x</button> -->
            </div>
        <?php endforeach; ?>
    <?php else : ?>
        <p>لم يتم اختيار موظفين لهذه الطلبية.</p>
    <?php endif; ?>
</div>

                            <form id="assignEmployeesForm" data-order-id="<?= htmlspecialchars($orderId) ?>">
                                    <label class="col-md-3 form-control-label" for="employeeSelect">اختر الموظفين:</label>
                                    <div class="col-md-6">

                                <select id="employeeSelect" class="form-control" >
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
                                <button type="button" id="submitButton" class="btn btn-primary">حفظ</button>
                                </div>
                                <div class="col-md-12">
                                    <div id="selectedEmployees" class="selected-employees">
                                        <!-- Les employés ajoutés apparaîtront ici -->
                                    </div>
                                </div>
                                    <input type="hidden" name="employees[]" id="employeeInput">


                            </form>

                            <!-- Zone pour afficher les messages -->
                            <div style="margin-bottom: 60px;"></div> <!-- Espacement entre les formulaires -->

                            <?php } ?>

                                <form method="post" enctype="multipart/form-data" class="form-horizontal" id="edit-order-form">
                                    <input name="order_id" class="form-control" type="hidden" value="<?= $order['order_id']; ?>">
                                    
                                    <!-- الفرع (Branch) -->
                                    <div class="form-group row">
                                        <label class="col-md-3 form-control-label" for="branch">الفرع</label>
                                        <div class="col-md-9">
                                            <select id="branch" name="branch" class="form-control" disabled>
                                                <option value="<?= $order['branch_id'] ?>"> <?= $order['branch_name'] ?></option>
                                                 
                                            </select>
                                        </div>
                                    </div>

                                    <!-- المرسل (Sender) -->
                                    <div class="form-group row">
                                        <label class="col-md-3 form-control-label" for="sender">المرسل</label>
                                        <div class="col-md-9">
                                            <input type="text" id="sender" name="sender" class="form-control" placeholder="أدخل اسم المرسل" disabled value="<?= htmlspecialchars($order['sender']); ?>">
                                        </div>
                                    </div>

                                    <!-- تاريخ الطلب (Order Date) -->
                                    <div class="form-group row">
                                        <label class="col-md-3 form-control-label" for="order-date">تاريخ الانشاء</label>
                                        <div class="col-md-9">
                                            <input type="datetime-local" id="order-date" name="order-date" class="form-control" disabled value="<?= date('Y-m-d\TH:i', strtotime($order['created_at'])); ?>">
                                        </div>
                                    </div>


                                    <!-- تاريخ التسليم (Delivery Date) -->
                                    <div class="form-group row">
                                        <label class="col-md-3 form-control-label" for="delivery-date">تاريخ التسليم</label>
                                        <div class="col-md-9">
                                            <input type="date"  <?php if(!$auth->hasRole(\Delight\Auth\Role::ADMIN)) echo 'readonly'?> id="delivery-date" name="delivery_date" class="form-control"  value="<?= ($order['delivery_date']); ?>">
                                        </div>
                                    </div>

                                    <!-- تفاصيل الطلب (Order Details) -->
                                    <div class="form-group row">
                                        <label class="col-md-3 form-control-label" for="order-details">تفاصيل الطلب</label>
                                        <div class="col-md-9">
                                            <textarea id="order-details"  <?php if($auth->hasRole(\Delight\Auth\Role::EMPLOYEE)) echo 'readonly'?> name="order-details" class="form-control" rows="3" placeholder="أدخل تفاصيل الطلب" ><?= ($order['details']); ?></textarea>
                                        </div>
                                    </div>
                                    
                                    <!-- مدة التنفيذ (Execution Time) -->
                                    <div class="form-group row">
                                        <label class="col-md-3 form-control-label" for="execution-time"> الكمية</label>
                                        <div class="col-md-9">
                                            <input type="text" id="execution-time" name="execution-time"  <?php if(!$auth->hasRole(\Delight\Auth\Role::ADMIN)) echo 'readonly'?> class="form-control"  placeholder="أدخل  الكمية" required value="<?= htmlspecialchars($order['execution_time']); ?>">
                                        </div>
                                    </div>
                                   
                                                    <!-- Formulaire avec champ de téléchargement de fichiers -->
                                                    <div class="form-group row">
                                                <label class="col-md-3 form-control-label" for="order-files">ملفات الطلب</label>
                                                <div class="col-md-9">
                                                <input type="file" id="order-files" name="order-files[]" class="form-control" 
                                                <?php if($auth->hasRole(\Delight\Auth\Role::EMPLOYEE)) echo 'disabled'; ?> 
                                                multiple onchange="addFiles()">

                                                    <!-- Liste des fichiers sélectionnés -->
                                                    <div id="file-list" style="margin-top: 10px;">
                                                    <?php if (!empty($existingFiles)): ?>
                                                        <?php foreach ($existingFiles as $file): ?>
                                                            <div class="file-item" style="display: flex; align-items: center; margin-bottom: 5px;">
                                                                <span style="margin-right: 10px;"><?= $file['name']; ?></span>
                                                                <?php if ($auth->hasRole(\Delight\Auth\Role::ADMIN)): // Bouton visible uniquement pour les administrateurs ?>
                                                                    <button 
                                                            type="button" 
                                                            class="btn btn-danger btn-sm" 
                                                            onclick="deleteFile(<?= $order['order_id']; ?>, '<?= ($file['file_name']); ?>', <?= $file['index']; ?>)">
                                                            حذف
                                                        </button>
                                                                <?php endif; ?>
                                                            </div>
                                                        <?php endforeach; ?>


                                                    <?php else: ?>
                                                        <div>لا توجد ملفات مرفقة</div>
                                                    <?php endif; ?>
                                                    </div>                                    
                                                </div>
                                            </div>

                                    <div class="form-group row">
                                    <label class="col-md-3 form-control-label" for="notes">ملاحظات</label>
                                    <div class="col-md-9">
                                        <textarea id="notes" name="notes" <?php if($auth->hasRole(\Delight\Auth\Role::EMPLOYEE)) echo 'readonly'?> class="form-control" rows="3" placeholder="أدخل ملاحظات إضافية"><?= ($order['notes']); ?></textarea>
                                    </div>
                                </div>
                                  
                                    <!-- السعر (Price) -->
                                    <div class="form-group row">
                                        <label class="col-md-3 form-control-label" for="price">السعر</label>
                                        <div class="col-md-9">
                                            <input type="number" id="price" name="price" class="form-control"  <?php if(!$auth->hasRole(\Delight\Auth\Role::ADMIN)) echo 'readonly'?> placeholder="أدخل السعر" required step="1" value="<?= htmlspecialchars($order['price']); ?>">
                                        </div>
                                    </div>

                                    <!-- تكرار الطلب (Request Repetition) -->
                                    <div class="form-group row">
                                        <label class="col-md-3 form-control-label" for="request-repetition">عدد مرات التكرار</label>
                                        <div class="col-md-9">
                                            <input type="number" id="request-repetition"  <?php if(!$auth->hasRole(\Delight\Auth\Role::ADMIN)) echo 'readonly'?> name="repeated" class="form-control" placeholder="أدخل عدد مرات التكرار" min="1" required value="<?= htmlspecialchars($order['repeated']); ?>">
                                        </div>
                                    </div>

                                    <!-- حالة الطلب (Order Status) -->
                                   <!-- حالة الطلب (Order Status) -->
                            <div class="form-group row">
                                <label class="col-md-3 form-control-label"   for="status">حالة الطلب</label>
                                <div class="col-md-9">
                                    <select id="status" <?php if(!$auth->hasRole(\Delight\Auth\Role::ADMIN)) echo 'readonly'?> name="status" class="form-control" required>
                                        <option value="في الانتظار" <?= ($order['status'] == 'في الانتظار') ? 'selected' : ''; ?>>في الانتظار</option>
                                        <option value="في انتظار التعميد"<?= ($order['status'] == 'في انتظار التعميد') ? 'selected' : ''; ?>>في انتظار التعميد</option>
                                        <option value="قيد التنفيذ" <?= ($order['status'] == 'قيد التنفيذ') ? 'selected' : ''; ?>>قيد التنفيذ</option>
                                        <option value="جاهز" <?= ($order['status'] == 'جاهز') ? 'selected' : ''; ?>>جاهز</option>
                                        <option value="تم ارسال الطلب" <?= ($order['status'] == 'تم ارسال الطلب') ? 'selected' : ''; ?>>تم إرسال الطلب</option>
                                    </select>
                                </div>
                            </div>

                            <?php if(!$auth->hasRole(\Delight\Auth\Role::EXTERN_USER))
                                    {
                                        ?>        
                                    <!-- Step Selection -->
                                     <div class="form-group row">
                                        <label class="col-md-3 form-control-label" for="available-steps">اختر خطوة:</label>
                                        <div class="col-md-9">
                                            <?php
                                            // Fetch and display step options by type
                                            try {
                                                $sql = "SELECT step.step_id, step.step_name, step_type.type_name AS type_name 
                                                        FROM steps step 
                                                        JOIN step_types step_type ON step.type_id = step_type.type_id 
                                                        ORDER BY  step.`step_id` ASC";
                                                $stmt = $db->prepare($sql);
                                                $stmt->execute();
                                                $stepsByType = [];
                                                while ($row = $stmt->fetch(PDO::FETCH_ASSOC)) {
                                                    $stepsByType[$row['type_name']][] = $row;
                                                }
                                                echo '<select id="available-steps"  class="form-control">';
                                                foreach ($stepsByType as $type => $steps) {
                                                    echo '<optgroup label="' . htmlspecialchars($type) . '">';
                                                    foreach ($steps as $step) {
                                                        echo '<option value="' . htmlspecialchars($step['step_id']) . '">' . htmlspecialchars($step['step_name']) . '</option>';


                                                    }
                                                    echo '</optgroup>';
                                                }
                                                echo '</select>';
                                            } catch (Exception $e) {
                                                echo "Error fetching steps: " . $e->getMessage();
                                            }
                                            ?>
                                            <button type="button" class="btn btn-primary" onclick="addStep()">إضافة خطوة</button>
                                        </div>
                                    </div>
                                    
                               
                                            <!-- Liste des étapes sélectionnées -->
                                    <div class="form-group row">
                                        <label class="col-md-3 form-control-label">الخطوات المختارة:</label>
                                        <div class="col-md-9">
                                        <ul id="selected-steps" class="selected-steps">
                                            <?php foreach ($selectedSteps as $step): ?>
                                                <li>
                                                    <?= htmlspecialchars($step['step_name']); ?>
                                                    <span class="but">
                                                    <?php  if ($auth->hasRole(\Delight\Auth\Role::ADMIN)) {?>
                                                        <!-- Afficher les boutons de déplacement si l'utilisateur est un admin -->
                                                        <button type="button" class="move-up" onclick="moveStepUp(<?= array_search($step, $selectedSteps); ?>)">↑</button>
                                                        <button type="button" class="move-down" onclick="moveStepDown(<?= array_search($step, $selectedSteps); ?>)">↓</button>
                                                    <?php }?>

                                                    <button type="button" class="remove-step" onclick="removeStep(<?= array_search($step, $selectedSteps); ?>)">x</button>
                                                    <span>
                                                </li>
                                            <?php endforeach; ?>
                                        </ul>
                                        </div>
                                    </div>

                                              <!-- Liste des étapes sélectionnées -->
                                    <div class="form-group row">
                                                <label class="col-md-3 form-control-label">
                                                    الخطوة الحالية:
                                                    <span class="step-name"> 
                                                    <?php 
                                                        if (isset($lastStep['step_name'])) {
                                                            echo htmlspecialchars($lastStep['step_name']); 
                                                        } else {
                                                            echo ""; // or any appropriate default message
                                                        }
                                                    ?>
                                                    </span>
                                                </label>
                                        <div class="col-md-9">

                                        <select id="current_step" name="current_step"  class="form-control" required> 
                                        <option value="0" selected disabled> اختر خطوة</option>
                                       <?php 
                                                    if (isset($selectedSteps) && is_array($selectedSteps)) {
                                                        foreach ($selectedSteps as $step) {
                                                            echo($lastStep['step_num']);
                                                            if ($step['step_num'] <= $lastStep['step_num']) {
                                                                echo '<option disabled value="' . htmlspecialchars($step['step_id']) . '" class="disabled-option">' . htmlspecialchars($step['step_name']) . '</option>';
                                                            } else {
                                                                echo '<option value="' . htmlspecialchars($step['step_id']) . '">' . htmlspecialchars($step['step_name']) . '</option>';
                                                            }
                                                        }
                                                    }
                                                    ?>

                                      
                                        </select>
                                            
                                    </div>
                                    </div>
                                  
                                    <input type="hidden" id="order_steps" name="order_steps" value="<?= htmlspecialchars(json_encode($selectedSteps)); ?>">
                                    <?php
                                    }
                                    ?>
                                    <div class="form-group">
                                        <label>
                                            <input type="checkbox" id="confirm-checkbox" required>
                                            اتعهد ان الطلب مضاف بكامل تفاصيله واتحمل المسؤولية اذا تبين وجود أي نقص.
                                        </label>
                                    </div>
                                   
                                </form>
                            </div>
                            <div class="card-footer">
                               
                                        <button type="submit" id="submit-order" class="btn btn-success">تعديل الطلب</button>
                                       <button class="btn btn-danger" > <a href="orders.php">إلغاء</a></button>
                                </div>
                                
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <script src="js/libs/jquery.min.js"></script>
    <script src="js/libs/tether.min.js"></script>
    <script src="js/libs/bootstrap.min.js"></script>

    <script src="js/app.js"></script>
       <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
       <script>

       <?php if($auth->hasRole(\Delight\Auth\Role::ADMIN)) { ?>

            document.getElementById('assignedEmployeesList').addEventListener('click', function (e) {
    if (e.target.classList.contains('remove-employee')) {
        const employeeId = e.target.dataset.employeeId;
        const orderId = document.getElementById('assignEmployeesForm').dataset.orderId;

        fetch('remove_employee.php', {
            method: 'POST',
            headers: { 'Content-Type': 'application/json' },
            body: JSON.stringify({ orderId, employeeId })
        })
        .then(response => response.json())
        .then(data => {
            if (data.success) {
                // Supprimer l'employé de la liste affichée
                e.target.parentElement.remove();
            } else {
                alert('فشل في إزالة الموظف.');
            }
        });
    }
});

document.getElementById('submitButton').addEventListener('click', function () {
    const form = document.getElementById('assignEmployeesForm');
    const orderId = form.dataset.orderId;
    const selectedEmployees = Array.from(form.employees.selectedOptions).map(option => option.value);

    fetch('../AJAX/update_employ_order.php', {
        method: 'POST',
        headers: {
            'Content-Type': 'application/json',
        },
        body: JSON.stringify({
            orderId: orderId,
            employees: selectedEmployees,
        }),
    })
        .then(response => response.json())
        .then(data => {
            if (data.success) {
                Swal.fire({
                    title: 'تم التحديث بنجاح!',
                    text: 'تم تحديث الموظفين المرتبطين بالطلب.',
                    icon: 'success',
                    confirmButtonText: 'حسنًا',
                    timer: 5000,
                    timerProgressBar: true,
                    toast: true,
                    position: 'top-end',
                    showConfirmButton: false,
                });
            } else {
                Swal.fire({
                    title: 'خطأ',
                    text: 'حدث خطأ أثناء التحديث.',
                    icon: 'error',
                    confirmButtonText: 'إغلاق',
                });
            }
        })
        .catch(error => {
            console.error('Erreur:', error);
            Swal.fire({
                title: 'خطأ غير متوقع',
                text: 'يرجى المحاولة مرة أخرى لاحقًا.',
                icon: 'error',
                confirmButtonText: 'إغلاق',
            });
        });
});
document.addEventListener('DOMContentLoaded', () => {
        const employeeSelect = document.getElementById('employeeSelect');
        const selectedEmployees = document.getElementById('selectedEmployees');
        const employeeInput = document.getElementById('employeeInput');
        const submitButton = document.getElementById('submitButton');

        let selectedEmployeeIds = []; // Stocke les IDs des employés sélectionnés

        // Lorsqu'un employé est sélectionné
        employeeSelect.addEventListener('change', () => {
            const employeeId = employeeSelect.value;
            const employeeName = employeeSelect.options[employeeSelect.selectedIndex].text;

            // Vérifier si l'employé a déjà été ajouté
            if (selectedEmployeeIds.includes(employeeId)) {
                Swal.fire({
                    title: 'خطأ',
                    text: 'تم اختيار هذا الموظف بالفعل.',
                    icon: 'error',
                    confirmButtonText: 'حسنًا',
                             timer: 3000,
                            timerProgressBar: true,
                            toast: true,
                            position: 'top-end',
                            showConfirmButton: false,
                });
                return;
            }

            // Ajouter l'ID de l'employé dans la liste
            selectedEmployeeIds.push(employeeId);

            // Créer un tag pour l'employé sélectionné
            const employeeTag = document.createElement('div');
            employeeTag.classList.add('employee-tag');
            employeeTag.setAttribute('data-id', employeeId);
            employeeTag.innerHTML = `
                <span>${employeeName}</span>
                <button class="remove-btn" title="إزالة"></button>
            `;

            // Ajouter le tag dans le conteneur
            selectedEmployees.appendChild(employeeTag);

            // Mettre à jour l'input caché avec les IDs sélectionnés
            employeeInput.value = selectedEmployeeIds.join(',');

            // Réinitialiser la sélection
            employeeSelect.value = '';
        });

        // Gérer la suppression d'un employé
        selectedEmployees.addEventListener('click', (e) => {
            if (e.target.classList.contains('remove-btn')) {
                const employeeTag = e.target.parentElement;
                const employeeId = employeeTag.getAttribute('data-id');

                // Supprimer l'employé de la liste des IDs sélectionnés
                selectedEmployeeIds = selectedEmployeeIds.filter(id => id !== employeeId);

                // Mettre à jour l'input caché
                employeeInput.value = selectedEmployeeIds.join(',');

                // Supprimer le tag de l'employé
                employeeTag.remove();
            }
        });
// Initialiser Select2
$(document).ready(function () {
    $('#employees').select2({
        placeholder: 'اختر الموظفين',
        allowClear: true,
        width: '100%', // Ajuste la largeur
    });
});

        // Soumettre le formulaire via AJAX avec SweetAlert2 notifications
        submitButton.addEventListener('click', function () {
            const orderId = this.closest('form').dataset.orderId;
            const employees = selectedEmployeeIds;

            // Validation de la sélection
            if (employees.length === 0) {
                Swal.fire({
                    title: 'خطأ',
                    text: 'يرجى اختيار موظف واحد على الأقل.',
                    icon: 'error',
                    confirmButtonText: 'حسنًا',
                            timer: 3000,
                            timerProgressBar: true,
                            toast: true,
                            position: 'top-end',
                            showConfirmButton: false,
                                        });
                return;
            }

            // Envoyer les données via AJAX
            fetch('../AJAX/update_employ_order.php', {
                method: 'POST',
                headers: {
                    'Content-Type': 'application/json',
                },
                body: JSON.stringify({
                    orderId: orderId,
                    employees: employees,
                }),
            })
                .then(response => response.json())
                .then(data => {
                    if (data.success) {
                        Swal.fire({
                            title: 'تم التحديث بنجاح!',
                            text: 'تم تحديث الموظفين المرتبطين بالطلب.',
                            icon: 'success',
                            confirmButtonText: 'حسنًا',
                            timer: 3000,
                            timerProgressBar: true,
                            toast: true,
                            position: 'top-end',
                            showConfirmButton: false,
                        });
                    } else {
                        Swal.fire({
                            title: 'خطأ',
                            text: data.message || 'حدث خطأ أثناء التحديث.',
                            icon: 'error',
                            confirmButtonText: 'إغلاق',
                             timer: 3000,
                            timerProgressBar: true,
                            toast: true,
                            position: 'top-end',
                            showConfirmButton: false,
                        });
                    }
                })
                .catch(error => {
                    console.error('Erreur:', error);
                    Swal.fire({
                        title: 'خطأ غير متوقع',
                        text: 'يرجى المحاولة مرة أخرى لاحقًا.',
                        icon: 'error',
                        confirmButtonText: 'إغلاق',
                             timer: 3000,
                            timerProgressBar: true,
                            toast: true,
                            position: 'top-end',
                            showConfirmButton: false,
                    });
                });
        });
    });
// Vérifier si l'utilisateur est un administrateur
 
// Fonction pour afficher la liste des étapes sélectionnées
function renderSelectedSteps() {
    const stepList = $('#selected-steps');
    stepList.empty(); // Vider la liste avant de la réinitialiser

    selectedSteps.forEach((step, index) => {
        const li = $('<li>').attr('data-value', step.step_id).text(step.step_name);
        const span = $('<span>').addClass('but')
        // Si l'utilisateur est un administrateur, ajouter des boutons pour déplacer les étapes
             const moveUpButton = $('<button>').addClass('move-up').text('↑').click(() => moveStepUp(index));
            const moveDownButton = $('<button>').addClass('move-down').text('↓').click(() => moveStepDown(index));
            
            span.append(moveUpButton).append(moveDownButton);
        

        // Ajouter un bouton pour supprimer l'étape
        const removeButton = $('<button>').addClass('remove-step').text('×').click(() => removeStep(step.step_id));
        span.append(removeButton);
        li.append(span);
        stepList.append(li);
    });

    // Mettre à jour la valeur cachée pour refléter les étapes sélectionnées
    $('#order_steps').val(selectedSteps.map(step => step.step_id).join(','));
}

// Fonction pour déplacer une étape vers le haut
function moveStepUp(index) {
    if (index > 0) { // S'assurer qu'on ne dépasse pas le début du tableau
        // Échanger les positions des étapes dans le tableau
        [selectedSteps[index], selectedSteps[index - 1]] = [selectedSteps[index - 1], selectedSteps[index]];
        renderSelectedSteps(); // Mettre à jour l'affichage
    }
}

// Fonction pour déplacer une étape vers le bas
function moveStepDown(index) {
    if (index < selectedSteps.length - 1) { // S'assurer qu'on ne dépasse pas la fin du tableau
        // Échanger les positions des étapes dans le tableau
        [selectedSteps[index], selectedSteps[index + 1]] = [selectedSteps[index + 1], selectedSteps[index]];
        renderSelectedSteps(); // Mettre à jour l'affichage
    }
}



<?php } ?>

// Initialisation de la variable selectedFiles avec les fichiers existants
// Fonction pour ajouter des fichiers sélectionnés
function addFiles() {
    const input = document.getElementById('order-files');

    // Ajoute les nouveaux fichiers à la liste des fichiers sélectionnés
    Array.from(input.files).forEach(file => {
        selectedFiles.push({
            file_name: file.name,
            file: file
        });
        console.log(file.name);
    });

    // Met à jour l'affichage
    displaySelectedFiles();
}

// Fonction pour afficher la liste des fichiers sélectionnés// Function to display the list of files (existing + new)
function displaySelectedFiles() {
    const fileListDiv = document.getElementById('file-list');
    fileListDiv.innerHTML = ''; // Clear the list

    // Display all selected files
    selectedFiles.forEach((file, index) => {
        const fileItem = document.createElement('div');
        fileItem.className = 'file-item';
        fileItem.style.display = 'flex';
        fileItem.style.alignItems = 'center';
        fileItem.style.marginBottom = '5px';
        fileItem.id = `file-item-${index}`; // Unique ID for each file item

        // Create a span to display the file name
        const fileName = document.createElement('span');
        fileName.textContent = file.file_name; // Display the file name
        fileName.style.marginRight = '10px';
        fileItem.appendChild(fileName);

        // Check if the user is an admin and add the delete button
        <?php if ($auth->hasRole(\Delight\Auth\Role::ADMIN)): ?>
        const orderId = <?= json_encode($order['order_id'] ?? null); ?>;
        const filePath = <?= json_encode($file['file'] ?? null); ?>;

        const removeButton = document.createElement('button');
        removeButton.type = 'button';
        removeButton.className = 'btn btn-danger btn-sm';
        removeButton.textContent = 'حذف'; // "Delete" in Arabic
        removeButton.onclick = () => {
            deleteFile(orderId, filePath, index); // Call the delete function
            selectedFiles.splice(index, 1); // Remove file from the list
            displaySelectedFiles(); // Refresh the list
        };

        fileItem.appendChild(removeButton);
        <?php endif; ?>

        // Add the file item to the file list container
        fileListDiv.appendChild(fileItem);
    });
}

// Fonction pour supprimer un fichier
function removeFile(index) {
    // Supprime le fichier de la liste selectedFiles
    selectedFiles.splice(index, 1);

    // Met à jour l'affichage
    displaySelectedFiles();
}
            let selectedSteps = <?= json_encode($selectedSteps); ?>; // Initialize selected steps from PHP

            function addStep() {
    const selectedOption = $('#available-steps option:selected');
    const stepId = selectedOption.val();
    const stepName = selectedOption.text();

    // Vérification que l'ID de l'étape est valide et qu'il n'a pas déjà été ajouté
    if (stepId && !selectedSteps.find(step => step.step_id === stepId)) {
        // Créez l'objet de l'étape à ajouter
        const newStep = { step_id: stepId, step_name: stepName };
        console.log(selectedSteps);
        // Trouver l'index de la dernière étape par défaut (ID "40")
        const lastDefaultStepIndex = selectedSteps.findIndex(step => step.step_id === 40);
        console.log(lastDefaultStepIndex);
        // Si l'étape par défaut existe, insérez la nouvelle étape avant celle-ci
        if (lastDefaultStepIndex !== -1) {
            selectedSteps.splice(lastDefaultStepIndex, 0, newStep); // Insérer avant l'index de "40"
        } else {
            // Si la dernière étape par défaut n'est pas trouvée, ajoutez à la fin
            selectedSteps.push(newStep);
        }

        // Rendre la liste des étapes sélectionnées
        renderSelectedSteps();
    }
}


    <?php if(!$auth->hasRole(\Delight\Auth\Role::ADMIN)) { ?>

            function renderSelectedSteps() {
                $('#selected-steps').empty();
                selectedSteps.forEach((step, index) => {
                    $('#selected-steps').append(`
                        <li>
                            ${step.step_name}
                            <button type="button" class="remove-step" onclick="removeStep(${index})">x</button>
                        </li>
                    `);
                });
                $('#order_steps').val(JSON.stringify(selectedSteps)); // store the selected steps in a hidden field
            }


            <?php } ?>
            function removeStep(index) {
                selectedSteps.splice(index, 1);
                renderSelectedSteps();
            }

            
            $(document).ready(function() {
            $('#submit-order').click(function(e) {
                e.preventDefault();
                
                            var checkbox = document.getElementById('confirm-checkbox');
            if (!checkbox.checked) {
                event.preventDefault(); // Annule l'envoi du formulaire
                Swal.fire({
                title: 'تنبيه!',
                text: 'يرجى التأكيد بأن الطلب مضاف بكامل تفاصيله.',
                icon: 'warning',
                confirmButtonText: 'حسنًا',
                confirmButtonColor: '#3085d6'
            });
            }
            else{
                var formData = new FormData($('#edit-order-form')[0]);
                formData.append('order_steps', JSON.stringify(selectedSteps));
                       // Ajouter les fichiers sélectionnés à FormData
                       selectedFiles.forEach(file => {
                            formData.append('files[]', file);
                        });
                $.ajax({
                    url: '../AJAX/process_edit_order.php',
                    type: 'POST',
                    data: formData,
                    contentType: false,
                    processData: false,
                    success: function(response) {
                    window.location.href = 'orders.php?edit_success=true';

                    },
                    error: function(jqXHR, textStatus, errorThrown) {
                        console.log('Error: ' + textStatus + ' - ' + errorThrown);
                    }
                });
            }
            });
         });
         function deleteFile(orderId, fileName, fileIndex) {
    Swal.fire({
        title: 'هل أنت متأكد؟',
        text: 'لن تتمكن من التراجع عن هذا الإجراء!',
        icon: 'warning',
        showCancelButton: true,
        confirmButtonColor: '#d33',
        cancelButtonColor: '#3085d6',
        confirmButtonText: 'نعم، احذف!',
        cancelButtonText: 'إلغاء',
        customClass: {
            confirmButton: 'swal-custom-confirm'
        }
    }).then((result) => {
        if (result.isConfirmed) {
            // Effectuer la requête AJAX pour supprimer le fichier
            $.ajax({
                url: '../AJAX/delete_file.php', // Script PHP dédié à la suppression
                type: 'POST',
                data: {
                    order_id: orderId,
                    file_name: fileName
                },
                success: function(response) {
                    console.log(response);
                    if (response.success) {
                        Swal.fire({
                            title: 'تم الحذف بنجاح!',
                            text: 'تم حذف الملف بنجاح.',
                            icon: 'success',
                            confirmButtonColor: '#3085d6',
                            confirmButtonText: 'حسنًا',
                            timer: 3000,
                            timerProgressBar: true,
                            toast: true,
                            position: 'top-end',
                            showConfirmButton: false
                        });
                        selectedFiles.splice(fileIndex, 1);
                        displaySelectedFiles(); // Mettre à jour l'affichage
                    } else {
                        Swal.fire({
                            title: 'خطأ!',
                            text: response.message || 'حدث خطأ أثناء حذف الملف.',
                            icon: 'error',
                            confirmButtonColor: '#3085d6',
                            confirmButtonText: 'حسنًا'
                        });
                    }
                },
                error: function(jqXHR, textStatus, errorThrown) {
                    console.error('Error: ' + textStatus + ' - ' + errorThrown);
                    Swal.fire({
                        title: 'خطأ!',
                        text: 'تعذر حذف الملف.',
                        icon: 'error',
                        confirmButtonColor: '#3085d6',
                        confirmButtonText: 'حسنًا'
                    });
                }
            });
        }
    });
}

        </script>
 
<script>

</script>
        
    </main>
</body>

 
 