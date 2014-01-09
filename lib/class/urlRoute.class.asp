<%
'==========================================================================
'文件名称：Accessdb.class.asp
'功　　能：数据库操作类
'===author 赵克立
'===blog:http://zhaokeli.com/
'===version.v1.0.0
'版权声明：可以在任意作品中使用本程序代码，但请保留此版权信息。
'          如果你修改了程序中的代码并得到更好的应用，请发送一份给我，谢谢。
'==========================================================================
'const db_path="data/#aspadmindata.mdb"
Class urlRoute
	public urlmodule
	public urlaction
	public urljiange
	private urlstr
	'==================================
	'初始化类函数
	'功能：初始化数据
	'==================================
	Private Sub Class_Initialize()
		urlmodule="index"
		urlaction="index"
		urljiange="_"
	End Sub
	Private Sub Class_Terminate()
	
	End Sub
	
	Public Property Let action(a)
		urlaction=a
	end property
	Public Property Get action()
		action=urlaction
	End Property
	'==================================
	'属性
	'功能：更新数据对象
	'返回值：没有
	'==================================
	Public Property Let module(a)
		urlmodule=a
	End Property
	Public Property Get module()
		module=urlmodule
	End Property
	'==================================
	'query函数
	'功能：查询记录集
	'==================================
	Function seturlstr(str)
		urlstr=str&urljiange
		a=split(urlstr,urljiange)
		b=ubound(a)
		if urlstr="" then
			if b=0  then
				urlmodule=urlstr
			elseif b>=2 then
				urlmodule=a(0)
				urlaction=a(1)
			elseif b>=0 then
				urlmodule=a(0)
			end if
		else
			urlmodule="index"
			urlaction="index"
		end if
	End Function
End Class
%>