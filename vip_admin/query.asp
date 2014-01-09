<!--#include file="lib/AdminInIt.asp"-->
<%
if G("sql")<>"" then
on error resume next
err.clear
newdb.kl_conn.execute(G("sql"))
if err.number<>0 then
AlertMsg(err.description)
err.clear
end if
end if
newtpl.display("query.html")
%>