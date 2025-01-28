<?php include('header.php') ;?>
<style>
    .form-control {
        margin-bottom: 10px;
    }

    /* Style pour les étapes sélectionnées */
    .steps-container {
        margin-top: 20px;
    }

    .selected-steps {
        list-style-type: none;
        padding: 0;
    }
    #progress-container {
    width: 100%;
    background-color: #ddd;
    margin-top: 10px;
}

#progress-bar {
    height: 20px;
    background-color: #4caf50;
    text-align: center;
    color: white;
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
</style>

<?php

$sql = "SELECT branch_name,branches.branch_id FROM users join user_branches on users.id=user_branches.user_id join branches on branches.branch_id = user_branches.branch_id where users.id = $userId;  ";

// Préparation et exécution de la requête
$stmt = $db->prepare($sql);
$stmt->execute();
$row = $stmt->fetch(PDO::FETCH_ASSOC);
?>
<body class="navbar-fixed sidebar-nav fixed-nav">
    <!-- Contenu principal -->
    <main class="main">
        <!-- Fil d'Ariane -->
        <ol class="breadcrumb">
            <li class="breadcrumb-item active">إضافة طلب</li>
        </ol>

        <div class="container-fluid">
            <div class="animated fadeIn">
                <div class="row">
                    <div class="col-md-12">
                        <div class="card">
                            <div class="card-header">
                                <strong>إضافة طلب</strong>
                            </div>
                            <div class="card-block">
                            <form method="post" enctype="multipart/form-data" class="form-horizontal" id="add-order-form">
                                <!-- الفرع (Branch) -->
                               
                                <div class="form-group row">
                                    <label class="col-md-3 form-control-label" for="branch">الفرع</label>
                                    <div class="col-md-9">
                                    <?php 
                                        
                                        if ($auth->hasRole(\Delight\Auth\Role::USER) || $auth->hasRole(\Delight\Auth\Role::EXTERN_USER)) {
                                            ?>
                                            
                                            <select class="form-control"   name="branch" required>
                                            <option  value="<?= $row['branch_id'] ?>"><?= $row['branch_name'] ?></option>
                                            </select>

                                        <?php     

                                            }
                                            else {
                                        ?>
                                        <select class="form-control" id="branch" name="branch" required>
                                         </select>
                                        <?php

                                            }

                                    ?>
                                       
                                     </div>
                                </div>

                                <!-- المرسل (Sender) -->
                                <div class="form-group row">
                                    <label class="col-md-3 form-control-label" for="sender">المرسل</label>
                                    <div class="col-md-9">
                                    <?php 
                                        
                                        if ($auth->hasRole(\Delight\Auth\Role::USER) || $auth->hasRole(\Delight\Auth\Role::EXTERN_USER)) {
                                            ?>
                                        <input type="text" id="sender" name="sender" class="form-control"  value="<?= $username?>" readonly>

                                        <?php
                                        }
                                        else {
                                        ?>
                                        <select class="form-control" id="sender" name="sender" required>
                                         </select>
                                        <?php
                                         }
                                         ?>   
                                        


                                    </div>
                                </div>

                                                                
                                <!-- تاريخ الطلب (Order Date) -->
                                <div class="form-group row">
                                    <label class="col-md-3 form-control-label" for="order-date">تاريخ الانشاء</label>
                                    <div class="col-md-9">
                                        <input type="datetime-local" id="order-date" name="order-date" value="<?= date('Y-m-d\TH:i'); ?>" class="form-control" readonly>
                                    </div>
                                </div>


                                <!-- تاريخ التسليم (Delivery Date) -->
                                <div class="form-group row">
                                    <label class="col-md-3 form-control-label" for="delivery-date">تاريخ التسليم</label>
                                    <div class="col-md-9">
                                        <input type="date" id="delivery-date"  <?php if($auth->hasRole(\Delight\Auth\Role::USER) || $auth->hasRole(\Delight\Auth\Role::EXTERN_USER)) echo 'readonly'?> name="delivery_date" class="form-control" required>
                                    </div>
                                </div>

                                <!-- تفاصيل الطلب (Order Details) -->
                                <div class="form-group row">
                                    <label class="col-md-3 form-control-label" for="order-details">تفاصيل الطلب</label>
                                    <div class="col-md-9">
                                        <textarea id="order-details" name="order-details" class="form-control" rows="3" placeholder="أدخل تفاصيل الطلب" required></textarea>
                                    </div>
                                </div>

                                <div class="form-group row">
                                    <label class="col-md-3 form-control-label" for="execution-time"> الكمية</label>
                                    <div class="col-md-9">
                                        <input type="text" id="execution-time" name="execution-time"    class="form-control" placeholder="أدخل  الكمية" required>
                                    </div>
                                </div>
                         <!-- Formulaire avec champ de téléchargement de fichiers -->
                         <div class="form-group row">
                                    <label class="col-md-3 form-control-label" for="order-files">ملفات الطلب</label>
                                    <div class="col-md-9">
                                        <input type="file" id="order-files" name="order-files[]" class="form-control" multiple onchange="addFiles()">
                                        
                                        <!-- Liste des fichiers sélectionnés -->
                                        <div id="file-list" style="margin-top: 10px;"></div>
                                                                        <p style="color: red;">في حال كان حجم الملف كبيرًا، يُرجى رفعه على Google Drive ومشاركة الرابط ضمن التفاصيل.</p>

                                    </div>
                                </div>

                                <script>
                                let selectedFiles = []; // Variable pour stocker les fichiers sélectionnés

                                function addFiles() {
                                    const input = document.getElementById('order-files');

                                    // Ajoute les nouveaux fichiers à la liste des fichiers sélectionnés
                                    Array.from(input.files).forEach(file => {
                                        selectedFiles.push(file);
                                    });

                                    // Met à jour l'affichage
                                    displaySelectedFiles();
                                }

                                function displaySelectedFiles() {
                                    const fileListDiv = document.getElementById('file-list');
                                    fileListDiv.innerHTML = ''; // Réinitialise la liste

                                    // Affiche chaque fichier dans la liste avec un bouton de suppression
                                    selectedFiles.forEach((file, index) => {
                                        const fileItem = document.createElement('div');
                                        fileItem.className = 'file-item';
                                        fileItem.style.display = 'flex';
                                        fileItem.style.alignItems = 'center';
                                        fileItem.style.marginBottom = '5px';

                                        // Nom du fichier
                                        const fileName = document.createElement('span');
                                        fileName.textContent = file.name;
                                        fileName.style.marginRight = '10px';

                                        // Bouton de suppression
                                        const removeButton = document.createElement('button');
                                        removeButton.type = 'button';
                                        removeButton.className = 'btn btn-danger btn-sm';
                                        removeButton.textContent = 'حذف'; // Texte "حذف" pour "Supprimer"
                                        removeButton.onclick = () => removeFile(index);

                                        fileItem.appendChild(fileName);
                                        fileItem.appendChild(removeButton);
                                        fileListDiv.appendChild(fileItem);
                                    });
                                }

                                function removeFile(index) {
                                    // Supprime le fichier de la liste selectedFiles
                                    selectedFiles.splice(index, 1);

                                    // Met à jour l'affichage
                                    displaySelectedFiles();
                                }
                                </script>


                                <!-- ملاحظات (Notes) -->
                                <div class="form-group row">
                                    <label class="col-md-3 form-control-label" for="notes">ملاحظات</label>
                                    <div class="col-md-9">
                                        <textarea id="notes" name="notes" class="form-control" rows="3" placeholder="أدخل ملاحظات إضافية"></textarea>
                                    </div>
                                </div>

                           
                                <!-- السعر (Price) -->
                                <div class="form-group row">
                                    <label class="col-md-3 form-control-label" for="price">السعر</label>
                                    <div class="col-md-9">
                                        <input type="number" id="price" name="price" class="form-control"<?php if($auth->hasRole(\Delight\Auth\Role::USER) || $auth->hasRole(\Delight\Auth\Role::EXTERN_USER)) echo 'readonly'?>  placeholder="أدخل السعر" required step="0.01">
                                    </div>
                                </div>

                                <!-- مدة التنفيذ (Execution Time) -->
                               

                                <!-- تكرار الطلب (Request Repetition) -->
                                <div class="form-group row">
                                    <label class="col-md-3 form-control-label" for="request-repetition">عدد مرات التكرار</label>
                                    <div class="col-md-9">
                                        <input type="number" id="request-repetition" <?php if($auth->hasRole(\Delight\Auth\Role::USER) || $auth->hasRole(\Delight\Auth\Role::EXTERN_USER)) echo 'readonly'?> name="repeated" class="form-control" placeholder="أدخل عدد مرات التكرار" min="1" required>
                                    </div>
                                </div>
                                <!-- Statut d'étape -->
                                <div class="form-group row">
                                    <label class="col-md-3 form-control-label" for="status">حالة الطلب</label>
                                    <div class="col-md-9">
                                        <select id="status" name="status" class="form-control" <?php if($auth->hasRole(\Delight\Auth\Role::USER) || $auth->hasRole(\Delight\Auth\Role::EXTERN_USER)) ?> required>
                                        <option <?php if($auth->hasRole(\Delight\Auth\Role::USER)||$auth->hasRole(\Delight\Auth\Role::EXTERN_USER)) echo 'selected'?> value="pending">في الانتظار</option>
                                        <?php if(!$auth->hasRole(\Delight\Auth\Role::USER) && !$auth->hasRole(\Delight\Auth\Role::EXTERN_USER)){?>
                                        <option value="in_progress">قيد التنفيذ</option>
                                        <option value="waiting">في انتظار التعميد</option>
                                        <option value="order_sent">تم إرسال الطلب</option>
                                        <option value="ready">جاهز</option>

                                        <?php }?>
                                    </select>
                                    </div>
                                </div>
                                <?php 
                                        
                                        if (!$auth->hasRole(\Delight\Auth\Role::EXTERN_USER)) {
                                            ?>
                                <!-- Sélection des étapes (Order Steps) -->
                                <div class="form-group row">
                                    <label class="col-md-3 form-control-label" for="available-steps">اختر خطوة:</label>
                                    <div class="col-md-9">
                                         <?php
                                        try {
                                            // Requête pour récupérer les étapes avec leur type
                                            $sql = "SELECT step.step_id, step.step_name, step_type.type_name AS type_name 
                                                    FROM steps step 
                                                    inner JOIN step_types step_type ON step.type_id = step_type.type_id 
                                                    ORDER BY  step.`step_id` ASC;
                                                    ";
                                            
                                            // Préparation et exécution de la requête
                                            $stmt = $db->prepare($sql);
                                            $stmt->execute();
                                        
                                            // Récupérer les résultats
                                            $stepsByType = [];
                                        
                                            while ($row = $stmt->fetch(PDO::FETCH_ASSOC)) {
                                                $stepsByType[$row['type_name']][] = $row; // Grouper les étapes par leur type
                                            }
                                        
                                            // Générer les options dans le select
                                            echo '<select id="available-steps" class="form-control">';
                                            foreach ($stepsByType as $type => $steps) {
                                                echo "<optgroup label=\"$type\">"; // Titre du groupe (Type de l'étape)
                                                foreach ($steps as $step) {
                                                    echo "<option value=\"{$step['step_id']}\">{$step['step_name']}</option>";
                                                }
                                                echo "</optgroup>";
                                            }

                                            echo '</select>';
                                            
                                        } catch (PDOException $e) {
                                            echo "Erreur lors de la récupération des étapes : " . $e->getMessage();
                                        }
                                        ?>  
                                         <button type="button" class="btn btn-primary mt-2" onclick="addStep()">أضف الخطوة</button>
                                    </div>
                                </div>

                                <!-- Liste des étapes sélectionnées -->
                                <div class="form-group row">
                                    <label class="col-md-3 form-control-label">الخطوات المختارة:</label>
                                    <div class="col-md-9">
                                        <ul id="selected-steps" class="selected-steps"></ul>
                                        <input type="hidden" name="order_steps" id="order_steps">
                                    </div>
                                </div>
                                <?php

}
?>
                                <div class="form-group">
                                        <label>
                                            <input type="checkbox" id="confirm-checkbox" required>
                                            اتعهد ان الطلب مضاف بكامل تفاصيله واتحمل المسؤولية اذا تبين وجود أي
                                            نقص.
                                        </label>
                                    </div>
                                  
                            </form>

                            </div>
                            <div class="card-footer">
                                <button type="submit" class="btn btn-sm btn-primary" id="submit-order"><i class="fa fa-dot-circle-o"></i> إضافة الطلب</button>
                                <button type="button" class="btn btn-sm btn-danger" onclick="history.back();">
                                    <i class="fa fa-ban"></i> إلغاء
                                </button>
                                <div id="progress-container" style="display: none;">
                                    <div id="progress-bar" style="width: 0%; height: 20px; background-color: #4caf50; text-align: center; color: white;">0%</div>
                                </div>

                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <!--/.container-fluid-->
    </main>

    <footer class="footer">
        
    </footer>

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

          // Set the current date in the "YYYY-MM-DD" format

    document.addEventListener("DOMContentLoaded", function() {
            fetchBranches();
            fetchUsers();
        });
        $(document).ready(function() {
            $('#submit-order').click(function(e) {
                e.preventDefault();
            var checkbox = document.getElementById('confirm-checkbox');
                    if (!checkbox.checked) {
                        event.preventDefault(); // Annule l'envoi du formulaire
                          Swal.fire({
                                title: 'تنبيه',
                                text: 'يرجى التأكيد بأن الطلب مضاف بكامل تفاصيله.',
                                icon: 'warning',
                                confirmButtonText: 'حسناً'
                            });                    
                                              
                            
                        }
                        else{

                            var formData = new FormData($('#add-order-form')[0]);
                            
    // Ajouter les fichiers sélectionnés à FormData
    selectedFiles.forEach(file => {
        formData.append('files[]', file);
    });

                       

    $.ajax({
    xhr: function() {
        var xhr = new window.XMLHttpRequest();
        
        // Display the progress container when the upload starts
        document.getElementById('progress-container').style.display = 'block';

        xhr.upload.addEventListener("progress", function(evt) {
            if (evt.lengthComputable) {
                var percentComplete = Math.round((evt.loaded / evt.total) * 100);
                
                // Update the progress bar width and text
                var progressBar = document.getElementById('progress-bar');
                progressBar.style.width = percentComplete + '%';
                progressBar.textContent = percentComplete + '%';
            }
        }, false);

        return xhr;
    },
    url: '../AJAX/process_add_order.php',
    type: 'POST',
    data: formData,
    contentType: false,
    processData: false,
    beforeSend: function() {
        // Reset progress bar on each upload attempt
        document.getElementById('progress-bar').style.width = '0%';
        document.getElementById('progress-bar').textContent = '0%';
    },
    success: function(response) {
        // Hide progress bar and redirect on success
        document.getElementById('progress-container').style.display = 'none';
        window.location.href = 'orders.php?success=true';
    },
    error: function(jqXHR, textStatus, errorThrown) {
          swal({
            title: "خطأ",
            text: 'حدث خطأ ما,المرجو اعادة ادخال الطلب',
            icon: "error",
            button: "حسنا"
        });
        document.getElementById('progress-container').style.display = 'none'; // Hide progress bar on error
    }
});


                        }
                        });
        });

        let selectedSteps = []; // Définir les étapes par défaut avec les IDs 0 et 40

function addStep() {
    const stepSelect = document.getElementById('available-steps');
    const stepText = stepSelect.options[stepSelect.selectedIndex].text;
    const stepValue = stepSelect.value;

    // S'assurer que l'étape ajoutée n'est pas déjà présente et qu'elle n'est pas par défaut
    if (stepValue && !selectedSteps.includes(stepValue) && stepValue !== "0" && stepValue !== "40") {
        selectedSteps.splice(selectedSteps.length - 1, 0, stepValue); // Ajouter avant la dernière étape "جاهز"

        const stepList = document.getElementById('selected-steps');
        const li = document.createElement('li');
        li.setAttribute('data-value', stepValue); // L'ID réel de l'étape ajoutée
        li.innerHTML = `${stepText} <button class="remove-step" onclick="removeStep('${stepValue}')">&times;</button>`;
        stepList.insertBefore(li, stepList.lastChild); // Ajouter avant l'étape "جاهز"
    }

    document.getElementById('order_steps').value = selectedSteps.join(',');
}

function removeStep(stepValue) {
    selectedSteps = selectedSteps.filter(value => value !== stepValue);
    const stepList = document.getElementById('selected-steps');
    const stepItems = stepList.querySelectorAll('li');

    stepItems.forEach(item => {
        if (item.getAttribute('data-value') === stepValue) {
            stepList.removeChild(item);
        }
    });

    document.getElementById('order_steps').value = selectedSteps.join(',');
}


document.addEventListener("DOMContentLoaded", function() {
    const stepList = document.getElementById('selected-steps');

    // Ajouter la première étape par défaut avec l'ID 0
    const startLi = document.createElement('li');
    startLi.setAttribute('data-value', "0"); // Utilisation de l'ID de l'étape
    startLi.textContent = "في انتظار الموظف";
    stepList.appendChild(startLi);

    // Ajouter la dernière étape par défaut avec l'ID 40
    const endLi = document.createElement('li');
    endLi.setAttribute('data-value', "40"); // Utilisation de l'ID de l'étape
    endLi.textContent = "جاهز";
    stepList.appendChild(endLi);

    // Mise à jour du tableau selectedSteps avec les IDs des étapes par défaut
    selectedSteps.push("0", "40"); // Ajoutez les IDs (0 et 40) au tableau
    document.getElementById('order_steps').value = selectedSteps.join(',');
});


    </script>
    <script>
   
    function fetchBranches() {
            fetch('../AJAX/get_branches.php')
                .then(response => {
                    if (!response.ok) {
                        throw new Error('Erreur lors de la récupération des données');
                    }
                    return response.json();
                })
                .then(data => {
                    const branchSelect = document.getElementById('branch');
                    data.forEach(branch => {
                        const option = document.createElement('option');
                        option.value = branch.branch_id;
                        option.textContent = branch.branch_name;
                        branchSelect.appendChild(option);
                    });
                })
                .catch(error => {
                    console.error('Erreur:', error);
                });
        }
        function fetchUsers() {
            fetch('../AJAX/get_users.php')
                .then(response => {
                    if (!response.ok) {
                        throw new Error('Erreur lors de la récupération des données');
                    }
                    return response.json();
                })
                .then(data => {
                    const userSelect = document.getElementById('sender');
                    data.forEach(user => {
                        const option = document.createElement('option');
                        option.value = user.username;
                        option.textContent = user.username;
                        userSelect.appendChild(option);
                    });
                })
                .catch(error => {
                    console.error('Erreur:', error);
                });
        }
    

</script>
</body>
