<!--#include file="lib/FrontInit.asp"-->
<!--#include file="lib/page.class.asp"-->
<%
'sql="create table test_table(tet text)"
'sql="alter table kl_content_types add formjsonstr text"
'在分类表中添加啦分类别名
sql="alter table kl_cats add cat_alias text"
on error resume next
db.kl_conn.execute(sql)
if err.number<>0 then
echo AlertMsg("更新失败:error "&err.description)
else
echo AlertMsg("更新成功")
end if
%>