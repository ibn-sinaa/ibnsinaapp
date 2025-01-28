<html dir="rtl">

<head>
<meta http-equiv="Content-Type" content="text/html; charset=windows-1256">
<link href="{$stylepath}/admin.css" rel="stylesheet" type="text/css" media="all" />
<script type="text/javascript" src="js/collapse.js"></script>
<script type="text/javascript" src="js/ext.js"></script>
<link href="admin.css" rel="stylesheet" type="text/css" media="all" />
<title>لوحة الادارة -نتائج البحث
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
		<br>
		
		<div align="center">
			<table border="0" width="83%" cellspacing="0" cellpadding="0">
				<tr>
					<td width="1%">
					<img border="0" src="{$stylepath}/images/admin_09.gif" width="33" height="31"></td>
					<td width="87%" background="{$stylepath}/images/admin_08.gif">
					<p align="center"><b>نتائج البحث</b></td>
					<td width="2%">
					<img border="0" src="{$stylepath}/images/admin_07.gif" width="22" height="31"></td>
				</tr>
				<tr>
					<td colspan="3" style="border: 1px solid #62607C" bgcolor="#EDF1F3">
					

						<br />
						<table border="0" width="820" cellpadding="0">
							<tr>
								<td class="main" width="272">
								اسم الملف</td>
								<td class="main" width="230">
								امتداد الملف</td>
								<td class="main" width="230">
								التاريخ</td>
								<td class="main" width="230">
								اي بي الزائر</td>
								<td class="main" width="230">
								حجم الملف</td>
								<td class="main" width="116">
								
								حذف</td>
							</tr>
							{foreach name="file" from=$result item="file"}
							<tr onMouseOver="this.bgColor='#E7E6EE';" onMouseOut="this.bgColor='#E1E9EC';" bgcolor="#E1E9EC">
								<td  width="272" >
								<a target="_blank" href="../uploads/{$file.group}/{$file.file_name}">&nbsp;<b>{$file.file_name}</b></a></td>
								<td  width="230" >
								&nbsp;{$file.file_tybe}</td>
								<td  width="230" >
								&nbsp;{chdate time= $file.file_date}</td>
								<td  width="230" >
								&nbsp;{$file.ipaddress}</td>
								<td  width="230" >
								&nbsp; [ {$file.file_size} ]&nbsp;&nbsp; كيلو بايت</td>
								<td  width="116" >
								<a href="files.php?do=find&go=del&id={$file.file_id}&type={$file.group}&name={$file.file_name}" onclick="return del('هل انت متأكد من حذف الملف');">حذف</a></td>
							</tr>
							{/foreach}
							
							</table>
					&nbsp;
					
					</td>
				</tr>
			</table>
		</div>		
	{totalpages}

		<p>
		<br />	
		</td>
	</tr>
</table>


</body>

</html>