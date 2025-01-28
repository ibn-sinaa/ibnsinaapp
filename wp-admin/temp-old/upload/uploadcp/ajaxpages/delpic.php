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
    include("adminquery-ajax.php");

    if(!isset($_COOKIE[trupuser])){

    	$traidnt->display("login.tpl");

    }else{
       include("../traidnt.php");

       	$id = clean($_POST[id]);

        $query = $db->query("SELECT * FROM `files` WHERE `files`.`file_id` = '$id' LIMIT 0 , 1 ")or die(mysql_error());

        while($db->fetchrow($query)){
        	$filename = $db->record[file_name];
        }


       switch($_POST[action]){
       	    case"images":

       		unlink("../../uploads/images/$filename");
          	unlink("../../uploads/thumbs/$filename");
           	$db->query("DELETE FROM `files` WHERE `files`.`file_id` = '$id' LIMIT 1")or die(mysql_error());

            break;
            case"files":

            unlink("../../uploads/files/$filename");
            $db->query("DELETE FROM `files` WHERE `files`.`file_id` = '$id' LIMIT 1")or die(mysql_error());

            break;
       }


        }
	$db->disconnect();

	ob_end_flush();
?>