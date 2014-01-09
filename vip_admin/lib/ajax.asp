<%
'bakon error resume next
oldtpl.setdisplaystate(true)'不让模板输出内容
dim ajaxstr
dim id:id=G("id")
'处理删除后台菜单请求
	if G("action")="delmenu" then
		'查询这个是不是顶级菜单，判断是不是有子菜单
			set rs=olddb.query("select * from "& suffix &"sysmenus where parent_menu_id="& id)
		if rs.eof then 
			 olddb.query("delete * from "& suffix &"sysmenus where sysmenuid="& id) 
			 ajaxstr=1
		else
			 ajaxstr=AJAX_NODELMENU
		end if
	end if
'更新后台菜单排序请求
	if G("action")="updtsort" then
		dim menusort:menusort=G("sort")
		olddb.query("update kl_sysmenus set [sort]='"&menusort&"' where sysmenuid="&id)
		ajaxstr=1
	end if
'删除前台栏目菜单
	if G("action")="delcat" then
			'判断这个分类下面是不是有文章，有的话不能删除
			set rs=olddb.GetRecord("kl_archives","*","cat_id="&id,"",0)
			if not rs.eof then 
				ajaxstr="分类下有文章不能删除!"
				echo ajaxstr
				die("")
			end if
			'查询这个是不是顶级菜单，判断是不是有子菜单,含有子菜单的不能删除
			set rs=olddb.query("select * from "& suffix &"cats where parent_id="& id)
			if rs.eof then 
				 olddb.query("delete * from "& suffix &"cats where cat_id="& id)
				 ajaxstr=1 
			else
				 ajaxstr=AJAX_NODELMENU
			end if
	end if
	
'删除友情链接
	if G("action")="delfriendlink" then
		friend_id=G("friend_id")
		result=olddb.deleteRecord("kl_friend_link","friend_id",friend_id)
		if result<>0 then
			ajaxstr=1
		end if
	end if
echo ajaxstr
die("")
%>