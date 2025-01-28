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

    $page = get($_GET[page]);

 	$pagequery = $db->query("SELECT * FROM `pages`  LIMIT 0 , 1 ");

  	while($db->fetchrow($pagequery)){      $advpage = charset($db->record[page_adv]);
      $rulepage = charset($db->record[page_rules]);
  	}


  	switch($page){
  		case"rules":

         $traidnt->assign(message,$rulepage);
         $traidnt->display("message.tpl");

  		break;
  		case"adv":

   		 $traidnt->assign(message,$advpage);
         $traidnt->display("message.tpl");

  		break;

  		case"extension":

			$extquery = $db->query("SELECT * FROM `extension` ORDER BY `ex_name` ASC");

			while($db->fetchrow($extquery)){
			    $ext[] = $db->record;
			}

   			$traidnt->assign(ext,$ext);
   			$traidnt->display("ext.tpl");

  		break;

		case "statistics":

			// Get Alexa Class
			include("includes/class.alexa.php");

   			$alexa = new alexa('http://alexa.com/xml/dad?url=',$_SERVER[HTTP_HOST]);
			$rank[alexa] = $alexa->get('rank');

            // Get site pagerank
			$rank[pagerank] = get_page_rank($_SERVER[HTTP_HOST]);

            //Get Total Images
            $picquery = $db->query("SELECT *  FROM `files`  WHERE   `group`  = 'images' ");
            $rank[totalpic] = $db->resultcount($picquery);

   			//Get Total files
            $filequery = $db->query("SELECT *  FROM `files`  WHERE   `group`  = 'files' ");
            $rank[totalfiles] = $db->resultcount($filequery);



           $traidnt->assign(rank,$rank);
           $traidnt->display("statistics.tpl");

		break;

  		default:

    	 $traidnt->assign(message,charset("кнцЧ хах ЧсенЭЩ лэб уЪцнбЩ"));
         $traidnt->display("message.tpl");

  		break;

  	}

	$traidnt->display("footer.tpl");



$db->disconnect();
ob_end_flush();

?>