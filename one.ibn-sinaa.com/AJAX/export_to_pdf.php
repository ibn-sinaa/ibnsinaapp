<?php 
require '../vendor/autoload.php'; // Charger les dépendances mPDF
require '../SYS/db.php'; // Charger la connexion à la base de données

use Mpdf\Mpdf;

// Initialisation de mPDF avec des options de base, y compris la prise en charge de l'arabe
$mpdf = new Mpdf([
    'mode' => 'utf-8',
    'format' => 'A4',
    'default_font' => 'dejavusans', // Utiliser une police qui supporte l'arabe
    'autoScriptToLang' => true, // Active la gestion automatique de la langue pour l'arabe
    'autoLangToFont' => true, // Active la gestion automatique des polices pour différentes langues
    'directionality' => 'rtl' // Direction par défaut pour l'arabe
]);

// Récupération des données pour le rapport
$start_date = isset($_GET['start_date']) ? $_GET['start_date'] : null;
$end_date = isset($_GET['end_date']) ? $_GET['end_date'] : null;
$branch_id = isset($_GET['branch_id']) ? $_GET['branch_id'] : null;

// Fonction pour récupérer le rapport par filiale
function getBranchReport($db, $start_date = null, $end_date = null, $branch_id = null) {
        // Construction de la requête principale
        $sql = "SELECT 
        orders.branch_id, 
        branches.branch_name AS branch_name, 
        COUNT(orders.order_id) AS total_orders, 
        SUM(orders.price) AS total_price,
        JSON_ARRAYAGG(JSON_OBJECT(
            'order_number', orders.order_number,
            'sender', orders.sender, -- Exemple d'attribut
            'datails', orders.details,
            'price', orders.price,
            'execution_time', orders.execution_time,
            'created_at', orders.created_at
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
        $sql .= " GROUP BY orders.branch_id, branches.branch_name";

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

        // Exécuter la requête
        $stmt->execute();
        return $stmt->fetchAll(PDO::FETCH_ASSOC);
}

// Récupérer les données du rapport
$report_data = getBranchReport($db, $start_date, $end_date, $branch_id);

// Création du contenu HTML pour le PDF avec la prise en charge de l'arabe
$html = '<h1 style="text-align:right; font-family:dejavusans;">تقرير حسب الفرع</h1>';
if (!empty($start_date) || !empty($end_date)) {
    $html .= '<h2 style="text-align:right; font-family:dejavusans;">تاريخ البداية: ' . htmlspecialchars($start_date) . ' - تاريخ النهاية: ' . htmlspecialchars($end_date) . '</h2>';
}
if (!empty($branch_id)) {
    // Rechercher le nom de la filiale dans la base de données
    $stmt = $db->prepare("SELECT branch_name FROM branches WHERE branch_id = :branch_id");
    $stmt->bindParam(':branch_id', $branch_id);
    $stmt->execute();
    $branch_name = $stmt->fetchColumn();
    $html .= '<h3 style="text-align:right; font-family:dejavusans;">الفرع: ' . htmlspecialchars($branch_name) . '</h3>';
}

// Alignement à droite du tableau et des cellules
$html .= '<table border="1" cellpadding="5" cellspacing="0" style="text-align:right; font-family:dejavusans; direction: rtl; width: 100%;">';
$html .= '<tr style="background-color: #f2f2f2; text-align:right;">';
$html .= '<th style="padding:5px;">الفرع</th>';
$html .= '<th style="padding:5px;">إجمالي الطلبات</th>';
$html .= '<th style="padding:5px;">إجمالي الأسعار</th>';
$html .= '</tr>';

// Vérifiez si des données ont été retournées
if (!$report_data || !is_array($report_data)) {
    $html .= '<tr><td colspan="3" style="text-align:right;">لم يتم العثور على بيانات.</td></tr>';
} else {
    // Parcourir les données récupérées
    foreach ($report_data as $row) {
        $html .= '<tr>';
        $html .= '<td style="padding:5px;">' . htmlspecialchars($row['branch_id']) . '</td>'; // Afficher l'ID de la filiale
        $html .= '<td style="padding:5px;">' . htmlspecialchars($row['total_orders']) . '</td>';
        $html .= '<td style="padding:5px;">' . htmlspecialchars(number_format($row['total_price'], 2)) . '</td>';
        $html .= '</tr>';
    }
}

$html .= '</table>';
// Afficher les détails des commandes
$html .= '<h3 style="text-align:right; font-family:dejavusans;">تفاصيل الطلبات</h3>';
$html .= '<table border="1" cellpadding="5" cellspacing="0" style="text-align:right; font-family:dejavusans; direction: rtl; width: 100%;">';
$html .= '<tr style="background-color: #f2f2f2; text-align:right;">';
$html .= '<th style="padding:5px;">رقم الطلب</th>';
$html .= '<th style="padding:5px;">المرسل</th>';
$html .= '<th style="padding:5px;">التفاصيل</th>';
$html .= '<th style="padding:5px;">السعر</th>';
$html .= '<th style="padding:5px;">وقت التنفيذ</th>';
$html .= '<th style="padding:5px;">تاريخ الإنشاء</th>';
$html .= '</tr>';

$details_found = false;
foreach ($report_data as $row) {
    // Décoder les détails des commandes
    $order_details = json_decode($row['order_details'], true);
    if (!empty($order_details) && is_array($order_details)) {
        foreach ($order_details as $order) {
            $details_found = true;
            $html .= '<tr>';
            $html .= '<td style="padding:5px;">' . htmlspecialchars($order['order_number']) . '</td>';
            $html .= '<td style="padding:5px;">' . htmlspecialchars($order['sender']) . '</td>';
            $html .= '<td style="padding:5px;">' . htmlspecialchars($order['datails']) . '</td>';
            $html .= '<td style="padding:5px;">' . htmlspecialchars(number_format($order['price'], 2)) . '</td>';
            $html .= '<td style="padding:5px;">' . htmlspecialchars($order['execution_time']) . '</td>';
            $html .= '<td style="padding:5px;">' . htmlspecialchars($order['created_at']) . '</td>';
            $html .= '</tr>';
        }
    }
}

if (!$details_found) {
    $html .= '<tr><td colspan="6" style="text-align:right;">لم يتم العثور على بيانات.</td></tr>';
}
$html .= '</table>';

// Inverser les chaînes si nécessaire (pour l'arabe et direction 'rtl')
if (strtolower($mpdf->directionality) == 'rtl' && !mb_detect_encoding($html, array("ASCII"))) {
    preg_match_all('/./us', $html, $ar);
    $html = join('', array_reverse($ar[0]));
    $html = preg_replace_callback('/\d+-\d+|\d+|\d+\.\d+|\S+@\S+/', function (array $m) {
        return strrev($m[0]);
    }, $html);
}

// Charger le contenu HTML dans mPDF
$mpdf->WriteHTML($html);

// Sortie du fichier PDF pour téléchargement
$mpdf->Output('rapport_filiale.pdf', 'D'); // 'D' pour forcer le téléchargement

?>
