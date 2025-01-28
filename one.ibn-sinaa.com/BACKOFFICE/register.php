<div class="card card-inverse card-success p-y-3" style="width: 44%">
    <div class="card-block text-xs-center">
        <h2>إنشاء حساب</h2>
        <p>إذا لم تكن عضواً في النظام، يمكنك التسجيل.</p>
        <form id="registration-form">
            <div class="input-group m-b-1">
                <span class="input-group-addon"><i class="icon-user"></i></span>
                <input id="reg-email" type="email" class="form-control" placeholder="البريد الإلكتروني" required aria-label="البريد الإلكتروني">
            </div>
            <div class="input-group m-b-1">
                <span class="input-group-addon"><i class="icon-user"></i></span>
                <input id="username" type="username" class="form-control" placeholder=" username" required aria-label="username ">
            </div>
            <div class="input-group m-b-2">
                <span class="input-group-addon"><i class="icon-lock"></i></span>
                <input id="reg-password" type="password" class="form-control" placeholder="كلمة المرور" required aria-label="كلمة المرور">
            </div>
            <button type="button" id="register-button" class="btn btn-primary active m-t-1">تسجيل</button>
        </form>
    </div>
</div>
<script>
 document.getElementById('register-button').addEventListener('click', function() {
    var regEmail = document.querySelector('#reg-email').value;
    var regPassword = document.querySelector('#reg-password').value;
    var username = document.querySelector('#username').value;

    fetch('../AJAX/register_user.php', {
        method: 'POST',
        headers: {
            'Content-Type': 'application/json',
        },
        body: JSON.stringify({
            email: regEmail,
            password: regPassword,
            username: username  // Envoyer le nom d'utilisateur
        }),
    })
    .then(response => {
        if (!response.ok) {
            throw new Error('Erreur réseau');
        }
        return response.json();
    })
    .then(data => {
        if (data.success) {
            console.log('Inscription réussie');
            // Redirection ou traitement en cas de succès
        } else {
            console.log('Erreur:', data.error);
        }
    })
    .catch(error => {
        console.log("Erreur réseau:", error);
    });
});

</script>
