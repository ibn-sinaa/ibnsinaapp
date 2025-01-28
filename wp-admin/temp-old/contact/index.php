<?php
session_start();

if($_POST){

	/*if($_SESSION['check'] != $_POST['txtcaptcha'])
	{
		echo '<center><b>«·—„“ «·√„‰Ì €Ì— ’ÕÌÕ ... <a href="contactus.php">⁄Êœ…</a></b>';
	}else{*/

	$name    = $_POST['name'];
	$email   = $_POST['email'];
	$mobil   = $_POST['mobil'];
	//$fax     = $_POST['fax'];
	//$phone   = $_POST['phone'];
	//$subject = $_POST['subject'];
	$subject = 'ibn-sinaa.net';
	$body    = $_POST['body'];

include ('mail.php');
	
	$email_it_to = "ibn.sinaa@hotmail.com";
	
	$email_message = '<style type="text/css">
.style1 {
	text-align: center;
	font-size: small;
	font-family: Tahoma;
}
.style2 {
	text-align: right;
	font-size: small;
}
.style3 {
	text-align: right;
	font-family: Tahoma;
	font-size: small;
}
.style4 {
	text-align: right;
	font-family: Tahoma;
	font-size: small;
}
</style>

<table style="width: 100%">
	<tr>
		<td style="width: 70%" class="style4">
		<span lang="en-us" class="style3">'.$name.'</span></td>
		<td class="style1"><strong>≈”„ «·„—”·</strong></td>
	</tr>
	<tr>
		<td style="width: 70%" class="style2"><span class="style3">'.$email.'</span></td>
		<td class="style1"><strong>»—ÌœÂ «·≈·ﬂ —Ê‰Ì</strong></td>
	</tr>
	<tr>
		<td style="width: 70%" class="style4">
		<span lang="en-us" class="style3">'.$mobil.'</span></td>
		<td class="style1"><strong>«·ÃÊ«·</strong></td>
	</tr>
	<tr>
		<td style="width: 70%" class="style4">
		<span lang="en-us" class="style3">'.$body.'</span></td>
		<td class="style1"><strong>‰’ «·—”‹«·…</strong></td>
	</tr>
</table>

';
	
	$headers  = 'MIME-Version: 1.0' . "\r\n";
	$headers .= 'Content-type: text/html; charset=windows-1256' . "\r\n";
	$headers .= "From: http://www.ibn-sinaa.net/ <http://www.ibn-sinaa.net/>";

	$Sent = smtpmail($email_it_to,$subject,$email_message,$headers);
	
	if($Sent){
		echo '<center><b> „ ≈—”‹«· «·—”‹«·…</b>';
	}else{
		echo '<center><b>·„ Ì „ «·≈—”‹«·</b>';
	}
	
	//}

}else{

?>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">

<head>
<meta http-equiv="Content-Language" content="ar-sa" />
<meta http-equiv="Content-Type" content="text/html; charset=windows-1256" />
<link rel="stylesheet" type="text/css" href="cstyle.css" />
<script type="text/javascript" src="validator.js"></script>
<title>Contact Us Form</title>
</head>

<body>

<div id="form">
<form method="POST" name="Sform">
 <table border="0" align="center" cellpadding="0" cellspacing="0" style="width: 80%">
        <tr>
          <td class="brd">
		   <div class="mg">
		      <p align="center">‰„Ê–Ã ≈ ’‹· »‰«</p>
              <table border="0" align="center" cellpadding="4" cellspacing="0" style="width: 523px">
			  
                <tr> 
                  <td style="width: 402px" class="style22"><input type="text" name="name" size="30" /></td>
                  <td><label> : «·≈”„ »«·ﬂ«„·</label></td>
                </tr>
				
                <tr> 
                  <td style="width: 402px" class="style22"><input type="text" name="email" size="30" /></td>
                  <td><label> : «·»—Ìœ «·≈·ﬂ —Ê‰Ì</label></td>
                </tr>
				
                <tr> 
                  <td style="width: 402px" class="style22"><input type="text" name="mobil" size="30" /></td>
                  <td><label> : «·ÃÊ«·</label></td>
                </tr>
				
                <tr> 
                  <td style="width: 402px" class="style22">
					<textarea name="body" name="body" style="width: 344px; height: 177px" dir="rtl"></textarea></td>
                  <td valign="top"><label> : ‰’ «·—”‹«·…</label></td>
                </tr>
				
                <tr align="center"> 
                  <td colspan="2">
					<input type="submit" value="≈—”‹«·" name="submit" onClick="return check_values();"></td>
                </tr>
              </table>
			  
<script language="JavaScript">
var frmvalidator = new Validator("Sform");

 frmvalidator.addValidation("name","req","Õﬁ· «·≈”„ „ÿ·Ê»");
 frmvalidator.addValidation("name","maxlen=25","«·≈”„ √ÿÊ· „‰ «··«“„");
 frmvalidator.addValidation("name"," alphanum_s","ÌÃ» √·« ÌÕ ÊÌ «·≈”„ ⁄·Ì —„Ê“ Œ«’…");

 frmvalidator.addValidation("email","req","«·»—Ìœ «·≈·ﬂ —Ê‰Ì „ÿ·Ê»");
 frmvalidator.addValidation("email","maxlen=50","«·»—Ìœ «·≈·ﬂ —Ê‰Ì √ÿÊ· „‰ «··«“„");
 frmvalidator.addValidation("email","email","’Ì€… «·»—Ìœ €Ì— ’ÕÌÕ…");

 frmvalidator.addValidation("body","req","‰’ «·—”‹«·… „ÿ·Ê»");
 

</script>
            </form>
					<div id="confirmation" style="display:none" align="center"></div><br />
			</p>
			</div>

</body>

</html>

<?php 

}

?>