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
$(function(){
	//提交表单验证
	$('.nonull').bind('focus', function () {
		$(this).css({
			border : 'solid 1px #ccc',
			color : '#000'
		});
		if ($(this).val() == '请输入内容')
			$(this).val('')
	});

	$('.submitbtn').bind('click',function(){
		//console.log($(this).parents('form'));
		var a=true;
		if(typeof(checkform)=='function'){
			a=checkform();
		}else{
				$('.nonull').each(function (index, element) {
					if ($(this).val() == '' || $(this).val() == '请输入内容') {
						$(this).val('请输入内容')
						$(this).css({
							color : '#ccc',
							border : 'solid 1px #f00'
						});
						a = false;
					}
				});
			}
		if(a)$(this).parents('form').submit();
		});
});
