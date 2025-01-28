// 23-10-2007

var http = createRequestObject();
var mydiv;
//From: http://www.webpasties.com/xmlHttpRequest
function createRequestObject()
{

  var xmlhttp;
  try
    {
    // Firefox, Opera 8.0+, Safari
    xmlhttp=new XMLHttpRequest();
    }
  catch (e)
    {
    // Internet Explorer
    try
      {
      xmlhttp=new ActiveXObject("Microsoft.XMLHTTP");
      }
    catch (e)
      {
      try
        {
        xmlhttp=new ActiveXObject("Microsoft.XMLHTTP");
        }
      catch (e)
        {
        alert("Your browser does not support AJAX!");
        return false;
        }
      }
    }

    return xmlhttp;
}
function getInfo(url, mydiva, method_, send_){
	mydiv = mydiva;
	if(!method_)method_ = "GET";
	if(!send_)send_ = null;
    http.open(method_, url, true);
    http.onreadystatechange = handleInfo;
    //http.setRequestHeader('Content-Type', 'application/x-www-form-urlencoded');
    http.send(send_);//alert(send_);
}
function handleInfo(){
    if(http.readyState == 1){
        document.getElementById(mydiv).innerHTML = '<img src="images/indicator_tiny_red.gif" />  „‰ ›÷·ﬂ «‰ Ÿ—...';
    }
    if(http.readyState == 4){
        var response = http.responseText;
        document.getElementById(mydiv).innerHTML = response;
    }
}
