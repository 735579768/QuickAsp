<!--#include file="lib/AdminInIt.asp"-->
<%
if G("act")="add" then
	newdb.table("kl_module").create()
	result=newdb.add()
	if result then
		alertMsgGo "添加成功","module.asp"
	else
		alertMsgGo "添加失败"
	end if
else
	newtpl.display("module_add")
end if
%>