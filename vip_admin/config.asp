<!--#include file="lib/AdminInIt.asp"-->
<%
on error resume next
key="#key#"
fie="#fie#"
if G("upcfg")="true" then 
	'Set o = jsObject()
	str=""
	
	for each a in request.Form
			str=str&fie&a&key&G(a)&fie
	next
	set rs=newdb.table("kl_meta").where("meta_key='cfg_system'").sel()
	rs("meta_value")=str
	rs.update
	if err.number=0 then 
		alertmsggo UPDATE_SUCCESS_STR,"config.asp"
	else
		alertmsg UPDATE_FAIL_STR
	end if
	set rs=nothing
end if



set rs=db.table("kl_meta").where("meta_key='cfg_system'").fild("meta_value").sel()
jsonstr=rs(0)&""
set cfgobj=jsontoobj(jsonstr)
newtpl.assign "cfgobj",cfgobj

set dir=server.CreateObject("Scripting.Dictionary")
dir("0")="关闭"
dir("1")="启用"
newtpl.assign "radioarr",dir
newtpl.assign "yasuoradioarr",dir
newtpl.assign "seled",cfgobj("cfg_weijingtai")
newtpl.assign "seled2",cfgobj("cfg_spider")
newtpl.assign "yasuoseled",cfgobj("cfg_pageyasuo")
set dir=nothing


newtpl.display("config.html")
%>