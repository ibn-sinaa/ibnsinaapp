<?php /* ��� ������� ������ 
http://ahmed-elsayed.com */ ?>
﻿<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" >

<head>

<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />

<link href="<?php echo $this->_tpl_vars['stylepath']; ?>
/style.css" rel="stylesheet" type="text/css" media="all" />

<title><?php echo $this->_tpl_vars['site']['site_name']; ?>
</title>
</head>

<body style="margin: 0">


<table style="width: 100%" cellspacing="0" cellpadding="0">
	<tr>
		<td>
		
		<!--Start Header!-->
		
		
		<table style="width: 100%" cellspacing="0" cellpadding="0">
	<tr>
		<td>
		<img src="<?php echo $this->_tpl_vars['stylepath']; ?>
/images/tr-up_01.gif" width="20" height="179" alt="" /></td>
		<td style="width: 255px">
		<img src="<?php echo $this->_tpl_vars['stylepath']; ?>
/images/tr-up_02.gif" width="318" height="179" alt="" /></td>
		<td style="width: 615px" class="style1">
		<img src="<?php echo $this->_tpl_vars['stylepath']; ?>
/images/tr-up_03.gif" width="17" height="179" alt="" /></td>
		<td>
		<img src="<?php echo $this->_tpl_vars['stylepath']; ?>
/images/tr-up_04.gif" width="394" height="179" alt="" /></td>
		<td>
		<img src="<?php echo $this->_tpl_vars['stylepath']; ?>
/images/tr-up_05.gif" width="28" height="179" alt=""  /></td>
	</tr>
</table>

		<!--End Header!-->
		
		</td>
	</tr>
	<tr>
		<td>
		
		<table border="0" width="100%" cellspacing="0" cellpadding="0">
			<tr>
				<td width="5" class="left" >
			<img src="<?php echo $this->_tpl_vars['stylepath']; ?>
/images/tr-up_06.gif" width="20" height="10" alt="" />
			</td>
				<td class="subbody">
				<div align="center">
		<table style="width: 44%; height: 32px;">
			<tr>
				<td>&nbsp;<a href="sendmessage.php">
				<img alt="اتصل بالادارة" src="<?php echo $this->_tpl_vars['stylepath']; ?>
/images/button_telladmin.gif" class="noborder" width="127" height="66" /></a></td>
				<td>
				<a href="page.php?page=statistics">
				<img alt="الاحصائيات" src="<?php echo $this->_tpl_vars['stylepath']; ?>
/images/button_statistics.gif" class="noborder" width="137" height="67" /></a></td>
				<td>
				<a href="page.php?page=adv">
				<img alt="الاعلانات" src="<?php echo $this->_tpl_vars['stylepath']; ?>
/images/button_adv.gif" class="noborder" width="132" height="67" /></a></td>
				<td>
				<a href="page.php?page=rules">
				<img alt="القوانين" src="<?php echo $this->_tpl_vars['stylepath']; ?>
/images/button_rules.gif" class="noborder" width="125" height="67" /></a></td>
				<td>&nbsp;<a href="index.php"><img class="noborder" alt="الصفحة الرئيسية" src="<?php echo $this->_tpl_vars['stylepath']; ?>
/images/button_main.gif" width="128" height="66" /></a></td>
			</tr>
		</table>
		</div>
		
				<!-- Start Adv!-->
				<?php $_smarty_tpl_vars = $this->_tpl_vars;
$this->_smarty_include(array('smarty_include_tpl_file' => 'adv.htm', 'smarty_include_vars' => array()));
$this->_tpl_vars = $_smarty_tpl_vars;
unset($_smarty_tpl_vars);
 ?>
				<!--End Adv!-->
		