<!--#include file="lib/AdminInIt.asp"-->
<%
set rs=olddb.query("select count(*) as arccount from kl_archives")
newtpl.assign "arccount",rs("arccount")&""'有效文章

set rs=olddb.query("select count(*) as arcyescount from kl_archives where recycling=0")
newtpl.assign "arcyescount",rs("arcyescount")&""'有效文章

set rs=olddb.query("select count(*) as arcnocount from kl_archives where recycling=1")
newtpl.assign "arcnocount",rs("arcnocount")&""'回收站文章
set rs=nothing


'sql="select top 5 * from kl_archives order by uddate desc,id desc"
'arr=array("arctitle:arctitle","uddate:uddate")
'loopblock "arclist",sql

'sql="select top 5 * from kl_admin_log order by logintime desc,id desc"
'loopblock "adminlog",sql
'oldtpl.Parse
'Destroy our objects
newtpl.display("main")
%>