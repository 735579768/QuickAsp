<%
class AspTplPlug
	private tpl_str'模板字符串
	private	p_regexp'正则对象
	 Property Let templatestr(str)
		tpl_str=str
	 End Property 
	 Property Get templatestr
		templatestr=tpl_str
	 End Property 
	private sub class_Initialize
		Set p_regexp = New RegExp
		p_regexp.Global = true
		p_regexp.IgnoreCase = True
	end sub
	
	Function run()
		loopsql()
	End function
'//////////////////////////////////loop code start///////////////////////////////////////////////////
'===============================================================================
'loop万能循环
'===============================================================================
	Function loopsql()
		p_regexp.Pattern =  "<\!--\{loop([\s\S]*?)\}-->([\s\S]*?)<\!--\{/loop\}-->" 
		p_regexp.Global = true
		'查询模板中的所有loop块
		set matches=p_regexp.Execute(tpl_str)
		if matches.count>0 then 
		redim looparr(Matches.count)
			'循环处理loop块
			for i=0 to Matches.count-1
			'取loop块中的参数
				temsql=getloopparam(Matches(i),"loop","sql")
				temnum=getloopparam(Matches(i),"loop","num")
				temiterator=getloopparam(Matches(i),"loop","iterator")
				temtitlelen=getloopparam(Matches(i),"loop","titlelen")
				temcontentlen=getloopparam(Matches(i),"loop","contentlen")
				if temnum="" then:temnum=0:else:temnum=Cint(temnum):end if
				if temtitlelen="" then:temtitlelen=30:else:temtitlelen=Cint(temtitlelen):end if
				if temcontentlen="" then:temcontentlen=30:else:temcontentlen=Cint(temcontentlen):end if
				'处理单个loop中的内容
				vostr=volist(Matches(i).SubMatches(1),temsql,temnum,temiterator,temtitlelen,temcontentlen)
				'把这个loop块中的内容换为指定的内容
				tpl_str=replace(tpl_str,Matches(i),vostr)
			next
		end if
'		For Each Match in Matches      ' Iterate Matches collection
'			xh_str= Match.SubMatches(0) '取出循环内容
'		Next
		'echo looparr(1)(0)
	End Function	
'===============================================================================
'取标签中的参数
'@param str包含标签的字符串
'@param tag标签
'@param key参数所在的键值
'===============================================================================	
	Function getloopparam(str,tag,key)
		str1=""
		Set reg = New RegExp 
		reg.Global = true
		reg.Pattern =  "<\!--\{"&tag&"([\s\S]*?)"&key&"=\'([\s\S]*?)\'([\s\S]*?)\}-->" 
		set ms=reg.Execute(str)
		if ms.count>0 then
		str1=ms(0).SubMatches(1)'取sql语句
		end if
		set reg=nothing
		getloopparam=str1
	End Function
'===============================================================================
'循环单个loop中的内容并返回处理过的内容
'===============================================================================	
	Function volist(str,sql,num,iterator,titlelen,contentlen)
		str1=""'一个块最终处理好后放的变量
		str2=""'循环字段替换时用到的
		set vors=db.query(sql)
		if num=0 then num=vors.recordcount
		if num>vors.recordcount then num=vors.recordcount
		'取查询数据集的字段
		fieldarr=getTableField(sql)
			if vors.recordcount>0 then
			'循环记录集
				for i=0 to num-1
					if vors.eof  then exit for
					str2=str
					'迭代序号
					str2=replace(str2,"{{"&iterator&"}}",i+1)
					'循环记录集中的字段并替换为指定的值
					for j=0 to ubound(fieldarr)-1
						fieldstr=fieldarr(j)(0)
	if instr(fieldstr,"content")>0 then: str2=replace(str2,"{{infocontent}}",left(removehtml(vors(fieldstr)&""),contentlen)	):end if
	if instr(fieldstr,"title")>0 then: str2=replace(str2,"{{infotitle}}",left(vors(fieldstr)&"",titlelen)):end if
						str2=replace(str2,"{{"&fieldstr&"}}",vors(fieldstr)&"")
					next
					str1=str1+str2
					str2=""
				vors.movenext
				next
			end if
		set vors=nothing
		volist=str1
	End Function	
'正则最终输出的模板字符串
	Function regtplstr()
	if isobject(regarr) then
		for each a in regarr 
			ta=split(a,"##",2)
			if ubound(ta)>0 then 
				p_regexp.Pattern = ta(0)
				tpl_str= p_regexp.Replace(tpl_str,ta(1))	
			end if
		next
	end if
		'伪静态
	End Function
'//////////////////////////////////loop code end///////////////////////////////////////////////////
end class
%>