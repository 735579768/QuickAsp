<!--#include file="../lib/InIt.asp"-->
<%
	tpl.assign "adminDir","admin/"
	tpl.p_tpl_dir=TPL_PATH
	tpl.p_tpl_suffix=".html"
	tpl.display("login.html")
%>