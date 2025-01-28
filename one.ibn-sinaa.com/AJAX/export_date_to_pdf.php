<?php
require '../vendor/autoload.php'; // Charger mPDF
require '../SYS/db.php'; // Charger la connexion à la base de données

use Mpdf\Mpdf;

// Initialisation de mPDF
$mpdf = new Mpdf([
    'mode' => 'utf-8',
    'format' => 'A4',
    'default_font' => 'dejavusans',
    'autoScriptToLang' => true,
    'autoLangToFont' => true,
    'directionality' => 'rtl'
]);

// Récupérer la date actuelle ou la date passée en paramètre
$start_date = isset($_GET['start_date']) ? $_GET['start_date'] : date('Y-m-d');

// Récupérer les commandes du jour
$sql = "SELECT orders.*, branches.branch_name 
        FROM orders 
        JOIN branches ON branches.branch_id = orders.branch_id 
        WHERE delivery_date = :start_date";
$stmt = $db->prepare($sql);
$stmt->bindParam(':start_date', $start_date);
$stmt->execute();
$orders = $stmt->fetchAll(PDO::FETCH_ASSOC);

// Calculer le total des commandes et des prix depuis SQL
$sql_totals = "SELECT 
                COUNT(*) AS total_count, 
                COALESCE(SUM(price), 0) AS total_price 
            FROM orders 
            WHERE delivery_date = :start_date";
$stmt_totals = $db->prepare($sql_totals);
$stmt_totals->bindParam(':start_date', $start_date);
$stmt_totals->execute();
$totals = $stmt_totals->fetch(PDO::FETCH_ASSOC);

// Construire le contenu HTML
$html = '
<style>
    body {
        font-family: "dejavusans", sans-serif;
        text-align: right;
        direction: rtl;
        margin: 0;
        position: relative; /* Ajout de position relative pour le footer */
        min-height: 100vh; /* S’assurer que le corps prend toute la hauteur */
        padding-bottom: 60px; /* Espacement pour le footer */
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
        font-size: 30px;
        color: #000;
        text-align: center;
        margin-top: 50px;
    }
    h3{
            text-align: center;

}

    .date-info {
        font-size: 16px;
        margin-top: 10px;
        margin-bottom: 20px;
        text-align: right;
    }
    table {
        width: 100%;
        border-collapse: collapse;
        margin-top: 40px;
    }
    th {
        background-color: #000;
        color: #fff;
        padding: 10px;
        text-align: center;
        font-size: 16px;
    }
    td {
        border: 1px solid #ddd;
        padding: 10px;
        text-align: center;
        font-size: 16px;
    }
    .totals {
        font-size: 16px;
        margin-top: 20px;
        text-align: right;
        border-top: 2px solid #000;
        padding-top: 10px;
    }
    .totals p {
        margin: 5px 0;
        color: #000;
    }
    .footer {
        position: absolute;
        bottom: 0;
        left: 0;
        width: 100%;
        height: 50px; /* Hauteur du footer */
        background-color: #000; /* Couleur de fond du footer */
        color: #fff; /* Couleur du texte du footer */
        text-align: center; /* Centre le texte */
        line-height: 50px; /* Centrer le texte verticalement */
    }
</style>
<div class="header-bar"></div>

"<h1>تقرير الطلبات ليوم ' . htmlspecialchars($start_date) . '</h1>
<p class="date-info">اليوم: ' . date('Y-m-d') . '</p>

<h3  >قائمة الطلبات</h3>
 <table>
    <thead>
        <tr>
            <th>رقم الطلب</th>
            <th>الفرع</th>
            <th>تفاصيل الطلب</th>
            <th>السعر</th>
            <th>الكمية</th>
            <th>تاريخ الإنشاء</th>
        </tr>
    </thead>
    <tbody>';

// Ajouter les commandes au tableau
if ($orders) {
    foreach ($orders as $order) {
        $html .= '<tr>
            <td>' . htmlspecialchars($order['order_number']) . '</td>
            <td>' . htmlspecialchars($order['branch_name']) . '</td>
            <td>' . htmlspecialchars($order['details']) . '</td>
            <td>' . number_format($order['price'], 2) . '</td>
            <td>' . htmlspecialchars($order['execution_time']) . '</td>
            <td>' . htmlspecialchars($order['created_at']) . '</td>
        </tr>';
    }
} else {
    $html .= '<tr><td colspan="6">لا توجد بيانات متاحة</td></tr>';
}

// Fermer le tableau des commandes
$html .= '</tbody>
</table>';

// Ajouter le tableau des totaux
$html .= '
<table class="table table-striped table-bordered" id="total-orders-table" style="margin-top: 20px; width: 100%; border-collapse: collapse; text-align: center;">
    <thead>
        <tr>
            <th>إجمالي عدد الطلبات</th>
            <th>إجمالي أسعار الطلبات</th>
        </tr>
    </thead>
    <tbody>
        <tr>
            <td id="total-orders-count">' . htmlspecialchars($totals['total_count']) . '</td>
            <td id="total-orders-price">' . number_format($totals['total_price'], 2) . '</td>
        </tr>
    </tbody>
</table>';
// Ajout du footer
$html .= '
<div class="footer">
 </div>
';
// Générer et envoyer le fichier PDF
$mpdf->WriteHTML($html);
$mpdf->Output(  htmlspecialchars($start_date) .'تقرير_الطلبات_اليومية.pdf', 'D'); // Forcer le téléchargement
?>
