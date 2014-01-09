<!--#include file="../lib/InIt.asp"-->
<%
msg=G("msg")
uri=G("uri")
tpl.assign "adminDir","admin/"
tpl.p_tpl_dir=TPL_PATH
tpl.p_tpl_suffix=".html"
tpl.assign "message",msg
tpl.assign "uri",uri
tpl.display("message.html")
%>