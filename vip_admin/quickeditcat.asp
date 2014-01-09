<!--#include file="lib/AdminInIt.asp"-->
<%
'更新数据
act=G("act")
cat_id=G("cat_id")
if act="upd" then
	newdb.table("kl_cats").where("cat_id="&cat_id).create()
	newdb.save()
end if


rsarr=newdb.table("kl_cats").where("cat_id="&cat_id).selarr()
set radioobj=server.CreateObject("scripting.dictionary")
radioobj("0")="关闭自定义模板"
radioobj("1")="启用自定义模板"
newtpl.assign "selarr",radioobj
newtpl.assign "seled",rsarr(0)("cat_single")



set catobj=rsarr(0)
catobj("parentidsel")=getArcCatSel()
'生成启用单页模板按钮


'======================
'生成cat_id select 的js代码
parentid=catobj("parent_id")&""
jssstr=""
if parentid=0 then
jsstr="<script>$(function(){$(""#cat_id option[value='0']"").attr('selected','true');$(""#cat_id option[value='0']"").html('顶级分类');$('#cat_id').attr('name','parent_id');});</script>"
else
jsstr="<script>$(function(){$(""#cat_id option[value='0']"").html('顶级分类');$('#cat_id').attr('name','parent_id');$(""#cat_id option[value='"&parentid&"']"").attr('selected','true');});</script>"
end if
catobj("jsstr")=jsstr
newtpl.assign "catobj",catobj
newtpl.display("quickeditcat.html")
%>