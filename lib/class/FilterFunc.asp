<%
'================================
'过滤器函数
'================================
Function FilterFunc(val,funcname,param)
	set fireg=new regExp
	fireg.IgnoreCase = True
	fireg.Global = True
	temvar=val
	Select Case trim(funcname)
				case "left" 
						fireg.pattern="<.*?>|\s*|\r*\n\s*\r*\n"
						val=fireg.replace(val,"")
						set fireg=nothing
						val=replace(val,"&nbsp;","")
						if param="" then param=20
						temVar=left(val,Cint(param))
				case "empty" 
						if val="" then
							param=replace(param," eq ","=")
							if instr(param,"$")<>0 then
								fireg.pattern="(\$)([\w\.]+?)\s+?|(\$)([\w\.]+?)$"
								set ms=fireg.execute(param)
								for each a in ms
									param=replace(param,a,"{"&a&"}")	
								next  
								temvar=tpl.jiexivar(param)
							else
								temvar=param
							end if
						else
							temvar=val
						end if
				case "formatdate" 
						valarr=split(val," ")
							if instr(val,"/")<>0 then param="/"
							if instr(val,"-")<>0 then param="-"
						datenow=split(valarr(0),param)
						if ubound(datenow)=2 then
							if len(datenow(1))<2 then datenow(1)="0"&datenow(1)
							if len(datenow(2))<2 then datenow(2)="0"&datenow(2)
							newdate=datenow(0)&"/"&datenow(1)&"/"&datenow(2)
							temvar=newdate
						else
							temvar=valarr(0)
						end if
				case else 
						temvar=val
	end select
	if isnull(temvar) then temvar=""
	FilterFunc=temvar
	set fireg=nothing
End Function
%>