<%

'退出登陆
if getparam("act")="exit" Then
destroyCookies()
echo "<script>parent.window.location.reload();</script>"
die("")
end if


'登陆错误信息
dim logerrmsg:logerrmsg=""
'验证登陆
dim Uname,Upwd,zhiye,rs,sqlstr
Uname=G("loginname")
Upwd=G("loginpwd")
numcode=G("numcode")
loginstate=G("loginstate")


'如果有用户名和密码传过来的话进行验证
if Uname<>"" and Upwd<>"" and numcode<>"" Then
	'验证码检验
	if numcode<>trim(Session("numcode")) then 
		AlertMsg("验证码错误！")
		die("")
	end if
set rs=olddb.GetRecord(suffix & "admin","*","username='"&Uname&"'","",0)
	if not rs.eof Then
		dim md5pwd:md5pwd=md5(Upwd,32)
		if rs("password")<> md5pwd Then
			AlertMsg("密码错误！")
			die("")
		else
		'echo rs("password")&"--"&md5pwd
			'更新登陆次数
			result=olddb.UpdateRecord("kl_admin","id="&rs("id"),array("logintimes:"&(rs("logintimes")+1),"lastdate:"&now()))
			'记录登陆日志
			result=olddb.AddRecord("kl_admin_log",array("uname:"&rs("username"),"loginip:"&getip(),"qx_id:"&rs("qx_id")))
			Session("admin_id")=rs("id")'保存管理员在数据表中的id值
			Session("adminqxid")=rs("qx_id")'保存管理员在数据表中的权限id值
			Session.Timeout=30
			Response.Cookies("adminid")=rs("id")
			Response.Cookies("U_name")=Uname
			Response.Cookies("U_pwd")=md5(Upwd,32)
			'求记录时间
			shijian=0
			select case loginstate
				case "0":
					shijian=0.2'10分钟
				case "1":
					shijian=0.5'半小时
				case "2":
					shijian=24'一天
				case "3":
					shijian=24*7'一周
				case "4":
					shijian=24*30'一月
			end select
			Response.Cookies("U_name").Expires=now()+(shijian/24)
			Response.Cookies("U_pwd").Expires=now()+(shijian/24)
		end if
	else
		logerrmsg="用户名不存在"
		AlertMsg("用户名不存在！")
		die("")
	end if
end if


'if Uname="" then call AlertMsgGo("用户名不能为空！","/admin/login.asp"):die("")
'if Upwd="" then call AlertMsgGo("用户名不能为空！","/admin/login.asp"):die("")
'if numcode="" then call AlertMsgGo("用户名不能为空！","/admin/login.asp"):die("")
'检查cookies验证登陆状
if not yanzhengCookies() then 
	login("")
end if
act=getparam("act")
if act="ajax" then
%>
<!-- #include file="ajax.asp" -->
<%
end if
'///////////////////////////////////////////////////////////////////////////////////////
	'检查cookies验证登陆状态
	function yanzhengCookies()
			if Request.Cookies("U_pwd")="" or Request.Cookies("U_name")="" then  '使用cookies验证登陆状态
				destroyCookies()
				yanzhengCookies=false
		else
			'验证cookies
			set rs=olddb.GetRecord(suffix & "admin","*","username='"&Request.Cookies("U_name")&"'","",0)
			if not rs.eof Then
				if rs("password") <> Request.Cookies("U_pwd") Then
					destroyCookies()
					yanzhengCookies=false
				else
		'更新登陆次数
					'result=olddb.UpdateRecord("kl_admin","id="&rs("id"),array("logintimes:"&(rs("logintimes")+1),"lastdate:"&now()))
					'记录登陆日志
					'result=olddb.AddRecord("kl_admin_log",array("uname:"&rs("username"),"loginip:"&getip(),"qx_id:"&rs("qx_id")))
					Session("admin_id")=rs("id")'保存管理员在数据表中的id值
					Session("adminqxid")=rs("qx_id")'保存管理员在数据表中的权限id值
					Session.Timeout=30
					yanzhengCookies=true
				end if
			end if
		end if
	end function
	function login(errstr)	
'		oldtpl.SetTemplateFile "login.html" '设置模板文件
'		oldtpl.SetVariable "adminDir","/"&adminDir&"/"
'		oldtpl.setvariable "errstr",errstr
'		oldtpl.Parse
'		set oldtpl = nothing
'		newtpl.assign "errstr",errstr
'		newtpl.assign "adminDir","admin/"
'		newtpl.display("login.html")
		echo "<script>window.parent.location='login.asp';</script>"
		die("")
	end function
%>
