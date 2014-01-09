<!--#include file="lib/AdminInIt.asp"-->
<%
if G("act")="del" then
result=newdb.table("kl_module").where("id="&G("id")).delete()
	if result then
		alertMsgGo "删除成功","module.asp"
	else
		alertMsg "删除失败"
	end if
end if
newtpl.display("module")
%>