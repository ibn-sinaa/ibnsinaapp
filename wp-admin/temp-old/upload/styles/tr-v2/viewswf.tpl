

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
				<img border="0" src="{$stylepath}/images/tr-up_28.gif" width="18" 

height="10"></td>
				<td style="width: 775px" class="trstyle5">
				<div id="viewpic" >
				
				<br>
				
				<object id="obj1" border="0" codebase="http://download.macromedia.com/pub/shockwave/cabs/flash/swflash.cab#version=6,0,40,0" classid="clsid:D27CDB6E-AE6D-11CF-96B8-444553540000" style="height: 211px; width: 283px">
					<param name="movie" value="{$files.file_url}">
					<param name="quality" value="High">
					<embed src="{$files.file_url}" pluginspage="http://www.macromedia.com/go/getflashplayer" type="application/x-shockwave-flash" name="obj1" width="369" height="377"></object>
				
				<br>
				
				<a target="_blank" href="{$files.file_url}">فتح الملف بصفحة جديدة</a><br>
				<fieldset style="width: 472px">
				<legend>معلومات الملف </legend>
				
				<table style="width: 90%">
					<tr>
						<td class="up2" style="width: 161px"><strong>اسم الملف : 
						</strong> </td>
						<td class="up3"> {$files.file_name}</td>
					</tr>
					<tr>
						<td class="up2" style="width: 161px"><strong>تاريخ التحميل :</strong></td>
						<td class="up3">{$files.file_date}</td>
					</tr>
					<tr>
						<td class="up2" style="width: 161px"><strong>عدد الزيارات : 
						</strong> </td>
						<td class="up3">{$files.file_count}</td>
					</tr>
					<tr>
						<td class="up2" style="width: 161px"><strong>حجم الملف : 
						</strong> </td>
						<td class="up3">{$files.file_size} كيلو بايت</td>
					</tr>
				</table>
				<br>
				</fieldset> 
				<br>
				<br>
				
				<fieldset style="width: 470px">
				<legend>ارسال الملف </legend>
				<form name="" action="friend.php" method="post">
				<table style="width: 90%">
					<tr>
						<td class="up2" style="width: 161px"><strong>بريد صديقك 
						: </strong></td>
						<td class="up3">
						<input type="" name="email" value="" style="width: 190px" ></td>
					</tr>
					{if $site.gd_friend eq '1'}
					<tr>
						<td class="up2" style="width: 161px"><strong>كود التحقق 
						:&nbsp;</strong></td>
						<td class="up3">
						
						<div id="captcha"><img src="captcha.php" border="0" alt="صورة التحقق">&nbsp;&nbsp; <input name="code" type="text" value=""></div>
						
						</td>
					</tr>
					{/if}
					<tr>
						<td class="up2" style="width: 161px">&nbsp;</td>
						<td class="up3">
						<input name="fileid" type="hidden" value="{$files.file_id}">

						<input type="submit" value="ارسال الملف">
						
						&nbsp;</td>
					</tr>
				</table>
				</form>
				<br>
				</fieldset> <br>
				<br>
				<fieldset style="width: 467px">
				<legend>الابلاغ عن ملف</legend>
				<form name="" action="report.php" method="post">
				<table style="width: 90%">
					<tr>
						<td class="up2" style="width: 160px"><span lang="ar-eg">
						<strong>سبب التبليغ : </strong></span></td>
						<td class="up3"> 
						<textarea name="trtext" style="height: 61px; width: 225px"></textarea></td>
					</tr>
					{if $site.gd_report eq '1'}
					<tr>
						<td class="up2" style="width: 160px"><strong>كود التحقق 
						:</strong></td>
						<td class="up3">
						
						
						<div id="captcha"><img src="captcha.php" border="0" alt="صورة التحقق">&nbsp;&nbsp; <input name="code" type="text" value=""></div>
						

						</td>
					</tr>
					{/if}
					<tr>
						<td class="up2" style="width: 160px">&nbsp;</td>
						<td class="up3">
						<input name="fileid" type="hidden" value="{$files.file_id}">
						<input type="submit" name="" value="التبليغ عن الملف">&nbsp;</td>
					</tr>
				</table>
				</form>
				<br>
				</fieldset>
				<br>
				</div>
				
				&nbsp;</td>
				<td class="trstyle3">
				<img border="0" src="{$stylepath}/images/tr-up_26.gif" width="26" height="10" 

alt="" ></td>
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
