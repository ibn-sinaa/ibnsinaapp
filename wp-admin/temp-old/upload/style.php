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

        $styleid= $_GET[styleid];
    	$ustyle = $trarray[$styleid];


      	if($_SERVER[HTTP_REFERER]  ==  ''){
           	$goto = 'index.php';
          }else{
         	$goto = $_SERVER[HTTP_REFERER];
        }


        if($ustyle  ==  ''){        	$traidnt->assign(message,$lang[stylenotfound]);
        	$traidnt->display("message.tpl");
        	echo "<META HTTP-EQUIV='Refresh' CONTENT='2; url=$goto'>";

        }else{
         @setcookie("trupstyle",$ustyle,time()+3600*24);
         	$traidnt->assign(message,$lang[stylesuc]);
        	$traidnt->display("message.tpl");
        	echo "<META HTTP-EQUIV='Refresh' CONTENT='2; url=$goto'>";

        }

	$traidnt->display("footer.tpl");



$db->disconnect();
ob_end_flush();

?>