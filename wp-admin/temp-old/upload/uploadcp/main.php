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

       	switch($_GET['do']){
             case"ip":

    			switch($_GET[go]){                    default:

                     $lisppan = $db->query(" SELECT * FROM `banned` ORDER BY `banned`.`banned_id` DESC");
                     $total = $db->resultcount($lisppan);
                     $traidnt->assign(total,$total);
                     	while($db->fetchrow($lisppan)){                          $list[] = $db->record;
                    	}
                     $traidnt->assign('list',$list);
                     $traidnt->display("ip.tpl");

                    break;
                    case"add":

						$ip = trim($_POST[ip]);
      					$ipquery = $db->query(" SELECT * FROM `banned` WHERE `banned`.`banned_ip` = '$ip' LIMIT 0 , 1 ");
      					$issetip = $db->resultcount($ipquery);

      					if($issetip != 0 ){                           $error = "ÚİæÇ åĞÇ ÇáÇí Èí ãæÌæÏ ãä ŞÈá "."<br><a href='main.php?do=ip'>ÇÖÛØ åäÇ ááÚæÏÉ ááÎáİ</a>";
      					}

      					if($ip == ''){      						$error = "ÚİæÇ áã ÊŞã ÈÇÏÎÇá ÇáÇí Èí"."<br><a href='main.php?do=ip'>ÇÖÛØ åäÇ ááÚæÏÉ ááÎáİ</a>";
      					}

      					if($error != ''){                             $traidnt->assign(message,$error);
                             $traidnt->display("message.tpl");
      					}else{
                           $db->query("INSERT INTO `banned` (`banned_id` ,`banned_ip`) VALUES (NULL , '$ip');");

						   $error = "Êã ÇÖÇİå ÇáÇí Èí ÈäÌÇÍ"."<br><a href='main.php?do=ip'>ÇÖÛØ åäÇ ááÚæÏÉ ááÎáİ</a>";

      					   $traidnt->assign(message,$error);
           				   $traidnt->display("message.tpl");
                        }
                    break;
                    case"delete":
                     $id = $_GET[id];
                     $db->query("DELETE FROM `banned` WHERE `banned`.`banned_id` = '$id' LIMIT 1")or die(mysql_error());
         				$error = "Êã ÍĞİ ÇáÇí Èí ÈäÌÇÍ"."<br><a href='main.php?do=ip'>ÇÖÛØ åäÇ ááÚæÏÉ ááÎáİ</a>";

      					$traidnt->assign(message,$error);
           				$traidnt->display("message.tpl");
                    break;
    			}

             break;
             case"changepass":

				switch($_GET[go]){
                     case"":

                     $traidnt->assign(adminname,$_COOKIE[trupuser]);
                     $traidnt->display("changepass.tpl");
                     break;

                     case"update":

                      $oldpass =  md5(clean($_POST[oldpass]));
                      $newpass = clean($_POST[newpass]);
                      $username = clean($_POST[username]);

                      // Get Error's

					 if($username == ''){                      $error = $error."ÚİæÇ áã ÊŞã ÈÇÏÎÇá ÇÓã ÇáãÓÊÎÏã"."<br>";
					 }

					 if($oldpass != $_COOKIE[truppassword]){      					$error = $error."ÚİæÇ ßáãÉ ÇáãÑæÑ ÇáŞÏíãå ÛíÑ ÕÍíÍÉ"."<br>";
					 }

      				 if($newpass == ''){                       $password = $oldpass;
      				 }else{      				 	$password = md5($newpass);
      				 }


      				 if($error != ''){                       $traidnt->assign(message,$error);
                       $traidnt->display("message.tpl");
      				 }else{                      $db->query("UPDATE `admin` SET `admin_user` = '$username',`admin_password` = '$password' WHERE `admin_id` = '$adminid' ;");
                      $traidnt->assign(message,"Êã ÊÍÏíË ÇáÈíÇäÇÊ ÈäÌÇÍ");
                      $traidnt->display("message.tpl");
      				 }


                     break;

				}

             break;
             case"logout":

             @setcookie("trupuser",$adminname,time()-3600*3);
      		 @setcookie("truppassword",$adminpassword,time()-3600*3);
      		 echo "<META HTTP-EQUIV=\"Refresh\" CONTENT=\"2; url=login.php\">";

      		 $traidnt->assign(message,"Êã ÊÓÌíá ÇáÎÑæÌ ÈäÌÇÍ ÇäÊÙÑ Óæİ íÊã ÊÍæíáß");
      		 $traidnt->display("message.tpl");


             break;

       	}




    }


	$db->disconnect();

	ob_end_flush();
?>