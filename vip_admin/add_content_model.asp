<!--#include file="lib/AdminInIt.asp"-->
<%
datatable=G("data_table")
if datatable<>"" then
	on error resume next
	newdb.kl_conn.execute(G("sql"))
	if err.number<>0 then
		err.clear
		call AlertmsgGo("run sql fail,error str:"&err.description,-1)
	else
		set rs=newdb.table("kl_content_types").sel()'打开一个表的记录集
		rs.addnew
		rs("type_name")=G("type_name")
		rs("type_sxname")=G("type_name")
		rs("data_table")=datatable
		rs("tpl_addform")="addform.html"
		rs("tpl_editform")="editform.html"
		rs("tpl_index")="article_index.html"
		rs("tpl_list")="article_list.html"
		rs("tpl_article")="article_article.html"
		rs("formjsonstr")=""
		rs.update
		if err.number<>0 then
			AlertMsg(ADD_FAIL_STR)
		else
			set rs=newdb.table("kl_content_types").order("type_id desc").sel()
			reurl("edit_field.asp?type_id="&rs("type_id"))
		end if
	 end if
else	
newtpl.assign "act","runsql"
newtpl.display("add_content_model.html")
end if
%>