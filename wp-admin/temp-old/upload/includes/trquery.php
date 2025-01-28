<?
/*
#############################
	Traidnt Up v 2.0
    http://traidnt.net
############################
*/

 if (!defined('traidnt')) {
    die("Error: 404 Not Found");
 }

 //«” œ⁄«¡ «·ﬁÊ«·»
	$traidnt = new Smarty;
	$traidnt->compile_check = true;
	$traidnt->debugging = false;
	$traidnt->compile_dir = 'trcash';


    // Get Main  setting
	$getsetting = $db->query("SELECT * FROM `setting` where `site_id` = '1'")or  die(mysql_error());

 		while($db->fetchrow($getsetting)){
            $site[site_name] = charset($db->record[site_name]);
            $site[site_meta] = charset($db->record[site_meta]);
            $site[site_link] = charset($db->record[site_link]);
            $site[site_host] = charset($db->record[site_host]);
            $site[site_mail] = charset($db->record[site_mail]);
            $site[site_logo] = charset($db->record[site_logo]);
            $site[site_second] = charset($db->record[site_second]);
            $site[img_high] = charset($db->record[img_high]);
            $site[img_width] = charset($db->record[img_width]);
            $site[site_closeupload] = charset($db->record[site_inactive]);
            $site[site_previous] = charset($db->record[site_previous]);
            $site[site_maxinput] = charset($db->record[site_delimg]);
            $site[site_totalsize] = charset($db->record[site_totalsize]);
            $site[site_close] = charset($db->record[site_close]);
            $site[site_closemessage] = charset($db->record[site_closemessage]);
 		}

    // Get Default Lang And Default
    $getstyle = $db->query("SELECT * FROM `style` WHERE `style`.`style_id` = '1'  ");

    	while($db->fetchrow($getstyle)){
    		 $site[style_style] = $db->record[style_style];
        	 $site[style_lang] = $db->record[style_lang];
    	}


    // Get Gd Info
    $gdquery = $db->query("SELECT * FROM `gd` WHERE `gd`.`gd_id` = '1'  LIMIT 0 , 1 ");

    	while($db->fetchrow($gdquery)){
           $site[gd_upload] = $db->record[gd_upload];
           $site[gd_admin] = $db->record[gd_admin];
           $site[gd_friend] = $db->record[gd_friend];
           $site[gd_report] = $db->record[gd_report];

    	}


        $traidnt->assign(site,$site);


		//Get User Style
		  if(isset($_COOKIE[trupstyle])){
     		if(!is_dir("styles/$_COOKIE[trupstyle]")){
     		$trstyle = $site[style_style];
     			}else{
     		$trstyle = $_COOKIE[trupstyle];
     		}
  		}else{
  			$trstyle = $site[style_style];
 	 	}
  		//End User Style

  	$footerfile =  @file_get_contents("./styles/$trstyle/footer.tpl");
 		if (!ereg("{traidntright}",$footerfile)) {
         	die("Error : Don't Remove Traidnt Copyright");
        }



   		$traidnt->template_dir = "styles/$trstyle";
   		$stylepath = "styles/$trstyle";
   		$traidnt->compile_id = $trstyle;
   		$traidnt->assign("stylepath",$stylepath);

        $traidnt->register_function('allowext', 'allowext');
        function allowext (){        	$query = mysql_query("SELECT * FROM `extension` ORDER BY `ex_name` ASC");
         	while($ex = mysql_fetch_array($query)){         		echo $ex[ex_name]."-";
         	}

        }





	function style($trarray){
		global $stylelist;
		$stylelist= "<select size=\"1\" name=\"Name\" onchange=\"window.location.href=this.options[this.selectedIndex].value\">";
		$stylelist.= "<option value=\"\">".charset("«Œ — «·«” «Ì·")."</option>" ;
		while (list($key,$value) = each($trarray))
		{
		$stylelist.= "<option value=\"style.php?styleid=$key\">$value</option>" ;
		}
		$stylelist.= "</select>";
		return($stylelist);
	}

 	$path ="./styles";
	$dh = opendir($path);
	$count=1;
		while ($file = readdir($dh)){
				if(is_dir("$path/$file")) {
				{
				if($file != "." && $file != ".."){
				$countarray[] = $count++;
         		$stylearray[] = $file;
         			}
				}
			}
		}
	closedir($dh); // √€·«ﬁ «·„Ã·œ
	$trarray = array_combine($countarray,$stylearray);
	$traidnt->assign("stylelist",style($trarray));

?>