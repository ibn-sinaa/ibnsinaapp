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

	if($site[site_closeupload] == 0){
		$traidnt->display("form.tpl");

    }else{
      $traidnt->assign(message,$lang[closeupload]);
      $traidnt->display("message.tpl");

    	}


	$traidnt->display("footer.tpl");



$db->disconnect();
ob_end_flush();

?>