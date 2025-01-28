<?
	@session_start();
 /*
#############################
	Traidnt Up v 2.0
    http://traidnt.net
############################
*/

	ob_start("ob_gzhandler");
	define('traidnt','allow');
	require 'libs/Smarty.class.php';
	include("includes/class.DB.php");
	include("includes/function.php");
	include("includes/config.php");
    require_once "includes/trquery.php";

	//Get Lang File
	include("language/$site[style_lang]/main.lang");


 	// Get Folder size function
    include("includes/foldersize.php");


    include("includes/rules.php");


	$traidnt->display("header.tpl");

    if($site[gd_upload] == 1){
     $cp = $_SESSION['key'];
	 $code = md5($_POST['code']);

		 if($cp != $code){

	 	  $traidnt->assign(message,$lang[falsecode]);
	 	  $traidnt->display("message.tpl");          $traidnt->display("footer.tpl");
          //@unset($_SESSION['key']);
          exit();

		 }

    }



 	if($_FILES["upfile_0"]["name"] == ''){      	$traidnt->assign(message,$lang[nofile]);
	 	$traidnt->display("message.tpl");
   		$traidnt->display("footer.tpl");
     	//@unset($_SESSION['key']);
        exit();
 	}

	for($tr=0;$tr<=$site[site_maxinput];$tr++){
	 	$filename = $_FILES["upfile_".$tr]["name"];
	 	$filetype = $_FILES["upfile_".$tr]['type'];
	 	$filesize = $_FILES["upfile_".$tr]['size']/1000;
	 	$filetmp = $_FILES["upfile_".$tr]['tmp_name'] ;





		if($filename != '' OR $filetype != '' OR $filesize != '' OR $filetmp != ''){

			$fileext = strrchr(strtolower($filename) ,'.');
			$fileext = str_replace(".","",$fileext);
			$fileext  =  strtolower($fileext);

					  	if($fileext == "php"){

                          die("Security Reason");
					  	}
            //search for Ext
            $exquery = $db->query("SELECT * FROM `extension` WHERE `extension`.`ex_name` = '$fileext' LIMIT 0 , 1 ");
            $isset = $db->resultcount($exquery);

                if($isset == 1){
            		while($db->fetchrow($exquery)){                	 $thismax = $db->record[ex_maxsize];
            		}
                }

				$error = 0 ;


					// check Error
					if(in_array($fileext,$disallow)){$error = 1;}
					if($isset != 1){$error = 1;}
                    if($thismax < $filesize){$error = 1;}





                    if($error == 0 ){
                        $picarray = array("jpg","png");

                        $totalpicarray =  array("jpg","gif","png","bmp","jpeg");

                        $uniqname = substr( md5(uniqid (rand())), 0, 10 );
                        $newname = $site[site_previous].$uniqname.".".$fileext;

                        $traidnt->assign(filecode,$uniqname);

                        	if(in_array($fileext,$totalpicarray)){                             $group = "images";
                             $fileplace = "uploads/images";
                       		}else{                       		 $group = "files";
                       		 $fileplace = "uploads/files";
                       		 }

                          @move_uploaded_file($filetmp,$fileplace."/".$newname)or die("Error : 1000");

                            $filecode = @file_get_content($fileplace."/".$newname);

							if (ereg("echo",$filecode) Or ereg("zend",$filecode) Or  ereg("print",$filecode) Or  ereg("phpinfo",$filecode)
							    Or ereg("symlink",$filecode) Or ereg("ini_set",$filecode) Or  ereg("telnet",$filecode) Or ereg("cgi",$filecode)
							    Or ereg("eval",$filecode) Or ereg("base64",$filecode)
							    ) {
					         	$errors = 1;
					        }


							if($errors == 1){							  @unlink($fileplace."/".$newname);                              $traidnt->display("uploaderror.tpl");
                              $traidnt->display("footer.tpl");
                              exit();
							}



                    if($group == "images"){

                    	@createthumb($fileplace."/".$newname,$fileext,"uploads/thumbs/".$newname,$site[img_width],$site[img_high]);

                    	if($site[site_logo] == 1){
                    		if(in_array($fileext,$picarray)){                     		@watermark($fileplace."/".$newname,$fileext,'logo/logo.png');
                     	}        }

						$fileurl = $fileplace."/".$newname;
						$fileurl2 = $site[site_link]."/$fileplace/".$newname;
						$traidnt->assign(direct,$fileurl2);
						$traidnt->assign(fileurl,$fileurl);

						$fileicon = "uploads/thumbs/$newname";
                        $traidnt->assign(fileicon,$fileicon);
      					}else{
						$fileurl = $fileplace."/".$newname;
						$fileurl2 = $site[site_link]."/$fileplace/".$newname;
						$traidnt->assign(direct,$fileurl2);
						$traidnt->assign(fileurl,$fileurl);

						$fileicon = "uploads/thumbs/$newname";
                        $traidnt->assign(fileicon,$fileicon);

                        $fileurl = $fileplace."/".$newname;
						$traidnt->assign(fileurl,$fileurl);


						$iconarray = array("avi","css","divx","doc","docx","dvd","fon","swf" ,
						"mmf","mmm","movie","mp2","mp2v","mp3","mp4","mpeg","mpg","pdf","psd","ram","rar","rm","vcr","wma","zap","zip");

                        	if(in_array($fileext,$iconarray)){                               $fileicon = "./extension/$fileext.gif";
                       		}else{                       		  $fileicon = "./extension/traidnt.gif";

                       		}

                        $traidnt->assign(fileicon,$fileicon);



      					}

                    $ip = getenv('REMOTE_ADDR');
                    $time = time();

					$db->query("INSERT INTO `files` (`file_id` ,`file_name` ,`ipaddress` ,`file_date` ,`file_url` ,`file_tybe` ,
					`file_size` ,`file_count` ,`file_key` ,`group` )VALUES (NULL , '$newname', '$ip', '$time', '$fileurl2', '$fileext', '$filesize', '0', '$uniqname', '$group');");

     	    			if($group == "images"){
     	    			$traidnt->display("uploadimages.tpl");
     	    			    }else{
                             $traidnt->display("uploadfiles.tpl");

     	    			    }


                        unset($filetmp);
                    }else{                       $traidnt->display("uploaderror.tpl");

                    }





        }



	}

	$traidnt->display("footer.tpl");



$db->disconnect();
ob_end_flush();

?>