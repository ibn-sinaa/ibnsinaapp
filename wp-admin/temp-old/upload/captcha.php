<?php
session_start();

$md5 = md5(microtime() * mktime());

$string = substr($md5,0,5);

$captcha = imagecreatefrompng("./images/captcha.png");


function Hxdec_arr($color){
$int = hexdec($color);
$arr = array("red" => 0xFF & ($int >> 0x10),
"green" => 0xFF & ($int >> 0x8),
"blue" => 0xFF & $int);
return $arr;
}

$black = imagecolorallocate($captcha, 0, 0, 0);

$c1 = Hxdec_arr('DAEDF6');
$c2 = Hxdec_arr('9CB7C4');

$line = imagecolorallocate($captcha,$c1["red"],$c1["green"],$c1["blue"]);
$line2 = imagecolorallocate($captcha,$c2["red"],$c2["green"],$c2["blue"]);

imageline($captcha,0,0,39,29,$line);
imageline($captcha,-100,57,34,8,$line2);
imageline($captcha,0,0,39,29,$line);
imageline($captcha,40,0,64,29,$line2);
imageline($captcha,10,-80,90,-50,$line2);
imageline($captcha,-50,0,10,5,$line2);



imagestring($captcha,5, 20, 1, $string, $c1);



$_SESSION['key'] = md5($string);

header("Content-type: image/png");
imagepng($captcha);


?>
