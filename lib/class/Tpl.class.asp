<!--#INCLUDE FILE="Tag.class.asp"-->
<!--#INCLUDE FILE="FilterFunc.asp"-->
<%
'===================================================
'===author 赵克立
'===blog:http://zhaokeli.com/
'===version.v1.0.0
'===asp template class
'===运行模式类似于smarty不过没有smary强大
'===================================================
class AspTpl
	private debug
	private p_errstr
	private p_var_l
	private p_var_r
	private p_tag_l
	private p_tag_r
	public  p_var_list
	private p_tpl_content
	private	p_reg
	private p_fs
	private p_tpl_file
	private p_charset
	public  p_tpl_dir
	public  p_tpl_suffix	
	private sub class_Initialize
		debug=app_debug
		p_tpl_suffix=".html"
		p_charset="UTF-8"
		p_var_l = "\{\$"
		p_var_r = "\}"
		p_tag_l = "<\!--\{"
		p_tag_r = "\}-->"
		p_tpl_dir = "tpl"
		set p_fs= server.createobject("Scripting.FileSystemObject")
		set p_var_list = server.CreateObject("Scripting.Dictionary")
		set p_var_list("precode") = server.CreateObject("Scripting.Dictionary")
		Set p_reg = New RegExp 
		p_reg.IgnoreCase = True
		p_reg.Global = True
	end sub
	
	Private Sub Class_Terminate()
		set p_reg=nothing
		set p_fs=nothing
		set p_var_list=nothing
	end sub
	'==================================================
	'模板目录
	'==================================================	
	Property Let tpldir(a)
		p_tpl_dir=a
	End Property 
	Property Get tpldir
		tpldir=p_tpl_dir
	End Property 
	'==================================================
	'检查模板目录
	'==================================================
	private sub checkTplDirAndFile()
	
		tdir=server.mappath(p_tpl_dir)
		if not p_fs.FolderExists(tdir) then
			p_fs.CreateFolder(tdir)
		end if
		
		if p_fs.FileExists(server.mappath(p_tpl_dir &"/"& p_tpl_File)) then
				'set oFile = p_fs.OpenTextFile(server.mappath(p_tpl_dir &"/"& p_tpl_File), 1)
				p_tpl_content = ReadFromTextFile(p_tpl_dir &"/"& p_tpl_File,p_charset)'oFile.ReadAll
				'oFile.Close
				
			else
				echoErr 1,"<b>ASPTemplate Error: File [" & server.mappath(p_tpl_dir &"/"& p_tpl_File) & "] does not exists!</b><br>"
			end if
			
	end sub
	'==================================================
	'解析模板变量
	'功能主要是解析模板中的全局变量
	'==================================================
	public Function jiexivar(str)
		on error resume next
		a=p_var_list.keys
		p_reg.Pattern =  p_var_l & "(\S*?)" & p_var_r 
		set matches=p_reg.execute(str)
		'遍历在字符串中找到的模板变量
		for each a in matches
			c=isHaveFilteFunc(a)
			if isarray(c) then
			'处理有过滤器的情况
					'判断是不是对象，也就是有键值的情况
					num=instr(c(0),".")						
					if num>0 then
						'取出对象 和键
						temobj=mid(c(0),1,num-1)
						objkey=mid(c(0),num+1)
						if p_var_list.exists(temobj) then
						str=replace(str,a,filtervar(p_var_list(temobj)(objkey),c(1),c(2)))
						end if
					else
						str=replace(str,a,filtervar(p_var_list(c(0)),c(1),c(2)))
					end if
			else
			'没有过滤器
					'判断是不是对象，也就是有键值的情况
					num=instr(a.submatches(0),".")		
					if num>0 then
						'取出对象 和键
						temobj=mid(a.submatches(0),1,num-1)
						objkey=mid(a.submatches(0),num+1)
						if p_var_list.Exists(temobj) then
							if isobject(p_var_list(temobj)) then
							  str=replace(str,a,p_var_list(temobj)(objkey))
							else
								echoerr 1,"键"&temobj&"的值不是对象,在输出"&temobj&"."&temkey&"时出错"	
							end if
						else
							echoerr 1,"不存在键为"&temobj&"的对象"			
						end if
						
					else
					'不是对象，普通变量的输出
						temval=p_var_list(a.submatches(0))
						if isarray(temval) then '过滤去除数组变量
							str=replace(str,a,"<pre style='color:red;'>'"&a.submatches(0)&" ' is Array </pre>")
						else
							str=replace(str,a,temval)
						end if
					end if
			end if 
		next
		jiexivar=str
	end Function
	'==================================================
	'判断变量有否有过滤器
	'@param a一个完整的变量标签({$a|left=10}) 或{$a}
	'返回值：有过滤器的情况下返回一个数据 包含变量键名，函数名，参数，否则返回false
	'==================================================
	public Function isHaveFilteFunc(a)
			Set re = New RegExp 
			re.IgnoreCase = True
			re.Global = True
			'分析是否有变量过滤器start 
			re.Pattern =  p_var_l &  "(\S*?)\|([^\=]*?)\=?([^\=]*?)"  & p_var_r 
			set Ms=re.execute(a)
			'处理有过滤器的情况
			if Ms.count>0 then
				redim arr(3) 
				arr(0)=Ms(0).SubMatches(0)&""'变量键名
				'echo Ms(0).SubMatches(0)&"---"&Ms(0).SubMatches(1)&"-----"& Ms(0).SubMatches(2)&"<br>"
				if Ms(0).SubMatches(1)="" or Ms(0).SubMatches(1)=null then
					arr(1)=Ms(0).SubMatches(2)&""'函数名
					arr(2)=""'调用参数				
				else
					arr(1)=Ms(0).SubMatches(1)&""'函数名
					arr(2)=Ms(0).SubMatches(2)&""'调用参数				
				end if

				isHaveFilteFunc=arr
			else
				isHaveFilteFunc=false
			end if
			set ms=nothing
			set re=nothing
	end function
	'==================================================
	'解析if标签
	'==================================================	
	Public Function iftag(str)
		regtag=p_tag_l & "if\s+?(.*?)\s*?"& p_tag_r  &"([\s\S]*?)"& p_tag_l & "/if"& p_tag_r
		p_reg.Pattern=regtag
		Set Matches = p_reg.Execute(str)
		For Each Match in Matches 
			if instr(Match,replace(p_tag_l & "else"& p_tag_r,"\",""))=0 then
			on error resume next
				err.clear
				bol=eval(jiexivar(Match.SubMatches(0)))
				if err.number<>0 or not bol then
					err.clear
					str=replace(str,Match,"")	
				else
						str=replace(str,Match,jiexiShortTag(Match.SubMatches(1)))			
				end if
			end if
		next
		ifTag=str
	End function
	'==================================================
	'解析ifelse标签
	'==================================================	
	Public Function ifElseTag(str)
		regtag=p_tag_l & "if\s+?(.*?)\s*?"& p_tag_r  &"([\s\S]*?)"& p_tag_l & "else"& p_tag_r & "([\s\S]*?)"& p_tag_l & "/if"& p_tag_r
		p_reg.Pattern=regtag
		Set Matches = p_reg.Execute(str)
		For Each Match in Matches  
				on error resume next
				err.clear
		on error resume next
				err.clear
				bol=eval(replace(trim(jiexivar(Match.SubMatches(0))),"'",""""))
				if err.number<>0 or not bol then
					err.clear
				str=replace(str,Match,Match.SubMatches(2))
				else
					str=replace(str,Match,Match.SubMatches(1))	
				end if
		next
		ifElseTag=str
	end Function
	'==================================================
	'解析foreach标签
	'功能解析一维数组
	'==================================================	
	Public Function foreachTag(str)

		p_reg.Pattern=p_tag_l & "foreach([\s\S]*?)" & p_tag_r&"([\s\S]*?)" & p_tag_l & "/foreach" &p_tag_r
		Set Matches = p_reg.Execute(str)
		For Each Match in Matches  
				temname=getTagParam(Match.SubMatches(0),"name")
				temvar=getTagParam(Match.SubMatches(0),"var")
				dim temarr
				if isobject(p_var_list(temname)) then
					set temarr=p_var_list(temname)
				else
					temarr=p_var_list(temname)
				end if
									
				str1=""
				'如果变量是数组
			if isarray(temarr) then
				str1=jiexiforeacharr(Match.submatches(1),temarr,temvar)
				str1=jiexiShortTag(str1)
				str=replace(str,Match,str1)
			elseif isobject(temarr) then
				'如果变量是对象
				str1=jiexiforeachobj(Match.submatches(1),temarr,temvar)
				str1=jiexiShortTag(str1)
				str=replace(str,Match,str1)
			else
				'循环变量没有定义时直接输出空
				te=("<span style='color:red'>var: ' "&temname&"' if no define</span>")
				str=replace(str,Match,te)
			end if
				
		next
		foreachTag=str					
	End Function
	'==================================================
	'用数组解析foreach中的字符串
	'功能：循环一个字符串在每次循环中用数组当前索引数据替换字符串中的变量
	'@param str 要解析的字符串
	'@param arr	数据所在的数组
	'@param temvar循环时的临时变量
	'==================================================
	private Function jiexiforeacharr(str,temarr,temvar)
		'循环foreach中间的内容 
				restr=""'把每次循环处理过的字符串累加在这里
				for each a in temarr
					'查找变量
					p_reg.Pattern =  p_var_l & "(\S*?)" & p_var_r 
					set ms=p_reg.execute(str)
				'	str1=Match.SubMatches(1)'str1是foreach里面包含的内容
					'遍历在字符串中找到的模板变量并判断是否有过滤器
					if ms.count>0 then
						temstr=str
						for each e in ms
							c=isHaveFilteFunc(e)
							if isarray(c) then
							'处理有过滤器的情况
									'判断 是不是循环变量因为里面除啦循环变量还有全局变量，如果有重复全局变量的属性会被覆盖
									if c(0)=temvar then
										temstr=replace(temstr,e,filtervar(a,c(1),c(2)))
									else
										temstr=replace(temstr,e,filtervar(p_var_list(c(0)),c(1),c(2)))
									end if	
							else
							'没有过滤器
									'temval=p_var_list(e.submatches(0))
									if e.SubMatches(0)=temvar then
										temstr=replace(temstr,e,a)
									else
										temstr=replace(temstr,e,p_var_list(e.submatches(0)))
									end if
							end if 
						next
						restr=restr&temstr
					else
						restr=restr&str
					end if
					
				next
				jiexiforeacharr=restr
	End Function
	'==================================================
	'用对象解析foreach中的字符串
	'功能：循环一个字符串在每次循环中用对象当前键的值数据替换字符串中的变量
	'@param str 要解析的字符串
	'@param temobj	数据所在的数组
	'@param temvar循环时的临时变量
	'==================================================
	Function jiexiforeachobj(str,temobj,temvar)
		restr=""'把每次循环处理过的字符串累加在这里
		for each a in temobj.keys
		'查找变量
			p_reg.Pattern =  p_var_l & "(\S*?)" & p_var_r 
			set ms=p_reg.execute(str)
		'	str1=Match.SubMatches(1)'str1是foreach里面包含的内容
			'遍历在字符串中找到的模板变量并判断是否有过滤器
			for each e in ms
				c=isHaveFilteFunc(e)
				if isarray(c) then
				'处理有过滤器的情况
						'判断 是不是循环变量因为里面除啦循环变量还有全局变量，如果有重复全局变量的属性会被覆盖
						if c(0)=temvar&"."&a or c(0)=temvar&"['"&a&"']"  then
							restr=restr&replace(str,e,filtervar(temobj(a),c(1),c(2)))
						else
							restr=restr&replace(str,e,filtervar(p_var_list(c(0)),c(1),c(2)))
						end if	
				else
				'没有过滤器
						if  e.SubMatches(0)=temvar&"."&a or e.SubMatches(0)=temvar&"['"&a&"']"   then
							restr=restr&replace(str,e,temobj(a))
						else
							restr=restr&replace(str,e,p_var_list(e.submatches(0)))
						end if
				end if 
			next
		next
		jiexiforeachobj=restr
	End function
	'==================================================
	'解析语法中的变量
	'@param varstr变量字符串
	'@param val变量值
	'==================================================	
	Function jiexiyufavar(varstr,val)
				c=isHaveFilteFunc(varstr)
				if isarray(c) then
				'处理有过滤器的情况
						'判断 是不是循环变量因为里面除啦循环变量还有全局变量，如果有重复全局变量的属性会被覆盖
						if c(0)=temvar&"."&a or c(0)=temvar&"['"&a&"']"  then
							restr=restr&replace(str,e,filtervar(temobj(a),c(1),c(2)))
						else
							restr=restr&replace(str,e,filtervar(p_var_list(c(0)),c(1),c(2)))
						end if	
				else
				'没有过滤器
						if  e.SubMatches(0)=temvar&"."&a or e.SubMatches(0)=temvar&"['"&a&"']"   then
							restr=restr&replace(str,e,temobj(a))
						else
							restr=restr&replace(str,e,p_var_list(e.submatches(0)))
						end if
				end if 
	End Function
	'==================================================
	'给模板赋值
	'==================================================
	public sub assign(key,val)
			if  p_var_list.Exists(key) then p_var_list.Remove(key)
			if isobject(val) then
				set p_var_list(key)=val
			else
				p_var_list(key)=val
			end if
		if err.number<>0 then
			echo err.description
		end if
	End sub
	'==================================================
	'把数组组合成键值对象
	'==================================================
	public Function getKeyVal(keyarr,valuearr)
			set kvarr = server.CreateObject("Scripting.Dictionary")
			if isarray(keyarr) and isarray(valuearr) then
				for i=0 to ubound(keyarr)
					kvarr(keyarr(i))=valuearr(i)
				next
			else
				echoerr 0,"组合格式错误!"
				exit function
			end if
			set getKeyVal=kvarr
			set kvarr=nothing
	End Function
	'===============================================================================
	'包含文件
	'在设置模板的时候首先把里面的包含标签替换
	'===============================================================================
	private function includefile(str)
		'bakon error resume next
		p_reg.Pattern =  p_tag_l & "include(\s+?)file=[\""|\'](\S*?)[\""|\'](\s*?)" & p_tag_r 
		set matches=p_reg.Execute(str)
		if matches.count<1 then includefile=str end if
		For Each Match in Matches      ' Iterate Matches collection
			s_str=match '保存在模板文件中查到的包含标签
			m_filestr= match.SubMatches(1) '取出包含的文件名
			'判断要包含的文件是否存在
				set fs = createobject("Scripting.FileSystemObject")
			if fs.FileExists(server.mappath(p_tpl_dir  &"/"& m_filestr)) then
				'读取包含的文件并替换标签
				temstr = ReadFromTextFile(p_tpl_dir  &"/"& m_filestr,p_charset)
				if haveinclude(temstr) then temstr=includefile(temstr)	end if  '递归包含文件
				str=replace(str,s_str,temstr)'替换模板中的包含标签
			else
			response.write "<b>ASPTemplate Error: File [" & server.mappath(p_tpl_dir  &"/"& m_filestr) & "] does not exists!</b><br>"
			end if
		Next
		includefile=str
	end function
	'===============================================================================
	'判断字符串中是否有包含标签,如果有就返回true，否则返回false
	'===============================================================================
	private function haveinclude(str)
		p_reg.IgnoreCase = True
		p_reg.Global = True
		p_reg.Pattern =  p_tag_l &  "include(\s+?)file=\""(\S+?)\""(\s*?)"  & p_tag_r 
		set matches=p_reg.Execute(str)
		if matches.count<1 then
			 haveinclude=false
		else
			 haveinclude=true
		end if
	end function
	'================================================
	'解析模板内容
	'=================================================
	private Function jiexiTpl()
		p_tpl_content=includefile(p_tpl_content)'包含文件
		p_tpl_content=reurltag(p_tpl_content)
		p_tpl_content=precodetag(p_tpl_content)
		p_tpl_content=ifTag(p_tpl_content)
		p_tpl_content=ifElseTag(p_tpl_content)
		p_tpl_content=foreachTag(p_tpl_content)
		p_tpl_content=looptag(p_tpl_content)
		p_tpl_content=htmlselect(p_tpl_content)
		p_tpl_content=htmlradio(p_tpl_content)
		'扩展cms内容输出标签
		set tpltag=new QuickTag
		p_tpl_content=tpltag.run(p_tpl_content)
		set tpltag=nothing
		'扩展cms内容输出标签
		p_tpl_content=jiexiShortTag(p_tpl_content)
		p_tpl_content=jiexivar(p_tpl_content)
		p_tpl_content=regtplstr(p_tpl_content)
		p_tpl_content=Endjiexi(p_tpl_content)
		jiexiTpl=p_tpl_content
	end function
	'==========================
	'伪静态处理
	'===========================
	public Function regtplstr(str)
		'判断如果是前台就输出伪静态
		if isobject(seoobj) then
			if seoobj("cfg_weijingtai")="1" then	
				if  seoobj("cfg_spider")<>"1" then			
					for each a in regarr 
						ta=split(a,"##",2)
						if ubound(ta)>0 then 
							p_reg.Pattern = ta(0)
							str= p_reg.Replace(str,ta(1))	
						end if
					next
				else
					if getbot<>"" then
						for each a in regarr 
							ta=split(a,"##",2)
							if ubound(ta)>0 then 
								p_reg.Pattern = ta(0)
								str= p_reg.Replace(str,ta(1))	
							end if
						next
					end if
				end if
			end if
		end if
		'伪静态
		regtplstr=str
	End Function
	'=================================================
	'解析字符串模板
	'==================================================
	public function show(str)
			p_tpl_content=str
			str=jiexiTpl()
			response.Write str
			debugstr()
	end function
	'=================================================
	'解析字符串模板
	'==================================================
	private Function debugstr()
		if debug then
		end_time=timer()
		time_ijob=FormatNumber((end_time-start_time)*1000,3)
		'输出执行的sql语句
		runsqlstr="<ul>"
		for each a in db.kl_sqlobj
			runsqlstr=runsqlstr&"<li style='padding-left:50px;'>"&a&"、"&db.kl_sqlobj(a)&"</li>"
		next 
		debugshow=""
		if p_errstr<>"" then
		 debugshow="display:block;"
		else
		 debugshow="display:none;"
		end if
		runsqlstr=runsqlstr&"</ul>"
		runtime="<div id='debugsqlshow' style=' border:solid 1px #ccc;width:auto; height:40px; line-height:40px; text-align:center; position:fixed;_position:absolute;_bottom:auto;_top:expression(eval(document.documentElement.scrollTop+document.documentElement.clientHeight-this.offsetHeight-(parseInt(this.currentStyle.marginTop,10)||0)-(parseInt(this.currentStyle.marginBottom,10)||0))); right:0px; bottom:0px; cursor:pointer; font-size:20px; text-align:center;font-weight:bolder;z-index:8; background:#fff;'>执行"&db.kl_sqlnum&"个sql语句,执行时间：<font color=""#ff0000"">"&time_ijob&"</font> 毫秒<div>"
		response.Write "<style>*html{background-image:url(about:blank);background-attachment:fixed;}#debugsql ul li,#debug ul li{ border:none;border-bottom: solid 1px #EDEDED;line-height: 20px;padding: 2px 0px;}</style><div id='debug' style='z-index:9; position:fixed;_position:absolute;_bottom:auto;_top:expression(eval(document.documentElement.scrollTop+document.documentElement.clientHeight-this.offsetHeight-(parseInt(this.currentStyle.marginTop,10)||0)-(parseInt(this.currentStyle.marginBottom,10)||0))); left:0px; "&debugshow&" bottom:0px; width:500px; height:300px; padding:10px; background:#fff; border:solid 3px #ccc; overflow:auto;'><div id='debugclose' style='width:30px; height:30px; position:absolute; right:0px; top:0px; cursor:pointer; font-size:20px; text-align:center;font-weight:bolder;' >X</div><ul>"&p_errstr&"</ul></div><div id='debugshow' style='width:100px; height:40px; line-height:40px; text-align:center; position:fixed;_position:absolute;_bottom:auto;_top:expression(eval(document.documentElement.scrollTop+document.documentElement.clientHeight-this.offsetHeight-(parseInt(this.currentStyle.marginTop,10)||0)-(parseInt(this.currentStyle.marginBottom,10)||0))); left:0px; bottom:0px; cursor:pointer; font-size:20px; text-align:center;font-weight:bolder;z-index:8; background:#fff;border:solid 1px #ccc;'>DEBUG</div><div id='debugsql' style='z-index:9; position:fixed;_position:absolute;_bottom:auto;_top:expression(eval(document.documentElement.scrollTop+document.documentElement.clientHeight-this.offsetHeight-(parseInt(this.currentStyle.marginTop,10)||0)-(parseInt(this.currentStyle.marginBottom,10)||0))); right:0px; display:none; bottom:0px; width:100%; height:300px; padding:10px; background:#fff; border:solid 3px #ccc; overflow:auto;'><div id='debugsqlclose' style='width:30px; height:30px; position:absolute; right:0px; top:0px; cursor:pointer; font-size:20px; text-align:center;font-weight:bolder;' >X</div>"&runsqlstr&"</div>"&runtime&"<script charset='utf-8' src='/admin/js/debug.js'></script>"
		end if	
	end Function
	'==================================================
	'解析模板文件
	'==================================================
	public Function display(tplfile)
		nu=instrrev(tplfile,".")
		if nu=0 then 
			tplfile=tplfile&p_tpl_suffix
		else
			tplfile=mid(tplfile,1,nu-1)&p_tpl_suffix
		end if
		'这里解析的顺序不能错
		p_tpl_file=tplfile
		checkTplDirAndFile()'载入模板
		str=jiexiTpl()
		response.Write str
		debugstr()
	end Function
	'==================================================
	'输出错误
	'==================================================
	'==================================
	'echoErr函数
	'功能：把不同的错误级别输出
	'==================================
	Function echoErr(errnum,errstr)
		p_errstr=p_errstr&"<li>"&errstr&"</li><li>"&"Error Description:"&err.description&"</li>"
			select case errnum
				case 0'致命错误
					kl_err="Error Description:"&err.description
					response.Write errstr&"<br>"
					response.Write kl_err&"<br>"
					response.End()	
				case 1'一般错误
				'	kl_err="Error Description:"&err.description
				'	response.Write errstr&"<br>"
				'	response.Write kl_err&"<br>"
						
				case else'其它
				'	response.Write errstr&"<br>"
				'	response.Write("<br>")
			end select
		err.clear
	End Function
	'===============================================================================
	'变量过滤器
	'@param tplvars模板变量将要赋值的字符串
	'@param funcname处理函数
	'@param param函数的参数字符串
	'===============================================================================	
	public Function filterVar(val,funcname,param)
			filterVar=FilterFunc(val,funcname,param)
	End Function
	'===============================================================================
	'取标签中的参数
	'@param str包含标签中键的字符串
	'@param key参数所在的键值
	'===============================================================================	
	public Function getTagParam(str,key)
		str1=""
		p_reg.Pattern ="([\s\S]*?)"&key&"=[\""|\']([\s\S]*?)[\""|\']([\s\S]*?)"	
		set ms=p_reg.Execute(str)
		if ms.count>0 then
		str1=jiexivar(ms(0).SubMatches(1))'取sql语句
		str1=replace(str1,"&","'")
		end if
		set ms=nothing
		getTagParam=str1
	End Function
	'=====================================================
	'函数名称:ReadTextFile 
	'作用:利用AdoDb.Stream对象来读取UTF-8格式的文本文件 
	'====================================================
	Public function ReadFromTextFile (FileUrl,CharSet) 
		dim str 
		set stm=server.CreateObject("adodb.stream") 
		stm.Type=2 '以本模式读取 
		stm.mode=3 
		stm.charset=CharSet 
		stm.open 
		stm.loadfromfile server.MapPath(FileUrl) 
		str=stm.readtext 
		stm.Close 
		set stm=nothing 
		ReadFromTextFile=str 
	end function 
	'================================================== 
	'函数名称:WriteToTextFile 
	'作用:利用AdoDb.Stream对象来写入UTF-8格式的文本文件 
	'===================================================
	Public Sub WriteToTextFile (FileUrl,byval Str,CharSet) 
		set stm=server.CreateObject("adodb.stream") 
		stm.Type=2 '以本模式读取 
		stm.mode=3 
		stm.charset=CharSet 
		stm.open 
		stm.WriteText str 
		stm.SaveToFile server.MapPath(FileUrl),2 
		stm.flush 
		stm.Close 
		set stm=nothing 
	end Sub 
	'===============================================================================
	'清空没有替换的变量
	'===============================================================================	
	Public Function Endjiexi(str)
		p_reg.Pattern = "\'#\'|""#"""    
		str= p_reg.Replace(str, "'javascript:void(0);'")'去掉锚点
		if isobject(seoobj) then
			if seoobj("cfg_pageyasuo")="1" then
				p_reg.Pattern = "\r*\n\s*"  '页面压缩	
				str= p_reg.Replace(str, "")			
			else
				p_reg.Pattern = "\r*\n\s*\r*\n"  '去掉空行
				str= p_reg.Replace(str, vbCrLf)		
			end if	
		end if
		p_reg.Pattern = p_var_l&"\S*"&p_var_r    
		str= p_reg.Replace(str, "")			 '把没有赋值的变量标签替换成空
		'输出原样标签中的内容
		for each a in p_var_list("precode").keys
			str=replace(str,a,p_var_list("precode")(a))
		next
		Endjiexi=str
	End Function
	'===============================================================================
	'原样输出代码
	'===============================================================================	
	Private Function precodetag(str)
		p_reg.Pattern="<precode>([\s\S]*?)</precode>" 
 		set matches=p_reg.execute(str)
		for each match in matches
			p_var_list("precode")(md5(match.SubMatches(0),32))=jiexivar(match.SubMatches(0))
			str=replace(str,match,md5(match.SubMatches(0),32))
		next
		precodetag=str	
	End Function
	'================================================== 
	'函数名称:looptag 
	' 
	'===================================================
	private function looptag(str)
		'on error resume next
		p_reg.Pattern=p_tag_l & "loop(.*?)" & p_tag_r&"([\s\S]*?)" & p_tag_l & "/loop" &p_tag_r
		set matches=p_reg.execute(str)
		for each match in matches
				temname=getTagParam(Match.SubMatches(0),"name")
				iteration=getTagParam(Match.SubMatches(0),"iteration")
				'if not isarray(p_var_list(temname)) then :echoerr 1,"error: var: ' "&temname&" ' it is no array!"
				temobjarr=p_var_list(temname)'对象数组
				temvar=getTagParam(Match.SubMatches(0),"var")'循环时用的变量对象
				str1=""'处理过的内容
				if isarray(temobjarr) then
					for i=0 to ubound(temobjarr)-1
							restr=Match.SubMatches(1)'loop的内容
							if not isobject(temobjarr(i)) then exit for
							'set obj=temobj(objkey)
							'替换迭代变量
								p_reg.Pattern =p_var_l &iteration& p_var_r
								restr=p_reg.replace(restr,i+1)
							'替换键值变量
							for each k in temobjarr(i).keys'循环对象obj中元素并替换成值
								zhvar=p_var_l & temvar& "." & k &"(.*?)"& p_var_r
								p_reg.Pattern = zhvar
								set temm=p_reg.execute(restr)
								for each m in temm
									c=isHaveFilteFunc(m)
									if isarray(c) then
										
										restr=replace(restr,m,filtervar(temobjarr(i)(k),c(1),c(2)) )
									else
										restr=replace(restr,m,temobjarr(i)(k))
									end if
								next
							next
							restr=jiexivar(restr)'在解析短标签前把里面的全局变量解析成数据
							restr=jiexiShortTag(restr)'处理短标签
							str1=str1&restr
					next
				end if
				str=replace(str,match,str1)
		next
		looptag=str
	End Function
	'======================================
	'对语法中的短标签进行处理，新加的短标签也加在这里
	'======================================
	public Function jiexiShortTag(str)
		'处理eq短标签
		jiexiShortTag=eqtag(str)
		
	end Function
	'==========================
	'模板eq短标签替换
	'============================
	private function eqtag(str)
		'str=jiexivar(str)
		Set p_eqreg = New RegExp 
		p_eqreg.Pattern ="<eq([\s\S]*?)>([\s\S]*?)</eq>"
		p_eqreg.IgnoreCase = True
		p_eqreg.Global = True
		set eqm=p_eqreg.execute(str)
		if eqm.count>0 then
			for each m in eqm
				on error resume next
				err.clear
				bol=eval(replace(m.submatches(0),"neq","<>"))
				if err.number<>0 or not bol then
					err.clear
					str=replace(str,m,"")
				else
					str=replace(str,m,m.submatches(1))			
				end if
			next
		end if
		eqtag=str
		set p_eqreg=nothing
	end function
	'==========================
	'模板reurl重定位url地址
	'============================
	private function reurltag(str)
		Set p_eqreg = New RegExp 
		p_eqreg.Pattern ="<reurl(\s+?)url=[\'|\""](.*?)[\'|\""](\s+?)([\s\S]*?)/?>"
		p_eqreg.IgnoreCase = True
		p_eqreg.Global = True
		set eqm=p_eqreg.execute(str)
		if eqm.count>0 then
			for each m in eqm
				on error resume next
				err.clear
				bol=eval(jiexivar(m.submatches(3)))
				if err.number<>0 or not bol then
					err.clear
					str=replace(str,m,"")
				else
					reurl regtplstr(m.submatches(1))
				end if
			next
		end if
		set p_eqreg=nothing	
		reurltag=str
	end function
	'==========================
	'模板select控件输出
	'============================
	private Function htmlselect(str)
		p_reg.Pattern="<htmlselect(.*?)/?>"
		set m=p_reg.execute(str)
		for each mm in m
			paramstr=mm.SubMatches(0)
			selkey=getTagParam(paramstr,"options")
			dim objarr
			if p_var_list.Exists(selkey) then
				set objarr=p_var_list(selkey)
				selname=getTagParam(paramstr,"name")
				selid=getTagParam(paramstr,"id")
				selected=getTagParam(paramstr,"selected")
				selstr="<select name='"&selname&"' id='"&selid&"'>"
				for each key in objarr.keys
					if cstr(p_var_list(selected))<>cstr(key) then
						selstr=selstr&"<option value='"&key&"'>"&objarr(key)&"</option>"
					else
						selstr=selstr&"<option value='"&key&"' selected>"&objarr(key)&"</option>"
					end if
				next
				selstr=selstr&"</select>"
				str=replace(str,mm,selstr)
			else
				'echoerr 1,"htmlselect key is null"
				str=replace(str,mm,"<span style='color:red;'>htmlselect key '"&selkey&"' is null</span>")
			end if
		next
		htmlselect=str
	End Function	
	'==========================
	'模板radio控件输出
	'============================
	private Function htmlradio(str)
		p_reg.Pattern="<htmlradio(.*?)/?>"
		set m=p_reg.execute(str)
		for each mm in m
			paramstr=mm.SubMatches(0)
			selkey=getTagParam(paramstr,"options")
			dim objarr
			if p_var_list.Exists(selkey) then
				set objarr=p_var_list(selkey)
				selname=getTagParam(paramstr,"name")
				selid=getTagParam(paramstr,"id")
				selected=getTagParam(paramstr,"selected")
				selstr=""
				for each key in objarr.keys
					if p_var_list(selected)&""<>key&"" then
						selstr=selstr&"<input type='radio' name='"&selname&"' value='"&key&"' /><span>"&objarr(key)&"</span>"
					else
						selstr=selstr&"<input type='radio' name='"&selname&"' value='"&key&"' checked='checked' /><span>"&objarr(key)&"</span>"
					end if
				next
				str=replace(str,mm,selstr)
			else
				'echoerr 1,"htmlselect key is null"
				str=replace(str,mm,"<span style='color:red;'>htmlradio key '"&selkey&"' is null</span>")
			end if
		next
		htmlradio=str
	End Function
	'取标签库中的参数
	function tagparam(str)
		if isobject(p_var_list("tagparam")) then
			set temobj=p_var_list("tagparam")
			tagparam=temobj(str)
		else
			tagparam=""
		end if
	end function	
end class
%>