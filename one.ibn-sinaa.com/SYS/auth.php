<?php
include_once 'db.php';
include '../vendor/autoload.php';
use Delight\Auth\Auth;
use Delight\Db\PdoDatabase;
// Connexion à la base de données
$auth = new Auth($db);
