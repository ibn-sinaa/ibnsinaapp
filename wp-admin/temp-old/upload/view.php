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

	$filekey = get($_GET['file']);

	$filequery = $db->query("SELECT * FROM `files` WHERE `files`.`file_key` = '$filekey' LIMIT 0 , 1 ");

	$issetfile = $db->resultcount($filequery);


		if($issetfile != 1){
			$traidnt->assign(message,$lang[deletedfile]);
            $traidnt->display("message.tpl");
		}else{
   			while($db->fetchrow($filequery)){
            	$files[file_name] = $db->record[file_name];
            	$files[file_date] = date("d-m-Y",$db->record[file_date]);
            	$files[file_url] = $db->record[file_url];
            	$files[file_type] = $db->record[file_tybe];
            	$files[file_size] = $db->record[file_size];
            	$files[file_count] = $db->record[file_count];
            	$files[file_group] = $db->record[group];

            	}

				$files[file_id] = $filekey;

			if($files[file_group] == "images"){
				if($files[file_type] == "bmp"){
                   $files[imageurl] = "./uploads/images/$files[file_name]";
                   $files[imagethumbs] = "./uploads/images/$files[file_name]";
				}else{
				   $files[imageurl] = "./uploads/images/$files[file_name]";
                   $files[imagethumbs] = "./uploads/thumbs/$files[file_name]";

				}

             $traidnt->assign('files',$files);
             $traidnt->display("viewimages.tpl");
			}else{

			    switch($files[file_type]){
        			case"swf":

           				$traidnt->assign('files',$files);
             			$traidnt->display("viewswf.tpl");

        			break;

        			default:
           				$traidnt->assign('files',$files);
             			$traidnt->display("viewfiles.tpl");
        			break;

			    }



			}

		}

  	$updatecount = $db->query("UPDATE `files` SET `file_count` = file_count+1  WHERE `file_key` = '$filekey' LIMIT 1 ;")or die(mysql_error());

  	$db->clear($updatecount);
    $db->clear($filequery);

	$traidnt->display("footer.tpl");



$db->disconnect();
ob_end_flush();

?>