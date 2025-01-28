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

       $sitename  = charset($_POST[sitename]);
       $sitemeta = charset($_POST[sitemeta]);
       $sitescript = charset($_POST[sitescript]);
       $siteurl = charset($_POST[siteurl]);
       $siteemail = charset($_POST[siteemail]);
       $sitemaxupload = charset($_POST[sitemaxupload]);
       $sitelogo  = charset($_POST[sitelogo]);
       $sitewaiting = charset($_POST[sitewaiting]);
       $sitewidth = charset($_POST[sitewidth]);
       $sitehight = charset($_POST[sitehight]);
       $siteprname = charset($_POST[siteprname]);
       $sitetotalsize = charset($_POST[sitetotalsize]);
       $siteupload = charset($_POST[siteupload]);
       $siteclose = charset($_POST[siteclose]);
       $siteclosemsg = charset($_POST[siteclosemsg]);


			if ($sitename =='' )
			{
				$errors[] = '·„  ﬁ„ »«œŒ«· «”„ «·„Êﬁ⁄';
			}

			if ($sitemeta =='' )
			{
				$errors[] = '·„  ﬁ„ »«œŒ«· Ê’› «·„Êﬁ⁄';
			}

			if ($siteurl =='' )
			{
				$errors[] = '·„  ﬁ„ »«œŒ«· —«»ÿ «·„Êﬁ⁄';
			}

			if (valid_email($siteemail)==FALSE)
			{
				$errors[] = '⁄›Ê« »—Ìœ «·«œ«—… €Ì— ’ÕÌÕ';
			}

			if ($sitemaxupload =='' || is_numeric($sitemaxupload)==FALSE)
			{
				$errors[] = '⁄›Ê« «·Õœ «·«ﬁ’Ì ·· Õ„Ì· «—ﬁ«„ ›ﬁÿ';
			}

			if ($sitewaiting =='' || is_numeric($sitewaiting)==FALSE)
			{
				$errors[] = '„‰ ›÷·ﬂ ⁄œœ ÀÊ«‰Ì «·«‰ Ÿ«— «—ﬁ«„ ›ﬁÿ';
			}

			if ($sitewidth =='' || is_numeric($sitewidth)==FALSE)
			{
				$errors[] = '⁄›Ê« ⁄—÷ «·’Ê— «·„’€—… «—ﬁ«„ ›ﬁÿ';
			}

			if ($sitehight =='' || is_numeric($sitehight)==FALSE)
			{
				$errors[] = '⁄›Ê« «— ›«⁄ «·’Ê— «·„’€—… «—ﬁ«„ ›ﬁÿ';
			}

			if ($sitetotalsize =='' || is_numeric($sitetotalsize)==FALSE)
			{
				$errors[] = '⁄›Ê« «·ÕÃ„ «·ﬂ·Ì ·· Õ„Ì· «—ﬁ«„ ›ﬁÿ';
			}

			if ($siteprname =='' )
			{
				$errors[] = '„‰ ›÷·ﬂ «œŒ· ”«»ﬁ… «”„ «·„·›« ';
			}

			if ($siteclosemsg =='' )
			{
				$errors[] = '„‰ ›÷·ﬂ «œŒ· —”«·… «·«€·«ﬁ';
			}




		if(is_array($errors))
		{
			echo iconv('windows-1256','utf-8','<p ><b>»—Ã«¡ „—«Ã⁄… «·«Œÿ«¡ «· «·Ì…</b></p>');
				while (list($key,$value) = each($errors))
				{

					echo iconv('windows-1256','utf-8','<span class="error">'.$value.'</span><br />'); ;
				}
		}
		else {
         $db->query("UPDATE `setting` SET
         	`site_name` = '$sitename',
			`site_meta` = '$sitemeta',
			`site_link` = '$sitescript',
			`site_host` = '$siteurl',
			`site_mail` = '$siteemail',
			`site_logo` = '$sitelogo',
			`site_second` = '$sitewaiting',
			`img_high` = '$sitehight',
			`img_width` = '$sitewidth',
			`site_inactive` = '$siteupload',
			`site_previous` = '$siteprname',
			`site_delimg` = '$sitemaxupload',
			`site_totalsize` = '$sitetotalsize',
			`site_close` = '$siteclose',
			`site_closemessage` = '$siteclosemsg' WHERE `setting`.`site_id` =1 LIMIT 1 ;
			")or die(mysql_error());
	  	 echo charset2("<span class='right'> „  ÕœÌÀ «·„·«ÕŸ«  »‰Ã«Õ</span>");


		}



    }


	$db->disconnect();

	ob_end_flush();
?>