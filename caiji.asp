<!--#include file="lib/FrontInit.asp"-->
<%
'火车头采集接口
const pw="adminrootkl"
rpw=trim(request("pw"))
if not isempty(rpw) then
	if rpw<>pw then die("password error!")
else
	die("password error")
end if

dim arctitle,arccontent,arcpic
arctitle=request.Form("arctitle")


if not isempty(arctitle) then
set obj=db.table("kl_archives").create()
obj("fbdate")=formatdate(now,2)
'obj("fbip")=getip()
db.formdata=obj
a=db.add()
	if a then
		echo "添加成功"
	else
		echo "添加失败"
	end if
else
	echo getcats()
end if



function getcats()
	str="<select>"
	obj=db.table("kl_cats").selarr()
	for i=0 to ubound(obj)-1
	set a=obj(i)
	str=str&"<option value='"&a("cat_id")&"'>"&a("cat_name")&"</option>"	
	next
	getcats=str&"</select>"
end function
tpl.display("")
%>