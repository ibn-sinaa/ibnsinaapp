<?php /* تمت البرمجة بواسطة 
http://ahmed-elsayed.com */ ?>
<html dir="rtl">

<head>
<meta http-equiv="Content-Type" content="text/html; charset=windows-1256">
<link href="<?php echo $this->_tpl_vars['stylepath']; ?>
/admin.css" rel="stylesheet" type="text/css" media="all" />
<script type="text/javascript" src="js/collapse.js"></script>
<script type="text/javascript" src="js/mootools.js"></script>
<SCRIPT LANGUAGE="JavaScript" TYPE="text/javascript" SRC="js/ajax.js"></SCRIPT>
<link href="admin.css" rel="stylesheet" type="text/css" media="all" />
<title>لوحة الادارة - الصفحة الرئيسية</title>
</head>

<body topmargin="0" leftmargin="0" rightmargin="0" bottommargin="0" marginwidth="0" marginheight="0">
<table border="0" width="100%" cellpadding="0" height="65">
	<tr>
		<td colspan="2" background="<?php echo $this->_tpl_vars['stylepath']; ?>
/images/head.gif" height="31">
		<p style="text-align: right"><a href="index.php">&nbsp; لوحة الادارة</span></a> -<a href="../index.php"> 
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
		<div align="center">
			<table border="0" width="89%" cellspacing="0" cellpadding="0">
				<tr>
					<td width="1%">
					<img border="0" src="<?php echo $this->_tpl_vars['stylepath']; ?>
/images/admin_09.gif" width="33" height="31"></td>
					<td width="96%" background="<?php echo $this->_tpl_vars['stylepath']; ?>
/images/admin_08.gif">
					<p align="center"><b>الترخيص</b></td>
					<td width="2%">
					<img border="0" src="<?php echo $this->_tpl_vars['stylepath']; ?>
/images/admin_07.gif" width="22" height="31"></td>
				</tr>
				<tr>
					<td colspan="3" style="border: 1px solid #62607C" bgcolor="#EDF1F3">
					<p align="center">&nbsp;
					مركز تحميل <b>
					<a target="_blank" href="http://www.traidnt.net/">ترايد نت</a></b> الاصدار الثاني
					<br>
					هذه النسخة مجانية ولا يسمح بالمتاجرة بها <span lang="ar-eg">
					بأي</span> حال من الأحوال 
					</td>
				</tr>
			</table>
		</div>
<br>
		
		<div align="center">
			<table border="0" width="89%" cellspacing="0" cellpadding="0">
				<tr>
					<td width="1%">
					<img border="0" src="<?php echo $this->_tpl_vars['stylepath']; ?>
/images/admin_09.gif" width="33" height="31"></td>
					<td width="96%" background="<?php echo $this->_tpl_vars['stylepath']; ?>
/images/admin_08.gif">
					<p align="center"><b>ملاحظات المدير</b></td>
					<td width="2%">
					<img border="0" src="<?php echo $this->_tpl_vars['stylepath']; ?>
/images/admin_07.gif" width="22" height="31"></td>
				</tr>
				<tr>
					<td colspan="3" style="border: 1px solid #62607C" bgcolor="#EDF1F3">
						<div id="log">
							<div id="log_res">
					<!-- SPANNER -->
							</div>
						</div>
						<br>
						<div id="container">
					<form name="" id="registerForm"  action="ajaxpages/updatenote.php" method="post">
				
					<textarea rows="10" id="note" cols="67" name="note"><?php echo $this->_tpl_vars['notevalue']; ?>
</textarea>
					<br><br>
					<input type="submit" value="تحديث الملاحظات"  >
					</form>
					</div>
					</td>
				</tr>
			</table>
		</div>		
	

		<br />
		
		
		<div align="center">
			<table border="0" width="89%" cellspacing="0" cellpadding="0">
				<tr>
					<td width="1%">
					<img border="0" src="<?php echo $this->_tpl_vars['stylepath']; ?>
/images/admin_09.gif" width="33" height="31"></td>
					<td width="96%" background="<?php echo $this->_tpl_vars['stylepath']; ?>
/images/admin_08.gif">
					<p align="center"><b>احصائيات المركز</b></td>
					<td width="2%">
					<img border="0" src="<?php echo $this->_tpl_vars['stylepath']; ?>
/images/admin_07.gif" width="22" height="31"></td>
				</tr>
				<tr>
					<td colspan="3" style="border: 1px solid #62607C" bgcolor="#EDF1F3">
					
					<br>
					&nbsp;<table border="0" width="61%" cellpadding="0" cellspacing="1">
						<tr>
							<td rowspan="5" width="339"><?php echo $this->_tpl_vars['chart']; ?>
</td>
							<td width="131" bgcolor="#CCD7DD">العــدد الكلي للملفــــات :</td>
							<td style="text-align: right" bgcolor="#D9E1E6">&nbsp; <?php echo $this->_tpl_vars['totalfiles']; ?>
</td>
						</tr>
						<tr>
							<td width="131" bgcolor="#CCD7DD">عـــــدد الملفـــــــــــــات :</td>
							<td style="text-align: right" bgcolor="#D9E1E6">&nbsp;<?php echo $this->_tpl_vars['totalfile']; ?>
</td>
						</tr>
						<tr>
							<td width="131" bgcolor="#CCD7DD">عــــــدد الصــــــــــــــــور :</td>
							<td style="text-align: right" bgcolor="#D9E1E6">&nbsp;<?php echo $this->_tpl_vars['totalimages']; ?>
</td>
						</tr>
						<tr>
							<td width="131" bgcolor="#CCD7DD">عدد الملفات المبلغ عنها :</td>
							<td style="text-align: right" bgcolor="#D9E1E6">&nbsp;<?php echo $this->_tpl_vars['totalreport']; ?>
</td>
						</tr>
						<tr>
							<td width="131" bgcolor="#CCD7DD">
							المساحة المستخدمة :</td>
							<td style="text-align: right" bgcolor="#D9E1E6">&nbsp; <?php echo $this->_tpl_vars['percentage']; ?>
%
</td>
						</tr>
					</table>
					<br>&nbsp;</td>
				</tr>
			</table>
		</div>
		<br />	
		</td>
	</tr>
</table>


</body>

</html>