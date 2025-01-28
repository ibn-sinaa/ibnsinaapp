<!DOCTYPE html>
<html lang="ar" dir="rtl">

<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <meta name="description" content="تسجيل الدخول إلى حسابك">
    <meta name="author" content="Lukasz Holeczek">
    <meta name="keyword" content="تسجيل الدخول, حساب, إدارة, Bootstrap">
    <title>تسجيل الدخول</title>
    <!-- أيقونات -->
    <link href="css/font-awesome.min.css" rel="stylesheet">
    <link href="css/simple-line-icons.css" rel="stylesheet">
    <!-- الأنماط الرئيسية لهذا التطبيق -->
    <link href="dest/style.css" rel="stylesheet">
</head>

<body class="">
    <div class="container">
        <div class="row">
            <div class="col-md-8 m-x-auto pull-xs-none vamiddle">
                <div class="card-group">
                    <div class="card p-a-2">
                        <div class="card-block">
                            <h1>تسجيل الدخول</h1>
                            <p class="text-muted">قم بتسجيل الدخول إلى حسابك</p>
                            <div class="input-group m-b-1">
                                <span class="input-group-addon"><i class="icon-user"></i></span>
                                <input id="email" type="email" class="form-control en" placeholder="البريد الإلكتروني" aria-label="البريد الإلكتروني">
                            </div>
                            <div class="input-group m-b-2">
                                <span class="input-group-addon"><i class="icon-lock"></i></span>
                                <input id="password" type="password" class="form-control en" placeholder="كلمة المرور" aria-label="كلمة المرور">
                            </div>
                            <div class="row">
                                <div class="col-xs-6">
                                    <button type="button" class="btn btn-primary p-x-2">
                                        <i class="icon-login"></i> تسجيل الدخول
                                    </button>
                                </div>
                             </div>
                        </div>
                    </div>
                    <div class="card card-inverse card-primary p-y-3" style="width:44%">
                        <div class="card-block text-xs-center">
                            <div>
                                <h2>إنشاء حساب</h2>
                                <p>إذا لم تكن عضواً في النظام، يمكنك التسجيل.</p>
                                <button type="button" class="btn btn-primary active m-t-1" onclick="redirectToWhatsApp()">تسجيل</button>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <!-- Scripts JavaScript nécessaires -->
    <script src="js/libs/jquery.min.js"></script>
    <script src="js/libs/tether.min.js"></script>
    <script src="js/libs/bootstrap.min.js"></script>
    <script>
        function verticalAlignMiddle() {
            var bodyHeight = $(window).height();
            var formHeight = $('.vamiddle').height();
            var marginTop = (bodyHeight / 2) - (formHeight / 2);
            if (marginTop > 0) {
                $('.vamiddle').css('margin-top', marginTop);
            }
        }

        $(document).ready(function () {
            verticalAlignMiddle();
        });

        $(window).bind('resize', verticalAlignMiddle);

        function redirectToWhatsApp() {
            const phoneNumber = "966542393936"; // أدخل رقم هاتف واتساب
            const message = encodeURIComponent("مرحبًا، أود إنشاء حساب جديد.");
            window.location.href = `https://wa.me/${phoneNumber}?text=${message}`;
        }

        document.querySelector('button[type="button"]').addEventListener('click', function() {
    var email = document.querySelector('input[placeholder="البريد الإلكتروني"]').value;
    var password = document.querySelector('input[placeholder="كلمة المرور"]').value;
    // Exemple d'appel AJAX avec jQuery
    $.ajax({
        url: '../AJAX/verify_login.php', // Chemin vers le fichier PHP de vérification
        type: 'POST',
        contentType: 'application/json',
        data: JSON.stringify({
            email: $('#email').val(),
            password: $('#password').val()
        }),
        success: function (response) {
        try {
            var data = JSON.parse(response); // Parse only if necessary
            if (data.success) {
                window.location.href = data.redirect;
            } else {
                alert(data.error);
            }
        } catch (e) {
            console.error('Invalid JSON response', e);
            alert('Erreur inattendue. Veuillez réessayer.');
        }
    },
    error: function (xhr, status, error) {
        console.error('AJAX error:', error);
        alert('Erreur de connexion. Veuillez vérifier votre réseau.');
    }

    });


});
    </script>
</body>

</html>
