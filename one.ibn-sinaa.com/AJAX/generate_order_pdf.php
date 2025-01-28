<?php 
require '../vendor/autoload.php'; // Charger les dépendances mPDF
require '../SYS/db.php'; // Charger la connexion à la base de données
use Mpdf\Mpdf;

// Définir le chemin absolu vers le dossier des polices
$fontDir = realpath('../vendor/mpdf/mpdf/ttfonts');  // Utiliser realpath pour obtenir le chemin absolu

// Initialiser mPDF avec la police Tajawal
$mpdf = new Mpdf([
    'mode' => 'utf-8',
    'format' => 'A4',
    'default_font' => 'tajawal',  // Utiliser le nom de la police
    'autoScriptToLang' => true,
    'autoLangToFont' => true,
    'directionality' => 'rtl',
     
]);

 

// Récupération de l'ID de la commande
$order_id = isset($_GET['order_id']) ? $_GET['order_id'] : null;

// Fonction pour récupérer les détails de la commande
function getOrderDetails($db, $order_id) {
    $sql = "SELECT order_number, branch_name, sender, order_date, delivery_date, details, price, execution_time,notes, status FROM orders join branches on orders.branch_id=branches.branch_id  WHERE order_id = :order_id";
    
    $stmt = $db->prepare($sql);
    $stmt->bindParam(':order_id', $order_id);
    $stmt->execute();
    
    return $stmt->fetch(PDO::FETCH_ASSOC);
}

// Récupérer les détails de la commande
$order_details = getOrderDetails($db, $order_id);

// Récupérer la date actuelle
$current_date = date('Y-m-d');
// Check if locale worked; fall back to translation if necessary
    $arabic_days = [
        'Sunday' => 'الأحد',
        'Monday' => 'الإثنين',
        'Tuesday' => 'الثلاثاء',
        'Wednesday' => 'الأربعاء',
        'Thursday' => 'الخميس',
        'Friday' => 'الجمعة',
        'Saturday' => 'السبت'
    ];
    $day_name = $arabic_days[date('l')];

// Calcul des montants
$price = $order_details ? $order_details['price'] : 0;
$vat_rate = 0.15; // Taux de TVA de 15%
$vat_amount = $price * $vat_rate; // Montant de la TVA
$total_inclusive_vat = $price + $vat_amount; // Total incluant la TVA

// Création du contenu HTML pour le PDF
$html = '
<style>
    body {
         font-family: "tajawal", sans-serif;  /* Vérifiez que le nom ici correspond au nom de votre police ajoutée */
        text-align: right;
        direction: rtl;
        margin: 0;
        position: relative; 
        min-height: 100vh; 
        padding-bottom: 60px; 
    }
    .header-bar {
        position: absolute;
        top: 0;
        left: 30%;
        transform: translateX(-50%);
        width: 40%;
        height: 30px;
        background-color: #000000;
    }
    h1 {
        font-size: 24px;
        color: #000;
        text-align: center;
        margin-top: 50px;
    }
    .date {
        font-size: 16px;
        text-align: center;
        margin-top: 10px;
    }
    table {
        width: 100%;
        border-collapse: collapse;
        margin-top: 20px;
        margin-bottom: 50px;

    }
    table, th, td {
        border: 1px solid #ddd;
        padding: 8px;
    }
    th {
        background-color: #000;  
        color: white;  
    }
    p {
        margin: 5px 0;
    }
    .footer {
        position: absolute;
        bottom: 0;
        left: 0;
        width: 100%;
        height: 50px; 
        background-color: #000; 
        color: #fff; 
        text-align: center; 
        line-height: 50px; 
    }
</style>

<div class="header-bar"></div>
<h1>فاتورة استلام طلب رقم ' . htmlspecialchars($order_details['order_number']) . '</h1>
<div class="date">اليوم: ' . htmlspecialchars($day_name) . ' | التاريــــخ: ' . htmlspecialchars($current_date) . '</div>
<div>الفرع: ' . htmlspecialchars($order_details['branch_name']) . '</div>
<div>المرسل: ' . htmlspecialchars($order_details['sender']) . '</div>
';

if ($order_details) {
    $html .= '
    <table>
        <tr>
            <th>التفاصيل</th>
            <th>السعر</th>
            <th>الكمية</th>
         </tr>
        <tr>
            <td>' . nl2br(htmlspecialchars($order_details['details'])) . '</td>
            <td>' . htmlspecialchars(number_format($price, 2)) . ' </td>
            <td>' . htmlspecialchars($order_details['execution_time']) . '</td>
         </tr>
    </table>
    ';

    $html .= '
    <table>
        <tr>
            <th>الملاحظات</th>
         
         </tr>
        <tr>
            <td>' . ( ($order_details['notes'])) . '</td>
     
         </tr>
    </table>
    ';
} else {
    $html .= '<p>لم يتم العثور على تفاصيل الطلب.</p>';
}

$html .= '
<p>الاجمالي غير شامل ضريبة القيمة المضافة: ' . htmlspecialchars(number_format($price, 2)) . '</p>
<p>ضريبة القيمة المضافة: ' . htmlspecialchars(number_format($vat_amount, 2)) . '</p>
<p>الاجمالي شامل ضريبة القيمة المضافة: ' . htmlspecialchars(number_format($total_inclusive_vat, 2)) . '</p>
';

// Ajout des conditions
$html .= '
<div style="margin-top: 400px; font-size: 16px;">
    <p>يحق للفرع اعتراض الطلب في عدم مطابقة الطلب مع التفاصيل المضافة فقط.</p>
    <p>الفواتير شامله لضريبة القيمة المضافة.</p>
    <p>مدة مراجعه الطلب 12 ساعه فقط ولايحق طلب اي اعتراض بعده.</p>
</div>
';

// Ajout du footer
$html .= '
<div class="footer">
    اسم الشركة: 
</div>
';

// Charger le contenu HTML dans mPDF
$mpdf->WriteHTML($html);

// Sortie du fichier PDF pour téléchargement
$mpdf->Output('طلب رقم_' . $order_details['order_number']. '.pdf', 'D'); // 'D' pour forcer le téléchargement
?>
