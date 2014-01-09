<!--#include file="lib/AdminInIt.asp"-->
<%
newtpl.assign "exit_url","?act=exit"
uname=Request.Cookies("U_name")&""
newtpl.assign "uname",uname

set rs=newdb.query("select top 2 logintime from kl_admin_log where uname='"&uname&"'")
if rs.recordcount=2 then
rs.movenext
newtpl.assign "lastdate",cstr(rs(0))
else
newtpl.assign "lastdate","null"
end if
newtpl.display("index")
%>