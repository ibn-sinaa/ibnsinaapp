<html dir="rtl">

<head>
<meta http-equiv="Content-Type" content="text/html; charset=windows-1256">
<link href="{$stylepath}/admin.css" rel="stylesheet" type="text/css" media="all" />
<script type="text/javascript" src="js/collapse.js"></script>
<link href="admin.css" rel="stylesheet" type="text/css" media="all" />
<title>لوحة الادارة -البحث عن الملفات
</title>
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
		<br />&nbsp;
		<br>
		<div id="add" >
		<form name="traidnt-ext" action="files.php" method="get">
		<input type="hidden" value="find" name="do">
		<input type="hidden" value="result" name="go">
		<table border="0" width="42%" cellpadding="0">
			<tr>
				<td colspan="2" class="main"><b>البحث عن الملفات</b></td>
			</tr>
			<tr>
				<td width="38%" class="main">
				اسم الملف :</td>
				<td class="submain" width="60%">
				<input name="filename" type="text" value="" size="28" dir="ltr">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </td>
			</tr>
			<tr>
				<td width="38%" class="main">حجم الملف :</td>
				<td class="submain" width="60%">
				<input name="maxsize" type="text" value="" size="29" dir="ltr">&nbsp; 
				كيلو بايت</td>
			</tr>
			<tr>
				<td width="38%" class="main">امتداد الملف :</td>
				<td class="submain" width="60%">
				<input name="fileext" type="text" value="" size="28" dir="ltr">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </td>
			</tr>
			<tr>
				<td width="38%" class="main">اي بي الزائر :</td>
				<td class="submain" width="60%">
				<input name="fileip" type="text" value="" size="28" dir="ltr">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </td>
			</tr>
			<tr>
				<td width="98%" colspan="2" class="submain">&nbsp;<input type="submit" value="البحث"></td>
			</tr>
		</table>
		</form>
	
		</div>
	

		<p>
		<br />	
		</td>
	</tr>
</table>


</body>

</html>