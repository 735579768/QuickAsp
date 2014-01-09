<!--#include file="lib/FrontInit.asp"-->
<!--#include file="lib/page.class.asp"-->
<%
db.kl_filtersql=true
set obj=db.table("kl_comments").create()
obj("fbdate")=formatdate(now,2)
obj("fbip")=getip()
db.formdata=obj
a=db.add()
if a then
AlertMsg "发布成功"
else
AlertMsg "发布失败"
end if
%>