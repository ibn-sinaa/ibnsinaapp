<?php /* تمت البرمجة بواسطة 
http://ahmed-elsayed.com */ ?>
<html dir="rtl">

<head>
<meta http-equiv="Content-Type" content="text/html; charset=windows-1256">
<link href="<?php echo $this->_tpl_vars['stylepath']; ?>
/admin.css" rel="stylesheet" type="text/css" media="all" />
<script type="text/javascript" src="js/collapse.js"></script>
<link href="admin.css" rel="stylesheet" type="text/css" media="all" />
<title>لوحة الادارة - ادار حظر الايبهات</title>
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
					<p align="center"><b>ادارة حظر الايبهات&nbsp; </b></td>
					<td width="2%">
					<img border="0" src="<?php echo $this->_tpl_vars['stylepath']; ?>
/images/admin_07.gif" width="22" height="31"></td>
				</tr>
				<tr>
					<td colspan="3" style="border: 1px solid #62607C" bgcolor="#EDF1F3">
						
					<br>	
						
					<form name="" action="main.php?do=ip&go=add" method="post">
					<div align="center">
					<table border="0" width="290" cellpadding="0">
						<tr>
							<td class="main" width="286" colspan="2"><b>أضافه اي 
							بي جديد</b></td>
						</tr>
						<tr>
							<td class="submain" width="203">&nbsp;<input type="text" value="" name="ip" size="31" dir="ltr"></td>
							<td class="submain" width="81">&nbsp;<input type="submit" value="اضافه"></td>
						</tr>
					</table>
						</div>
			</form>
			<div align="center">
			<?php if ($this->_tpl_vars['total'] != '0'): ?>
			
					<table border="0" width="31%" cellpadding="0">
						<tr>
							<td colspan="2" class="main"><b><span lang="ar-eg">
							قائمة المحظورين</span></b></td>
						</tr>
						<?php $_from = $this->_tpl_vars['list']; if (!is_array($_from) && !is_object($_from)) { settype($_from, 'array'); }if (count($_from)):
    foreach ($_from as $this->_tpl_vars['ip']):
?>
						<tr>
							<td class="submain" width="53%"><a href="http://whois.domaintools.com/<?php echo $this->_tpl_vars['ip']['banned_ip']; ?>
" target="_blank" ><?php echo $this->_tpl_vars['ip']['banned_ip']; ?>
</a></td>
							<td class="submain" width="45%">&nbsp;<a href="main.php?do=ip&go=delete&id=<?php echo $this->_tpl_vars['ip']['banned_id']; ?>
"><img src="images/delete.gif"  alt="حذف الاي بي" border="0"></a></td>
						</tr>
					<?php endforeach; endif; unset($_from); ?>
					</table>
					
					<?php endif; ?>
					</div>
					<br>
					</td>
				</tr>
			</table>
		<br>
		</div>		
			
		<br />	
		</td>
	</tr>
</table>


</body>

</html>