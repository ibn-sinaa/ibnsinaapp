<?php

	$name    = $_POST['name'];
	$email   = $_POST['email'];
	$mobil   = $_POST['mobil'];
	$fax     = $_POST['fax'];
	$phone   = $_POST['phone'];
	$subject = $_POST['subject'];
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
		<td style="width: 772px" class="style4">
		<span lang="en-us" class="style3">'.$name.'</span></td>
		<td class="style1"><strong>��� ������</strong></td>
	</tr>
	<tr>
		<td style="width: 772px" class="style2"><span class="style3">'.$email.'</span></td>
		<td class="style1"><strong>����� ����������</strong></td>
	</tr>
	<tr>
		<td style="width: 772px" class="style4">
		<span lang="en-us" class="style3">'.$phone.'</span></td>
		<td class="style1"><strong>��� ������</strong></td>
	</tr>
	<tr>
		<td style="width: 772px" class="style4">
		<span lang="en-us" class="style3">'.$mobil.'</span></td>
		<td class="style1"><strong>������</strong></td>
	</tr>
	<tr>
		<td style="width: 772px" class="style4">
		<span lang="en-us" class="style3">'.$fax.'</span></td>
		<td class="style1"><strong>������</strong></td>
	</tr>
	<tr>
		<td style="width: 772px" class="style4">
		<span lang="en-us" class="style3">'.$body.'</span></td>
		<td class="style1"><strong>�� ��������</strong></td>
	</tr>
</table>

';
	
	$headers  = 'MIME-Version: 1.0' . "\r\n";
	$headers .= 'Content-type: text/html; charset=windows-1256' . "\r\n";
	$headers .= "From: www.j-almulla.com <www.j-almulla.com>";

	$Sent = smtpmail($email_it_to,$subject,$email_message,$headers);
	
	
	
?>