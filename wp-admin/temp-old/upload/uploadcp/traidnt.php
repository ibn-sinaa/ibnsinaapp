<?
 if (!defined('traidnt')) {
    die("Error: 404 Not Found");
	}

	function clean ($voc){       $voc = trim($voc);
       $voc = strip_tags($voc);
       $voc = addslashes($voc);
       $voc = mysql_escape_string($voc);

		return($voc);
	}


 	function charset ($voc){
  	$voc = trim($voc);
  	$voc = iconv('utf-8','windows-1256',$voc);
  	return ($voc);
  	}


  	function charset2 ($voc){
  	$voc = trim($voc);
  	$voc = iconv('windows-1256','utf-8',$voc);
  	return ($voc);
  	}


   function percentage ($total,$this){       $percentage = $this/$total*100;
       $percentage = round($percentage,2);
       return($percentage);
   }

        function getcount($ext){
            $query = mysql_query("SELECT COUNT(*) AS `total` FROM `files` WHERE `files`.`file_tybe` = '$ext'");
            while($total = mysql_fetch_assoc($query)){
               $totals = $total[total];
            }

            return($totals);

       	}

	function valid_email($str)
	{
		return ( ! preg_match("/^([a-z0-9\+_\-]+)(\.[a-z0-9\+_\-]+)*@([a-z0-9\-]+\.)+[a-z]{2,6}$/ix", $str)) ? FALSE : TRUE;
	}




 $traidnt->register_function('report', 'report');

 function report ($params, &$smarty){

 	$why = $params['why'];
    $why = iconv('utf-8','windows-1256',$why);
    return($why);

 }

?>