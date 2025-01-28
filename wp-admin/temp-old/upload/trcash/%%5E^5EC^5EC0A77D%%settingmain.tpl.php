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
<title>لوحة الادارة - الاعدادت العامة</title>
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
					<p align="center"><b>الاعدادت العامة</b></td>
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
						<br />
						<form name="" id="registerForm"  action="ajaxpages/updatesetting.php" method="post">
						<table border="0" width="786" cellpadding="0">
							<tr>
								<td class="main" width="272">
								اســــــــــم المـــــــــــــــــــــــــوقع :</td>
								<td class="submain" width="505" colspan="2">&nbsp;<input type="text" name="sitename" value="<?php echo $this->_tpl_vars['site']['site_name']; ?>
" size="53"></td>
							</tr>
							<tr>
								<td class="main" width="272">
								وصــــــــــــــــــف&nbsp; 
								المــــــــــــــــوقع :</td>
								<td class="submain" width="505" colspan="2">&nbsp;<textarea dir="rtl" rows="4" cols="34" name="sitemeta"><?php echo $this->_tpl_vars['site']['site_meta']; ?>
</textarea></td>
							</tr>
							<tr>
								<td class="main" width="272">
								رابـــــــــــــط البرنامـــــــــــــــــــــج 
								:</td>
								<td class="submain" width="505" colspan="2">
								<input type="text" name="sitescript" value="<?php echo $this->_tpl_vars['site']['site_link']; ?>
" size="53" dir="ltr"></td>
							</tr>
							<tr>
								<td class="main" width="272">
								رابــــــــــــــط المــــــــــــــــــــوقع :</td>
								<td class="submain" width="505" colspan="2">
								<input type="text" name="siteurl" value="<?php echo $this->_tpl_vars['site']['site_host']; ?>
" size="53" dir="ltr"></td>
							</tr>
							<tr>
								<td class="main" width="272">
								البريـــــــــــــد الالكتـــــــــــــروني :</td>
								<td class="submain" width="505" colspan="2">
								<input type="text" name="siteemail" value="<?php echo $this->_tpl_vars['site']['site_mail']; ?>
" size="53" dir="ltr"></td>
							</tr>
							<tr>
								<td class="main" width="272">
								الحد الأقصي للتحميل بالمرة الواحده :</td>
								<td class="submain" width="505" colspan="2">
								<input type="text" name="sitemaxupload" value="<?php echo $this->_tpl_vars['site']['site_delimg']; ?>
" size="53"></td>
							</tr>
							<tr>
								<td class="main" width="272">
								تفعيـــــــل ختـــــــم الصــــــــــــور :</td>
								<td class="submain" width="233">
								<input type="radio" id="sitelogo" value="1" name="sitelogo" <?php if ($this->_tpl_vars['site']['site_logo'] == '1'): ?>checked<?php endif; ?>>
								<label for="sitelogo">نعم</label></td>
								<td class="submain" width="273">
								<input type="radio" id="sitelogo-no" value="0" name="sitelogo" <?php if ($this->_tpl_vars['site']['site_logo'] == '0'): ?>checked<?php endif; ?> >
								<label for="sitelogo-no" >لا</label>
								</td>
							</tr>
							<tr>
								<td class="main" width="272">
								عــــدد ثــــواني الانتظــــــــــــــــار :</td>
								<td class="submain" width="505" colspan="2">
								<input type="text" name="sitewaiting" value="<?php echo $this->_tpl_vars['site']['site_second']; ?>
" size="53"></td>
							</tr>
							<tr>
								<td class="main" colspan="3"><i><b>
								خيارات مصغرات الصور</b></i></td>
							</tr>
							<tr>
								<td class="main" width="272">
								عـــرض الصـــــــــــــور المصغــــرة :</td>
								<td class="submain" width="505" colspan="2">
								<input type="text" name="sitewidth" value="<?php echo $this->_tpl_vars['site']['img_width']; ?>
" size="53"></td>
							</tr>
							<tr>
								<td class="main" width="272">
								ارتفــــــــاع الصـــــــــــور المصغرة :</td>
								<td class="submain" width="505" colspan="2">
								<input type="text" name="sitehight" value="<?php echo $this->_tpl_vars['site']['img_high']; ?>
" size="53"></td>
							</tr>
							<tr>
								<td class="main" width="99%" colspan="3"><i><b>
								خيارات التحميل بالمركز</b></i></td>
							</tr>
							<tr>
								<td class="main" width="272">
								ســـــــابقة اسم الملفات والصـور :</td>
								<td class="submain" width="505" colspan="2">
								<input type="text" name="siteprname" value="<?php echo $this->_tpl_vars['site']['site_previous']; ?>
" size="53" dir="ltr"></td>
							</tr>
							<tr>
								<td class="main" width="272">
								الحجم الكلي لمجــــــــلد التحميل :</td>
								<td class="submain" width="505" colspan="2">
								<input type="text" name="sitetotalsize" value="<?php echo $this->_tpl_vars['site']['site_totalsize']; ?>
" size="53"></td>
							</tr>
							<tr>
								<td class="main" width="272">
								ايقـــــاف رفــــع الملفـــــــــــــــات :
								</td>
								<td class="submain" width="233">
								<input type="radio" id="siteupload" value="1" name="siteupload" <?php if ($this->_tpl_vars['site']['site_inactive'] == '1'): ?>checked<?php endif; ?> >
								<label for="siteupload">نعم</label>
								</td>
								<td class="submain" width="273">
								<input type="radio" id="siteupload-no" value="0" name="siteupload" <?php if ($this->_tpl_vars['site']['site_inactive'] == '0'): ?>checked<?php endif; ?>>
								<label for="siteupload-no">لا</label>
								</td>
							</tr>
							<tr>
								<td class="main" width="272">
								اغــــــــــــلاق المــــــــــــــــــركز :</td>
								<td class="submain" width="233">
								<input type="radio" id="siteclose" value="1" name="siteclose" <?php if ($this->_tpl_vars['site']['site_close'] == '1'): ?>checked<?php endif; ?>> 
								<label for="siteclose">نعم</label>
								</td>
								<td class="submain" width="273">
								<input type="radio" id="siteclose-no" value="0" name="siteclose" <?php if ($this->_tpl_vars['site']['site_close'] == '0'): ?>checked<?php endif; ?>>
								<label for="siteclose-no">لا</label>
								</td>
							</tr>
							<tr>
								<td class="main" width="272">
								رســــــــالة الاغــــــــــــــــــــــلاق :</td>
								<td class="submain" width="505" colspan="2">
								<textarea rows="4" cols="34" name="siteclosemsg" dir="rtl"><?php echo $this->_tpl_vars['site']['site_closemessage']; ?>
</textarea></td>
							</tr>
							<tr>
								<td class="main" width="272">&nbsp;</td>
								<td class="submain" width="505" colspan="2"><div align="center"><input type="submit" value="تحديث الإعدادات"></div></td>
							</tr>
						</table>
						</form>
					
						</div>
					</td>
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