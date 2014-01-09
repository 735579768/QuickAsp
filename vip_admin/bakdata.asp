<!--#include file="lib/AdminInIt.asp"-->
<% if session("APP")<>"true" then reurl("/") end if %>
<%
act=G("act")
on error goto 0
bakmsg=""
if act="bakdata" then
	set fs=server.CreateObject("scripting.FileSystemObject")
	path1=server.MapPath(sql_data)
	curtime=replace(now(),"/","-")'Formatdate(now,0)
	curtime=replace(curtime,":","-")
	path2=server.MapPath("#data/#bak/"&curtime&".mdb")

	'set rs=olddb.GetRecord("kl_admin","*","id="&session("admin_id"),"",0)
	set rs=newdb.query("select * from kl_admin where id="&session("admin_id"))
	adminname=rs("nicheng")
	set rs =newdb.query("select * from kl_databak")
	rs.addnew
	rs("bakname")=curtime&".mdb"
	rs("bakadminname")=adminname
	rs("bakdate")=curtime
	rs("bakdescr")=G("bakdescr")
	rs.update
	set rs=nothing
	set newdb=nothing
	fs.copyFile path1,path2,true
	set fs=nothing
'	bakmsg="备份成功，路径为：<span style='color:'>#data/#bak/"&curtime&".mdb"
	alertmsggo G("dbname")&"备份成功","bakdata.asp"
end if
if act ="deldb" then 
	set fs=server.CreateObject("scripting.FileSystemObject")
	path2=server.MapPath("#data/#bak/")&"\"
	on error resume next
	fs.DeleteFile(path2&G("dbname"))
	set fs=nothing
	newdb.query("delete from kl_databak  where id="&G("id"))
	alertmsggo "删除成功","bakdata.asp"
end if
if act ="hydb" then 
	set rs=newdb.query("select * from kl_databak")
	echo rs.recordcount 
	if rs.recordcount>0 then
		redim arr(rs.recordcount)
		for i=0 to ubound(arr)-1
		set keyval = server.CreateObject("Scripting.Dictionary")
		keyval("bakname")=rs("bakname")&""
		keyval("bakadminname")=rs("bakadminname")&""
		keyval("bakdescr")=rs("bakdescr")&""
		keyval("bakdate")=rs("bakdate")&""
		set arr(i)=keyval
		set keyval=nothing
		rs.movenext
		next
	end if
	set rs=nothing	

	set fs=server.CreateObject("scripting.FileSystemObject")
	path1=server.MapPath(sql_data)
	path2=server.MapPath("#data/#bak/")
	path2=path2&"\"&G("dbname")
	'echo path2
	
	fs.copyFile path2,path1,true
	'Set newdb = new Accessdb
	set rss=newdb.query("delete * from kl_databak")
	set rss=newdb.query("select * from kl_databak")
	for i=0 to ubound(arr)-1
		set temobj=arr(i)
		rss.addnew
		rss("bakname")=temobj("bakname")&""
		rss("bakadminname")=temobj("bakadminname")&""
		rss("bakdescr")=temobj("bakdescr")&""
		rss("bakdate")=temobj("bakdate")&""
		rss.update
	next
	set rss=nothing
	set fs=nothing
	alertmsggo G("dbname")&"还原成功","bakdata.asp"
end if
newtpl.assign "bakmsg",bakmsg
newtpl.assign "dbpath",Sql_Data
set rs=newdb.table("kl_databak").order("id desc").sel()
rsarr=newdb.rsToArr(rs)
newtpl.assign "baklist",rsarr
newtpl.display("bakdata.html")
%>