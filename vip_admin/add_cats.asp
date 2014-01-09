<!--#include file="lib/AdminInIt.asp"-->
<%
'这个文件用来添加子类和顶级类
'cat如果为0则添加顶级类，不为0则为这个分类的父id
dim parent_id:parent_id=G("parent_id")
if G("act")="add" then
				'bakon error resume next
				set fordata=newdb.table("kl_cats").create()
				fordata("cat_content")=request("cat_content")
'				err.clear
'				set uprs=server.createobject("adodb.recordset")
'				uprs.open "select * from kl_cats",olddb.idbconn,1,3
'				uprs.addnew
'				uprs("parent_id")=parent_id
'				uprs("cat_name")=G("cat_name")
'				uprs("sort")=G("sort")
'				uprs("type_id")=G("type_id")
'				uprs("cat_show")=G("cat_show")
'				uprs("cat_pic")=G("cat_pic")
'				uprs("cat_seotitle")=G("cat_seotitle")
'				uprs("cat_seokeys")=G("cat_seokeys")
'				uprs("cat_seodescr")=G("cat_seodescr")
'				uprs("cat_single")=G("cat_single")
'				uprs("catflag")=G("catflag")
'				uprs("cat_content")=request("cat_content")
				
				cat_index=G("cat_index")
				cat_list=G("cat_list")
				cat_article=G("cat_article")
'				uprs("cat_index")=cat_index
'				uprs("cat_list")=cat_list
'				uprs("cat_article")=cat_article
				
				if cat_index="" or cat_list="" or cat_article="" then
					set tplrs=newdb.query("select * from kl_content_types where type_id="&G("type_id"))
					if cat_index="" then fordata("cat_index")=tplrs("tpl_index")&""
					if cat_list="" then fordata("cat_list")=tplrs("tpl_list")&""
					if cat_article="" then fordata("cat_article")=tplrs("tpl_article")&""
					set tplrs=nothing
				end if
				newdb.formdata=fordata
				result=newdb.add()
'				uprs.update
'				uprs.close
'				set uprs=nothing
		if result then
			AlertMsgGo ADDSUCCESS,"cats_list.asp"
			
		else
			AlertMsg ADDFAIL&err.description
		end if
		
'	end if
end if
'Generate the page
dim obj
if parent_id<>0 then
	rsarr=newdb.table("kl_cats").where("cat_id="&parent_id).selarr()'query("select * from "&suffix&"cats where cat_id="&parent_id)
	set obj=rsarr(0)
	obj("parent_id")=parent_id
'	oldtpl.setvariable "parent_id",parent_id
'	oldtpl.setvariable "cat_name",rs("cat_name")&""
'	oldtpl.setvariable "cat_index",rs("cat_index")&""
'	oldtpl.setvariable "cat_list",rs("cat_list")&""
'	oldtpl.setvariable "cat_article",rs("cat_article")&""
else
'	oldtpl.setvariable "cat_name","无"
'	oldtpl.setvariable "parent_id",parent_id
	set obj=getobj()
	obj("cat_name")="无"
	obj("parent_id")=parent_id
'	newtpl.assign "cat_name","无"
'	newtpl.assign "parent_id",parent_id
end if
obj("typeidsel")=getContentTypeSel()
'oldtpl.setvariable "typeidsel",
''Generate the page
'oldtpl.Parse
''Destroy our objects
'set oldtpl = nothing
newtpl.assign "obj",obj
newtpl.display("add_cats")

'////////////////////////////////////////////////////////本页函数库///////////////////////////////////////////////////////////

%>