window.onload = function(){
var actif = window.setInterval(function(){
	document.getElementById("url").innerHTML = '<h3>' + msg_input + '<br>' +timer + '</h3>';
	if(timer == 0){
	window.clearInterval(actif);
	document.getElementById("url").innerHTML = '<h3>' + this_url + '</h3>';
	return
		}
	timer--;
	},1000);
}
