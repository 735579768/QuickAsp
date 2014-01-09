<!--#include file="lib/AdminInIt.asp"-->
<%
id=G("id")
if G("act")="updsingle" then
	
	pagecontent=G("pagecontent")
	set uprs=server.createobject("adodb.recordset")
	uprs.open "select * from kl_single where id="&id,olddb.idbconn,0,2
	uprs("pagecontent")=pagecontent
	uprs.update
	uprs.close
	set uprs=nothing
end if
sql="select * from kl_single where id="&id
setTplVarBySql sql
%>