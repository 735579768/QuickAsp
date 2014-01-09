<!--#include file="lib/FrontInit.asp"-->
<!--#include file="lib/page.class.asp"-->
<%
catid=G("catid")
if catid="" then reurl("/") end if
'查询分类信息
set rs=db.where("cat_id="&catid).table("kl_cats").top("1").sel()
cat_single=rs("cat_single")&"" 
cat_content=rs("cat_content")&"" 
'输出分类信息
rsarr=db.rsToArr(rs)
set catobj=rsarr(0)
tpl.assign "catinfo",catobj

keywords=filtersql(trim(G("keywords")))
sql="select * from kl_archives as a inner join kl_cats as b on a.cat_id=b.cat_id where (a.cat_id="&catid&" or b.parent_id="&catid&") and  arctitle like '%"&keywords&"%'"

tpl.assign "sql",sql
tpl.assign "keywords",keywords
if  cat_single=1 then 
	tpl.show(cat_content)
	die("")
end if
'设定指定的模板
tplfile=getCatTpl(G("catid"))
tpl.display(tplfile)
%>