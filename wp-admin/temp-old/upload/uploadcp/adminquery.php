<?

 if (!defined('traidnt')) {
    die("Error: 404 Not Found");
}

    require '../libs/Smarty.class.php';
	include("../includes/class.DB.php");
	include("../includes/config.php");

	//New Smarty
	$traidnt = new Smarty;
	$traidnt->compile_check = true;
	$traidnt->debugging = false;
	$traidnt->compile_dir = '../trcash';
	$traidnt->template_dir = "adminstyle/";
	$traidnt->assign("stylepath","adminstyle");


	if(isset($_COOKIE[trupuser])){
      $adminuser =  strip_tags($_COOKIE[trupuser]);
      $adminpassword = strip_tags($_COOKIE[truppassword]);

 	  $getadmin = $db->query("SELECT * FROM `admin` WHERE `admin`.`admin_user` = '$adminuser' AND `admin`.`admin_password` = '$adminpassword'  LIMIT 0 , 1 ");
   	  $issetadmin = $db->resultcount($getadmin);

   	  if($issetadmin == 1){
        while($db->fetchrow($getadmin)){

        	$piclast = $db->record[admin_lastviste];
        	$fileslast = $db->record[admin_lastviste_file];            $adminid =  $db->record[admin_id];
        }

   	  }else{    		@setcookie("trupuser",$adminname,time()-3600*3);
      		@setcookie("truppassword",$adminpassword,time()-3600*3);
      		echo "<META HTTP-EQUIV=\"Refresh\" CONTENT=\"2; url=login.php\">";
      		exit();

   	  }

	}



?>