<html dir="rtl">

<head>
<meta http-equiv="Content-Type" content="text/html; charset=windows-1256">
<link href="{$stylepath}/admin.css" rel="stylesheet" type="text/css" media="all" />
<script type="text/javascript" src="js/collapse.js"></script>
<link href="admin.css" rel="stylesheet" type="text/css" media="all" />
<title>لوحة الادارة - خيارات حذف الملفات</title>
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
					<p align="center"><b>خيارات حذف الملفات&nbsp; </b></td>
					<td width="2%">
					<img border="0" src="{$stylepath}/images/admin_07.gif" width="22" height="31"></td>
				</tr>
				<tr>
					<td colspan="3" style="border: 1px solid #62607C" bgcolor="#EDF1F3">
						
						</div>
						<br />
						<form name="" action="files.php?do=delete&go=del" method="post">
						حذف الملفات ا<span lang="ar-eg">لمرفوعة</span> منذ<span lang="ar-eg"> 
						أكثر من </span><br>
						<input type="text" value="" name="days">				
						
					&nbsp; يوم
					
					<br>
					<input type="submit" value="حذف">
					</form>
					</td>
				</tr>
			</table>
		</div>		
	

		<p>
		<br />	
		</td>
	</tr>
</table>


<p>&nbsp;</p>


</body>

</html>