<html dir="rtl">

<head>
<meta http-equiv="Content-Type" content="text/html; charset=windows-1256">
<link href="{$stylepath}/admin.css" rel="stylesheet" type="text/css" media="all" />
<script type="text/javascript" src="js/collapse.js"></script>
<script type="text/javascript" src="js/jquery.js"></script>
<script type="text/javascript" src="js/ajaxpic.js"></script>
<link href="admin.css" rel="stylesheet" type="text/css" media="all" />
<title>لوحة الادارة - عرض كافة الصور</title>
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
					<p align="center"><b>عرض كافة الصور</b><b>&nbsp;
					</b></td>
					<td width="2%">
					<img border="0" src="{$stylepath}/images/admin_07.gif" width="22" height="31"></td>
				</tr>
				<tr>
					<td colspan="3" style="border: 1px solid #62607C" bgcolor="#EDF1F3">
						<div align="center"> <img src="images/spinner.gif" id="loading" style="display:none;" /></div>
						<table border="0" width="74%" cellpadding="0" cellspacing="4">
							<tr>
							{foreach name="piclast" from=$piclastv item="pic"}

								<td class="{$pic.file_id}" bgcolor="#D9E1E6">
								<a target="_blank" href="{$pic.file_url}">
								<img border="0" src="../uploads/thumbs/{$pic.file_name}" width="150" height="93" alt=""></a>
								<div>IP : {$pic.ipaddress}</div>
								 
								<div>
								<a href="javascript: ajaxDelete({$pic.file_id});">
			<img border="0" src="./images/delete.gif" alt="اضغط هنا للحذف" width="18" height="18"></a>
								</div>
								</td>
								
															
						     {if not $smarty.foreach.last and $smarty.foreach.piclast.iteration is div by 5}
						     
			   		  </tr>
			   		  
			   		  <tr>
			   			  {/if}				
							
							 {/foreach} 
								
								</tr>
							
						</table>
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