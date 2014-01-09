<!--#include file="lib/AdminInIt.asp"-->
<%
'oldtpl.SetTemplatesDir("")
'包含文件
'oldtpl.setVariableFile "TOP_HTML","public/top.html"
'oldtpl.setVariableFile "FOOTER_HTML","public/footer.html"

'添加菜单和子菜单
	if G("act")="add" then
		if G("lanmu")<>"" then
			olddb.query("insert into kl_sysmenus(parent_menu_id,menu_name) values(0,'"&G("lanmu")&"')")
			'echo "insert into "&suffix&"sysmenus(parent_menu_id,menu_name) values(0,'"&G("lanmu")&"')"
			AlertMsg("添加菜单--"&G("lanmu")&"-- 成功！")
		end if 
		if G("childlanmu")<>"" then
			olddb.query("insert into kl_sysmenus(parent_menu_id,menu_name,menu_link) values("&G("sysmenuid")&",'"&G("childlanmu")&"','"&G("childlanmuurl")&"')")
			AlertMsg("子菜单 --"&G("childlanmu")&"-- 添加成功！")
		end if 
	end if



'更新栏目和子菜单
	if G("act")="update" then
		sqlstr=""
		id=G("id")
		if G("sysmenu_link")<>"" then
			sqlstr="update kl_sysmenus set menu_name='"&G("sysmenu_name")&"',qx_id="&G("qx_id")&",menu_link='"&G("sysmenu_link")&"' where sysmenuid="& id
			olddb.query(sqlstr)
		else
			sqlstr="update kl_sysmenus set menu_name='"&G("sysmenu_name")&"',qx_id="&G("qx_id")&" where sysmenuid="& id
			olddb.query(sqlstr)
			
		end if
	end if

'输出栏目和子菜单
	dim str:str=getSysMenusSel()
	oldtpl.setVariable "sysmenus",str
	oldtpl.UpdateBlock "m2_block"
	oldtpl.UpdateBlock "m1_block"
	'查一级菜单
	set rs=olddb.query("select sysmenuid,menu_name,parent_menu_id,menu_link,sort,qx_id from " & suffix & "sysmenus  where parent_menu_id=0 order by sort asc ")
	do while not rs.eof
			'查询二级菜单
			set rss=olddb.query("select sysmenuid,menu_name,menu_link,sort,qx_id from " & suffix & "sysmenus  where parent_menu_id="&rs("sysmenuid")&" order by sort asc ")
			do while not rss.eof
				oldtpl.SetVariable "sort2",rss("sort")&""
				oldtpl.SetVariable "qx_id2",rss("qx_id")&""
				oldtpl.SetVariable "menu2_id",rss("sysmenuid")&""
				oldtpl.SetVariable "menu2_name",rss("menu_name")&""
				oldtpl.SetVariable "menu2_link",rss("menu_link")&""
				oldtpl.ParseBlock "m2_block"
			rss.movenext
			loop
		oldtpl.SetVariable "sort1",rs("sort")&""
		oldtpl.SetVariable "qx_id1",rs("qx_id")&""
		oldtpl.SetVariable "menu1_id",rs("sysmenuid")&""
		oldtpl.SetVariable "menu1_name",rs("menu_name")&""
		oldtpl.ParseBlock "m1_block"
		rs.movenext
	loop
'Generate the page
oldtpl.Parse
'Destroy our objects
set oldtpl = nothing
%>