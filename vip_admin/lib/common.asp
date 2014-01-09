<%
'输出所有文章分类
	function getArcCatSel()
		'检查当前是否有默认的id传过来
		dim selid,typeid,sql'定义默认选中的id
			if G("id")<>"" then
			'  set selrs=olddb.getrecord("kl_article","type_id",array("id:"&G("id")))
			  set selrs=olddb.query("select cat_id,type_id from kl_archives where id="&G("id"))
			  selid =cstr(selrs("cat_id"))
			end if
			
			if G("cat_id")<>"" and G("cat_id")<>"0" then  
				selid =G("cat_id")
				set srs=olddb.query("select type_id from kl_cats where cat_id="&selid)
				typeid=srs("type_id")
			end if
			'编辑文章时进行类型过滤
			if typeid<>"" and G("id")<>"" then 
				sql="select cat_id,cat_name,parent_id from kl_cats where parent_id=0  order by sort asc"
			else
				sql="select cat_id,cat_name from kl_cats where parent_id=0 order by sort asc"
			end if
		'输出sel表单
		dim str:str="<select id='cat_id' name='cat_id' style='width:200px;'>"
		set selrs=olddb.GetRecordBySQL(sql)
		set srs=nothing
				str=str&"<option value='0' >全部分类</option>"	
		if selrs.recordcount>0 then 
			do while not selrs.eof
				kongge=0
				childbool=ischildcat(selrs("cat_id"))
				selstyle=""
				if childbool then
					selstyle=" style='color:#ccc;' "
				else
					selstyle=" "
				end if
				if selid=selrs("cat_id")&"" then
				str=str&"<option value='"&selrs("cat_id")&"' "&selstyle&" selected>"&selrs("cat_name")&"</option>"				
				else
				str=str&"<option value='"&selrs("cat_id")&"'  "&selstyle&" >"&selrs("cat_name")&"</option>"
				end if
			
				'查询二级分类start
				if childbool then
					str=str&catoptions(selrs("cat_id"))
				end if
			selrs.movenext
			loop
		end if
		str=str&"</select>"
		getArcCatSel=str
		set selrs=nothing
		set selrss=nothing
	end function
	
	function ischildcat(catid)
		set rstem=olddb.query("select * from kl_cats where parent_id="&catid)
		if rstem.recordcount>0 then
			ischildcat=true
		else
			ischildcat=false
		end if
		set rstem=nothing
	end function
	'定义一个变量输出空格用
	jiange=12
	kongge=0
	'===============================
	'输出options
	'=================================
	function catoptions(catid)
	kongge=kongge+jiange
		str=""
		set selrss=olddb.GetRecordBySQL("select cat_id,cat_name from kl_cats where parent_id="&catid&" order by sort asc")
				if selrss.recordcount>0 then 
					do while not selrss.eof
						child2=ischildcat(selrss("cat_id"))
						selstyle2=""
						if child2 then
							selstyle2=" style='color:#ccc;' "
						else
							selstyle2=" "
						end if
						if G("cat_id")=selrss("cat_id")&"" then
							str=str&"<option value='"&selrss("cat_id")&"' "&selstyle2&" selected  >"&String(kongge,"-")&selrss("cat_name")&"</option>"				
						else
							str=str&"<option value='"&selrss("cat_id")&"' "&selstyle2&" >"&String(kongge,"-")&selrss("cat_name")&"</option>"
						end if
						'递归输出
						if child2 then
							'kongge=kongge+10
							str=str&catoptions(selrss("cat_id"))
							
						end if					
					selrss.movenext
					loop
					set selrss=nothing
				end if
				kongge=kongge-jiange
				catoptions=str
	end function
'输出内容模型sel
	function getContentTypeSel()
	'检查当前是否有默认的id传过来
		dim selid'定义默认选中的id
		if G("id")<>"" then
		'  set selrs=olddb.getrecord("kl_article","type_id",array("id:"&G("id")))
		  set selrs=olddb.query("select type_id from kl_archives where id="&G("id"))
		  selid =cstr(selrs("type_id"))
		end if
		if G("type_id")<>"" and G("type_id")<>"0" then  selid =G("type_id")
		if G("cat_id")<>"" and G("id")<>"" and  G("cat_id")<>"0" then 
			  set selrs=olddb.query("select type_id from kl_cats where cat_id="&G("cat_id"))
			  selid =cstr(selrs("type_id"))
		end if
		'输出sel表单
		dim str:str="<select id='type_id' name='type_id' style='width:150px;'>"
		set selrs=olddb.GetRecordBySQL("select * from kl_content_types")
			str=str&"<option value='0' >全部类型</option>"
		if selrs.recordcount>0 then 
			do while not selrs.eof
				if selid=selrs("type_id")&"" then
				str=str&"<option value='"&selrs("type_id")&"' selected>"&selrs("type_name")&"|内容类型</option>"				
				else
				str=str&"<option value='"&selrs("type_id")&"'>"&selrs("type_name")&"|内容类型</option>"
				end if
				selrs.movenext
			loop
		set selrs=nothing
		end if
		str=str&"</select>"
		getContentTypeSel=str
	end function
'输出后台栏目菜单
	function getSysMenusSel()
			dim str
			str="<select name=sysmenuid>"
		set selrs=olddb.GetRecordBySQL("select * from kl_sysmenus where parent_menu_id=0 order by sort asc")
				if selrs.recordcount>0 then 
					do while not selrs.eof
							if G("sysmenuid")=selrs("sysmenuid")&"" then
							str=str&"<option value='"&selrs("sysmenuid")&"' selected>"&selrs("menu_name")&"</option>"				
							else
							str=str&"<option value='"&selrs("sysmenuid")&"'>"&selrs("menu_name")&"</option>"
							end if
							selrs.movenext
					loop
					set selrs=nothing
				end if
		str=str&"</select>"
		getSysMenusSel=str
	end function
'输出角色权限下拉菜单
	Function getQxsel()
			dim str
			qx_id=session("adminqxid")
			str="<select name=qx_id>"
		set selrs=olddb.GetRecordBySQL("select * from kl_admin_qx where qx_id>="&qx_id)
				if selrs.recordcount>0 then 
					do while not selrs.eof
							if G("qx_id")=selrs("qx_id")&"" then
							str=str&"<option value='"&selrs("qx_id")&"' selected>"&selrs("qx_name")&"</option>"				
							else
							str=str&"<option value='"&selrs("qx_id")&"'>"&selrs("qx_name")&"</option>"
							end if
							selrs.movenext
					loop
					set selrs=nothing
				end if
		str=str&"</select>"
		getQxsel=str
	End Function
'输出单页面下拉菜
	function getsinglesel()
			dim str
			str="<select name=singleid>"
		set selrs=olddb.GetRecordBySQL("select * from kl_single")
				if selrs.recordcount>0 then 
					do while not selrs.eof
							if G("singleid")=selrs("id")&"" then
							str=str&"<option value='"&selrs("id")&"' selected>"&selrs("pagename")&"</option>"				
							else
							str=str&"<option value='"&selrs("id")&"'>"&selrs("pagename")&"</option>"
							end if
							selrs.movenext
					loop
					set selrs=nothing
				end if
		str=str&"</select>"
		getsinglesel=str	
	end function
	
	'更改父分类
	Function catparentsel(catid)
		'查询它的父分类
		set zrs=olddb.query("select parent_id from kl_cats where cat_id="&catid)
		prentid=zrs("parent_id")&""
		set zrs=nothing
		restr=""
		fsql="select * from kl_cats where cat_id<>"&catid
		set frs=olddb.query(fsql)
		if frs.recordcount>0 then
			restr="<select name=parent_id>"
				if parentid=0 then
					restr=restr&"<option value='0' selected>顶级分类</option>"
				end if
			do while not frs.eof
				if prentid=frs("cat_id")&"" then
				restr=restr&"<option value='"&frs("cat_id")&"' selected>"&frs("cat_name")&"</option>"				
				else
				restr=restr&"<option value='"&frs("cat_id")&"'>"&frs("cat_name")&"</option>"
				end if
				frs.movenext
			loop
			restr=restr&"</select>"
		end if
		set frs=nothing
		catparentsel=restr
	end function
%>