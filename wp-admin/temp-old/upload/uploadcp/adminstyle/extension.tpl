<html dir="rtl">

<head>
<meta http-equiv="Content-Type" content="text/html; charset=windows-1256">
<link href="{$stylepath}/admin.css" rel="stylesheet" type="text/css" media="all" />
<script type="text/javascript" src="js/collapse.js"></script>
<script type="text/javascript" src="js/ext.js"></script>
<script type="text/javascript" src="js/valid.js"></script>
<link href="admin.css" rel="stylesheet" type="text/css" media="all" />
<title>لوحة الادارة -التحكم بالامتدادت
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
		<input type="button" value="اضافه امتداد جديد" onclick="hideDiv();return false">
		<br>
		<div id="add" style="display:none">
		<form name="traidnt-ext" action="files.php?do=extension&go=add" method="post">
		<table border="0" width="42%" cellpadding="0">
			<tr>
				<td colspan="2" class="main"><b>اضافة امتداد 
				جديد</b></td>
			</tr>
			<tr>
				<td width="38%" class="main">
				الامتـــــــــــــــــداد :</td>
				<td class="submain" width="60%">
				<input name="exname" type="text" value="" size="28" dir="ltr">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </td>
			</tr>
			<tr>
				<td width="38%" class="main">الحد الأقصي 
				للرفع :</td>
				<td class="submain" width="60%">
				<input name="maxsize" type="text" value="" size="29" dir="ltr">&nbsp; 
				كيلو بايت</td>
			</tr>
			<tr>
				<td width="98%" colspan="2" class="submain">&nbsp;<input type="submit" value="اضافه الامتداد"></td>
			</tr>
		</table>
		</form>
		       <script language="JavaScript" type="text/javascript">
  var frmvalidator  = new Validator("traidnt-ext");
  frmvalidator.addValidation("exname","req","من فضلك ادخل امتداد الملف");
 frmvalidator.addValidation("maxsize","req","من فضلك ادخل اقصي حجم للملف");
  frmvalidator.addValidation("maxsize","numeric","عفوا اقصي حجم للملف ارقام فقط");


</script>
		</div>
		<br>
		
		<div align="center">
			<table border="0" width="83%" cellspacing="0" cellpadding="0">
				<tr>
					<td width="1%">
					<img border="0" src="{$stylepath}/images/admin_09.gif" width="33" height="31"></td>
					<td width="87%" background="{$stylepath}/images/admin_08.gif">
					<p align="center"><b>التحكم بالامتدادت</b></td>
					<td width="2%">
					<img border="0" src="{$stylepath}/images/admin_07.gif" width="22" height="31"></td>
				</tr>
				<tr>
					<td colspan="3" style="border: 1px solid #62607C" bgcolor="#EDF1F3">
					

						<br />
						<table border="0" width="739" cellpadding="0">
							<tr>
								<td class="main" width="272">
								الامتداد</td>
								<td class="main" width="230">
								اقصي حجم للرفع</td>
								<td class="main" width="229">
								
								حذف</td>
							</tr>
							{foreach name="ext" from=$extension item="ext"}
							<tr onMouseOver="this.bgColor='#E7E6EE';" onMouseOut="this.bgColor='#E1E9EC';" bgcolor="#E1E9EC">
								<td  width="272" >
								&nbsp;<b>{$ext.ex_name}</b></td>
								<td  width="230" >
								&nbsp; [ {$ext.ex_maxsize} ]&nbsp;&nbsp; كيلو بايت</td>
								<td  width="229" >
								<a href="files.php?do=extension&go=del&id={$ext.ex_id}" onclick="return del('هل انت متأكد من حذف الامتداد {$ext.ex_name}');" >حذف</a></td>
							</tr>
							{/foreach}
							</table>
					&nbsp;</td>
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