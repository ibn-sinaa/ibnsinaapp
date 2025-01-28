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
<body class="navbar-fixed sidebar-nav fixed-nav">
    <!-- Contenu principal -->
    <main class="main">
        <!-- Fil d'Ariane -->
        <ol class="breadcrumb">
            <li class="breadcrumb-item active">إضافة فرع</li>
        </ol>

        <div class="container-fluid">
            <div class="animated fadeIn">
                <div class="row">
                    <div class="col-md-12">
                        <div class="card">
                            <div class="card-header">
                                <strong>إضافة فرع</strong>
                            </div>
                            <div class="card-block">
                            <form method="post" enctype="multipart/form-data" class="form-horizontal" id="add-order-form">
                             

                                <!-- المرسل (Sender) -->
                                <div class="form-group row">
                                    <label class="col-md-3 form-control-label" for="sender">اسم الفرع</label>
                                    <div class="col-md-9">
                                        <input type="text" id="branch_name" name="branch_name" class="form-control" placeholder="أدخل اسم الفرع" required>
                                    </div>
                                </div>

                                <!-- رقم السند (Receipt Number) -->
                                <div class="form-group row">
                                    <label class="col-md-3 form-control-label" for="receipt-number"> عنوان الفرع</label>
                                    <div class="col-md-9">
                                        <input type="text" id="receipt-number" name="location" class="form-control" placeholder="أدخل عنوان الفرع" required>
                                    </div>
                                </div>

                             

                            </form>

                            </div>
                            <div class="card-footer">
                                <button type="submit" class="btn btn-sm btn-primary" id="submit-order"><i class="fa fa-dot-circle-o"></i> إضافة الفرع</button>
 <button type="button" class="btn btn-sm btn-danger" onclick="history.back();">
                                    <i class="fa fa-ban"></i> إلغاء
                                </button>                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <!--/.container-fluid-->
    </main>

    <footer class="footer">
        
    </footer>

    <!-- Bootstrap et plugins nécessaires -->
    <script src="js/libs/jquery.min.js"></script>
    <script src="js/libs/tether.min.js"></script>
    <script src="js/libs/bootstrap.min.js"></script>

    <script src="js/app.js"></script>
    <script>
    $(document).ready(function() {
        $('#submit-order').click(function(e) {
            e.preventDefault();
            
            // Get the branch name
            var branchName = $('#branch_name').val().trim();
            
            // Check if the branch name is empty
            if (branchName === "") {
                alert("يرجى إدخال اسم الفرع.");
                return;
            }

            // Check if branch name exists before submitting the form
            $.ajax({
    url: '../AJAX/check_branch_name.php',
    type: 'POST',
    data: { branch_name: branchName },
    dataType: 'text', // Change temporarily to see response as plain text
    success: function(response) {
        console.log("Raw response:", response); // Log raw response for debugging
        try {
            var jsonResponse = JSON.parse(response); // Parse manually if necessary
            if (jsonResponse.exists) {
                alert("اسم الفرع موجود بالفعل. يرجى اختيار اسم آخر.");
            } else {
                // Proceed with form submission
                var formData = new FormData($('#add-order-form')[0]);
                $.ajax({
                    url: '../AJAX/process_add_branch.php',
                    type: 'POST',
                    data: formData,
                    contentType: false,
                    processData: false,
                    success: function(response) {
                        alert("تمت اضافة الفرع بنجاح");
                    },
                    error: function(jqXHR, textStatus, errorThrown) {
                        alert('Error: ' + textStatus + ' - ' + errorThrown);
                    }
                });
            }
        } catch (error) {
            console.error("JSON parse error:", error); // Log parse errors
        }
    },
    error: function(jqXHR, textStatus, errorThrown) {
        alert('Error checking branch name: ' + textStatus);
    }
});

        });
    });
</script>

</body>
