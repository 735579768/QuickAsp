<!--#include file="lib/AdminInIt.asp"-->
<% if session("APP")<>"true" then reurl("/") end if %>
<%
'添加文章
	if G("isaddarticle")="true" then
'		'bakon error resume next
		err.clear
		cat_id=G("cat_id")
		sql="select b.data_table as datatable from kl_cats as a inner join kl_content_types as b on a.type_id=b.type_id where a.cat_id="&cat_id
		set rs=olddb.query(sql)
		datatable=rs("datatable")
		
				set uprs=server.createobject("adodb.recordset")
				uprs.open "select * from "&datatable,olddb.idbconn,1,3
				uprs.addNew
				
				for each key in request.Form()
					 if  key<>"isaddarticle" then
						val=G(key)
'						if not isnumeric(val) then
'							val="'"&val&"'"
'						end if
						'echo val&"<br>"
						'echo key&"<br>"
						uprs(key)=val
					 end if
				next
				uprs("fbdate")=FormatDate(now,2)
				uprs("uddate")=FormatDate(now,2)
				if(G("arcdescr")="") then uprs("arcdescr")=left(removehtml(G("arccontent")),30)
				uprs.update
				
				if err.number<>0 then
					echoErr()
					AlertMsg(ADD_FAIL_STR)
					err.clear
				else
					AlertMsg(ADD_SUCCESS_STR)
				end if
	end if
'添加文章时取传递过来的分类
cat_id=G("cat_id")
if cat_id="" then echo "<script>window.history.go(-1);</script>":die("") end if

set rs=olddb.query("select a.type_id as typeid, * from kl_cats as a inner join kl_content_types as b on a.type_id=b.type_id where a.cat_id="&cat_id)
newtpl.assign "arctpl",rs("cat_article")&""
newtpl.assign "cat_name",rs("cat_name")&""
newtpl.assign "type_name",rs("type_name")&""
newtpl.assign "type_id",rs("typeid")&""


uname=Request.Cookies("U_name")&""
set nirs=olddb.query("select top 1 * from kl_admin where username='"&uname&"'")
val=cstr(nirs("nicheng")&"")
if val="" then
	val=uname
end if
set nirs=nothing
newtpl.assign "author",val
newtpl.assign "source","http://"&cstr(Request.ServerVariables("SERVER_NAME"))


'oldtpl.SetVariable "typeidsel",getContentTypeSel()
newtpl.assign "catidsel",getArcCatSel()


newtpl.display(rs("tpl_addform")&"")'getAddform(cat_id)
'oldtpl.Parse
''Destroy our objects
'set oldtpl = nothing
%>