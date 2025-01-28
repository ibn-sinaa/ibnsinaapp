<?php
include('header.php');

// Récupérer l'ID du ticket
$ticket_id = $_GET['ticket_id'] ?? null;

if (!$ticket_id || !is_numeric($ticket_id)) {
    die("رقم التذكرة غير صحيح.");
}

// Vérifier si le ticket existe et appartient à l'utilisateur connecté
try {
    $query = "SELECT tickets.*, users.username, users.id as user_id FROM tickets JOIN users ON tickets.user_id = users.id WHERE tickets.id = :ticket_id";
    $stmt = $db->prepare($query);
    $stmt->bindParam(':ticket_id', $ticket_id, PDO::PARAM_INT);
    $stmt->execute();

    if ($stmt->rowCount() === 0) {
        die("التذكرة غير موجودة أو ليس لديك إذن للوصول إليها.");
    }

    $ticket = $stmt->fetch(PDO::FETCH_ASSOC);
} catch (PDOException $e) {
    die("حدث خطأ: " . $e->getMessage());
}

// Vérification si l'utilisateur est administrateur
$isAdmin = 0; // Par défaut, l'utilisateur n'est pas administrateur
// Vérifier si l'utilisateur a le rôle administrateur
if ($auth->hasRole(\Delight\Auth\Role::ADMIN)) {
    $isAdmin = 1;
}
?>

<!-- CSS et styles -->
<style>
    /* Styles pour la fenêtre de discussion et les messages */
    body {
        background-color: #f7f7f7;
        margin: 0;
        padding: 0;
    }
    .chat-wrapper {
        max-width: 90%;
        margin: 20px auto;
        background: #fff;
        border-radius: 10px;
        box-shadow: 0 4px 10px rgba(0, 0, 0, 0.1);
        display: flex;
        flex-direction: column;
        height: 90vh;
        overflow: hidden;
    }

    .chat-header {
        background-color: #007bff;
        color: white;
        padding: 10px;
        font-size: 15px;
        font-weight: bold;
        text-align: center;
    }

    .chat-container {
        flex: 1;
        padding: 20px;
        overflow-y: auto;
        display: flex;
        flex-direction: column;
        gap: 15px;
        background-color: #f1f1f1;
    }

    .message {
        max-width: 70%;
        padding: 10px 15px;
        border-radius: 20px;
        font-size: 14px;
        line-height: 1.5;
        word-wrap: break-word;
        position: relative;
    }

    .message-user {
        align-self: flex-end;
        background: #007bff;
        color: white;
    }

    .message-admin {
        align-self: flex-start;
        background: #e4e6eb;
        color: black;
    }

    .message small {
        font-size: 12px;
        color: #555;
        position: absolute;
        bottom: -15px;
        right: 10px;
    }

    .chat-footer {
        padding: 15px;
        background: #f1f1f1;
        border-top: 1px solid #ddd;
        display: flex;
        gap: 10px;
    }

    .chat-footer textarea {
        flex: 1;
        resize: none;
        padding: 10px;
        border: 1px solid #ccc;
        border-radius: 5px;
    }

    .chat-footer button {
        background: #007bff;
        color: white;
        border: none;
        padding: 10px 20px;
        border-radius: 5px;
        cursor: pointer;
    }

    .chat-footer button:hover {
        background: #0056b3;
    }

    /* Style du séparateur de jour */
    .date-divider {
        text-align: center;
        font-size: 16px;
        font-weight: bold;
        margin: 10px 0;
        position: relative;
    }

    .date-divider::before, .date-divider::after {
        content: '';
        position: absolute;
        top: 50%;
        width: 40%;
        height: 1px;
        background: #ddd;
    }

    .date-divider::before {
        left: 0;
    }

    .date-divider::after {
        right: 0;
    }
</style>

<body class="navbar-fixed sidebar-nav fixed-nav">
    <main class="main">
       

        <div class="animated fadeIn">
            <div class="chat-wrapper">
                <div class="chat-header">
                    <?php if (isset($role) && $role === \Delight\Auth\Role::ADMIN) {
                        echo "محادثة مع " . htmlspecialchars($ticket['username']);
                    } else {
                        echo "محادثة مع الادمن";
                    }?>
                </div>

                <div id="chat-container" class="chat-container">
                    <?php
                    // Charger les messages
                    try {
                        $query = "SELECT * FROM messages WHERE ticket_id = :ticket_id ORDER BY sent_at ASC";
                        $stmt = $db->prepare($query);
                        $stmt->bindParam(':ticket_id', $ticket_id, PDO::PARAM_INT);
                        $stmt->execute();

                        if ($stmt->rowCount() > 0) {
                            $previous_date = null; // Variable pour suivre la date précédente
                            while ($message = $stmt->fetch(PDO::FETCH_ASSOC)) {
                                $message_date = new DateTime($message['sent_at']);
                                $formatted_date = $message_date->format('l, d F Y');

                                if ($formatted_date != $previous_date) {
                                    echo "<div class='date-divider'>$formatted_date</div>";
                                    $previous_date = $formatted_date;
                                }

                                $message_time = new DateTime($message['sent_at']);
                                $formatted_time = $message_time->format('H:i');

                                // Déterminer la classe en fonction du rôle de l'expéditeur et de l'utilisateur connecté
                                if ($isAdmin == 1) {
                                    $sender_class = $message['isAdmin'] == 1 ? 'message-admin' : 'message-user';
                                } else {
                                    $sender_class = $message['isAdmin'] == 1 ? 'message-user' : 'message-admin';
                                }

                                echo "<div class='message $sender_class'>
                                        <p>" . htmlspecialchars($message['content']) . "</p>
                                        <small>" . htmlspecialchars($formatted_time) . "</small>";

                                // Vérification et affichage des fichiers attachés
                                if ($message['file_path']) {
                                    $file_url = $message['file_path'];
                                    $file_name = basename($file_url);
                                    echo "<div><a href='$file_url' target='_blank'>  $file_name</a></div>";
                                }

                                echo "</div>";
                            }
                        } else {
                            echo "<p>لا توجد رسائل بعد.</p>";
                        }
                    } catch (PDOException $e) {
                        echo "حدث خطأ أثناء تحميل الرسائل: " . $e->getMessage();
                    }
                    ?>
                </div>

                <div class="chat-footer" style="display: flex; flex-direction: column; align-items: flex-start;">
                    <?php if( $ticket['status']=="closed") {

                        ?>
                    <h6 style="color: red;">لا يمكنك ارسال رسائل جديدة, تم غلق هذه التذكرة.</h6>
                        <?php
                    }
                    else {
                        ?>
                <form id="send-message-form" enctype="multipart/form-data" class="form-chat" style="display: flex; width: 100%; align-items: center;">
                    <textarea id="message" name="message" placeholder="اكتب رسالتك هنا..." required style="flex-grow: 1; padding: 10px; font-size: 14px; border: 1px solid #ccc; border-radius: 5px;"></textarea>
                    
                    <!-- Masquer le champ de fichier -->
                    <input type="file" id="file" name="file" style="display: none;" onchange="displayFileName()" />
                    
                    <!-- Ajouter une icône pour remplacer l'input de fichier -->
                    <label for="file" class="file-icon" >
                        <i class="fa fa-paperclip" style="font-size: 20px; color: #555;"></i> <!-- Icône de pièce jointe -->
                    </label>

                    <button type="submit" class="send-btn" style="padding: 8px 16px; background-color: #4CAF50; color: white; border: none; border-radius: 5px; cursor: pointer; font-size: 14px;">إرسال</button>
                </form>
                
                <!-- Zone pour afficher le nom du fichier avec un style élégant -->
                <div id="file-name-display" style="margin-top: 10px; color: #555; font-size: 14px; display: flex; align-items: center;">
                    <span id="file-name" style="margin-left: 8px; font-weight: 500;"></span>
                </div>
                <?php }
                ?>
            </div>

<script>
    // Fonction pour afficher le nom du fichier sélectionné
    function displayFileName() {
        const fileInput = document.getElementById('file');
        const fileNameDisplay = document.getElementById('file-name');
        
        // Vérifier si un fichier est sélectionné
        if (fileInput.files.length > 0) {
            fileNameDisplay.textContent = 'الملف المرفق  : ' + fileInput.files[0].name;
        } else {
            fileNameDisplay.textContent = '';
        }
    }
</script>

<style>
    /* Style global du footer */
    .chat-footer {
        padding: 20px;
        background: #f9f9f9;
        border-top: 1px solid #ddd;
        display: flex;
        justify-content: space-between;
        align-items: center;
        box-shadow: 0 -1px 5px rgba(0, 0, 0, 0.1);
    }

    /* Formulaire du chat */
    .form-chat {
        display: flex;
        width: 100%;
        align-items: center;
    }

    /* Textarea de message */
    .form-chat textarea {
        width: 70%;
        padding: 10px;
        font-size: 14px;
        border-radius: 5px;
        border: 1px solid #ccc;
        margin-right: 10px;
        resize: none;
        min-height: 50px;
        outline: none;
        transition: border-color 0.3s;
    }

    .form-chat textarea:focus {
        border-color: #007bff;
    }

    /* Icône de fichier */
    .file-icon i {
        font-size: 24px;
        color: #007bff;
        transition: transform 0.3s ease;
        padding: 10px 20px;

    }

    .file-icon:hover i {
        transform: scale(1.1);
    }
 
    /* Petit style pour les icônes */
    .file-icon {
        margin-right: 10px;
    }
</style>

            </div>
        </div>
    </main>
  <script src="js/libs/jquery.min.js"></script>
    <script src="js/libs/tether.min.js"></script>
    <script src="js/libs/bootstrap.min.js"></script>
    <script src="js/app.js"></script>
    <script src="js/libs/jquery.min.js"></script>
    <script>
$(document).ready(function () {
    const chatContainer = $('#chat-container');
    const fileInput = document.getElementById('file');

    // Auto-scroll vers le bas au chargement
    chatContainer.scrollTop(chatContainer.prop('scrollHeight'));

    // Soumission du formulaire
    $('#send-message-form').on('submit', function (e) {
        e.preventDefault();

        // Récupérer le fichier sélectionné
        const file = $('#file')[0].files[0];
        const messageContent = $('#message').val();

        // Si aucun fichier n'est sélectionné, vérifier si le message est vide
        if (!file && messageContent.trim() === '') {
            alert('يرجى إدخال رسالة أو تحميل ملف.');
            return;
        }

        // Créer un objet FormData pour envoyer les données du formulaire
        const formData = new FormData();
        formData.append('userId', <?php echo $ticket['user_id']; ?>);  // ID de l'utilisateur connecté
        formData.append('ticket_id', <?php echo $ticket_id; ?>);  // ID du ticket de discussion
        formData.append('message', messageContent);  // Contenu du message
        formData.append('isAdmin', <?php echo $isAdmin; ?>);  // Rôle de l'utilisateur (Admin ou non)

        if (file) {
            formData.append('file', file);  // Ajouter le fichier à FormData
        }

        $.ajax({
            url: '../AJAX/send_message.php',  // URL du script PHP
            type: 'POST',
            data: formData,
            processData: false,  // Important pour envoyer un fichier
            contentType: false,  // Important pour envoyer un fichier
            success: function (response) {
                if (response.success) {
                    const newMessage = `
                    <div class="message message-admin">
                        <p>${response.message}</p>
                        ${response.filePath ? `<a href="${response.filePath}" target="_blank">${response.filePath}</a>` : ''}
                        <small>${response.sentAt}</small>
                    </div>`;
                    chatContainer.append(newMessage);  // Ajouter le message à la discussion
                    $('#message').val('');  // Réinitialiser le champ de texte
                    $('#file-name').text('');  // Réinitialiser l'affichage du nom du fichier
                    $('#file').val('');  // Réinitialiser le champ de fichier
                    chatContainer.scrollTop(chatContainer.prop('scrollHeight'));  // Auto-scroll vers le bas

                } else {
                    alert('حدث خطأ أثناء إرسال الرسالة.');
                }
            },
            error: function () {
                alert('حدث خطأ في الاتصال بالخادم.');
            }
        });
    });
});
</script>

</body>
</html>
