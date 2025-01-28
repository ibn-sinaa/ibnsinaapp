<?
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

	switch($_GET[go]){        default:

        	$traidnt->display("sendmessage.tpl");

        break;

        case"send":

			$name = get($_POST[name]);
			$email = get($_POST[email]);
			$msg = get($_POST[msg]);
   			$code =  md5(get($_POST[code]));
            $cp = $_SESSION['key'];

   			//Change charset For VAR
			$name =  iconv("UTF-8","windows-1256",$name);
			$msg =  iconv("UTF-8","windows-1256",$msg);


			// Make List Error

			if($site[gd_admin] == 1){

       			if($cp != $code){
         			$errors = $errors.'ÚİæÇ ßæÏ ÇáÊÍŞŞ ÛíÑ ÕÍíÍ'."<br>";
		       }

			}


			if (valid_email($email)==FALSE)
				{
					$errors = $errors.'ÚİæÇ ÈÑíÏß ÇáÇáßÊÑæäí ÛíÑ ÕÍíÍ'."<br>";
				}

			if ($name == '')
				{
					$errors = $errors.'ÚİæÇ áã ÊŞã ÈÇÏÎÇá ÇÓãß'."<br>";
				}

			if ($msg == '')
				{
					$errors = $errors.'ÚİæÇ áã ÊŞã ÈÇÏÎÇá ÑÓÇáÊß'."<br>";
				}

   		if($errors != ''){
			$traidnt->assign(message,charset($errors."<b><a href='sendmessage.php'>ÇÖÛØ åäÇ ááÚæÏÉ ááÎáİ<a></b>"));
			$traidnt->display("message.tpl");

   		}else{


  		$mail_headers .= "From: ".$name."<" .$email. ">" . "\r\n";
		$mail_headers .= "MIME-Version: 1.0\r\n";
		$mail_headers .= "	X-Priority: ". $Priority . "\r\n";
    	$mail_headers .= "Content-Type: text/html; charset=\"windows-1256\"\r\n";

     	$send = @mail($site[site_mail],"ÑÓÇáÉ ãä ÇáãæŞÚ",$msg,$mail_headers);

		if($send){  			$traidnt->assign(message,charset("Êã ÇÑÓÇá ÑÓÇáÊß ÈäÌÇÍ "));
		}else{  			$traidnt->assign(message,charset("ÚİæÇ åäÇß ãÔßáÉ ÈÇÑÓÇá ÇáÑÓÇáÉ"));

		}

		$traidnt->display("message.tpl");


   		}

        break;
	}

	$traidnt->display("footer.tpl");




$db->disconnect();
ob_end_flush();

?>