<script type="text/javascript" src="js/trup.js"></script>
<script type="text/javascript" src="js/form.js"></script>
<script type="text/javascript" src="js/xp_progress.js"></script>
<script language = "javascript" type = "text/javascript">

    var max_tr_upload = {$site.site_maxinput};
</script>

		<br />

<table style="width: 55%" dir="rtl" align="center" cellspacing="0" cellpadding="0">
	<tr>
		<td>
		<table cellspacing="0" cellpadding="0">
			<tr>
				<td style="width: 237px; height: 64px;">
				<img src="{$stylepath}/images/tr-up_24.gif" width="248" height="74" alt=""></td>
				<td style="width: 396px; height: 64px" class="trstyle1">
				<img src="{$stylepath}/images/tr-up_23.gif" width="14" height="74" alt=""></td>
				<td style="height: 64px">
				<img src="{$stylepath}/images/tr-up_21.gif" width="164" height="74" alt=""></td>
			</tr>
		</table>
		</td>
	</tr>
	<tr>
		<td>
		<table style="width: 100%" cellspacing="0" cellpadding="0" dir="rtl">
			<tr>
				<td style="width: 18px" class="trstyle4">
				<img border="0" src="{$stylepath}/images/tr-up_28.gif" width="18" height="10"></td>
				<td style="width: 775px" class="trstyle5">
				<div id="form">
				{$lang.welcomemsg} {$site.site_name}
				
<form name = "tr_upload"   method = "post" enctype = "multipart/form-data" onsubmit="return check();"  action = "upload.php"  style = "margin: 0px; padding: 0px;">
    <input type = "hidden" name = "upload_range" value = "1">
    <div id = "tr_up">
		<input  type = "file" name = "upfile_0" onChange = "traidntslot(1)"    size="55"></div>

	{if $site.gd_upload eq '1'}
 
	<div id="captcha"><img src="captcha.php" border="0" alt="صورة التحقق">&nbsp;&nbsp; <input name="code" type="text" value=""></div>
	{/if}
	<div align="center" >
	<strong><a target="_blank" href="page.php?page=extension">{$lang.allowext}</a>: </strong>{allowext}
	</div>			


	<input type="submit" name="" value="تحميل " >			
	</form>			
	</div>
	
	<div id="waiting" style="display:none">
	من فضلك انتظر جاري تحميل الملف
	<br >
			<script language="javascript">
		var bar2=createBar(300,10,'#E8F2FF',1,'black','#C1DFFF',45,15,2);
	</script> 
	</div>			
				<br>
				</td>
				<td class="trstyle3">
				<img border="0" src="{$stylepath}/images/tr-up_26.gif" width="26" height="10" alt="" ></td>
			</tr>
		</table>
		</td>
	</tr>
	<tr>
		<td>
		<table style="width: 100%" cellspacing="0" cellpadding="0">
			<tr>
				<td style="width: 10px">
				<img src="{$stylepath}/images/tr-up_33.gif" width="21" height="50" alt=""></td>
				<td style="width: 761px" class="trstyle2">
				<img src="{$stylepath}/images/tr-up_31.gif" width="13" height="50" alt=""></td>
				<td>
				<img src="{$stylepath}/images/tr-up_30.gif" width="37" height="50" alt=""></td>
			</tr>
		</table>
		</td>
	</tr>
</table>
<br />
<br />
<br />
