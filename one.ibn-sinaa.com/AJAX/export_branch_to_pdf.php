<?php
require '../vendor/autoload.php'; // Charger les dépendances mPDF
require '../SYS/db.php'; // Charger la connexion à la base de données

use Mpdf\Mpdf;

// Initialisation de mPDF avec des options pour la prise en charge de l'arabe
$mpdf = new Mpdf([
    'mode' => 'utf-8',
    'format' => 'A4',
    'default_font' => 'dejavusans',
    'autoScriptToLang' => true,
    'autoLangToFont' => true,
    'directionality' => 'rtl'
]);

$branch_id = isset($_GET['branch_id']) ? $_GET['branch_id'] : null;

if (!$branch_id) {
    die('Erreur : Aucun identifiant de branche fourni.');
}

// Récupération des données pour le rapport
$start_date = isset($_GET['start_date']) ? $_GET['start_date'] : null;
$end_date = isset($_GET['end_date']) ? $_GET['end_date'] : null;

// Fonction pour récupérer les totaux des commandes
$sql = "SELECT 
            branches.branch_name AS branch_name, 
            COUNT(orders.order_id) AS total_orders, 
            SUM(orders.price) AS total_price,
            JSON_ARRAYAGG(JSON_OBJECT(
                'order_number', orders.order_number,
                'sender', orders.sender,
                'details', orders.details,
                'price', orders.price,
                'execution_time', orders.execution_time,
                'created_at', DATE(orders.created_at)
            )) AS order_details
        FROM orders
        JOIN branches ON branches.branch_id = orders.branch_id";

// Conditions supplémentaires selon les filtres
$conditions = [];
if (!empty($start_date) && !empty($end_date)) {
    $conditions[] = "orders.order_date BETWEEN :start_date AND :end_date";
} elseif (!empty($start_date)) {
    $conditions[] = "orders.order_date >= :start_date";
} elseif (!empty($end_date)) {
    $conditions[] = "orders.order_date <= :end_date";
}

if (!empty($branch_id)) {
    $conditions[] = "orders.branch_id = :branch_id";
}

// Si des conditions existent, ajouter une clause WHERE
if (!empty($conditions)) {
    $sql .= " WHERE " . implode(' AND ', $conditions);
}

// Ajouter un GROUP BY correct pour les colonnes agrégées
$sql .= " GROUP BY branches.branch_name";

// Préparer et exécuter la requête
$stmt = $db->prepare($sql);

// Lier les paramètres dynamiquement
if (!empty($start_date) && !empty($end_date)) {
    $stmt->bindParam(':start_date', $start_date, PDO::PARAM_STR);
    $stmt->bindParam(':end_date', $end_date, PDO::PARAM_STR);
}
if (!empty($start_date) && empty($end_date)) {
    $stmt->bindParam(':start_date', $start_date, PDO::PARAM_STR);
}
if (empty($start_date) && !empty($end_date)) {
    $stmt->bindParam(':end_date', $end_date, PDO::PARAM_STR);
}
if (!empty($branch_id)) {
    $stmt->bindParam(':branch_id', $branch_id, PDO::PARAM_INT);
}

$stmt->execute();
$order_totals = $stmt->fetch(PDO::FETCH_ASSOC);

if (!$order_totals) {
    die('Erreur : Aucune donnée trouvée pour cette branche.');
}

// Obtenir le nom du jour en arabe
$days_arabic = [
    'Sunday' => 'الأحد',
    'Monday' => 'الإثنين',
    'Tuesday' => 'الثلاثاء',
    'Wednesday' => 'الأربعاء',
    'Thursday' => 'الخميس',
    'Friday' => 'الجمعة',
    'Saturday' => 'السبت'
];
$day_name = $days_arabic[date('l')];

// Calcul des totaux avec TVA de 15 %
$tv_rate = 0.15; // Taux de TVA (15 %)
$total_tax = $order_totals['total_price'] * $tv_rate; // Montant de la TVA
$total_price = $order_totals['total_price'] + $total_tax?: 0;
$total_without_tax = $order_totals['total_price']; // Montant hors TVA

// Création du contenu HTML pour le PDF
$html = '
<style>
    body {
        font-family: "dejavusans", sans-serif;
        text-align: right;
        direction: rtl;
        margin: 0;
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
<h1>تقرير إجمالي للطلبات حسب الفرع</h1>
<p class="date-info">اليوم: ' . $day_name . ' ' . date('Y-m-d') . '</p>
<p class="date-info">من: ' . htmlspecialchars($start_date) . ' إلى: ' . htmlspecialchars($end_date) . '</p>
';

if ($order_totals) {
    $html .= '
    <table>
        <thead>
            <tr>
                <th>الفرع المرسل</th>
                <th>إجمالي الطلبات</th>
                <th>إجمالي الأسعار</th>
            </tr>
        </thead>
        <tbody>
            <tr>
                <td>' . htmlspecialchars($order_totals['branch_name']) . '</td>
                <td>' . htmlspecialchars($order_totals['total_orders']) . '</td>
                <td>' . htmlspecialchars(number_format($order_totals['total_price'], 2, '.', '')) . '</td>
            </tr>
        </tbody>
    </table>';

    $order_details = json_decode($order_totals['order_details'], true);
    $html .= '<h3>تفاصيل الطلبات</h3>';
    $html .= '<table border="1">';
    $html .= '<tr><th>رقم الطلب</th><th>المرسل</th><th>التفاصيل</th><th>السعر</th><th>الكمية </th><th>تاريخ الإنشاء</th></tr>';

    if (!empty($order_details)) {
        foreach ($order_details as $order) {
            $html .= '<tr>
                <td>' . htmlspecialchars($order['order_number']) . '</td>
                <td>' . htmlspecialchars($order['sender']) . '</td>
                <td>' . htmlspecialchars($order['details']) . '</td>
                <td>' . htmlspecialchars(number_format($order['price'], 2)) . '</td>
                <td>' . htmlspecialchars($order['execution_time']) . '</td>
                <td>' . ($order['created_at']) . '</td>
            </tr>';
        }
    } else {
        $html .= '<tr><td colspan="6">لم يتم العثور على بيانات.</td></tr>';
    }

    $html .= '</table>';
} else {
    $html .= '<p>لم يتم العثور على تفاصيل الطلبات.</p>';
}

$html .= '
<div class="totals">
    <p>الاجمالي غير شامل ضريبة القيمة المضافة: ' . number_format($total_without_tax, 2, '.', '') . '</p>
    <p>ضريبة القيمة المضافة: ' . number_format($total_tax, 2, '.', '') . '</p>
    <p>الاجمالي: ' . number_format($total_price, 2, '.', '') . '</p>
</div>';
$html .= '
<div class="footer">
ابن سينا للطباعة والدعاية والاعلان
 </div>
';

// Génération du fichier PDF
$mpdf->WriteHTML($html);
$mpdf->Output('تقرير الطلبات ' . htmlspecialchars($order_totals['branch_name']) . '.pdf', 'D'); // 'D' pour forcer le téléchargement
?>