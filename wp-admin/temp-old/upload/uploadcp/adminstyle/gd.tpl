<html dir="rtl">

<head>
<meta http-equiv="Content-Type" content="text/html; charset=windows-1256">
<link href="{$stylepath}/admin.css" rel="stylesheet" type="text/css" media="all" />
<script type="text/javascript" src="js/collapse.js"></script>
<script type="text/javascript" src="js/mootools.js"></script>
<SCRIPT LANGUAGE="JavaScript" TYPE="text/javascript" SRC="js/ajax.js"></SCRIPT>
<link href="admin.css" rel="stylesheet" type="text/css" media="all" />
<title>لوحة الادارة - خيارات صورة التحقق</title>
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
					<p align="center"><span lang="ar-eg"><b>خيارات صورة التحقق</b></span></td>
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
						<form name="" id="registerForm"  action="ajaxpages/updategd.php" method="post">
						<table border="0" width="786" cellpadding="0">
							<tr>
								<td class="main" width="272">
								استخـــــدام التحقق عند رفع الملفــــــــات :</td>
								<td class="submain" width="233">
								<input type="radio" id="gduploadyes" value="1" name="gdupload" {if $gd.gd_upload  eq '1'}checked{/if} ><label for="gduploadyes">نعم</label></td>
								<td class="submain" width="273">
								<input type="radio" id="gduploadno" value="0" name="gdupload" {if $gd.gd_upload  eq '0'}checked{/if} ><label for="gduploadno"> لا</label></td>
							</tr>
							<tr>
								<td class="main" width="272">
								استخـــــدام التحقق عند الاتصال بالمـــــدير :</td>
								<td class="submain" width="233">
								<input type="radio" id="gdcontactyes" value="1" name="gdcontact" {if $gd.gd_admin  eq '1'}checked{/if} ><label for="gdcontactyes">نعم</label></td>
								<td class="submain" width="273">
								<input type="radio" id="gdcontactno" value="0" name="gdcontact" {if $gd.gd_admin  eq '0'}checked{/if} ><label for="gdcontactno"> لا</label></td>
							</tr>
							<tr>
								<td class="main" width="272">
								استخدام التحقق عند ارسال الصورة لصديق :</td>
								<td class="submain" width="233">
								<input type="radio" id="siteupload" value="1" name="gdfriend" {if $gd.gd_friend  eq '1'}checked{/if} >
								<label for="siteupload">نعم</label>
								</td>
								<td class="submain" width="273">
								<input type="radio" id="siteupload-no" value="0" name="gdfriend" {if $gd.gd_friend  eq '0'}checked{/if}>&nbsp;
								<label for="siteupload-no">لا</label>
								</td>
							</tr>
							<tr>
								<td class="main" width="272">
								استخــــدام التحقق عند الابــــلاغ عن
								<span lang="ar-eg">ملف</span> :</td>
								<td class="submain" width="233">
								<input type="radio" id="siteclose" value="1" name="gdreport" {if $gd.gd_report  eq '1'}checked{/if}> 
								<label for="siteclose">نعم</label>
								</td>
								<td class="submain" width="273">
								<input type="radio" id="siteclose-no" value="0" name="gdreport" {if $gd.gd_report  eq '0'}checked{/if}>&nbsp;
								<label for="siteclose-no">لا</label>
								</td>
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