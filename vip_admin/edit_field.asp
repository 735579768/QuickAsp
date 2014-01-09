<!--#include file="lib/AdminInIt.asp"-->
<%
typeid=G("type_id")
if G("updformjson")="true" and typeid<>"" then
	Set o = jsObject()
	for each a in request.Form
		num=instr(a,"auto_")
		if num<>0 then
		fie=replace(a,"auto_","")
		o(fie)=G(fie&"1")&"|"&G(fie&"2")&"|"&G(fie&"3")
		end if
	next
	formjsonstr= tojson(o)
	set rs=newdb.table("kl_content_types").where("type_id="&typeid).sel
	rs("formjsonstr")=formjsonstr
	rs("fieldtag")=G("fieldtag")
	rs.update
end if
'输出表中的字段
dim datatable,type_name,formjsonstr,jsonobj,fieldtag
datatable=G("data_table")
if typeid<>"" then
	set rs=newdb.table("kl_content_types").where("type_id="&typeid).sel()
	type_name=rs("type_name")&""
	datatable=rs("data_table")&""
	fieldtag=rs("fieldtag")&""
end if
if datatable<>"" then
	set rs=newdb.table(datatable).sel()
'		listdata=""
		fieldstr=""
		for each a in rs.fields
				echo fieldtag&""
			if fieldtag="" then 
				fieldstr=fieldstr&"<field name='"&a.name&"' title='"&a.name&"' descr='' listshow='1' addshow='' editshow=''  func='' datatype='text' />"&vbCrLf
			end if
		next
		fieldstr=fieldstr&"<field name='type_id' title='内容类型' descr='' listshow='1' addshow='1' editshow='1' datatype='cat_id' func=''/>"
		if fieldtag="" then fieldtag=fieldstr
		newtpl.assign "fieldtag",fieldtag
		newtpl.assign "type_id",typeid
		newtpl.assign "type_name",type_name
		newtpl.display("edit_field.html")
else
	echo "<script>window.history.go(-1);</sript>"
end if
%>