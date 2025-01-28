<html dir="rtl">

<head>
<meta http-equiv="Content-Type" content="text/html; charset=windows-1256">
<link href="{$stylepath}/admin.css" rel="stylesheet" type="text/css" media="all" />
<script type="text/javascript" src="js/collapse.js"></script>
<script type="text/javascript" src="js/mootools.js"></script>
<SCRIPT LANGUAGE="JavaScript" TYPE="text/javascript" SRC="js/ajax.js"></SCRIPT>
<link href="admin.css" rel="stylesheet" type="text/css" media="all" />
<title>لوحة الادارة - الصفحة الرئيسية</title>
</head>

<body topmargin="0" leftmargin="0" rightmargin="0" bottommargin="0" marginwidth="0" marginheight="0">
<table border="0" width="100%" cellpadding="0" height="65">
	<tr>
		<td colspan="2" background="{$stylepath}/images/head.gif" height="31">
		<p style="text-align: right"><a href="index.php">&nbsp; لوحة الادارة</span></a> -<a href="../index.php"> 
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
		<div align="center">
			<table border="0" width="89%" cellspacing="0" cellpadding="0">
				<tr>
					<td width="1%">
					<img border="0" src="{$stylepath}/images/admin_09.gif" width="33" height="31"></td>
					<td width="96%" background="{$stylepath}/images/admin_08.gif">
					<p align="center"><b>الترخيص</b></td>
					<td width="2%">
					<img border="0" src="{$stylepath}/images/admin_07.gif" width="22" height="31"></td>
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
					<img border="0" src="{$stylepath}/images/admin_09.gif" width="33" height="31"></td>
					<td width="96%" background="{$stylepath}/images/admin_08.gif">
					<p align="center"><b>ملاحظات المدير</b></td>
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
						<br>
						<div id="container">
					<form name="" id="registerForm"  action="ajaxpages/updatenote.php" method="post">
				
					<textarea rows="10" id="note" cols="67" name="note">{$notevalue}</textarea>
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
					<img border="0" src="{$stylepath}/images/admin_09.gif" width="33" height="31"></td>
					<td width="96%" background="{$stylepath}/images/admin_08.gif">
					<p align="center"><b>احصائيات المركز</b></td>
					<td width="2%">
					<img border="0" src="{$stylepath}/images/admin_07.gif" width="22" height="31"></td>
				</tr>
				<tr>
					<td colspan="3" style="border: 1px solid #62607C" bgcolor="#EDF1F3">
					
					<br>
					&nbsp;<table border="0" width="61%" cellpadding="0" cellspacing="1">
						<tr>
							<td rowspan="5" width="339">{$chart}</td>
							<td width="131" bgcolor="#CCD7DD">العــدد الكلي للملفــــات :</td>
							<td style="text-align: right" bgcolor="#D9E1E6">&nbsp; {$totalfiles}</td>
						</tr>
						<tr>
							<td width="131" bgcolor="#CCD7DD">عـــــدد الملفـــــــــــــات :</td>
							<td style="text-align: right" bgcolor="#D9E1E6">&nbsp;{$totalfile}</td>
						</tr>
						<tr>
							<td width="131" bgcolor="#CCD7DD">عــــــدد الصــــــــــــــــور :</td>
							<td style="text-align: right" bgcolor="#D9E1E6">&nbsp;{$totalimages}</td>
						</tr>
						<tr>
							<td width="131" bgcolor="#CCD7DD">عدد الملفات المبلغ عنها :</td>
							<td style="text-align: right" bgcolor="#D9E1E6">&nbsp;{$totalreport}</td>
						</tr>
						<tr>
							<td width="131" bgcolor="#CCD7DD">
							المساحة المستخدمة :</td>
							<td style="text-align: right" bgcolor="#D9E1E6">&nbsp; {$percentage}%
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