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

		$gdupload  = $_POST[gdupload];
		$gdcontact = $_POST[gdcontact];
		$gdfriend  = $_POST[gdfriend];
		$gdreport  = $_POST[gdreport];


	   $db->query("UPDATE `gd` SET
	    `gd_upload` = '$gdupload',
		`gd_admin` = '$gdcontact',
		`gd_friend` = '$gdfriend',
		`gd_report` = '$gdreport' WHERE `gd`.`gd_id` =1 LIMIT 1 ;")or die(mysql_error());

	   echo charset2("<span class='right'> „  ÕœÌÀ «·»Ì«‰«  »‰Ã«Õ</span>");


    }


	$db->disconnect();

	ob_end_flush();
?>