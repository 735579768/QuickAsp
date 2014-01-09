<!--#include file="lib/AdminInIt.asp"-->
<%
id=G("id")

if G("act")="upd" then
	newdb.table("kl_module").where("id="&id).create()
	result=newdb.save()
	if result then
		alertMsgGo "更新成功","module.asp"
	else
		alertMsgGo "更新失败"
	end if
else
	arr=newdb.table("kl_module").where("id="&id).selarr()
	newtpl.assign "obj",arr(0)
	newtpl.display("module_edit")
end if



%>