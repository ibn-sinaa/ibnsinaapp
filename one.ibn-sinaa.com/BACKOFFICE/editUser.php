<?php 
include('header.php');

// Vérifier si l'utilisateur a le rôle requis
if (!$auth->hasRole(\Delight\Auth\Role::ADMIN)) {
    // Rediriger vers une page d'accès refusé ou une autre page
    header('Location: noAuth.php');
    exit;
}

 
// Vérifiez si l'ID de l'utilisateur est passé dans l'URL
if (isset($_GET['id']) && !empty($_GET['id'])) {
    $userId = $_GET['id'];
  
    // Préparer et exécuter la requête pour récupérer les informations de l'utilisateur
    $query = "SELECT * FROM users join user_branches on user_branches.user_id=users.id JOIN branches ON branches.branch_id=user_branches.branch_id WHERE id = :userId";
    $stmt = $db->prepare($query);
    $stmt->bindParam(':userId', $userId, PDO::PARAM_INT);
    $stmt->execute();
    $user = $stmt->fetch(PDO::FETCH_ASSOC);
    
    if (!$user) {
        // Si l'utilisateur n'existe pas, redirigez avec un message d'erreur
        header("Location: users.php?error=Utilisateur introuvable");
        exit();
    }
} else {
    // Rediriger si l'ID de l'utilisateur n'est pas valide
    header("Location: users.php?error=ID utilisateur invalide");
    exit();
}
?>

<body class="navbar-fixed sidebar-nav fixed-nav">
    <main class="main">
        <ol class="breadcrumb">
            <li class="breadcrumb-item active">المستخدمين</li>
        </ol>

        <div class="container-fluid">
            <div class="animated fadeIn">
                <div class="row">
                    <div class="col-md-12">
                        <div class="card">
                            <div class="card-header">
                                <strong>تعديل المستخدم</strong>
                            </div>
                            <div class="card-block">
                                <form id="editUserForm">
                                    <!-- Nom d'utilisateur -->
                                    <div class="form-group">
                                        <label for="username">اسم المستخدم</label>
                                        <input type="text" class="form-control" id="username" name="username" value="<?php echo htmlspecialchars($user['username']); ?>" required>
                                    </div>

                                    <!-- Email -->
                                    <div class="form-group mt-3">
                                        <label for="email">البريد الإلكتروني</label>
                                        <input type="email" class="form-control" id="email" name="email" value="<?php echo htmlspecialchars($user['email']); ?>" required>
                                    </div>

                                    <!-- Mot de passe -->
                                    <div class="form-group mt-3">
                                        <label for="password">كلمة المرور</label>
                                        <input type="password" class="form-control" id="password" name="password" placeholder="أدخل كلمة المرور (laisser vide pour ne pas changer)">
                                    </div>

                                    <!-- Rôle -->
                                    <div class="form-group mt-3">
                                        <label for="role">دور المستخدم</label>
                                        <select class="form-control" id="role" name="role" required>
                                            <option value="8" <?php if ($user['roles_mask'] == 8) echo 'selected'; ?>>مستخدم خارجي</option>
                                            <option value="4" <?php if ($user['roles_mask'] == 4) echo 'selected'; ?>>مستخدم</option>
                                            <option value="2" <?php if ($user['roles_mask'] == 2) echo 'selected'; ?>>موظف</option>
                                            <option value="1" <?php if ($user['roles_mask'] == 1) echo 'selected'; ?>>مدير</option>
                                        </select>
                                    </div>

                                    <!-- Branche -->
                                    <div class="form-group mt-3">
                                        <label for="branch">فرع المستخدم</label>
                                        <select class="form-control" id="branch" name="branch" required>
                                            <option value="">اختر الفرع</option>
                                            <!-- Les options de branche seront chargées ici via JavaScript -->
                                        </select>
                                    </div>

                                    <!-- Bouton de mise à jour -->
                                    <button type="button" onclick="editUser(<?php echo $userId; ?>)" class="btn btn-primary mt-4">تعديل المستخدم</button>
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
                    // Sélectionner la branche actuelle de l'utilisateur
                    branchSelect.value = "<?php echo htmlspecialchars($user['branch_id']); ?>";
                })
                .catch(error => {
                    console.error('Erreur:', error);
                });
        }

        function editUser(userId) {
            const formData = {

                userId:userId,
                username: document.getElementById("username").value,
                email: document.getElementById("email").value,
                password: document.getElementById("password").value,
                role: document.getElementById("role").value,
                branch: document.getElementById("branch").value
            };

            fetch('../AJAX/edit_user.php', {
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

            window.location.href = 'users.php?success_edit=true';

           

            } else {
            Swal.fire({
                    title: 'خطأ',
                    text: data.message || 'حدث خطأ أثناء التعديل.',
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
            });
        }
    </script>

    <style>
        .text-success {
            color: green;
        }
        .text-danger {
            color: red;
        }
    </style>
</body>
</html>
