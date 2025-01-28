<?php
require '../vendor/autoload.php'; // Charger les dépendances mPDF
use Mpdf\Mpdf;

// Vérifiez si les données sont envoyées via POST
if (isset($_POST['userData'])) {
    // Récupérer les données envoyées par AJAX
    $userData = json_decode($_POST['userData'], true);

    // Récupérer le nom de l'utilisateur
    $username = isset($userData['username']) ? htmlspecialchars($userData['username']) : ' ';

    // Initialisation de mPDF avec des options
    $mpdf = new Mpdf([
        'mode' => 'utf-8',
        'format' => 'A4',
        'default_font' => 'dejavusans',
        'autoScriptToLang' => true,
        'autoLangToFont' => true
    ]);

    // Création du contenu HTML pour le PDF
    $html = '
    <style>
        body {
            font-family: "dejavusans", sans-serif;
            text-align: right;
            direction: rtl;
            margin: 0;
            padding: 40px;
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

    <h1>تقرير  حسب المرسل</h1>
    <p class="date-info">تاريخ  اصدار التقرير: ' . date('Y-m-d') . '</p>
    <p class="date-info">اسم المرسل: ' . $username . '</p>';  

    // Afficher les données mensuelles
    if (!empty($userData['monthlyData'])) {
        $html .= '
             <table>
                <thead>
                    <tr>
                        <th>الشهر</th>
                        <th>إجمالي الطلبات</th>';
                        
        if ($userData['status'] == "1" || $userData['status'] == "all") {
            $html .= '<th>الطلبات المقبولة</th>';
            $html .= '<th>إجمالي أسعار الطلبات المقبولة</th>';

        }
        
        if ($userData['status'] == "-1" || $userData['status'] == "all") {
            $html .= '<th>الطلبات المرفوضة</th>';
            $html .= '<th>إجمالي أسعار الطلبات المرفوضة</th>';

        }
        if ( $userData['status'] == "all") {

        $html .= '<th>إجمالي الأسعار </th>';
        }
        $html .= '
                    </tr>
                </thead>
                <tbody>';
        
        // Boucle sur les données mensuelles
        foreach ($userData['monthlyData'] as $monthlyData) {
            $html .= '
                    <tr>
                        <td>' . htmlspecialchars($monthlyData['month']) . '</td>
                        <td>' . htmlspecialchars($monthlyData['total_orders']) . '</td>';
            
            if ($userData['status'] == "1") {
                $html .= '<td>' . htmlspecialchars($monthlyData['accepted_orders']) . '</td>';
                $html .= '<td>' . htmlspecialchars($monthlyData['accepted_price']) . '</td>';
            } elseif ($userData['status'] == "-1") {
                $html .= '<td>' . htmlspecialchars($monthlyData['rejected_orders']) . '</td>';
                $html .= '<td>' . htmlspecialchars($monthlyData['rejected_price']) . '</td>';
            } elseif ($userData['status'] == "all") {
                $html .= '<td>' . htmlspecialchars($monthlyData['accepted_orders']) . '</td>';
                $html .= '<td>' . htmlspecialchars($monthlyData['accepted_price']) . '</td>';

                $html .= '<td>' . htmlspecialchars($monthlyData['rejected_orders']) . '</td>';
                $html .= '<td>' . htmlspecialchars($monthlyData['rejected_price']) . '</td>';
                $html .= '<td>' . htmlspecialchars($monthlyData['total_price']) . '</td>';}
            
            $html .= '
                    </tr>';
        }
        
        $html .= '
                </tbody>
            </table>';
    } else {
        $html .= '<p>لا توجد بيانات شهرية متاحة.</p>';
    }
    

    // Afficher les commandes
    if (!empty($userData['orders'])) {
        $html .= '<h2 style="text-align: center;">تفاصيل الطلبات</h2>
        <table>
            <thead>
                <tr>
                    <th>رقم الطلب</th>
                    <th>التاريخ	</th>
                    <th>السعر</th>
                    <th> التفاصيل</th>
                    <th>حاله الطلب</th>
                </tr>
            </thead>
            <tbody>';

        foreach ($userData['orders'] as $order) {
            // Logique pour déterminer si la commande est acceptée ou refusée
            $statusText = '';
            if ($order['valid'] == 1) {
                $statusText = 'مقبول';
            } elseif ($order['valid'] == -1) {
                $statusText = 'مرفوض';
            } else {
                $statusText = ' '; 
            }

            $html .= '<tr>
                <td>' . htmlspecialchars($order['order_number']) . '</td>
                <td>' . htmlspecialchars($order['created_at']) . '</td>
                <td>' . htmlspecialchars(number_format($order['price'], 2, '.', ',')) . ' </td>
                <td>' . htmlspecialchars($order['details']) . '</td>
                <td>' . htmlspecialchars($order['status']) . '</td>

             </tr>';
        }

        $html .= '</tbody>
        </table>';
    }

    // Ajout du footer
    $html .= '
    <div class="footer">
ابن سينا للطباعة والدعاية والاعلان      
    </div>';
    try {
        // Générer le fichier PDF avec le nom de l'utilisateur
        $filePath = 'تقرير المستخدم_' . $username  . '.pdf';
        $mpdf->WriteHTML($html);
        $mpdf->Output($filePath, 'D'); // Sauvegarder le fichier PDF sur le serveur

    } catch (Exception $e) {
        // Gestion des erreurs de mPDF
        echo 'Erreur lors de la génération du PDF : ' . $e->getMessage();
    }
} else {
    echo "Aucune donnée utilisateur reçue.";
}
?>
