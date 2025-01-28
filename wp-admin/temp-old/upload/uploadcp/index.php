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

    }else{        include("./traidnt.php");

       $getnote = $db->query("SELECT * FROM `note` WHERE `note`.`note_id` = '1' LIMIT 0 , 1 ");

       while($db->fetchrow($getnote)){       	$notevalue = $db->record[note_value];
       }

       $traidnt->assign('notevalue',$notevalue);

       // Draw Chart
       $exquery = $db->query("SELECT * FROM `extension` ORDER BY `extension`.`ex_id` DESC ");
       $totalex = $db->resultcount($exquery);

      	 while($db->fetchrow($exquery)){      			$ex = $ex.$db->record[ex_name]."*";
      		   	$num = $num.getcount($db->record[ex_name])."*";
     	 }


    	$chart =  "<img src=\"chart.php\" /> ";
        $traidnt->assign('chart',$chart);

     	$filesquery = $db->query("SELECT * FROM `files`  ");
        $totalfiles = $db->resultcount($filesquery);
		$traidnt->assign('totalfiles',$totalfiles);

     	$querys = $db->query("SELECT * FROM `files` WHERE `files`.`group` = 'images'  ");
        $totalimages = $db->resultcount($querys);

     	$query = $db->query("SELECT * FROM `files` WHERE `files`.`group` = 'files'  ");
        $totalfile = $db->resultcount($query);

     	$queryreport = $db->query("SELECT * FROM `report`  ");
        $totalreport = $db->resultcount($queryreport);



        $traidnt->assign('totalfile',$totalfile);
        $traidnt->assign('totalimages',$totalimages);
        $traidnt->assign('totalreport',$totalreport);

        //Get Used Space
        include("../includes/foldersize.php");
        $foldersize = FolderSize("../uploads")/1000/1000;

        //Get Max Folder Size From Db
        $sizequery = $db->query("SELECT `site_totalsize` FROM `setting` WHERE `setting`.`site_id` = '1' ");
       		 while($db->fetchrow($sizequery)){        			$maxsize = $db->record[site_totalsize];
      		 }

       $percentage = percentage($maxsize,$foldersize);
       $traidnt->assign('percentage',$percentage);


       $traidnt->display("index.tpl");

    }


	$db->disconnect();

	ob_end_flush();
?>