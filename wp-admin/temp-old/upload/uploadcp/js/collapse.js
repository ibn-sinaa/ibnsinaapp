function tradmin(id,image) {
var did =  document.getElementById(id);
var imageid = document.getElementById(image);
if(did.style.display=="none") {
   did.style.display="block";
	imageid.src='adminstyle/images/collapse_off.gif';
 }
else {
   did.style.display="none";
   imageid.src='adminstyle/images/collapse_on.gif';
   }
 }

