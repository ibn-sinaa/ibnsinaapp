<?php /* تمت البرمجة بواسطة 
http://ahmed-elsayed.com */ ?>
<html dir="rtl">

<head>
<meta http-equiv="Content-Type" content="text/html; charset=windows-1256">
<link href="<?php echo $this->_tpl_vars['stylepath']; ?>
/admin.css" rel="stylesheet" type="text/css" media="all" />
<script type="text/javascript" src="js/collapse.js"></script>
<link href="admin.css" rel="stylesheet" type="text/css" media="all" />
<title>لوحة الادارة - تغيير معلومات الادارة</title>
</head>

<body topmargin="0" leftmargin="0" rightmargin="0" bottommargin="0" marginwidth="0" marginheight="0">
<table border="0" width="100%" cellpadding="0" height="65">
	<tr>
		<td colspan="2" background="<?php echo $this->_tpl_vars['stylepath']; ?>
/images/head.gif" height="31">
		<p style="text-align: right"><a href="index.php">&nbsp; لوحة الادارة</a> -<a href="../index.php"> 
		العودة للرئيسية</a></td>
	</tr>
	<tr>
		<td width="16%" valign="top">&nbsp;
		
		<!-- blocks!-->
		
		<?php $_smarty_tpl_vars = $this->_tpl_vars;
$this->_smarty_include(array('smarty_include_tpl_file' => 'link.tpl', 'smarty_include_vars' => array()));
$this->_tpl_vars = $_smarty_tpl_vars;
unset($_smarty_tpl_vars);
 ?>
		
		<!--End blocks!-->
		
		
		
		
		
		</td>
		<td width="83%" valign="top">
		<br /><br />
<br>
		
		<div align="center">
			<table border="0" width="89%" cellspacing="0" cellpadding="0">
				<tr>
					<td width="1%">
					<img border="0" src="<?php echo $this->_tpl_vars['stylepath']; ?>
/images/admin_09.gif" width="33" height="31"></td>
					<td width="96%" background="<?php echo $this->_tpl_vars['stylepath']; ?>
/images/admin_08.gif">
					<p align="center"><b>تغيير معلومات الادارة&nbsp; </b></td>
					<td width="2%">
					<img border="0" src="<?php echo $this->_tpl_vars['stylepath']; ?>
/images/admin_07.gif" width="22" height="31"></td>
				</tr>
				<tr>
					<td colspan="3" style="border: 1px solid #62607C" bgcolor="#EDF1F3">
						
						</div>
						<br>
						<form name="" action="main.php?do=changepass&go=update" method="post">
						<div align="center">
						<table border="0" width="52%" cellpadding="0">
							<tr>
								<td colspan="2" class="main"><b><span lang="ar-eg">
								معلومات المدير</span></b></td>
							</tr>
							<tr>
								<td class="main" width="39%"><span lang="ar-eg">
								كلمة المرور القديمة : </span>
								<font color="#FF0000">*</font></td>
								<td class="submain" width="60%">&nbsp;<input name="oldpass" type="text" value="" size="37"></td>
							</tr>
							<tr>
								<td class="main" width="39%"><span lang="ar-eg">
								كلمة المرور الجديدة :</span></td>
								<td class="submain" width="60%">
								<input name="newpass" type="text" value="" size="37"></td>
							</tr>
							<tr>
								<td class="main" width="39%"><span lang="ar-eg">
								اسم المستخدم :</span> <font color="#FF0000">*</font></td>
								<td class="submain" width="60%">
								<input name="username" type="text" value="<?php echo $this->_tpl_vars['adminname']; ?>
" size="37"></td>
							</tr>
							<tr>
								<td class="main" width="39%">&nbsp;</td>
								<td class="submain" width="60%">&nbsp;<input type="submit" value="تحديث المعلومات"></td>
							</tr>
						</table>
						</div>
						</form>
						<br></td>
				</tr>
			</table>
		</div>		
	

		<p>
		<br />	
		</td>
	</tr>
</table>


</body>

</html>