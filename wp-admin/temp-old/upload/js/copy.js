function highlight(elemnt,message) {
document.getElementById(elemnt).select();
document.getElementById(elemnt).focus();
if (document.all) {
textRange = document.getElementById(elemnt).createTextRange();
textRange.execCommand('RemoveFormat');
textRange.execCommand('Copy');
alert(message);
}
}