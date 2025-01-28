<?php

function displayErrors() {
    ini_set('display_errors', 1);
    ini_set('display_startup_errors', 1);
    error_reporting(E_ALL);
}
// Décommenter la ligne suivante si vous voulez voir les erreurs
displayErrors();
function array_addslashes(&$item, $key) { // à utiliser pour les données $_POST : $_GET
    if (!is_array($item) && !is_null($item)) {
        $item = addslashes($item);
    }
}

function array_stripslashes(&$item, $key) { // quand on récupère quelque chose de la BDD 
    if (!is_array($item) && !is_null($item)) {
        $item = stripslashes($item);
        // $item = htmlentities($item);
    }
}

$db_host="127.0.0.1";
$db_port="3306";
$db_name="ibnsina_order_management";
$db_user="ibnsina_admin";
$db_pass="ibnsina_admin";


try {
    // Établir la connexion à la base de données
    $db = new PDO("mysql:host=$db_host;port=$db_port;dbname=$db_name;charset=utf8", $db_user, $db_pass);
    $db->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);
    
    // Définir le fuseau horaire
    $timezone = '+03:00'; // UTC+3 pour La Mecque
    $db->exec('SET @@session.time_zone = "'.$timezone.'";');
    
} catch (PDOException $e) {
    // Afficher un message d'erreur détaillé
    echo 'Erreur de connexion à la base de données : ' . $e->getMessage();
    // Arrête le script en cas d'erreur critique
    exit();
}

// Note: Il n'est pas nécessaire de cacher les erreurs avec @ pour les déboguer
