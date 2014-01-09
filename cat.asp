<!--#include file="lib/FrontInit.asp"-->
<!--#include file="lib/page.class.asp"-->
<%
on error resume next
catid=G("catid")
if catid="" then reurl("/") end if
'查询分类信息
set rs=db.where("cat_id="&catid).table("kl_cats").top("1").sel()


cat_single=rs("cat_single")&"" 
cat_content=rs("cat_content")&""

if err.number<>0 then
	AlertMsg "非法访问"
	reurl("/")
end if

'输出分类信息
rsarr=db.rsToArr(rs)
set catobj=rsarr(0)
tpl.assign "catinfo",catobj


if  cat_single=1 then 
	tpl.show(cat_content)
	die("")
end if
'设定指定的模板
tplfile=getCatTpl(G("catid"))
tpl.display(tplfile)
%>