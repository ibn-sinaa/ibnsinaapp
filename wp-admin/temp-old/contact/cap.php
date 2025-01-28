<?php
session_start();

$img    = imagecreatefrompng('black.png'); 
$numero = rand(5678,9876);
$_SESSION['check'] = ($numero); 
$white = imagecolorallocate($img, 255, 255, 255); 
imagestring($img, 5, 5, 3, $numero, $white);
header ("Content-type: image/png");
imagepng($img);

/*$captcha = imagecreatefrompng("./captcha.png"); 
header("Content-type: image/png");
$capcha_image = imagecreate(120, 40);
$bg_color     = imagecolorallocate($capcha_image, 0, 0, 0);
$text_color   = imagecolorallocate($capcha_image, 255, 255, 255);
$capcha_text  = 
imagestring($capcha_image, 6, 20, 12,  $capcha_text, $text_color);
imagepng($capcha_image);
imagedestroy($capcha_image);*/

?>