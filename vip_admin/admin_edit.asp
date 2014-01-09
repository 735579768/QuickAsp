<!--#include file="lib/AdminInIt.asp"-->
<%
'oldtpl.SetTemplatesDir("")
'包含文件
'Generate the page

'输出内容
'echo olddb.wGetRecord("kl_content_types","type_id,type_name,type_index,type_list,type_article","type_id="&type_id,"type_id desc",0)
'set rs=olddb.GetRecord("kl_content_types","type_id,type_name,tpl_index,tpl_list,tpl_article","type_id="&type_id,"type_id desc",0)
id=G("id")
	if G("act")="uptadmin" then		
		pwd=G("newpwd")
		qx_id=G("qx_id")
		nicheng=G("nicheng")
		'echo olddb.wUpdateRecord("kl_admin","id="&id,array("password:"&md5(pwd,32)))
		result=olddb.UpdateRecord("kl_admin","id="&id,array("password:"&md5(pwd,32),"qx_id:"&qx_id,"nicheng:"&nicheng))
		if result<>0 then
			AlertMsg(UPDATE_SUCCESS_STR)
		else
			AlertMsg(UPDATE_FAIL_STR)
			die("")
		end if
	end if

set rs=olddb.query("select top 1 * from kl_admin where id="&id)
'初始化数据
setvararr(array("username:"&rs("username"),"nicheng:"&rs("nicheng"),"id:"&id))
oldtpl.setvariable "qx_idsel",getQxsel()
oldtpl.Parse
'Destroy our objects
set oldtpl = nothing
%>