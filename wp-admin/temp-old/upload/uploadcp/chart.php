<?
/*
#####################################################################################################
#							Powerd By : Traidnt                                                     #
#                                                                                                   #
# @@@@@@@@@@@@  @@@@@@@@          @@@@        @@@@  @@@@@@@@@@      @@@@      @@@@  @@@@@@@@@@@@    #
#     @@@@      @@@@  @@@@      @@@@@@@@      @@@@  @@@@    @@@@    @@@@@@    @@@@      @@@@        #
#     @@@@      @@@@  @@@@      @@@@@@@@      @@@@  @@@@      @@@@  @@@@@@@@  @@@@      @@@@        #
#     @@@@      @@@@  @@@@      @@    @@@@    @@@@  @@@@      @@@@  @@@@  @@  @@@@      @@@@        #
#     @@@@      @@@@@@@@      @@@@    @@@@    @@@@  @@@@      @@@@  @@@@  @@@@@@@@      @@@@        #
#     @@@@      @@@@  @@@@    @@@@@@@@@@@@    @@@@  @@@@      @@@@  @@@@    @@@@@@      @@@@        #
#     @@@@      @@@@  @@@@  @@@@        @@@@  @@@@  @@@@    @@@@    @@@@    @@@@@@      @@@@        #
#     @@@@      @@@@    @@  @@@@        @@@@  @@@@  @@@@@@@@@@      @@@@      @@@@      @@@@        #
#                                                                                                   #
#					                                                                                #
#####################################################################################################
*/

	ob_start("ob_gzhandler");
	define('traidnt','allow');


    //include Admin Query
    include("./adminquery.php");

    if(!isset($_COOKIE[trupuser])){

    	$traidnt->display("login.tpl");
        exit();
    }

		include("./traidnt.php");

     	$filesquery = $db->query("SELECT * FROM `files`  ");
        $totalfiles = $db->resultcount($filesquery);

        if($totalfiles == 0){
        header('Content-type: image/jpeg');
		header("Cache-Control: no-cache, must-revalidate");
		header("Expires: Mon, 26 Jul 1997 05:00:00 GMT");
        $read = readfile("./images/nofiles.jpg");
        unset($read);
        exit();
        }

       // Draw Chart
       $exquery = $db->query("SELECT * FROM `extension` ORDER BY `extension`.`ex_id` DESC ");
       $totalex = $db->resultcount($exquery);

      	 while($db->fetchrow($exquery)){
      			$ex = $ex.$db->record[ex_name]."*";
      		   	$num = $num.getcount($db->record[ex_name])."*";
     	 }


		$show_label = true;
		$show_percent = true;
		$show_text = true;
		$show_parts = false;
		$label_form = 'round';
		$width = 199;
		$background_color = 'EDF1F3';
		$text_color = '000000';
		$colors = array('003366', 'CCD6E0', '7F99B2','F7EFC6', 'C6BE8C', 'CC6600','990000','520000','BFBFC1','808080');
		$shadow_height = 16;
		$shadow_dark = true;


		$data = $num;
		$label = $ex;
		$limit = $totalex;

		$height = $width/2;
		$data = explode('*',$data,$limit);

		if ($label != '') $label = explode('*',$label,$limit);

			for ($i = 0; $i < count($label); $i++)
			{
				if ($data[$i]/array_sum($data) < 0.1) $number[$i] = ' '.number_format(($data[$i]/array_sum($data))*100,1,',','.').'%';
				else $number[$i] = number_format(($data[$i]/array_sum($data))*100,1,',','.').'%';
				if (strlen($label[$i]) > $text_length) $text_length = strlen($label[$i]);
			}

if (is_array($label))
{
$antal_label = count($label);
$xtra = (5+15*$antal_label)-($height+ceil($shadow_height));
if ($xtra > 0) $xtra_height = (5+15*$antal_label)-($height+ceil($shadow_height));

$xtra_width = 5;
if ($show_label) $xtra_width += 20;
if ($show_percent) $xtra_width += 45;
if ($show_text) $xtra_width += $text_length*8;
if ($show_parts) $xtra_width += 35;
}

$img = ImageCreateTrueColor($width+$xtra_width, $height+ceil($shadow_height)+$xtra_height);

ImageFill($img, 0, 0, colorHex($img, $background_color));

foreach ($colors as $colorkode)
{
	$fill_color[] = colorHex($img, $colorkode);
	$shadow_color[] = colorHexshadow($img, $colorkode, $shadow_dark);
}

$label_place = 5;

if (is_array($label))
{
for ($i = 0; $i < count($label); $i++)
{
	if ($label_form == 'round' && $show_label)
	{
		imagefilledellipse($img,$width+11,$label_place+5,10,10,colorHex($img, $colors[$i % count($colors)]));
		imageellipse($img,$width+11,$label_place+5,10,10,colorHex($img, $text_color));
	}
	else if ($label_form == 'square' && $show_label)
	{
		imagefilledrectangle($img,$width+6,$label_place,$width+16,$label_place+10,colorHex($img, $colors[$i % count($colors)]));
		imagerectangle($img,$width+6,$label_place,$width+16,$label_place+10,colorHex($img, $text_color));
	}

	if ($show_percent) $label_output = $number[$i].' ';
	if ($show_text) $label_output = $label_output.$label[$i].' ';
	if ($show_parts) $label_output = $label_output.$data[$i];

	imagestring($img,'2',$width+20,$label_place,$label_output,colorHex($img, $text_color));
	$label_output = '';

	$label_place = $label_place + 15;
}
}
$centerX = round($width/2);
$centerY = round($height/2);
$diameterX = $width-4;
$diameterY = $height-4;

$data_sum = array_sum($data);

$start = 270;

for ($i = 0; $i < count($data); $i++)
{
	$value += $data[$i];
	$end = ceil(($value/$data_sum)*360) + 270;
	$slice[] = array($start, $end, $shadow_color[$value_counter % count($shadow_color)], $fill_color[$value_counter % count($fill_color)]);
	$start = $end;
	$value_counter++;
}

for ($i=$centerY+$shadow_height; $i>$centerY; $i--)
{
	for ($j = 0; $j < count($slice); $j++)
	{
		ImageFilledArc($img, $centerX, $i, $diameterX, $diameterY, $slice[$j][0], $slice[$j][1], $slice[$j][2], IMG_ARC_PIE);
	}
}

for ($j = 0; $j < count($slice); $j++)
{
	ImageFilledArc($img, $centerX, $centerY, $diameterX, $diameterY, $slice[$j][0], $slice[$j][1], $slice[$j][3], IMG_ARC_PIE);
}

OutputImage($img);
ImageDestroy($img);


function colorHex($img, $HexColorString)
{
		$R = hexdec(substr($HexColorString, 0, 2));
		$G = hexdec(substr($HexColorString, 2, 2));
		$B = hexdec(substr($HexColorString, 4, 2));
		return ImageColorAllocate($img, $R, $G, $B);
}

function colorHexshadow($img, $HexColorString, $mork)
{
	$R = hexdec(substr($HexColorString, 0, 2));
	$G = hexdec(substr($HexColorString, 2, 2));
	$B = hexdec(substr($HexColorString, 4, 2));

	if ($mork)
	{
		($R > 99) ? $R -= 100 : $R = 0;
		($G > 99) ? $G -= 100 : $G = 0;
		($B > 99) ? $B -= 100 : $B = 0;
	}
	else
	{
		($R < 220) ? $R += 35 : $R = 255;
		($G < 220) ? $G += 35 : $G = 255;
		($B < 220) ? $B += 35 : $B = 255;
	}

	return ImageColorAllocate($img, $R, $G, $B);
}

function OutputImage($img)
{
	header('Content-type: image/jpg');
	ImageJPEG($img,NULL,100);
}

?>
