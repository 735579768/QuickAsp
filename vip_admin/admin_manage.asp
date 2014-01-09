<!--#include file="lib/AdminInIt.asp"-->
<%
'oldtpl.SetTemplatesDir("")
'oldtpl.setVariableFile "TOP_HTML","public/top.html"
'oldtpl.setVariableFile "FOOTER_HTML","public/footer.html"
if G("act")="delmem" then
id=G("id")
	if id="78" then
		AlertMsg(NODELADMIN)
	else	
		newdb.query("delete from kl_admin where id="&id)
	end if
end if

qxid=session("adminqxid")
sql="select a.qx_id as qxid, * from kl_admin as  a  inner join kl_admin_qx as b on a.qx_id=b.qx_id where a.qx_id>="&qxid
'keyvaluarr=array("uname:username","id:id","nicheng:nicheng","qx_name:qx_name","logintimes:logintimes","qx_id:b.qx_id")
'listBlock "adminlist",sql,keyvaluarr
'set rs=nothing
newtpl.assign "sql",sql
newtpl.display("admin_manage.html")
%>