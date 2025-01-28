<html dir="rtl">

<head>
<meta http-equiv="Content-Type" content="text/html; charset=windows-1256">
<link href="{$stylepath}/admin.css" rel="stylesheet" type="text/css" media="all" />
<script type="text/javascript" src="js/collapse.js"></script>
<script type="text/javascript" src="js/mootools.js"></script>
<SCRIPT LANGUAGE="JavaScript" TYPE="text/javascript" SRC="js/ajax.js"></SCRIPT>
<link href="admin.css" rel="stylesheet" type="text/css" media="all" />
<title>لوحة الادارة - الاعدادت العامة</title>
</head>

<body topmargin="0" leftmargin="0" rightmargin="0" bottommargin="0" marginwidth="0" marginheight="0">
<table border="0" width="100%" cellpadding="0" height="65">
	<tr>
		<td colspan="2" background="{$stylepath}/images/head.gif" height="31">
		<p style="text-align: right"><a href="index.php">&nbsp; لوحة الادارة</a> -<a href="../index.php"> 
		العودة للرئيسية</a></td>
	</tr>
	<tr>
		<td width="16%" valign="top">&nbsp;
		
		<!-- blocks!-->
		
		{include file='link.tpl'}
		
		<!--End blocks!-->
		
		
		
		
		
		</td>
		<td width="83%" valign="top">
		<br /><br />
<br>
		
		<div align="center">
			<table border="0" width="89%" cellspacing="0" cellpadding="0">
				<tr>
					<td width="1%">
					<img border="0" src="{$stylepath}/images/admin_09.gif" width="33" height="31"></td>
					<td width="96%" background="{$stylepath}/images/admin_08.gif">
					<p align="center"><b>الاعدادت العامة</b></td>
					<td width="2%">
					<img border="0" src="{$stylepath}/images/admin_07.gif" width="22" height="31"></td>
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
								<td class="submain" width="505" colspan="2">&nbsp;<input type="text" name="sitename" value="{$site.site_name}" size="53"></td>
							</tr>
							<tr>
								<td class="main" width="272">
								وصــــــــــــــــــف&nbsp; 
								المــــــــــــــــوقع :</td>
								<td class="submain" width="505" colspan="2">&nbsp;<textarea dir="rtl" rows="4" cols="34" name="sitemeta">{$site.site_meta}</textarea></td>
							</tr>
							<tr>
								<td class="main" width="272">
								رابـــــــــــــط البرنامـــــــــــــــــــــج 
								:</td>
								<td class="submain" width="505" colspan="2">
								<input type="text" name="sitescript" value="{$site.site_link}" size="53" dir="ltr"></td>
							</tr>
							<tr>
								<td class="main" width="272">
								رابــــــــــــــط المــــــــــــــــــــوقع :</td>
								<td class="submain" width="505" colspan="2">
								<input type="text" name="siteurl" value="{$site.site_host}" size="53" dir="ltr"></td>
							</tr>
							<tr>
								<td class="main" width="272">
								البريـــــــــــــد الالكتـــــــــــــروني :</td>
								<td class="submain" width="505" colspan="2">
								<input type="text" name="siteemail" value="{$site.site_mail}" size="53" dir="ltr"></td>
							</tr>
							<tr>
								<td class="main" width="272">
								الحد الأقصي للتحميل بالمرة الواحده :</td>
								<td class="submain" width="505" colspan="2">
								<input type="text" name="sitemaxupload" value="{$site.site_delimg}" size="53"></td>
							</tr>
							<tr>
								<td class="main" width="272">
								تفعيـــــــل ختـــــــم الصــــــــــــور :</td>
								<td class="submain" width="233">
								<input type="radio" id="sitelogo" value="1" name="sitelogo" {if $site.site_logo  eq '1'}checked{/if}>
								<label for="sitelogo">نعم</label></td>
								<td class="submain" width="273">
								<input type="radio" id="sitelogo-no" value="0" name="sitelogo" {if $site.site_logo  eq '0'}checked{/if} >
								<label for="sitelogo-no" >لا</label>
								</td>
							</tr>
							<tr>
								<td class="main" width="272">
								عــــدد ثــــواني الانتظــــــــــــــــار :</td>
								<td class="submain" width="505" colspan="2">
								<input type="text" name="sitewaiting" value="{$site.site_second}" size="53"></td>
							</tr>
							<tr>
								<td class="main" colspan="3"><i><b>
								خيارات مصغرات الصور</b></i></td>
							</tr>
							<tr>
								<td class="main" width="272">
								عـــرض الصـــــــــــــور المصغــــرة :</td>
								<td class="submain" width="505" colspan="2">
								<input type="text" name="sitewidth" value="{$site.img_width}" size="53"></td>
							</tr>
							<tr>
								<td class="main" width="272">
								ارتفــــــــاع الصـــــــــــور المصغرة :</td>
								<td class="submain" width="505" colspan="2">
								<input type="text" name="sitehight" value="{$site.img_high}" size="53"></td>
							</tr>
							<tr>
								<td class="main" width="99%" colspan="3"><i><b>
								خيارات التحميل بالمركز</b></i></td>
							</tr>
							<tr>
								<td class="main" width="272">
								ســـــــابقة اسم الملفات والصـور :</td>
								<td class="submain" width="505" colspan="2">
								<input type="text" name="siteprname" value="{$site.site_previous}" size="53" dir="ltr"></td>
							</tr>
							<tr>
								<td class="main" width="272">
								الحجم الكلي لمجــــــــلد التحميل :</td>
								<td class="submain" width="505" colspan="2">
								<input type="text" name="sitetotalsize" value="{$site.site_totalsize}" size="53"></td>
							</tr>
							<tr>
								<td class="main" width="272">
								ايقـــــاف رفــــع الملفـــــــــــــــات :
								</td>
								<td class="submain" width="233">
								<input type="radio" id="siteupload" value="1" name="siteupload" {if $site.site_inactive  eq '1'}checked{/if} >
								<label for="siteupload">نعم</label>
								</td>
								<td class="submain" width="273">
								<input type="radio" id="siteupload-no" value="0" name="siteupload" {if $site.site_inactive  eq '0'}checked{/if}>
								<label for="siteupload-no">لا</label>
								</td>
							</tr>
							<tr>
								<td class="main" width="272">
								اغــــــــــــلاق المــــــــــــــــــركز :</td>
								<td class="submain" width="233">
								<input type="radio" id="siteclose" value="1" name="siteclose" {if $site.site_close  eq '1'}checked{/if}> 
								<label for="siteclose">نعم</label>
								</td>
								<td class="submain" width="273">
								<input type="radio" id="siteclose-no" value="0" name="siteclose" {if $site.site_close  eq '0'}checked{/if}>
								<label for="siteclose-no">لا</label>
								</td>
							</tr>
							<tr>
								<td class="main" width="272">
								رســــــــالة الاغــــــــــــــــــــــلاق :</td>
								<td class="submain" width="505" colspan="2">
								<textarea rows="4" cols="34" name="siteclosemsg" dir="rtl">{$site.site_closemessage}</textarea></td>
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