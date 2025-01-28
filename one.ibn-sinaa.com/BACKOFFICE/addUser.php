<?php 
include('header.php');
    // Vérifier si l'utilisateur a le rôle requis
if ($auth->hasRole(\Delight\Auth\Role::EMPLOYEE)) {
    //Rediriger vers une page d'accès refusé ou une autre page
   header('Location: noAuth.php');
   exit;
}
?>

<body class="navbar-fixed sidebar-nav fixed-nav">

    <!-- Main content -->
    <main class="main">
        <!-- Breadcrumb -->
        <ol class="breadcrumb">
            <li class="breadcrumb-item active">المستخدمين</li>
        </ol>

        <div class="container-fluid">
            <div class="animated fadeIn">
                <div class="row">
                    <div class="col-md-12">
                        <div class="card">
                            <div class="card-header">
                                <strong>إضافة مستخدم</strong>
                            </div>
                            <div class="card-block">
                                <form id="addUserForm">
                                    <!-- Nom d'utilisateur -->
                                    <div class="form-group">
                                        <label for="username">اسم المستخدم</label>
                                        <input type="text" class="form-control" id="username" name="username" placeholder="أدخل اسم المستخدم" required>
                                    </div>

                                    <!-- Email -->
                                    <div class="form-group mt-3">
                                        <label for="email">البريد الإلكتروني</label>
                                        <input type="email" class="form-control" id="email" name="email" placeholder="أدخل البريد الإلكتروني" required>
                                    </div>

                                    <!-- Mot de passe -->
                                    <div class="form-group mt-3">
                                        <label for="password">كلمة المرور</label>
                                        <input type="password" class="form-control" id="password" name="password" placeholder="أدخل كلمة المرور" required>
                                    </div>

                                    <!-- Statut
                                    <div class="form-group mt-3">
                                        <label for="status">حالة المستخدم</label>
                                        <select class="form-control" id="status" name="status">
                                            <option value="1">نشط</option>
                                            <option value="0">غير نشط</option>
                                        </select>
                                    </div> -->

                                    <!-- Rôle -->
                                    <div class="form-group mt-3">
                                        <label for="role">دور المستخدم</label>
                                        <select class="form-control" id="role" name="role" required>
                                            <option value="8">مستخدم خارجي</option>
                                            <option value="4">مستخدم</option>
                                            <option value="2">موظف</option>
                                            <option value="1">مدير</option>
                                        </select>
                                    </div>

                                    <!-- Branche -->
                                    <div class="form-group mt-3">
                                        <label for="branch">فرع المستخدم</label>
                                        <select class="form-control" id="branch" name="branch" required>
                                            <option  value="">اختر الفرع</option>
                                        </select>
                                    </div>

                                    <!-- Bouton d'ajout -->
                                    <button type="button" onclick="addUser()" class="btn btn-primary mt-4">إضافة المستخدم</button>
                                </form>
                                <div id="responseMessage" class="mt-3"></div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </main>

    <?php include('footer.php'); ?>

  
    <!-- JavaScript pour charger les branches via l'API -->
    <script>
        document.addEventListener("DOMContentLoaded", function() {
            fetchBranches();
        });

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
        function addUser() {
            const formData = {
                username: document.getElementById("username").value,
                email: document.getElementById("email").value,
                password: document.getElementById("password").value,
                //status: document.getElementById("status").value,
                role: document.getElementById("role").value,
                branch: document.getElementById("branch").value
            };

            console.log("Form Data:", formData); // Ajoutez cette ligne pour déboguer

            fetch('../AJAX/add_user.php', {
                method: 'POST',
                headers: {
                    'Content-Type': 'application/json'
                },
                body: JSON.stringify(formData)
            })
            .then(response => response.json())
            .then(data => {
                const responseMessage = document.getElementById("responseMessage");
                responseMessage.classList.remove("text-success", "text-danger");

                if (data.success) {

                    window.location.href = 'users.php?success=true';

                    Swal.fire({
                            title: 'تم الاضافة بنجاح !',
                            text: 'تمت اضافة المستخدم بنجاح.',
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
                            text: data.message || 'حدث خطأ أثناء الاضافة.',
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
        }

    </script>

    <!-- CSS pour les messages de notification -->
    <style>
        .text-success {
            color: green; /* Couleur pour les messages de succès */
        }
        .text-danger {
            color: red; /* Couleur pour les messages d'échec */
        }
    </style>
</body>
</html>
