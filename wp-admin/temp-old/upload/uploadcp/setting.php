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
       		case"main":

            //Get Setting
            $settingquery = $db->query("SELECT * FROM `setting` WHERE `setting`.`site_id` = '1' LIMIT 0 , 1 ");

            while($db->fetchrow($settingquery)){
	            $site[site_name] =	$db->record[site_name];
	            $site[site_meta] =	$db->record[site_meta];
	            $site[site_link] =	$db->record[site_link];
	            $site[site_host] =	$db->record[site_host];
	            $site[site_mail] =	$db->record[site_mail];
	            $site[site_logo] =	$db->record[site_logo];
	            $site[site_second] =	$db->record[site_second];
	            $site[img_high] =	$db->record[img_high];
	            $site[img_width] =	$db->record[img_width];

				//update To Close Upload Images And User Can DownLoad Files.
	            $site[site_inactive] =	$db->record[site_inactive];


	            $site[site_previous] =	$db->record[site_previous];

	            //Update to max Upload In Time
	            $site[site_delimg] =	$db->record[site_delimg];

	            $site[site_totalsize] =	$db->record[site_totalsize];
	            $site[site_close] =	$db->record[site_close];
	            $site[site_closemessage] =	$db->record[site_closemessage];
            }


			$traidnt->assign('site',$site);

            $traidnt->display("settingmain.tpl");

       		break;
       		case"gd":

       			$gdquery = $db->query("SELECT * FROM `gd` WHERE `gd`.`gd_id` = '1'  LIMIT 0 , 1 ");

       			while($db->fetchrow($gdquery)){       				$gd[gd_upload] = $db->record[gd_upload];
       				$gd[gd_admin] = $db->record[gd_admin];
       				$gd[gd_friend] = $db->record[gd_friend];
       				$gd[gd_report] = $db->record[gd_report];
       			}

       			$traidnt->assign('gd',$gd);
       			$traidnt->display("gd.tpl");

       		break;

       		case"style":
              $stylequery = $db->query("SELECT * FROM `style` WHERE `style`.`style_id` = '1' LIMIT 0 , 1 ");

              while($db->fetchrow($stylequery)){
              	$masterstyle = $db->record[style_style];
              	$masterlang = $db->record[style_lang];
              }



			$traidnt->register_function('stylelist', 'stylelist');

              function stylelist (){
                 global $masterstyle;
                echo "<select size=\"1\" name=\"style\">";
              	$dir = scandir("../styles");

               	while (list($key,$value) = each($dir))
					{

						if(is_dir("../styles/$value")){

								if ( (!ereg("[.]",$value)) ) {
								    if ($value == $masterstyle){								    	echo "<option value=\"$value\" selected>$value</option>";
								    }else{
											echo "<option value=\"$value\">$value</option>";
									     }
								}

						}
					}
                echo "</select>";
              }


			$traidnt->register_function('langlist', 'langlist');

              function langlist (){
                 global $masterlang;

                echo "<select size=\"1\" name=\"lang\">";
              	$dir = scandir("../language");

               	while (list($key,$value) = each($dir))
					{

						if(is_dir("../language/$value")){

								if ( (!ereg("[.]",$value)) ) {

								    if ($value == $masterlang){
								    	echo "<option value=\"$value\" selected>$value</option>";
								    }else{
										echo "<option value=\"$value\">$value</option>";
									     }
								}


						}
					}
                echo "</select>";
              }

             $traidnt->display("subsetting.tpl");
       		break;
       		default:
            $traidnt->assign('message',"ÚÝæÇ åÐå ÇáÕÝÍÉ ÛíÑ ãÊæÝÑÉ");            $traidnt->display("message.tpl");
       }

    }


	$db->disconnect();

	ob_end_flush();
?>