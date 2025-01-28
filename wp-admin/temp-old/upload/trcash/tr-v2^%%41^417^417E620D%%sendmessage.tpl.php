<?php /* ��� ������� ������ 
http://ahmed-elsayed.com */ ?>
﻿
<head>
<meta http-equiv="Content-Language" content="ar-eg">
<link href="style.css" rel="stylesheet" type="text/css" media="all" />

		</head>

		<br />

<table style="width: 55%" dir="rtl" align="center" cellspacing="0" cellpadding="0">
	<tr>
		<td>
		<table cellspacing="0" cellpadding="0">
			<tr>
				<td style="width: 237px; height: 64px;">
				<img src="<?php echo $this->_tpl_vars['stylepath']; ?>
/images/tr-up_24.gif" width="248" height="74" alt=""></td>
				<td style="width: 396px; height: 64px" class="trstyle1">
				<img src="<?php echo $this->_tpl_vars['stylepath']; ?>
/images/tr-up_23.gif" width="14" height="74" alt=""></td>
				<td style="height: 64px">
				<img src="<?php echo $this->_tpl_vars['stylepath']; ?>
/images/tr-up_21.gif" width="164" height="74" alt=""></td>
			</tr>
		</table>
		</td>
	</tr>
	<tr>
		<td>
		<table style="width: 100%" cellspacing="0" cellpadding="0" dir="rtl">
			<tr>
				<td style="width: 18px" class="trstyle4">
				<img border="0" src="<?php echo $this->_tpl_vars['stylepath']; ?>
/images/tr-up_28.gif" width="18" height="10"></td>
				<td style="width: 775px" class="trstyle5">
				
				
				<br>
				<fieldset style="width: 444px">
				<legend>الاتصال بالادارة </legend>
				<form name="" action="sendmessage.php?go=send" method="post">
				<table style="width: 93%">
					<tr>
						<td style="width: 169px" class="up2"><strong>اســــــــــــــمـك 
						:&nbsp;</strong></td>
						<td class="up3">&nbsp;<input name="name" type="text" value="" style="width: 236px"></td>
					</tr>
					<tr>
						<td style="width: 169px" class="up2"><strong>بريدك الالكتروني :</strong></td>
						<td class="up3"> &nbsp;<input name="email" type="text" value="" style="width: 236px" dir="ltr"></td>
					</tr>
					<tr>
						<td style="width: 169px" class="up2">
						<strong>رســــــــــــــالتك :</strong></td>
						<td class="up3">&nbsp;<textarea style="height: 190px; width: 263px" name="msg"></textarea></td>
					</tr>
					
					<?php if ($this->_tpl_vars['site']['gd_admin'] == '1'): ?>
					<tr>
						<td style="width: 169px" class="up2"><strong>كود التحقق 
						:&nbsp;</strong></td>
						<td class="up3">
						<div id="captcha"><img src="captcha.php" border="0" alt="صورة التحقق">&nbsp;&nbsp; <input name="code" type="text" value=""></div>
						</td>
					</tr>
					<?php endif; ?>
					
					<tr>
						<td style="width: 169px" class="up2">&nbsp;</td>
						<td class="up3"><input type="submit" value="ارسال الرسالة" ></td>
					</tr>
				</table>
				</form>
				<br >
				</fieldset>
				<br>
				&nbsp;<br>
				</td>
				<td class="trstyle3">
				<img border="0" src="<?php echo $this->_tpl_vars['stylepath']; ?>
/images/tr-up_26.gif" width="26" height="10" alt="" ></td>
			</tr>
		</table>
		</td>
	</tr>
	<tr>
		<td>
		<table style="width: 100%" cellspacing="0" cellpadding="0">
			<tr>
				<td style="width: 10px">
				<img src="<?php echo $this->_tpl_vars['stylepath']; ?>
/images/tr-up_33.gif" width="21" height="50" alt=""></td>
				<td style="width: 761px" class="trstyle2">
				<img src="<?php echo $this->_tpl_vars['stylepath']; ?>
/images/tr-up_31.gif" width="13" height="50" alt=""></td>
				<td>
				<img src="<?php echo $this->_tpl_vars['stylepath']; ?>
/images/tr-up_30.gif" width="37" height="50" alt=""></td>
			</tr>
		</table>
		</td>
	</tr>
</table>
<br />
<br />
<br />