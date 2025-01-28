function clearStatusMsg($obj) {
	if($('div#statusMsg').html() != "") {
		$('div#statusMsg').html('');
	}
}

function ajaxDelete(id) {
	$('img#loading').show();
	$.ajax({
		type: "POST",
		url: "ajaxpages/delpic.php",
		data: "action=images&id=" + id,
		success: function(msg) {
			if(msg.indexOf("failed") == -1) {
				$('td.' + id).remove();
				$('div#statusMsg').html(msg);
				$('img#loading').hide();
				t = setTimeout("clearStatusMsg()", 5000);
			} else {
				$('div#statusMsg').html(msg);
				$('img#loading').hide();
				t = setTimeout("clearStatusMsg()", 5000);
			}
		}
	});
}



function fileDelete(id) {
	$('img#loading').show();
	$.ajax({
		type: "POST",
		url: "ajaxpages/delpic.php",
		data: "action=files&id=" + id,
		success: function(msg) {
			if(msg.indexOf("failed") == -1) {
				$('td.' + id).remove();
				$('div#statusMsg').html(msg);
				$('img#loading').hide();
				t = setTimeout("clearStatusMsg()", 5000);
			} else {
				$('div#statusMsg').html(msg);
				$('img#loading').hide();
				t = setTimeout("clearStatusMsg()", 5000);
			}
		}
	});
}