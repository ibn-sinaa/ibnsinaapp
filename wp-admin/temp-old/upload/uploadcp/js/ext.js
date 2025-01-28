function del(confirmation_message)
{
	var ht = document.getElementsByTagName("html")[0];
	ht.style.filter = "progid:DXImageTransform.Microsoft.BasicImage(grayscale=1)";
	if (confirm(confirmation_message))
	{
		return true;
	}
	else
	{
		ht.style.filter = "";
		return false;
	}
}


function hideDiv() {
if(document.getElementById("add").style.display=="none") {
   document.getElementById("add").style.display="block";

 }
else {
   document.getElementById("add").style.display="none";
   }
 }


