<!--#include file="lib/AdminInIt.asp"-->
<%
act=G("act")
cat_id=G("cat_id")
newtpl.assign "cat_id",cat_id
fenlei_parent_id=G("fenlei_parent_id")
newtpl.assign "catsel",getArcCatSel()
if act="del" then 
set testrs=newdb.table("kl_fenlei").where("fenlei_parent_id="&G("fenlei_id")).sel()
	if testrs.recordcount>0 then
		call alertMsg("此分类下面有子类不能删除")
	else
		newdb.table("kl_fenlei").where("fenlei_id="&G("fenlei_id")).delete()
		call alertMsgGo("删除成功","fenlei.asp?cat_id="&cat_id)
	end if
	set testrs=nothing
end if

'更新分类
if act="mod" then 
	newdb.table("kl_fenlei").create()
	newdb.where("fenlei_id="&G("fenlei_id")).save()
	call alertMsgGo("分类更新成功","fenlei.asp?cat_id="&cat_id)
end if

'添加新的分类
if act="add" then 
	newdb.table("kl_fenlei").create()
	newdb.add()
	call alertMsgGo("分类添加成功","fenlei.asp?cat_id="&cat_id)
end if
fenge="|————————"
fengenum=5
if cat_id<>"" or cat_id<>0 then
	set rss=newdb.table("kl_fenlei").where("cat_id="&cat_id&" and fenlei_parent_id=0").sel()
	flstr=""
	if rss.recordcount>0 then
		do while not rss.eof
			fenge="|————————"
			flstr=flstr&getfenlei(rss("fenlei_id"))
			rss.movenext
		loop
	end if
	newtpl.assign "sfenlei",flstr
end if
newtpl.display("fenlei")
'本页函数库
function getfenlei(fenleiid)
		fenge=String(fengenum,"——")
		jieguo=""
	if isobject(havechildfenlei(fenleiid)) then
		set rs1=newdb.table("kl_fenlei").where("fenlei_id="&fenleiid).sel()
		jieguo=jieguo&"<tr><td><span style='color:#ccc;'>"&fenge&"</span>(ID:"&rs1("fenlei_id")&")：<input name='fenlei_id' type='hidden' value='"&rs1("fenlei_id")&"'>分类名字：<input name='fenlei_name' type='text' value='"&rs1("fenlei_name")&"'></td><td><a href='javascript:void(0);' class='coolbg modfenlei'>修改</a><a href='?act=del&cat_id="&cat_id&"&fenlei_id="&rs1("fenlei_id")&"' class='coolbg modfenlei'>删除</a>子类名字：<input name='childfenlei_name' type='text' value=''><a href='javascript:void(0);' class='coolbg addchildfenlei' parentid="&rs1("fenlei_id")&">添加子类</a></tr>"
		set rs1=nothing
		set rs2=newdb.table("kl_fenlei").where("fenlei_parent_id="&fenleiid).sel()
		if rs2.recordcount>0 then
			do while not rs2.eof
				if isobject(havechildfenlei(rs2("fenlei_id"))) then
					fengenum=fengenum+5
					jieguo=jieguo&getfenlei(rs2("fenlei_id"))
					fengenum=fengenum-5
				else
				jieguo=jieguo&"<tr><td><span style='color:#ccc;'>"&fenge&"</span>(ID:"&rs2("fenlei_id")&")<input name='fenlei_id' type='hidden' value='"&rs2("fenlei_id")&"'>分类名字：<input name='fenlei_name' type='text' value='"&rs2("fenlei_name")&"'></td><td><a href='javascript:void(0);' class='coolbg modfenlei'>修改</a><a href='?act=del&cat_id="&cat_id&"&fenlei_id="&rs2("fenlei_id")&"' class='coolbg modfenlei'>删除</a>子类名字：<input name='childfenlei_name' type='text' value=''><a href='javascript:void(0);' class='coolbg addchildfenlei' parentid="&rs2("fenlei_id")&">添加子类</a></tr>"
		
		       end if
			rs2.movenext
			loop
		end if
		set rs2=nothing
	else
		set rs1=newdb.table("kl_fenlei").where("fenlei_id="&fenleiid).sel()
		jieguo=jieguo&"<tr><td><span style='color:#ccc;'>"&fenge&"</span>(ID:"&rs1("fenlei_id")&")<input name='fenlei_id' type='hidden' value='"&rs1("fenlei_id")&"'>分类名字：<input name='fenlei_name' type='text' value='"&rs1("fenlei_name")&"'></td><td><a href='javascript:void(0);' class='coolbg modfenlei'>修改</a><a href='?act=del&cat_id="&cat_id&"&fenlei_id="&rs1("fenlei_id")&"' class='coolbg modfenlei'>删除</a>子类名字：<input name='childfenlei_name' type='text' value=''><a href='javascript:void(0);' class='coolbg addchildfenlei' parentid="&rs1("fenlei_id")&">添加子类</a></tr>"
		set rs1=nothing
	end if


'		if isobject(havechildfenlei(fenleiid)) then
'			set rs=newdb.table("kl_fenlei").where(" fenlei_id="&fenleiid).sel()
'			str=str&"<tr><td><span style='color:#ccc;'>"&fenge&"</span>(ID:"&rs("fenlei_id")&")分类名字：<input name='fenlei_name' type='text' value='"&rs("fenlei_name")&"'></td><td><a href='javascript:void(0);' class='coolbg modfenlei'>修改</a>子类名字：<input name='childfenlei_name' type='text' value=''><a href='javascript:void(0);' class='coolbg addchildfenlei' parentid="&rs("fenlei_id")&">添加子类</a></tr>"
'			flstr=flstr&getfenlei(rs("fenlei_id"))
'			set rs=nothing
'		else
'			set rss=newdb.table("kl_fenlei").where("cat_id="&cat_id&" and fenlei_parent_id=0").sel()
'			do while not rss.eof
'			flstr=flstr&"<tr><td>(ID:"&rs("fenlei_id")&")分类名字：<input name='fenlei_name' type='text' value='"&rs("fenlei_name")&"'></td><td><a href='javascript:void(0);' class='coolbg modfenlei'>修改</a>子类名字：<input name='childfenlei_name' type='text' value=''><a href='javascript:void(0);' class='coolbg addchildfenlei' parentid="&rs("fenlei_id")&">添加子类</a></tr>"
'			loop
'		end if
		getfenlei=jieguo
end function
function havechildfenlei(fenleiid)
	set rs=newdb.table("kl_fenlei").where(" fenlei_parent_id=0").sel()
	if rs.recordcount>0 then
		set havechildfenlei=rs
	else
		havechildfenlei=false
	end if
end function
%>