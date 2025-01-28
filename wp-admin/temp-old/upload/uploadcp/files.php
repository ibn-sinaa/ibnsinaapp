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

		switch($_GET['do']){			case"extension":

				switch($_GET[go]){					  default:

                     	   $exquery = $db->query("SELECT * FROM `extension` ORDER BY `extension`.`ex_id` DESC ");

                        	while($db->fetchrow($exquery)){                              $extension[] = $db->record;
                        	}

                         	$traidnt->assign('extension',$extension);
                            $traidnt->display("extension.tpl");
					  break;
					  case"add":

           				$exname = clean($_POST[exname]);
           				$maxsize = clean($_POST[maxsize]);

					  	if($exname == "php"){
                          die("Security Reason");
					  	}

           				$db->query("INSERT INTO `extension` ( `ex_id` , `ex_name` , `ex_maxsize` )
						VALUES ('NULL', '$exname', '$maxsize');")or die(mysql_error());

                         $traidnt->assign('message',"Êã ÇÖÇİå ÇáÇãÊÏÇÏ ÈäÌÇÍ ÇäÊÙÑ Óæİ íÊã ÊÍæíáß"."<META HTTP-EQUIV=\"Refresh\" CONTENT=\"2; url=files.php?do=extension\">");
                         $traidnt->display("message.tpl");


					  break;
					  case"del":

                       $db->query("DELETE FROM `extension` WHERE `extension`.`ex_id` = '$_GET[id]'")or die(mysql_error());
                       $traidnt->assign('message',"Êã ÍĞİ ÇáÇãÊÏÇÏ ÈäÌÇÍ ÇäÊÙÑ Óæİ íÊã ÊÍæíáß"."<META HTTP-EQUIV=\"Refresh\" CONTENT=\"2; url=files.php?do=extension\">");
                       $traidnt->display("message.tpl");

					  break;

				}

			break;
			case"find":

                switch($_GET[go]){
                	default:
                    $traidnt->display("find.tpl");
                	break;

                	case"result":

                     $filename = clean($_GET[filename]);
                     $maxsize  = clean($_GET[maxsize]);
                     $fileext = clean($_GET[fileext]);
                     $fileip = clean($_GET[fileip]);

     				 //ÈÏÇíÉ ÊŞÓíã ÇáÕİÍÉ
					  	$page = (!isset($_GET['page']) ? 1 : intval($_GET['page']));
						$page =(intval($_GET['page'])<=0 ? 1 : $page );
						$numpage=50; #ÇáÚÏÏ Èßá ÕİÍÉ
						$limit=($page * $numpage) - $numpage;
					//äåÇíÉ

                     $resultquery = $db->query("SELECT * FROM `files` WHERE `file_name` =  '$filename' or
                      `file_size` =  '$maxsize'  or `file_tybe` =  '$fileext'  or `ipaddress` =  '$fileip'  limit  $limit,$numpage ");

                    $totalresult = $db->resultcount($resultquery);
                   	 	if($totalresult == 0){                    	    $traidnt->assign("message","ÚİæÇ áÇíæÌÏ äÊÇÆÌ áãÇ ÊÈÍË Úäå<br>
                    	    <b><a href='files.php?do=find'>ÇÖÛØ åäÇ ááÚæÏÉ ááÎáİ</a></b>");
                    	    $traidnt->display("message.tpl");
                    	}else{
                          while($db->fetchrow($resultquery)){                           $result[] = $db->record;
                          }

						$traidnt->assign("result",$result);

                   		  $totalquery = $db->query("SELECT * FROM `files` WHERE `file_name` =  '$filename' or
                      	 `file_size` =  '$maxsize'  or `file_tybe` =  '$fileext'  or `ipaddress` =  '$fileip'   ");

                          $total = $db->resultcount($totalquery);
                          $total = $total/$numpage;

							$traidnt->register_function('totalpages', 'totalpages');

							function totalpages (){
			    	 			global $total;
				   				echo "<br>ÇáÕİÍÇÊ:</b>";
							while (($i)<($total)){
								$i++;
								if($page <> $i) {
								$n="<a href='files.php?do=find&go=result&filename=$_GET[filename]&maxsize=$_GET[maxsize]&fileext=$_GET[fileext]&fileip=$_GET[fileip]&page=$i' class='font'>
								[$i]</a>";

								}else{$n="<b class='font'>[$i]
								</font>";
								}
									echo "$n&nbsp;&nbsp;";

							}

							}


						   $traidnt->register_function('chdate', 'chdate');

							function chdate($params, &$smarty)
							{

						    	$format = $params['time'];

                                $format = date("d-m-Y",$format);


							  	return ($format);
							}

							$traidnt->display("findresult.tpl");
                    	}

                	break;
                	case"del":

                     $id = $_GET[id];
                     $group = $_GET[type];
                     $filename = $_GET[name];

                     	if($group == 'images'){                          @unlink("../uploads/images/$filename");
                          @unlink("../uploads/thumbs/$filename");
                     	}else{                          @unlink("../uploads/files/$filename");
                     	}


                      $db->query("DELETE FROM `files` WHERE `files`.`file_id` = $id LIMIT 1")or die(mysql_error());

                    	$traidnt->assign("message","Êã ÍĞİ Çáãáİ ÈäÌÇÍ<br>
                    	<b><a href='files.php?do=find'>ÇÖÛØ åäÇ ááÚæÏÉ ááÎáİ</a></b>");
                    	$traidnt->display("message.tpl");


                	break;


                }

			break;
			case"piclast":

             switch($_GET[go]){             	default:
     		//ÈÏÇíÉ ÊŞÓíã ÇáÕİÍÉ
			$page = (!isset($_GET['page']) ? 1 : intval($_GET['page']));
			$page =(intval($_GET['page'])<=0 ? 1 : $page );
			$numpage=50; #ÇáÚÏÏ Èßá ÕİÍÉ
			$limit=($page * $numpage) - $numpage;
			//äåÇíÉ

			$picquery = $db->query("SELECT *  FROM `files`  WHERE   `group`  = 'images' and `file_date` > '$piclast' limit  $limit,$numpage  ");
            $totalfromlast = $db->resultcount($picquery);

             if($totalfromlast == 0){             	$traidnt->assign("message","ÚİæÇ áÇíæÌÏ ÕæÑ ãäĞ ÂÎÑ ÒíÇÑÉ<br><b><a href='files.php?do=piclast&go=update'>ÇÖÛØ åäÇ áÊÌÏíÏ ÂÎÑ ÒíÇÑÉ</a></b>");
             	$traidnt->display("message.tpl");
             }else{
				while($db->fetchrow($picquery)){					$piclastv[] = $db->record;
				}
                $traidnt->assign("piclastv",$piclastv);

				$totalquery = $db->query("SELECT *  FROM `files`  WHERE   `group`  = 'images' and `file_date` > '$piclast' ");
                $total = $db->resultcount($totalquery);
                $total = $total/$numpage;

				$traidnt->register_function('totalpages', 'totalpages');

				function totalpages (){
			    	 global $total;
				   	echo "<br>ÇáÕİÍÇÊ:</b>";
					while (($i)<($total)){
						$i++;
						if($page <> $i) {
							$n="<a href='files.php?do=piclast&page=$i' class='font'>
							[$i]</a>";

						}else{$n="<b class='font'>[$i]
						</font>";
						}
					echo "$n&nbsp;&nbsp;";

						}

				}


				function chdate2($params, &$smarty)
					{

					$format = $params['time'];
     				$format = date("d-m-Y",$format);

					return ($format);
					}

              $traidnt->display("piclast.tpl");

             }

             break;
             case"update":

				 $timenow = time();
                 $update = $db->query("UPDATE `admin` SET `admin`.`admin_lastviste` = '$timenow' WHERE `admin`.`admin_user` ='$adminuser'  LIMIT 1 ;")or die(mysql_error());

                 $traidnt->assign("message","Êã ÊÍÏíË ÂÎÑ ÒíÇÑÉ ÈäÌÇÍ <br>ÇäÊÙÑ Óæİ íÊã ÊÍæíáß"."<META HTTP-EQUIV=\"Refresh\" CONTENT=\"2; url=files.php?do=piclast\">");
                 $traidnt->display("message.tpl");
             break;


             }

			break;
			case"fileslast":

               switch($_GET[go]){                   default:
	     		//ÈÏÇíÉ ÊŞÓíã ÇáÕİÍÉ
				$page = (!isset($_GET['page']) ? 1 : intval($_GET['page']));
				$page =(intval($_GET['page'])<=0 ? 1 : $page );
				$numpage=50; #ÇáÚÏÏ Èßá ÕİÍÉ
				$limit=($page * $numpage) - $numpage;
				//äåÇíÉ

				$filesquery = $db->query("SELECT *  FROM `files`  WHERE   `group`  = 'files' and `file_date` > '$fileslast' limit  $limit,$numpage  ");
            	$totalfromlast = $db->resultcount($filesquery);

            	 if($totalfromlast == 0){
             		$traidnt->assign("message","ÚİæÇ áÇíæÌÏ ãáİÇÊ ãäĞ ÂÎÑ ÒíÇÑÉ<br><b><a href='files.php?do=fileslast&go=update'>ÇÖÛØ åäÇ áÊÌÏíÏ ÂÎÑ ÒíÇÑÉ</a></b>");
             		$traidnt->display("message.tpl");
            	 }else{

						   $traidnt->register_function('lastfile', 'lastfile');

							function lastfile($params, &$smarty)
							{

						    	$format = $params['filetype'];

				       			$exarray = array("avi","css","divx","doc","docx","dvd","fon","swf","mmf","mmm",
    	   						"movie","mp2","mp2v","mp3","mp4","mpeg","mpg","pdf","psd","ram","rar","rm","vcr","wma","zap","zip");


                                if(in_array($format,$exarray)){                                   $format =  "../extension/$format.gif";
                                }else{                                	$format =  "../extension/traidnt.gif";
                                }

							  	return ($format);
							}

						while($db->fetchrow($filesquery)){
							$latfile[] = $db->record;
						}

	                $traidnt->assign("latfile",$latfile);

					$totalquery = $db->query("SELECT *  FROM `files`  WHERE   `group`  = 'files' and `file_date` > '$fileslast'");
        	        $total = $db->resultcount($totalquery);
            	    $total = $total/$numpage;


					$traidnt->register_function('totalpages', 'totalpages');

					function totalpages (){
			    		 global $total;
				   		echo "<br>ÇáÕİÍÇÊ:</b>";
						while (($i)<($total)){
							$i++;
							if($page <> $i) {
								$n="<a href='files.php?do=fileslast&page=$i' class='font'>
								[$i]</a>";

							}else{$n="<b class='font'>[$i]
							</font>";
							}
						echo "$n&nbsp;&nbsp;";

							}

					}

                	 $traidnt->display("fileslast.tpl");

            	 }
                   break;
                   case"update":


					 $timenow = time();
                 	$update = $db->query("UPDATE `admin` SET `admin`.`admin_lastviste_file` = '$timenow' WHERE `admin`.`admin_user` ='$adminuser'  LIMIT 1 ;")or die(mysql_error());

                 	$traidnt->assign("message","Êã ÊÍÏíË ÂÎÑ ÒíÇÑÉ ÈäÌÇÍ <br>ÇäÊÙÑ Óæİ íÊã ÊÍæíáß"."<META HTTP-EQUIV=\"Refresh\" CONTENT=\"2; url=files.php?do=fileslast\">");
                 	$traidnt->display("message.tpl");

                   break;



               }

			break;
			case"allpic":



			//ÈÏÇíÉ ÊŞÓíã ÇáÕİÍÉ
			$page = (!isset($_GET['page']) ? 1 : intval($_GET['page']));
			$page =(intval($_GET['page'])<=0 ? 1 : $page );
			$numpage=50; #ÇáÚÏÏ Èßá ÕİÍÉ
			$limit=($page * $numpage) - $numpage;
			//äåÇíÉ

			$picquery = $db->query("SELECT *  FROM `files`  WHERE   `group`  = 'images'  limit  $limit,$numpage  ");
            $totalfromlast = $db->resultcount($picquery);

             if($totalfromlast == 0){
             	$traidnt->assign("message","ÚİæÇ áÇíæÌÏ ÕæÑ ÍÇáíÇ");
             	$traidnt->display("message.tpl");
             }else{

				while($db->fetchrow($picquery)){
					$piclastv[] = $db->record;
				}
                $traidnt->assign("piclastv",$piclastv);

				$totalquery = $db->query("SELECT *  FROM `files`  WHERE   `group`  = 'images'  ");
                $total = $db->resultcount($totalquery);
                $total = $total/$numpage;

				$traidnt->register_function('totalpages', 'totalpages');

				function totalpages (){
			    	 global $total;
				   	echo "<br>ÇáÕİÍÇÊ:</b>";
					while (($i)<($total)){
						$i++;
						if($page <> $i) {
							$n="<a href='files.php?do=allpic&page=$i' class='font'>
							[$i]</a>";

						}else{$n="<b class='font'>[$i]
						</font>";
						}
					echo "$n&nbsp;&nbsp;";

						}

				}


				function chdate2($params, &$smarty)
					{

					$format = $params['time'];
     				$format = date("d-m-Y",$format);

					return ($format);
					}

              $traidnt->display("allpic.tpl");

             }



			break;
			case"allfiles":


			//ÈÏÇíÉ ÊŞÓíã ÇáÕİÍÉ
				$page = (!isset($_GET['page']) ? 1 : intval($_GET['page']));
				$page =(intval($_GET['page'])<=0 ? 1 : $page );
				$numpage=50; #ÇáÚÏÏ Èßá ÕİÍÉ
				$limit=($page * $numpage) - $numpage;
				//äåÇíÉ

				$filesquery = $db->query("SELECT *  FROM `files`  WHERE   `group`  = 'files'  limit  $limit,$numpage  ");
            	$totalfromlast = $db->resultcount($filesquery);

            	 if($totalfromlast == 0){
             		$traidnt->assign("message","ÚİæÇ áÇíæÌÏ ãáİÇÊ");
             		$traidnt->display("message.tpl");
            	 }else{


						   $traidnt->register_function('lastfile', 'lastfile');

							function lastfile($params, &$smarty)
							{

						    	$format = $params['filetype'];

				       			$exarray = array("avi","css","divx","doc","docx","dvd","fon","swf","mmf","mmm",
    	   						"movie","mp2","mp2v","mp3","mp4","mpeg","mpg","pdf","psd","ram","rar","rm","vcr","wma","zap","zip");


                                if(in_array($format,$exarray)){
                                   $format =  "../extension/$format.gif";
                                }else{
                                	$format =  "../extension/traidnt.gif";
                                }

							  	return ($format);
							}

						while($db->fetchrow($filesquery)){
							$latfile[] = $db->record;
						}

	                $traidnt->assign("latfile",$latfile);

					$totalquery = $db->query("SELECT *  FROM `files`  WHERE   `group`  = 'files' ");
        	        $total = $db->resultcount($totalquery);
            	    $total = $total/$numpage;


					$traidnt->register_function('totalpages', 'totalpages');

					function totalpages (){
			    		 global $total;
				   		echo "<br>ÇáÕİÍÇÊ:</b>";
						while (($i)<($total)){
							$i++;
							if($page <> $i) {
								$n="<a href='files.php?do=allfiles&page=$i' class='font'>
								[$i]</a>";

							}else{$n="<b class='font'>[$i]
							</font>";
							}
						echo "$n&nbsp;&nbsp;";

							}

					}

                	 $traidnt->display("allfiles.tpl");

            	 }



			break;
			case"report":

				switch($_GET[go]){
                    default:

					$reportquery = $db->query("SELECT * FROM `report` ORDER BY `report`.`report_id` DESC ");
					$totalreport = $db->resultcount($reportquery);

					if($totalreport == 0 ){                        $traidnt->assign("message","ÚİæÇ áÇíæÌÏ ÊŞÇÑíÑ ÍÇáíÇ");
                    	$traidnt->display("message.tpl");					}else{
						while($db->fetchrow($reportquery)){                         $report[] = $db->record;
						}

                        $traidnt->assign(report,$report);
						$traidnt->display("report.tpl");

					}

					break;
					case"delreport":

                    	$id = $_GET[id];
                     	$db->query("DELETE FROM `report` WHERE `report`.`report_id` = '$id' LIMIT 1")or die (mysql_error());
                      	$traidnt->assign(message,"<a href='files.php?do=report'>Êã ÍĞİ ÇáÊŞÑíÑ ÈäÌÇÍ ÇÖÛØ åäÇ ááÚæÏÉ ááÎáİ</a>");
                      	$traidnt->display("message.tpl");

					break;

					case"delfile":
                     $id = $_GET[id];
                     $key = $_GET['file'];

                     $filequery = $db->query(" SELECT `file_name`,`group` FROM `files` WHERE `files`.`file_key` = '$key' LIMIT 0 , 1 ");

                     	while($db->fetchrow($filequery)){                         $filename  = $db->record[file_name];
                         $group = $db->record[group];
                    	}

                   	 if($group == "images"){
                    	@unlink("../uploads/images/$filename");
                    	@unlink("../uploads/thumbs/$filename");
                     }else{
     					@unlink("../uploads/files/$filename");

                     }
                        $db->query("DELETE FROM `report` WHERE `report`.`report_id` = '$id' LIMIT 1")or die (mysql_error());

                        $db->query("DELETE FROM `files` WHERE `files`.`file_key` = '$key' LIMIT 1");

                      	$traidnt->assign(message,"<a href='files.php?do=report'>Êã ÍĞİ ÇáÊŞÑíÑ æÇáãáİ ÈäÌÇÍ</a>");
                      	$traidnt->display("message.tpl");


					break;
    			}

			break;
			case"delete":

			  switch($_GET[go]){
			  	  case"":

					$traidnt->display("delete.tpl");

			  	  break;

			  	  case"del":
                    $day = $_POST[days];

                    if($day == '' OR !is_numeric($day)){                      $traidnt->assign(message,"ãä İÖáß ÇÏÎá ÚÏÏ ÇáÇíÇã ÇÑŞÇã İŞØ");
                      $traidnt->display("message.tpl");
                    }else{
                      $daytotime = 3600 * 24 * $day;
                      $times = time() - $daytotime;

					  $delquery = $db->query("SELECT * FROM `files` WHERE `files`.`file_date` > '$times'  ");
					  $totalfiles = $db->resultcount($delquery);

					  	if($totalfiles == 0 ){
                         	$traidnt->assign(message,"ÚİæÇ áÇíæÌÏ ãáİÇÊ ÊÊæÇİŞ ãÚ åĞÇ ÇáÊÇÑíÎ");
                      		$traidnt->display("message.tpl");
					  	}else{
							while($db->fetchrow($delquery)){

                            	if($db->record[group] == "images"){
                             		@unlink("../uploads/images/".$db->record[file_name]."");
                    				@unlink("../uploads/thumbs/".$db->record[file_name]."");

                            	}else{                                    @unlink("../uploads/files/".$db->record[file_name]."");
                            	}

                                $fileids[] = $db->record[file_id];
							}

							$db->query("DELETE FROM `files` WHERE `files`.`file_id` IN (".implode(",",$fileids).")")or die(mysql_error());

                            $traidnt->assign(message,"Êã ÍĞİ $totalfiles ãáİ ");
                      		$traidnt->display("message.tpl");
					  	}

                    }

			  	  break;
			  }

			break;
		}
    }


	$db->disconnect();

	ob_end_flush();
?>