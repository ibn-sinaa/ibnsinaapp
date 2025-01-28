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
    	 	switch($_GET['do']){     	       case"":

     	       	  $traidnt->display("login.tpl");

     	       break;

     	       case"login":

             	   include("traidnt.php");

                   $adminname = clean($_POST[adminname]);
                   $adminpassword = md5(clean($_POST[adminpassword]));

                   $getadmin = $db->query("SELECT * FROM `admin` WHERE `admin`.`admin_user` = '$adminname' AND `admin`.`admin_password` = '$adminpassword'  LIMIT 0 , 1 ");
                   $issetadmin = $db->resultcount($getadmin);

                   	if($issetadmin == 1){
                    	@setcookie("trupuser",$adminname,time()+3600*3);
                    	@setcookie("truppassword",$adminpassword,time()+3600*3);

                     	$traidnt->display("loginsuc.tpl");
                        echo "<META HTTP-EQUIV=\"Refresh\" CONTENT=\"2; url=index.php\">";

                   	}else{
                       $traidnt->display("loginfalse.tpl");

                   	}



     	       break;
     	       default:
     	       die("404 Not Found");
     	       break;


     		}

    	}else{
          echo "<META HTTP-EQUIV=\"Refresh\" CONTENT=\"0; url=index.php\">";

   		}


	$db->disconnect();

	ob_end_flush();
?>