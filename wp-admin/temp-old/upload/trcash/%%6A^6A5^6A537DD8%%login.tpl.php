<?php /* تمت البرمجة بواسطة 
http://ahmed-elsayed.com */ ?>
<html dir="rtl">

<head>
<meta http-equiv="Content-Type" content="text/html; charset=windows-1256">
<link href="<?php echo $this->_tpl_vars['stylepath']; ?>
/admin.css" rel="stylesheet" type="text/css" media="all" />
<script type="text/javascript" src="../js/collapse.js"></script>

<title>لوحة الادارة - تسجيل الدخول</title>
</head>

<body topmargin="0" leftmargin="0" rightmargin="0" bottommargin="0" marginwidth="0" marginheight="0">

<br /><br /><br /><br /><br /><br /><br />

<div align="center">
<table border="0" width="32%" cellspacing="0" cellpadding="0" height="127">
	<tr>
		<td width="41" height="36">
		<img border="0" src="<?php echo $this->_tpl_vars['stylepath']; ?>
/images/t_r.jpg" width="41" height="36"></td>
		<td background="<?php echo $this->_tpl_vars['stylepath']; ?>
/images/t_m.jpg" height="36">&nbsp;</td>
		<td width="32" height="36">
		<img border="0" src="<?php echo $this->_tpl_vars['stylepath']; ?>
/images/t_l.jpg" width="32" height="36"></td>
	</tr>
	<tr>
		<td width="41" background="<?php echo $this->_tpl_vars['stylepath']; ?>
/images/m_r.jpg">
		<img border="0" src="<?php echo $this->_tpl_vars['stylepath']; ?>
/images/m_r.jpg" width="41" height="5"></td>
		<td>
		<div id="loginform" align="center">
		تسجيل الدخول للوحة الادارة
		<br />
		<form name="" action="login.php?do=login" method="post">
		<input name="adminname" value="" type="text"><br />
		<input type="password" value="" name="adminpassword"><br>
		<input type="submit" value="تسجيل الدخول">
		</form>
		</div>
		
		</td>
		<td width="32" background="<?php echo $this->_tpl_vars['stylepath']; ?>
/images/m_l.jpg">
		<img border="0" src="<?php echo $this->_tpl_vars['stylepath']; ?>
/images/m_l.jpg" width="32" height="5"></td>
	</tr>
	<tr>
		<td width="41" height="32">
		<img border="0" src="<?php echo $this->_tpl_vars['stylepath']; ?>
/images/d_r.jpg" width="41" height="32"></td>
		<td background="<?php echo $this->_tpl_vars['stylepath']; ?>
/images/d_m.jpg" height="32">&nbsp;</td>
		<td width="32" height="32">
		<img border="0" src="<?php echo $this->_tpl_vars['stylepath']; ?>
/images/d_l.jpg" width="32" height="32"></td>
	</tr>
</table>
</div>

</body>

</html>