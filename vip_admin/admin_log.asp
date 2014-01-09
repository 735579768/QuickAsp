<!--#include file="lib/AdminInIt.asp"-->
<%
if G("act")="delall" then 
olddb.query("delete from kl_admin_log")
end if
id=G("id")
if id<>"" then
	result=olddb.deleteRecord("kl_admin_log","id",id)
end if
sql="select * from kl_admin_log as  a  inner join kl_admin_qx as b on a.qx_id=b.qx_id order by id desc"
newtpl.assign "sql",sql
newtpl.display("admin_log.html")
%>