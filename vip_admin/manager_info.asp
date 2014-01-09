<!--#include file="lib/AdminInIt.asp"-->
<%
'oldtpl.SetTemplatesDir("")
'包含文件
'Generate the page

'输出内容
'echo olddb.wGetRecord("kl_content_types","type_id,type_name,type_index,type_list,type_article","type_id="&type_id,"type_id desc",0)
'set rs=olddb.GetRecord("kl_content_types","type_id,type_name,tpl_index,tpl_list,tpl_article","type_id="&type_id,"type_id desc",0)
	if G("act")="updateadmin" then
		id=G("id")
		dim pwd:pwd=G("newpwd")
		'echo olddb.wUpdateRecord("kl_admin","id="&id,array("password:"&md5(pwd,32)))
		result=olddb.UpdateRecord("kl_admin","id="&id,array("password:"&md5(pwd,32)))
		if result<>0 then
			AlertMsg(UPDATE_SUCCESS_STR)
		end if
	end if


set rs=olddb.GetRecord("kl_admin","*","id="&session("admin_id"),"",0)
oldtpl.setvariable "id",cstr(rs("id"))
oldtpl.setvariable "Uname",cstr(rs("username"))
oldtpl.setvariable "Upwd",cstr(rs("password"))

oldtpl.Parse
'Destroy our objects
set oldtpl = nothing
%>