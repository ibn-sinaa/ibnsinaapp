<?

 if (!defined('traidnt')) {
    die("Error: 404 Not Found");
}

    require '../../libs/Smarty.class.php';
	include("../../includes/class.DB.php");
	include("../../includes/config.php");

	//New Smarty
	$traidnt = new Smarty;
	$traidnt->compile_check = true;
	$traidnt->debugging = false;
	$traidnt->compile_dir = '../trcash';
	$traidnt->template_dir = "adminstyle/";
	$traidnt->assign("stylepath","adminstyle");





?>