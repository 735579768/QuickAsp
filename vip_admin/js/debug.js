// JavaScript Document
///////////////////////////////////////////////////////////////////////js写cookies//////////////////////////////////////////////////

function writeCookie(name, value, hours)  

{  

  var expire = "";  

  if(hours != null)  

  {  

    expire = new Date((new Date()).getTime() + hours * 3600000);  

    expire = "; expires=" + expire.toGMTString();  

  }  

  document.cookie = name + "=" + escape(value) + expire;  

}  

///////////////////////////////////////////////////////////////用cookies名字读它的值////////////////////////////

function readCookie(name)  

{  

  var cookieValue = "";  

  var search = name + "=";  

  if(document.cookie.length > 0)  

  {   

    offset = document.cookie.indexOf(search);  

    if (offset != -1)  

    {   

      offset += search.length;  

      end = document.cookie.indexOf(";", offset);  

      if (end == -1) end = document.cookie.length;  

      cookieValue = unescape(document.cookie.substring(offset, end))  

    }  

  }  

  return cookieValue;  

}
window.onload=function(){
	document.getElementById('debugclose').onclick=function(){
		writeCookie('debugshow','0')
		this.parentNode.style.display='none';
		};
	document.getElementById('debugshow').onclick=function(){
		writeCookie('debugshow','1')
		document.getElementById('debug').style.display='block';
		};
	var debugs=readCookie('debugshow');
	if(debugs==1)document.getElementById('debugshow').click();
	
	
	
	document.getElementById('debugsqlclose').onclick=function(){
		writeCookie('debugsqlshow','0')
		this.parentNode.style.display='none';
		};
	document.getElementById('debugsqlshow').onclick=function(){
		writeCookie('debugsqlshow','1')
		document.getElementById('debugsql').style.display='block';
		};
	var debugs=readCookie('debugsqlshow');
	if(debugs==1)document.getElementById('debugsqlshow').click();

	}
