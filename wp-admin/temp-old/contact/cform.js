function check_values() {
	var valid = '';
	
	var name = document.getElementById("name").value;
	var email = document.getElementById("email").value;
	var subject = document.getElementById("subject").value;
	var body = document.getElementById("body").value;
	if(trim(name) == "" ||
		trim(email) == "" ||
		trim(subject) == "" ||
		trim(body) == "") {
			alert("ãä ÝÖáß Þã ÈÅÓÊßãÇá ÇáÈíÇäÇÊ ÃæáÇð");
	} else {
		if(!isEmail(email)){
			alert("ÇáÈÑíÏ ÇáÅáßÊÑæäí ÛíÑ ÕÍíÍ");
			document.getElementById("email").focus();
			document.getElementById("email").select();
	}
}

function isUndefined(a) {
   return typeof a == 'undefined';
}

function trim(a) {
	return a.replace(/^s*(S*(s+S+)*)s*$/, "$1");
}

function isEmail(a) {
   return (a.indexOf(".") > 0) && (a.indexOf("@") > 0);
}
