<?


        $traidnt->register_function('traidntright', 'traidntright');
  		function traidntright (){

     	 echo "
     	 	<p align='center' dir='ltr'>Powered by <b>
			<font color='#000080'><a href='http://traidnt.net' target='_blank'>
			<span style='text-decoration: none'><font color='#000000'>Traidnt&nbsp;UP</font></span></a></font></span></b>
			Version 2.0</p>
    	 ";
  		}

		// Get Rules And Close Site
		if($site[site_close] == 1 ){
           	$traidnt->display("header.tpl");
			$traidnt->assign(message,$site[site_closemessage]);
			$traidnt->display("message.tpl");
			$traidnt->display("footer.tpl");
			exit();
		}



		// check  User In Pan List
		$ip = getenv('REMOTE_ADDR');
		$panquery = $db->query("SELECT * FROM `banned` WHERE  `banned_ip` = '$ip' ");
        $issetip = $db->resultcount($panquery);

		if($issetip == 1 ){
           	$traidnt->display("header.tpl");
			$traidnt->assign(message,$lang[issetpan]);
			$traidnt->display("message.tpl");
			$traidnt->display("footer.tpl");
			exit();
		}


		//check folder Size
  		$uploadsize = round(FolderSize("uploads")/1000000);
  		$maxsize =  $site[site_totalsize];
  		if($uploadsize >= $maxsize){  			$traidnt->display("header.tpl");
			$traidnt->assign(message,$lang[maxsize]);
			$traidnt->display("message.tpl");
			$traidnt->display("footer.tpl");
			exit();
  		}


  		$path['main'] = "./uploads";
  		$path[images] = "./uploads/images";
  		$path[files] = "./uploads/files";
  		$path[imgthumbs] = "./uploads/thumbs";
  		$path[cash] =  "./trcash";







?>