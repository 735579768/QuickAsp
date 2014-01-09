<%
'==============================
'解析调试输出
'=============================
	function getobj()
		set getobj=server.CreateObject("Scripting.Dictionary")
	end function
'==============================
'解析调试输出
'=============================
	function debug(str)
		call db.echoErr(1,str)
	End function
'==============================
'解析jsong一维对象
'=============================
	function jsontoobj(jsonstr)
		set jsonreg=new Regexp
		jsonreg.IgnoreCase = True
		jsonreg.Global = True
		jsonreg.Pattern ="#fie#([\s\S]*?)#key#([\s\S]*?)#fie#"
		set keyobj=server.CreateObject("Scripting.Dictionary")
		set matches=jsonreg.execute(jsonstr)
		for each m in matches
			key=m.submatches(0)&""
			val=m.submatches(1)&""
			keyobj(key)=val
		next
		set jsontoobj=keyobj
		set jsonreg=nothing
	end function
'==============================
'给对象添加或重置项目和值
'=============================
	Function setitem(byval obj,itm,val)
		if not isobject(obj) then
			setitem=obj
		else
			if obj.Exists(itm) then obj.Remove(itm)
			obj(itm)=val
			set setitem=obj
		end if
	end Function
'==============================
'查询类的顶级分类id
'=============================
	function getTopCat(catid)
		set furs=db.table("kl_cats").where("cat_id="&catid).sel()
		'echo db.getlastsql()
		parentid=furs("parent_id")&""
		temid=furs("cat_id")&""
		if parentid<>"0" then
			getTopcat=getTopcat(parentid)
		else
			getTopcat=temid
		end if
	end function
'取分类封面模板在前台使用
'///////////////////////////////////////////
	Function getCatTpl(catid)
		set m=db.table("kl_cats").fild("cat_index").where("cat_id="&catid).sel()
		a=m("cat_index")&""
		set m=nothing
		getCatTpl=a
	End Function
'===========================================
'处理模板中的textarea
'===========================================
	Function convertTextarea(str)
		Set p_regexp = New RegExp   
		p_regexp.IgnoreCase = True
		p_regexp.Global = True
		p_regexp.Pattern="<textarea(.*?)>([\s\S]*?)</textarea>"
		convertTextarea=p_regexp.replace(str,"###textarea$1###$2###/textarea###")
	End Function
'///////////////////////////////////////////
'取数据表中的字段
'///////////////////////////////////////////
	Function getTableField(sql)
		'bakon error resume next
		err.clear
		set fieldrs=server.createobject("adodb.recordset")
		fieldrs.open sql,olddb.idbconn,1,1
		redim arr(fieldrs.fields.count)
			for i=0 to fieldrs.fields.count - 1
				'response.write(fieldrs.fields(i).name)
				'arrrr(0)=fieldrs.fields(i).name
				'arrrr(1)=fieldrs.fields(i).type
				arr(i)=array(fieldrs.fields(i).name,fieldrs.fields(i).type)
			next
		set fieldrs=nothing
		getTableField=arr
'		if err.number<>0 then
'			echoErr()
'		end if
	End Function
'///////////////////////////////////////////
'取添加信息表单页面
'///////////////////////////////////////////
	function getAddForm(cat_id)
		sql="select b.tpl_addform from kl_cats as a inner join kl_content_types as b on a.type_id=b.type_id where a.cat_id="&cat_id
		set m=db.query(sql)
		a=m("tpl_addform")&""
		getAddForm=a
	End function
'///////////////////////////////////////////
'输出错误
'///////////////////////////////////////////
	Function echoErr()
		echo("Error code: " & CStr(Err.Number) & "<br>Error Description: " & Err.Description)
		err.clear
		die("")
	End function
'///////////////////////////////////////////
'取编辑信息表单页面
'///////////////////////////////////////////
	function getEditForm(cat_id)
		sql="select b.tpl_editform from kl_cats as a inner join kl_content_types as b on a.type_id=b.type_id where a.cat_id="&cat_id
		set m=db.query(sql)
		a=m("tpl_editform")&""
		getEditForm=a
	End function
'///////////////////////////////////////////
'取文章模板
'///////////////////////////////////////////
	Function getArticleTpl(arcid)
		'sql="select * from (kl_archives as a inner join kl_cats as b on a.cat_id=b.cat_id) inner join kl_content_types as c on b.type_id=c.type_id where a.id="&arcid
		sql="select * from kl_archives as a inner join  kl_content_types as c on a.type_id=c.type_id where a.id="&arcid
		set m=db.query(sql)
		'arctpl=m("arctpl")&""
		'cat_article=m("cat_article")&""
		tpl_article=m("tpl_article")&""
'		a=""
'		if arctpl<>"" then 
'			a=arctpl
'		elseif cat_article<>"" then 
'			a=cat_article
'		elseif tpl_article<>"" then
'			a=tpl_article
'		else
'		end if
		'set m=db.getRecord("kl_archives","arctpl","id="&arcid,"",0)
		set m=nothing
		getArticleTpl=tpl_article
	End Function
'///////////////////////////////////////////
'取分类封面模板
'///////////////////////////////////////////
	Function getCatIndexTpl(catid)
		set m=db.getRecord("kl_cats","cat_index","cat_id="&catid,"",0)
		a=m("cat_index")&""
		set m=nothing
		getCatIndexTpl=a
	End Function
'///////////////////////////////////////////
'取分类封面模板
'///////////////////////////////////////////
	Function getCatListTpl(catid)
		set m=db.getRecord("kl_cats","cat_list","cat_id="&catid,"",0)
		a=m("cat_list")&""
		set m=nothing
		getCatListTpl=a
	End Function
'///////////////////////////////////////////
'通过sql语句设置模板变量
'///////////////////////////////////////////
	Function setTplVarBySql(sql)
		'bakon error resume next
		set funcrs=db.query(sql)
		sz=gettablefield(sql)
		for i=0 to ubound(sz)-1
			 oldtpl.SetVariable sz(i)(0),funcrs(sz(i)(0))&""
		next
		if err.number<>0 then 
				echo  die(Err.Description&":"&valu)
				err.clear
		end if
		set funcrs=nothing
	End Function	
'///////////////////////////////////////////
'指设置模板变量
'@param arr 键值数组 
'///////////////////////////////////////////
	Function setVarArr(arr)
		if isarray(arr) then
		 for i=0 to ubound(arr)
		 key=mid(arr(i),1,(instr(arr(i),":")-1))
		 valu=mid(arr(i),instr(arr(i),":")+1)
		 	oldtpl.SetVariable key,valu
		 next
		 	setvararr=true
		 else
		 	setvararr=false
		end if

	End Function
'///////////////////////////////////////////
'循环块输出
'@param block 要输出的块
'@param sqlstr 查询数据的sql语句
'@param arr 一个键值数组，如"key:valu"  对应的数据格式为 oldtpl.SetVariable key,funcrs(valu)&""
'///////////////////////////////////////////
	Function listBlock(block,sqlstr,arr)
	'bakon error resume next
	set funcrs=db.query(sqlstr)
			oldtpl.UpdateBlock block
		do while not funcrs.eof
			if funcrs.eof and funcrs.bof then exit do end if
			 for i=0 to ubound(arr)
				 key=mid(arr(i),1,(instr(arr(i),":")-1))
				 valu=mid(arr(i),instr(arr(i),":")+1)
				 oldtpl.SetVariable key,funcrs(valu)&""
			 next
			if err.number<>0 then 
				echo  die(Err.Description&":"&valu)
				err.clear
			end if
			oldtpl.ParseBlock block
			funcrs.movenext
		loop
	set funcrs=nothing
	End Function'////////////////////////////////////////////////////////////////////////////////////////////////////////////
'循环块输出,后面带分页显示
'@param block 要输出的块
'@param sqlstr 查询数据的sql语句
'@param arr 一个键值数组，如"key:valu"  对应的数据格式为 oldtpl.SetVariable key,funcrs(valu)&""
'@param pages页面的大小
'///////////////////////////////////////////
	Function listBlockPage(block,sqlstr,arr,pages)
				''创建对象
			Set mypage=new xdownpage
			''得到数据库连接
			mypage.getconn=olddb.idbconn
			''sql语句
			mypage.getsql=sqlstr
			''设置每一页的记录条数据为5条
			mypage.pagesize=pages
			''返回Recordset
			set funcrs=mypage.getrs()
			''显示分页信息，这个方法可以，在set funcrs=mypage.getrs()以后,可在任意位置调用，可以调用多次
			'mypage.showpage()
			'
			''显示数据
			'Response.Write("<br/>")
			'bakon error resume next
				oldtpl.UpdateBlock block
			for i=1 to mypage.pagesize
			''这里就可以自定义显示方式了
				if not funcrs.eof then 
			'        response.write funcrs(0) & "<br/>"
						 for j=0 to ubound(arr)
							 key=mid(arr(j),1,(instr(arr(j),":")-1))
							 valu=mid(arr(j),instr(arr(j),":")+1)
							 oldtpl.SetVariable key,funcrs(valu)&""
							if err.number<>0 then 
								echo  die(Err.Description&":"&valu)
								err.clear
							end if
						 next
					oldtpl.ParseBlock block
					funcrs.movenext
				else
					 exit for
				end if
			next
			oldtpl.setvariable "pagenav",mypage.getshowpage()
			set funcrs=nothing
	End Function
'/////////////////////////////////////////////////////////////////////////////////////////////////////////
'循环块输出
'@param block 要输出的块
'@param sqlstr 查询数据的sql语句
'@param tablename 数据表名字	
'///////////////////////////////////////////
	Function loopBlock(block,sqlstr)
		'bakon error resume next
		'取表中的字段值
		sz=getTableField(sqlstr)
		set funcrs=db.query(sqlstr)
				oldtpl.UpdateBlock block
			do while not funcrs.eof
				if funcrs.eof and funcrs.bof then exit do end if
				 for i=0 to ubound(sz)-1
					 oldtpl.SetVariable sz(i)(0),funcrs(sz(i)(0))&""
				 next
				if err.number<>0 then 
					echo  die(Err.Description&":"&valu)
					err.clear
				end if
				oldtpl.ParseBlock block
				funcrs.movenext
			loop
		set funcrs=nothing
	End Function
'////////////////////////////////////////////////////////////////////////////////////////////////////////////
'循环块输出,后面带分页显示
'@param block 要输出的块
'@param sqlstr 查询数据的sql语句
'@param arr 一个键值数组，如"key:valu"  对应的数据格式为 oldtpl.SetVariable key,funcrs(valu)&""
'@param pages页面的大小
'///////////////////////////////////////////
	Function loopBlockPage(block,sqlstr,pagesizes)
				''创建对象
			Set mypage=new xdownpage
			''得到数据库连接
			mypage.getconn=db.idbconn
			''sql语句
			mypage.getsql=sqlstr
			''设置每一页的记录条数据为5条
			mypage.pagesize=pagesizes
			''返回Recordset
			set funcrs=mypage.getrs()
			''显示分页信息，这个方法可以，在set funcrs=mypage.getrs()以后,可在任意位置调用，可以调用多次
			'mypage.showpage()
			'
			''显示数据
			'Response.Write("<br/>")
			'bakon error resume next
					'取表中的字段值
			sz=getTableField(sqlstr)
				oldtpl.UpdateBlock block
			for i=1 to mypage.pagesize
			''这里就可以自定义显示方式了
				if not funcrs.eof then 
			'        response.write funcrs(0) & "<br/>"
					 for j=0 to ubound(sz)-1
						 oldtpl.SetVariable sz(j)(0),funcrs(sz(j)(0))&""
							if err.number<>0 then 
								echo  die(Err.Description&":"&valu)
								err.clear
							end if
					 next
					oldtpl.ParseBlock block
					funcrs.movenext
				else
					 exit for
				end if
			next
			oldtpl.setvariable "pagenav",mypage.getshowpage()
			set funcrs=nothing
	End Function
'/////////////////////////////////////////////////////////////////////////////////////////////////////////
'url转向
'///////////////////////////////////////////
	Function reurl(url)
		url=tpl.regtplstr(url)
		response.Redirect(url)
	End Function 
'///////////////////////////////////////////
'输出js提示框到前台
'///////////////////////////////////////////
	Function getJsAlert(str)
		getJsAlert="<script>alert("""&str&""");</script>"
	End Function
'///////////////////////////////////////////
'弹出js提示框到前台
'///////////////////////////////////////////
	function AlertMsg(str)
		str=replace(str,"'","""")
		reurl("/admin/message.asp?msg="&server.URLEncode(str))
		'echo "<script>alert('"&str&"');<\/script>"
	end function
'弹出js提示框到前台并返回
'///////////////////////////////////////////
	function AlertMsgGo(str,go)
		str=replace(str,"'","""")
		reurl("/admin/message.asp?msg="&server.URLEncode(str)&"&uri="&go)
		'echo "<script>alert('"&str&"');<\/script>"
		'echo "<script>window.history.go("&go&");<\/script>"
	end function
'弹出js提示框到前台并刷新窗口
'///////////////////////////////////////////
	function AlertMsgreload(str)
		echo "<script>alert('"&str&"');window.location.reload();</script>"
	end function
'///////////////////////////////////////////
'简化取参数操作
'///////////////////////////////////////////
	function G(str)
		G=getparam(str)
	end function
'///////////////////////////////////////////
'取当前文件名，组合成模板
'///////////////////////////////////////////
	function getRunFileName()
		dim str:str=Request.ServerVariables("Script_Name")
		dim a:a=len(str)
		dim lenstr:lenstr=a-InStrRev(str, "/")
		Dim filename:filename =Right(str,lenstr) 'Replace(Request.ServerVariables("Script_Name"),"/","")
		f = mid(filename,1,InStrRev(filename, ".")-1)
		getRunFileName=f
	end function
'///////////////////////////////////////////
'判断是不是后台的请求
'///////////////////////////////////////////
	function isadmin()
		dim str:str=Request.ServerVariables("Script_Name")
		if instr(str,adminDir)>0 then
			isadmin=true
		else
			isadmin=false		
		end if
	end function
'///////////////////////////////////////////
'调试输出信息
'///////////////////////////////////////////
	function dump(str)
		response.Write "<pre style='color:red'>"
		response.Write str
		response.Write "</pre>"
	end function
'///////////////////////////////////////////
'输出信息
'///////////////////////////////////////////
	function echo(str)
		response.Write str
	end function
'///////////////////////////////////////////
'退出程序
'///////////////////////////////////////////
	function die(str)
		echo str
		response.End()
	End function
'///////////////////////////////////////////
'取url中的请求参数
'///////////////////////////////////////////
	Function getparam(str)
		str1=request(str)
		getparam=str1'replace(str1,";",";")
		'getparam=mydecodeurl(replace(request(str),"$","%"))&"888"
	End Function
'///////////////////////////////////////////
'生成编号
'///////////////////////////////////////////
	function getbh()
		Randomize
		rndName =Year(Now) & Right("0"& Month(Now),2) & Right("0"& Day(Now),2) & Right("0"& Hour(Now),2) & Right("0"& Minute(Now),2) & Right("0"& Second(Now),2)& Right("00000"& Round(Rnd*89999,0),4)
		rndName =""&rndName
		getbh=rndname
	end function
'///////////////////////////////////////////
'功能返回被js编码过的汉字传递请求url参数就可以
'///////////////////////////////////////////
	function getParamByJs(str)
		str=request(str)
		getParamByJs=mydecodeurl(replace(str,"$","%"))
	end function
'///////////////////////////////////////////
'过滤SQL非法字符并格式化html代码
'///////////////////////////////////////////
	function filterSql(fString)
		Set regsql = New RegExp 
		regsql.IgnoreCase = True
		regsql.Global = True
		regsql.Pattern="(\s*?)(dbcc|alter|drop|\*|and|exec|or|insert|select|delete|update|count|master|truncate|declare|char|mid\(|chr|set|where|xp_cmdshell)(\s+?)<(.*?)/?>"
		filtersql=regsql.replace(fstring," ")
'		if isnull(fString) then
'		filtersql=""
'		exit function
'		else
'		fString=trim(fString)
'		fString=replace(fString,"'","""")
'		fString=replace(fString,";","；")
'		fString=replace(fString,"--","—")
'		'fString=server.htmlencode(fString)
'		filtersql=fString
'		end if	
	end function
'///////////////////////////////////////////
'///////////////////////////////////////////
	Function NoSqlHack(FS_inputStr)
		Dim f_NoSqlHack_AllStr,f_NoSqlHack_Str,f_NoSqlHack_i,Str_InputStr
		Str_InputStr=FS_inputStr
		'目前用最严的过滤方式
		f_NoSqlHack_AllStr="dbcc|alter|drop|* |and|exec|or|insert|select|delete|update|count|master|truncate|declare|char|mid(|chr|set |where|xp_cmdshell"
		f_NoSqlHack_Str = Split(f_NoSqlHack_AllStr,"|")
	
		For f_NoSqlHack_i=LBound(f_NoSqlHack_Str) To Ubound(f_NoSqlHack_Str)
			If Instr(LCase(Str_InputStr),f_NoSqlHack_Str(f_NoSqlHack_i))<>0 Then
				If f_NoSqlHack_Str(f_NoSqlHack_i)="'" Then f_NoSqlHack_Str(f_NoSqlHack_i)=" \' "
				Response.Write "<html><title>警告</title><body bgcolor=""EEEEEE"" leftmargin=""60"" topmargin=""30""><font style=""font-size:16px;font-weight:bolder;color:blue;""><li>您提交的数据有恶意字符</li></font><font style=""font-size:14px;font-weight:bolder;color:red;""><br><li>您的数据已经被记录!</li><br><li>您的IP："&Request.ServerVariables("Remote_Addr")&"</li><br><li>操作日期："&Now&"</li></font></body></html><!--Powered by Foosun Inc.,AddTime:"&now&"-->"
				Response.End
			End if
		Next
		NoSqlHack = Replace(Replace(Str_InputStr,"'","''"),"%27","''")
	End Function
'///////////////////////////////////////////
'检测传递的参数是否为数字型
'///////////////////////////////////////////
	Function Chkrequest(Para)
	Chkrequest=False
	If Not (IsNull(Para) Or Trim(Para)="" Or Not IsNumeric(Para)) Then
	   Chkrequest=True
	End If
	End Function
'///////////////////////////////////////////
'检测传递的参数是否为日期型
'///////////////////////////////////////////
	Function Chkrequestdate(Para)
	Chkrequestdate=False
	If Not (IsNull(Para) Or Trim(Para)="" Or Not IsDate(Para)) Then
	   Chkrequestdate=True
	End If
	End Function

'///////////////////////////////////////////
'过滤SQL非法字符
'///////////////////////////////////////////
	Function checkStr(Chkstr)
		dim Str:Str=Chkstr
		if isnull(Str) then
			checkStr = ""
			exit Function
		else
			Str=replace(Str,"'","")
			Str=replace(Str,";","")
			Str=replace(Str,"--","")
			checkStr=Str
		end if
	End Function



'该函数作用：按指定参数格式化显示时间。
'numformat=1:将时间转化为yyyy-mm-dd hh:nn格式。
'numformat=2:将时间转化为yyyy-mm-dd格式。
'numformat=3:将时间转化为hh:nn格式。
'numformat=4:将时间转化为yyyy年mm月dd日 hh时nn分格式。
'numformat=5:将时间转化为yyyy年mm月dd日格式。
'numformat=6:将时间转化为hh时nn分格式。
'numformat=7:将时间转化为yyyy年mm月dd日 星期×格式。
'numformat=8:将时间转化为yymmdd格式。
'numformat=9:将时间转化为mmdd格式。
	function Formatdate(shijian,numformat)
		dim ystr,mstr,dstr,hstr,nstr '变量含义分别为年字符串，月字符串，日字符串，时字符串，分字符串
		
		if isnull(shijian) then
		numformat=0
		else
		ystr=DatePart("yyyy",shijian)
		
		if DatePart("m",shijian)>9 then 
		mstr=DatePart("m",shijian)
		else
		mstr="0"&DatePart("m",shijian) 
		end if
		
		if DatePart("d",shijian)>9 then 
		dstr=DatePart("d",shijian)
		else
		dstr="0"&DatePart("d",shijian) 
		end if
		
		if DatePart("h",shijian)>9 then 
		hstr=DatePart("h",shijian)
		else
		hstr="0"&DatePart("h",shijian) 
		end if
		
		if DatePart("n",shijian)>9 then 
		nstr=DatePart("n",shijian)
		else
		nstr="0"&DatePart("n",shijian) 
		end if
		end if
		
		select case numformat
		case 0
		formatdate=ystr&"-"&mstr&"-"&dstr&" "&hstr&"-"&nstr 
		case 1
		formatdate=ystr&"-"&mstr&"-"&dstr&" "&hstr&":"&nstr 
		case 2
		formatdate=ystr&"-"&mstr&"-"&dstr
		
		case 3
		formatdate=hstr&":"&nstr
		case 4
		formatdate=ystr&"年"&mstr&"月"&dstr&"日 "&hstr&"时"&nstr&"分"
		
		case 5
		formatdate=ystr&"年"&mstr&"月"&dstr&"日" 
		case 6
		formatdate=hstr&"时"&nstr&"分"
		case 7
		formatdate=ystr&"年"&mstr&"月"&dstr&"日 "&WeekdayName(Weekday(shijian))
		case 8
		formatdate=right(ystr,2)&mstr&dstr
		case 9
		formatdate=mstr&"月"&dstr&"日"
		end select
	end function

'///////////////////////////////////////////
'///////////////////////////////////////////
	function bin2str(binstr)                 '将bin2str二进数转化为字符串
		dim varlen, clow, ccc, skipflag
		skipflag = 0
		ccc = ""
		varlen = lenb(binstr)
		for i = 1 to varlen
			if skipflag = 0 then
				clow = midb(binstr, i, 1)
				if ascb(clow) > 127 then
					ccc = ccc & chr(ascw(midb(binstr, i + 1, 1) & clow))
					skipflag = 1
				else
					ccc = ccc & chr(ascb(clow))
				end if
			else
				skipflag = 0
			end if
		next
		bin2str = ccc
	end function

	function str2bin(str)             '将字符串转化为二进制数
		for i = 1 to len(str)
			str2bin = str2bin & chrb(asc(mid(str, i, 1)))
		next
	end function
'///////////////////////////////////////////
'包含文件
'///////////////////////////////////////////
	Function include(filename)
		Dim re,content,fso,f,aspStart,aspEnd
		set fso=CreateObject("Scripting.FileSystemObject")
		set f=fso.OpenTextFile(server.mappath(filename))
		content=f.ReadAll
		f.close
		set f=nothing
		set fso=nothing
		set re=new RegExp
		re.pattern="^\s*="
		aspEnd=1
		aspStart=inStr(aspEnd,content,"<%")+2
		do while aspStart>aspEnd+1 
		Response.write Mid(content,aspEnd,aspStart-aspEnd-2)
		aspEnd=inStr(aspStart,content,"%\>")+2
		Execute(re.replace(Mid(content,aspStart,aspEnd-aspStart-2),"Response.Write "))
		aspStart=inStr(aspEnd,content,"<%")+2
		loop
		Response.write Mid(content,aspEnd) 
		set re=nothing
	End Function 
'///////////////////////////////////////////
'销毁cookies
'///////////////////////////////////////////
	function destroyCookies()
		session.abandon
		Response.Cookies("adminid").Expires=now-100 
		Response.Cookies("U_name").Expires=now-100 
		Response.Cookies("U_pwd").Expires=now-100 
	end function
'///////////////////////////////////////////
'返回客户端的ip	
'///////////////////////////////////////////
	Function getIP() 
		Dim strIPAddr 
		If Request.ServerVariables("HTTP_X_FORWARDED_FOR") = "" OR InStr(Request.ServerVariables("HTTP_X_FORWARDED_FOR"), "unknown") > 0 Then
		strIPAddr = Request.ServerVariables("REMOTE_ADDR") 
		ElseIf InStr(Request.ServerVariables("HTTP_X_FORWARDED_FOR"), ",") > 0 Then 
		strIPAddr = Mid(Request.ServerVariables("HTTP_X_FORWARDED_FOR"), 1, InStr(Request.ServerVariables("HTTP_X_FORWARDED_FOR"), ",")-1) 
		ElseIf InStr(Request.ServerVariables("HTTP_X_FORWARDED_FOR"), ";") > 0 Then 
		strIPAddr = Mid(Request.ServerVariables("HTTP_X_FORWARDED_FOR"), 1, InStr(Request.ServerVariables("HTTP_X_FORWARDED_FOR"), ";")-1) 
		Else 
		strIPAddr = Request.ServerVariables("HTTP_X_FORWARDED_FOR") 
		End If 
		getIP = Trim(Mid(strIPAddr, 1, 30)) 
	End Function
'///////////////////////////////////////////
'///////////////////////////////////////////
'===============================asp调试函数==================================
	function dump(a)
	debug(a)
	end function
	function debug(a)
		if IsArray(a)  then
			response.write "=================调试输出==================<br />"
			for i=lbound(a) to ubound(a)-1
					if IsArray(a(i)) then
					response.write """"&i&"""=><br />"
							for j=lbound(a) to ubound(a)-1
											response.write "&nbsp&nbsp&nbsp&nbsp&nbsp"""&j&"""=><b style='color:red;'>"&a(i)(j)&"</b><br />"
							next
					else
							response.write """"&i&"""=><b style='color:red;'>"&a(i)&"</b><br />"
					end if
			next
			response.write "============================================<br />"
		else
			response.write "=================调试输出==================<br />"
			response.write "<b style='color:red;'>"&a&"</b><br />"
			response.write "============================================<br />"
			
		end if
	end function
'====================================================================================
'功能：删除文件（图片）
'参数：@filestr  文件路径，(可以用相对路径)
	Function DeleteFile(FileStr)
		   Dim FSO
		   'bakon error resume next
		   Set FSO = CreateObject("Scripting.FileSystemObject")
			If FSO.FileExists(Server.MapPath(FileStr)) Then
				FSO.DeleteFile Server.MapPath(FileStr), True
			Else
			DeleteFile = True
			End If
		   Set FSO = Nothing
		   If Err.Number <> 0 Then
		   Err.Clear:DeleteFile = False
		   Else
		   DeleteFile = True
		   End If
	End Function
'****************************************************
'过程名：RemoveHTML
'作  用：过滤HTML标签
'参  数：strHTML
'****************************************************
	Function RemoveHTML(strHTML)
	on error resume next
	 Dim objRegExp, Match, Matches 
	 Set objRegExp = New Regexp
	 objRegExp.IgnoreCase = True
	 objRegExp.Global = True
	 '取闭合的<>
	 objRegExp.Pattern = "<(.*?)>|\s+?|&nbsp;"
	 '进行匹配
	 strHTML=objRegExp.replace(strHTML,"")
'	 Set Matches=objRegExp.Execute(strHTML)
'	 ' 遍历匹配集合，并替换掉匹配的项目
'	 For Each Match in Matches 
'	 strHtml=Replace(strHTML,Match.Value,"")
'	 Next
'	 strHTML=replace(strHTML," ","")
	 RemoveHTML=strHTML
	 Set objRegExp = Nothing
	End Function
'****************************************************
'过程名：htmlencode
'作  用：过滤HTML标签
'参  数：strHTML
'****************************************************
	function    HTMLEncode2(fString)   
	   fString    =    replace(fString,    ">",    "&gt;")   
	   fString    =    replace(fString,    "<",    "&lt;")   
	   fString    =    Replace(fString,    CHR(32),    "&nbsp;")   
	   fString    =    Replace(fString,    CHR(34),    "&quot;")   
	   fString    =    Replace(fString,    CHR(39),    "&#39;")   
	   fString    =    Replace(fString,    CHR(13),    "")   
	   fString    =    Replace(fString,    CHR(10)    &    CHR(10),    "</P><P>")   
	   fString    =    Replace(fString,    CHR(10),    "<BR>")   
	   HTMLEncode2    =    fString   
   end    function   
'****************************************************
'过程名：htmldecode
'作  用：过滤HTML标签
'参  数：strHTML
'****************************************************
	function    HTMLDecode(fString)   
	   fString    =    replace(fString,    "&gt;",    ">")   
	   fString    =    replace(fString,    "&lt;",    "<")   
	   fString    =    Replace(fString,"&nbsp;",chr(32))   
	   fString    =    Replace(fString,"&quot;",chr(34))   
	   fString    =    Replace(fString,"&#39;",chr(39))   
	   fString    =    Replace(fString,    "",    CHR(13))   
	   fString    =    Replace(fString,    "</P><P>",    CHR(10)    &    CHR(10))   
	   fString    =    Replace(fString,    "<BR>",    CHR(10))   
	   HTMLDecode    =    fString   
   end    function
function getqikannian()
	set ters=db.table("kl_fenlei").where("fenlei_parent_id=61").order("fenlei_id desc").sel()
	str="<select id='qikannian' name='qikannian'><option value='0' selected>请选择年份</option>"
	if ters.recordcount>0 then
	do while not ters.eof
	if G("qikannian")=ters("fenlei_id")&"" then
		str=str&"<option value='"&ters("fenlei_id")&"' selected>"&ters("fenlei_name")&"</option>"	
	else
		str=str&"<option value='"&ters("fenlei_id")&"'>"&ters("fenlei_name")&"</option>"
	end if
	ters.movenext
	loop
	end if
	str=str&"</select>"
	getqikannian=str
	set ters=nothing
end function

function getqikanyue()
	set ters=db.table("kl_fenlei").where("fenlei_parent_id=91").order("fenlei_id desc").sel()
	str="<select id='qikanyue' name='qikanyue'><option value='0' selected>请选择月份</option>"
		if ters.recordcount>0 then
	do while not ters.eof
	if G("qikanyue")=ters("fenlei_id")&"" then
		str=str&"<option value='"&ters("fenlei_id")&"' selected>"&ters("fenlei_name")&"</option>"	
	else
		str=str&"<option value='"&ters("fenlei_id")&"'>"&ters("fenlei_name")&"</option>"
	end if
	ters.movenext
	loop
	end if
	str=str&"</select>"
	getqikanyue=str
	set ters=nothing
end function
function getqikanfenqi()
	set ters=db.table("kl_fenlei").where("fenlei_parent_id=63").order("fenlei_id desc").sel()
	str="<select  id='qikanfenqi' name='qikanfenqi'><option value='0' selected>请选择分期</option>"
		if ters.recordcount>0 then
	do while not ters.eof
	if G("qikanfenqi")=ters("fenlei_id")&"" then
		str=str&"<option value='"&ters("fenlei_id")&"' selected>"&ters("fenlei_name")&"</option>"	
	else
		str=str&"<option value='"&ters("fenlei_id")&"'>"&ters("fenlei_name")&"</option>"
	end if
	ters.movenext
	loop
	end if
	str=str&"</select>"
	getqikanfenqi=str
	set ters=nothing
end function
'
''查询蜘蛛来访问 
'
function GetBot() 
	'查询蜘蛛 
	dim s_agent 
	GetBot="" 
	s_agent=Request.ServerVariables("HTTP_USER_AGENT") '关键判断语句 
	if instr(1,s_agent,"googlebot",1) >0 then 
		GetBot="google" 
	end if 
	if instr(1,s_agent,"msnbot",1) >0 then 
		GetBot="MSN" 
	end if 
	if instr(1,s_agent,"slurp",1) >0 then 
		GetBot="Yahoo" 
	end if 
	if instr(1,s_agent,"baiduspider",1) >0 then 
		GetBot="baidu" 
	end if 
	if instr(1,s_agent,"sohu-search",1) >0 then 
		GetBot="Sohu" 
	end if 
	if instr(1,s_agent,"lycos",1) >0 then 
		GetBot="Lycos" 
	end if 
	if instr(1,s_agent,"robozilla",1) >0 then 
		GetBot="Robozilla" 
	end if 
end function 
'遍历文件夹中的文件返回一个数组
'
  function  bianli(path)   
	Set fso=Server.CreateObject("Scripting.FileSystemObject")
	Set f=fso.GetFolder(server.MapPath(path))
	dim a,b
	a=f.files.count
	b=0
	redim rearr(a)
	For Each i in f.Files
	rearr(b)=i.name
	b=b+1
	next
	set f=nothing
	set fso=nothing
	bianli=rearr  
end  function 


Function include(filename) 
	Dim re,content,fso,f,aspStart,aspEnd
	set fso=CreateObject("Scripting.FileSystemObject") 
	If not fso.FileExists(server.mappath(filename)) Then
		die("要操作的文件不存在:"&server.mappath(filename))
	end if
	set f=fso.OpenTextFile(server.mappath(filename)) 
	content=f.ReadAll 
	f.close 
	set f=nothing 
	set fso=nothing
	set re=new RegExp 
	re.pattern="^\s*=" 
	aspEnd=1 
	aspStart=inStr(aspEnd,content,"<%")+2 
	do while aspStart>aspEnd+1 
	Response.write Mid(content,aspEnd,aspStart-aspEnd-2) 
	aspEnd=inStr(aspStart,content,"%\>")+2 
	Execute(re.replace(Mid(content,aspStart,aspEnd-aspStart-2),"Response.Write ")) 
	aspStart=inStr(aspEnd,content,"<%")+2 
	loop 
	Response.write Mid(content,aspEnd) 
	set re=nothing 
End Function
	'==========================================================================================
	'返回当前位置字符串
	'=========================================================================================	
	Function getcat(catid,jiange)
		str=""
		if catid<>"" then
		set catrs=db.table("kl_cats").top("1").where("cat_id="&catid).sel()
		if catrs.recordcount>0 then
		if catrs("parent_id")<>0 then str=str&getcat(catrs("parent_id"),jiange)
		if catrs("cat_url")<>"" then
			str=str&"<a href='"&catrs("cat_url")&"'>"&jiange&catrs("cat_name")&"</a>"
		else
			str=str&"<a href='cat.asp?catid="&catrs("cat_id")&"'>"&jiange&catrs("cat_name")&"</a>"
		end if
		
		end if
		end if
		getcat=str
	end Function
%>
<script language="javascript" type="text/javascript" runat="server">
function mydecodeurl(s){return decodeURIComponent(s);}
function toObject(json) {eval("var o=" + json);return o;}
</script>