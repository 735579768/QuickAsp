<!--#INCLUDE FILE="config.asp"-->
<!--#INCLUDE file="lang.asp"-->
<!--#INCLUDE file="common/safe.asp"-->
<!--#INCLUDE FILE="common/Functions.asp"-->
<!--#INCLUDE file="common/md5.asp"-->
<!--#INCLUDE FILE="AspTpl.class.asp"-->
<!--#INCLUDE file="AspTplPlug.class.asp"-->
<!--#INCLUDE file="class/Tpl.class.asp"-->
<!--#INCLUDE file="class/Accessdb.class.asp"-->
<!--#INCLUDE FILE="db.class.asp"-->
<!--#INCLUDE FILE="json.asp"-->
<%
'初始化模板引擎
set tpl=New ASPtpl
'设置模板目录
tpl.p_tpl_dir=TPL_PATH&"/"&themes
tpl.p_tpl_suffix=".tpl"
'初始化数据库db类
Set db = new Accessdb
%>