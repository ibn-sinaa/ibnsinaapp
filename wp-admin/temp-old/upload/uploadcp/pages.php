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

       $thispage = $_GET['do'];
       $traidnt->assign('do',$thispage);

		switch($_GET[go]){			case"":
       		$getpage = $db->query("SELECT `page_$thispage` FROM `pages` WHERE `pages`.`page_id` = '1' LIMIT 0 , 1 ");

       			 while($db->fetchrow($getpage)){        			$pagecontents = $db->record["page_".$thispage];
        		}
       		$traidnt->assign(pagecontents,$pagecontents);
        	$traidnt->display("page.tpl");
            break;
            case"update":

            	$pgae = $_POST[page];
            	$db->query("UPDATE `pages` SET `page_$thispage` = '$pgae' WHERE `pages`.`page_id` =1 LIMIT 1 ;");

                $traidnt->assign(message,"йЦ ймоМк ЦмйФгМгй гАущми хДлгм");
            	$traidnt->display("message.tpl");

            break;


         }
    }


	$db->disconnect();

	ob_end_flush();
?>