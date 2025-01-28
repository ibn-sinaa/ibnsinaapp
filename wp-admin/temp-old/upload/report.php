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

     $trtext = get($_POST[trtext]);
     $code =  md5(get($_POST[code]));
     $fileid = get($_POST[fileid]);
     $cp = $_SESSION['key'];

	if ($trtext == '')
		{
			$errors = $errors.'ÚİæÇ ÓÈÈ ÇáÊÈáíÛ İÇÑÛ'."<br>";
		}

	if($site[gd_report] == 1){
       if($cp != $code){         $errors = $errors.'ÚİæÇ ßæÏ ÇáÊÍŞŞ ÛíÑ ÕÍíÍ'."<br>";
       }

	}


 	if($errors != ''){      $traidnt->assign(message,charset($errors."<b><a href='$site[site_link]/view.php?file=$fileid'>ÇäÊÙÑ Óæİ íÊã ÊÍæíáß ááãáİ ãÑÉ ÃÎÑí</a></b>"."<META HTTP-EQUIV='Refresh' CONTENT='2; url=$site[site_link]/view.php?file=$fileid'>"));
      $traidnt->display("message.tpl");
 	}else{        $ip = getenv('REMOTE_ADDR');

		$reportquery = $db->query("INSERT INTO `report` (`report_id` ,`report_key` ,`report_why` ,`report_ip` )
		VALUES ('', '$fileid', '$trtext', '$ip');");

        if($reportquery){
  		$traidnt->assign(message,$lang[report]."<META HTTP-EQUIV='Refresh' CONTENT='2; url=$site[site_link]/view.php?file=$fileid'>");
  		}else{  		$traidnt->assign(message,$lang[reporterror]."<META HTTP-EQUIV='Refresh' CONTENT='2; url=$site[site_link]/view.php?file=$fileid'>");
  		}
  		$traidnt->display("message.tpl");
 	}

	$traidnt->display("footer.tpl");



$db->disconnect();
ob_end_flush();

?>