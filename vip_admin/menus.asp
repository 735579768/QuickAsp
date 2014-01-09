<!--#include file="lib/AdminInIt.asp"-->
<%
'oldtpl.SetTemplatesDir("")
'包含文件
'oldtpl.setVariableFile "TOP_HTML","public/top.html"
'oldtpl.setVariableFile "FOOTER_HTML","public/footer.html"
oldtpl.UpdateBlock "m2_block"
oldtpl.UpdateBlock "m1_block"
'查一级菜单
set rs=olddb.query("select sysmenuid,menu_name,parent_menu_id,menu_link,sort from " & suffix & "sysmenus  where parent_menu_id=0 and qx_id>="&session("adminqxid")&" order by sort asc ")
do while not rs.eof
		'查询二级菜单
		set rss=olddb.query("select sysmenuid,menu_name,menu_link,sort from " & suffix & "sysmenus  where parent_menu_id="&rs("sysmenuid")&"   and qx_id>="&session("adminqxid")&" order by sort asc ")
		do while not rss.eof
			oldtpl.SetVariable "menu2_name",rss("menu_name")&""
			oldtpl.SetVariable "menu2_link",rss("menu_link")&""
			oldtpl.ParseBlock "m2_block"
		rss.movenext
		loop
	oldtpl.SetVariable "menu1_name",rs("menu_name")&""
	oldtpl.ParseBlock "m1_block"
	rs.movenext
loop
'Generate the page
oldtpl.Parse
'Destroy our objects
set oldtpl = nothing
%>