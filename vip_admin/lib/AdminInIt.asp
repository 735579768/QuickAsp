<!--#INCLUDE FILE="../../lib/init.asp"-->
<!--#INCLUDE FILE="../../lib/page.class.asp"-->
<%
'关闭后台调试
app_debug=false
'初始化模板引擎
'set oldtpl=nothing
set oldtpl=New ASPTemplate
'设置模板目录
'oldtpl.SetTemplatesDir(TPL_PATH)
'设置模板目录
'oldtpl.SetTemplatesDir(TPL_PATH&"/"&themes)

set fs=Server.CreateObject("Scripting.FileSystemObject") 
if fs.FileExists(server.MapPath(oldtpl.p_templates_dir & getRunFileName()&".html")) then
	oldtpl.SetTemplateFile getRunFileName()&".html" '设置模板文件
end if
set fs=nothing

'初始化数据库db类
Set olddb= new AspDb 
olddb.dbConn=Oc(CreatConn("ACCESS",Sql_Data,"","","")) 

'=======================初始化新模板类和数据库
set newtpl=New ASPtpl
'设置模板目录
'oldtpl.SetTemplatesDir(TPL_PATH)
'初始化数据库db类
Set newdb = new Accessdb
%>
<!--#INCLUDE FILE="common.asp"-->
<!--#INCLUDE FILE="loginsafe.asp"-->