<?
/*
#############################
	Traidnt Up v 2.0
    http://traidnt.net
############################
*/

 if (!defined('traidnt')) {
    die("Error: 404 Not Found");
 }


	 function charset ($variable){

   		$variable =  iconv("windows-1256","UTF-8",$variable);
   		return($variable);
	 }

 	function get ($variable){
  		$variable = trim($variable);
  		$variable = strip_tags($variable);
  		//$variable = mysql_real_escape_string($variable);
  		return($variable);
 	}

	function valid_email($str)
	{
		return ( ! preg_match("/^([a-z0-9\+_\-]+)(\.[a-z0-9\+_\-]+)*@([a-z0-9\-]+\.)+[a-z]{2,6}$/ix", $str)) ? FALSE : TRUE;
	}

 function watermark($name, $ext, $logo){

	if (preg_match("/jpg|jpeg/",$ext)){$src_img=imagecreatefromjpeg($name);}
	if (preg_match("/png/",$ext)){$src_img=imagecreatefrompng($name);}
	if (preg_match("/gif/",$ext)){$src_img=imagecreatefromgif($name);}

	$src_logo = imagecreatefrompng($logo);

    $bwidth  = imageSX($src_img);
    $bheight = imageSY($src_img);
    $lwidth  = imageSX($src_logo);
    $lheight = imageSY($src_logo);

	//fix bug for 1beta3
	if ( $bwidth > 160 &&  $bheight > 130 ) {

    $src_x = $bwidth - ($lwidth + 5);
    $src_y = $bheight - ($lheight + 5);
    ImageAlphaBlending($src_img, true);
    ImageCopy($src_img,$src_logo,$src_x,$src_y,0,0,$lwidth,$lheight);

	if (preg_match("/jpg|jpeg/",$ext)){imagejpeg($src_img, $name);}
	if (preg_match("/png/",$ext)){imagepng($src_img, $name);}
	if (preg_match("/gif/",$ext)){imagegif($src_img, $name);}

	}# < 150
	else
	{
	return false;
	}

}




  function file_get_content($filename, $incpath = false, $resource_context = null) {
    if (false === $fh = fopen($filename, 'rb', $incpath)) {
      user_error('file_get_contents() failed to open stream: No such file or directory', E_USER_WARNING);
      return false;
    }

    clearstatcache();
    if ($fsize = @filesize($filename)) {
      $data = fread($fh, $fsize);
    } else {
      $data = '';
      while (!feof($fh)) {
        $data .= fread($fh, 8192);
      }
    }

    fclose($fh);
    return $data;
  }



/*
	source :http://icant.co.uk/articles/phpthumbnails/
*/
function createthumb($name,$ext,$filename,$new_w,$new_h)
{

	if (preg_match("/jpg|jpeg/",$ext)){$src_img=imagecreatefromjpeg($name);}
	if (preg_match("/png/",$ext)){$src_img=imagecreatefrompng($name);}
	if (preg_match("/gif/",$ext)){$src_img=imagecreatefromgif($name);}

	$old_x=imageSX($src_img);
	$old_y=imageSY($src_img);

	if ($old_x > $old_y)
	{
		$thumb_w=$new_w;
		$thumb_h=$old_y*($new_h/$old_x);
	}
	elseif ($old_x < $old_y)
	{
		$thumb_w=$old_x*($new_w/$old_y);
		$thumb_h=$new_h;
	}
	elseif ($old_x == $old_y)
	{
		$thumb_w=$new_w;
		$thumb_h=$new_h;
	}
	$dst_img=ImageCreateTrueColor($thumb_w,$thumb_h);
	imagecopyresampled($dst_img,$src_img,0,0,0,0,$thumb_w,$thumb_h,$old_x,$old_y);

	if (preg_match("/jpg|jpeg/",$ext)){imagejpeg($dst_img,$filename);}
	if (preg_match("/png/",$ext)){imagepng($dst_img,$filename);}
	if (preg_match("/gif/",$ext)){imagegif($dst_img,$filename);}

	imagedestroy($dst_img);
	imagedestroy($src_img);
}

				$disallow = array("text/html",
		          "text/plain",
        		  "magnus-internal/shellcgi",
		          "application/x-php",
        		  "text/php",
          		  "application/x-httpd-php" ,
         		  "application/php",
          		  "magnus-internal/shellcgi",
         		  "text/x-perl",
          		  "application/x-perl",
          		  "application/x-exe",
          		  "application/exe",
          		  "application/x-java" ,
          		  "application/java-byte-code",
          		  "application/x-java-class",
          		  "application/x-java-vm",
          		  "application/x-java-bean",
          		  "application/x-jinit-bean",
          		  "application/x-jinit-applet",
          		  "magnus-internal/shellcgi",
          		  "image/svg",
          		  "image/svg-xml",
          		  "image/svg+xml",
          		  "text/xml-svg",
          		  "image/vnd.adobe.svg+xml",
    		      "image/svg-xml",
        		  "text/xml",

       				);

define ('GOOGLE_MAGIC', 0xE6359A60);

   //This class should work on most servers
   function zeroFill($a, $b)
   {
      $z = hexdec (80000000);
      if ($z & $a)
      {
         $a = ($a>>1);
         $a &= (~$z);
         $a |= 0x40000000;
         $a = ($a>>($b-1));
       }
       else
       {
         $a = ($a>>$b);
       }

       return $a;
    }

   function xor32($a, $b)
   {
      return int32($a) ^ int32($b);
   }

   //return least significant 32 bits
   //works by telling unserialize to create an integer even though we provide a double value
   function int32($x)
   {
      return unserialize ("i:$x;");
      //return intval($x); // This line doesn't work on all servers.
   }

   function mix($a,$b,$c)
   {
      $a -= $b; $a -= $c; $a = xor32($a,zeroFill($c,13));
      $b -= $c; $b -= $a; $b = xor32($b,$a<<8);
      $c -= $a; $c -= $b; $c = xor32($c,zeroFill($b,13));
      $a -= $b; $a -= $c; $a = xor32($a,zeroFill($c,12));
      $b -= $c; $b -= $a; $b = xor32($b,$a<<16);
      $c -= $a; $c -= $b; $c = xor32($c,zeroFill($b,5));
      $a -= $b; $a -= $c; $a = xor32($a,zeroFill($c,3));
      $b -= $c; $b -= $a; $b = xor32($b,$a<<10);
      $c -= $a; $c -= $b; $c = xor32($c,zeroFill($b,15));

      return array($a,$b,$c);
   }

   function GoogleCH($url, $length=null, $init=GOOGLE_MAGIC)
   {
      if (is_null ($length))
      {
         $length = sizeof ($url);
      }
      $a = $b = 0x9E3779B9;
      $c = $init;
      $k = 0;
      $len = $length;

      while ($len >= 12)
      {
         $a += ($url[$k+0] +($url[$k+1]<<8) +($url[$k+2]<<16) +($url[$k+3]<<24));
         $b += ($url[$k+4] +($url[$k+5]<<8) +($url[$k+6]<<16) +($url[$k+7]<<24));
         $c += ($url[$k+8] +($url[$k+9]<<8) +($url[$k+10]<<16)+($url[$k+11]<<24));
         $mix = mix($a,$b,$c);
         $a = $mix[0]; $b = $mix[1]; $c = $mix[2];
         $k += 12;
         $len -= 12;
     }
     $c += $length;
     switch ($len)
     {
         case 11: $c+=($url[$k+10]<<24);
         case 10: $c+=($url[$k+9]<<16);
         case 9 : $c+=($url[$k+8]<<8);
         /* the first byte of c is reserved for the length */
         case 8 : $b+=($url[$k+7]<<24);
         case 7 : $b+=($url[$k+6]<<16);
         case 6 : $b+=($url[$k+5]<<8);
         case 5 : $b+=($url[$k+4]);
         case 4 : $a+=($url[$k+3]<<24);
         case 3 : $a+=($url[$k+2]<<16);
         case 2 : $a+=($url[$k+1]<<8);
         case 1 : $a+=($url[$k+0]);
      }
      $mix = mix($a,$b,$c);
      /* report the result */
      return $mix[2];
   }



   //converts a string into an array of integers containing the numeric value of the char
   function strord($string)
   {
      for ($i=0; $i < strlen ($string); $i++)
      {
            $result[$i] = ord ($string{$i});
      }
      return $result;
   }

   //returns -1 if no page rank was found
   function get_page_rank($url)
   {
        $ch = "6".GoogleCH(strord("info:" . $url));

        $pagerank = -1;
        $fp = @ fsockopen ("www.google.com", 80, $errno, $errstr, 10);
        if (!$fp)
        {
            echo "$errstr ($errno)<br />\n";
        }
        else
        {
            $out  = "GET /search?client=navclient-auto&ch=" . $ch .  "&features=Rank&q=info:" . $url . " HTTP/1.1\r\n" ;
            $out .= "Host: www.google.com\r\n" ;
            $out .= "Connection: Close\r\n\r\n" ;
            @ fwrite ($fp, $out);

            while (!feof ($fp))
            {
                $data = @ fgets ($fp, 128);
                $pos  = strpos ($data, "Rank_");

                if ($pos !== false)
                {
                  $pagerank = trim (substr ($data, $pos + 9));
                }
            }
            @ fclose ($fp);
        }

     $i=0;

        return $pagerank;
    }




?>