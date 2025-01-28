<?
@session_start();

 /*
#############################
	Traidnt Up v 2.0
    http://traidnt.net
############################
*/

	ob_start("ob_gzhandler");
	define('traidnt','allow');
	require 'libs/Smarty.class.php';
	include("includes/class.DB.php");
	include("includes/function.php");
	include("includes/config.php");
    require_once "includes/trquery.php";

	//Get Lang File
	include("language/$site[style_lang]/main.lang");

 	// Get Folder size function
    include("includes/foldersize.php");

    include("includes/rules.php");


	$traidnt->display("header.tpl");

     $email = get($_POST[email]);
     $code =  md5(get($_POST[code]));
     $fileid = get($_POST[fileid]);
     $cp = $_SESSION['key'];

	if (valid_email($email)==FALSE)
		{
			$errors = $errors.'ÚİæÇ ÇáÈÑíÏ ÇáÇáßÊÑæäí ÛíÑ ÕÍíÍ'."<br>";
		}

	if($site[gd_friend] == 1){
       if($cp != $code){         $errors = $errors.'ÚİæÇ ßæÏ ÇáÊÍŞŞ ÛíÑ ÕÍíÍ'."<br>";
       }

	}


 	if($errors != ''){      $traidnt->assign(message,charset($errors."<b><a href='$site[site_link]/view.php?file=$fileid'>ÇäÊÙÑ Óæİ íÊã ÊÍæíáß ááãáİ ãÑÉ ÃÎÑí</a></b>"."<META HTTP-EQUIV='Refresh' CONTENT='2; url=$site[site_link]/view.php?file=$fileid'>"));
      $traidnt->display("message.tpl");
 	}else{
        $subject = "ÑÓÇáÉ ãä ÕÏíŞ";

        $message = "
        ŞÇã ÕÏíŞß áß ÈÏÚæÊß áÒíÇÑÉ Çáãáİ ÇáÊÇáí
        <br>
        <a href='$site[site_link]/view.php?file=$fileid'>$site[site_link]/view.php?file=$fileid</a>
        <br>

        İÑíŞ Úãá  $site[site_name]
        <br>
        $site[site_link]

  		 ";

  		$mail_headers .= "From: ".$site[site_name]."<" .$site[site_mail]. ">" . "\r\n";
		$mail_headers .= "MIME-Version: 1.0\r\n";
		$mail_headers .= "	X-Priority: ". $Priority . "\r\n";
    	$mail_headers .= "Content-Type: text/html; charset=\"windows-1256\"\r\n";

     	$send = @mail($email,$subject,$message,$mail_headers);

        if($send){        	$traidnt->assign(message,$lang[sucfriend]."<META HTTP-EQUIV='Refresh' CONTENT='2; url=$site[site_link]/view.php?file=$fileid'>");
        }else{        	$traidnt->assign(message,$lang[errorfrind]."<META HTTP-EQUIV='Refresh' CONTENT='2; url=$site[site_link]/view.php?file=$fileid'>");
        }

        $traidnt->display("message.tpl");

 	}

	$traidnt->display("footer.tpl");



$db->disconnect();
ob_end_flush();

?>