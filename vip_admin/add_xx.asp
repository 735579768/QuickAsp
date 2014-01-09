<!--#include file="lib/AdminInIt.asp"-->
<% if session("APP")<>"true" then reurl("/") end if %>
<%
'接收类型id  分类id   二个参数
typeid=G("type_id")
set typers=newdb.table("kl_content_types").where("type_id="&typeid).sel()
fieldtag=typers("fieldtag")&""
type_name=typers("type_name")&""
datatable=typers("data_table")&""
'===============================
'添加数据
	if G("act")="addxx"  then
		set formobj=newdb.table(datatable).create()
		formobj("fbdate")=FormatDate(now,2)
		formobj("uddate")=FormatDate(now,2)
		'如果图片为空则从文章中提取第一个图片 start
		if G("arcpic")="" then
			Set picreg = New RegExp 
			picreg.IgnoreCase = True
			picreg.Global = True
			picreg.Pattern="<img(.*?)/?>"
			set mats=picreg.execute(G("arccontent"))
			if mats.count>0 then
				formobj("arcpic")= newtpl.gettagparam(mats(0),"src")
			end if
			set picreg=nothing
		end if
		'如果图片为空则从文章中提取第一个图片 end
		newdb.formdata=formobj
		result=newdb.add()
		if result then
			AlertMsgGo ADD_SUCCESS_STR,"list_xx.asp?cat_id="&G("cat_id")
		else
			echoErr()
			AlertMsg ADD_FAIL_STR
		end if
	end if

'====================
'发布者和来源
uname=Request.Cookies("U_name")&""
set nirs=olddb.query("select top 1 * from kl_admin where username='"&uname&"'")
nicheng=cstr(nirs("nicheng")&"")
if nicheng="" then
	nicheng=uname
end if
set nirs=nothing
author=nicheng
arcsource="http://"&cstr(Request.ServerVariables("SERVER_NAME"))


'输出添加表单
Set reg = New RegExp 
reg.IgnoreCase = True
reg.Global = True
reg.Pattern ="<field(.*?)/>"
Set Matches = reg.Execute(fieldtag)
addform=""
For Each Match in Matches 
	nme=getFieldParam(Match,"name")
	title=getFieldParam(Match,"title")
	descr=getFieldParam(Match,"descr")
	datatype=getFieldParam(Match,"datatype")
	addshow=getFieldParam(Match,"addshow")
	'defaultdata  是xml中的一个键  含义是当前这个字段要有默认的数据他的值代表啦一个函数名字，如果为空则就不设置默认值 
	defaultdata=getFieldParam(Match,"defaultdata")
	if addshow="1" then
	val=""
	if defaultdata<>"" then
		val=formdefaultval(defaultdata)
	else
		if nme="arcauthor" then val=author 
		if nme="arcsource" then val=arcsource 	
	end if

	addform=addform&gettypeform(nme,val,title,descr,datatype)
	end if
next 
newtpl.assign "addform",addform
'输出添加表单

newtpl.display("add_xx.html")
'=================================本页函数库========
	public Function getFieldParam(str,key)
		Set p_reg = New RegExp 
		str1=""
		p_reg.Pattern ="([\s\S]*?)"&key&"=[\""|\']([\s\S]*?)[\""|\']([\s\S]*?)"	
		set ms=p_reg.Execute(str)
		if ms.count>0 then
		str1=ms(0).SubMatches(1)'取sql语句
		end if
		set ms=nothing
		getFieldParam=str1
	End Function
'==========================================
'返回表单类型
'==========================================
	public Function gettypeform(nme,val,title,descr,datatype)
		select case datatype
			case "text" 'text
				gettypeform="<tr><td align='right'>"&title&":</td><td><input name='"&nme&"' value='"&val&"' type='text' style='width:200px;' /></td></tr>"
			case "textarea" 'textarea
				gettypeform="<tr><td align='right'>"&title&":</td><td><textarea name='"&nme&"' style='width:500px; height:50px;'>"&val&" </textarea>"&descr&"</td></tr>"
			case "html" 'html数据
				gettypeform="<script>var editor;KindEditor.ready(function(K) {editor = K.create('textarea[name="""&nme&"""]', {'allowFileManager' : true,'uploadJson': 'editor/asp/upload_json.asp','fileManagerJson': 'editor/asp/file_manager_json.asp','allowFlashUpload':true,'allowFileManager':true,'filterMode':false,'allowPreviewEmoticons':true,'afterBlur':function(){this.sync();}});});</script><tr><td align='right'>"&title&":</td><td><textarea name='"&nme&"' style='width:710px;height:400px;visibility:hidden;'>"&val&"</textarea>"&descr&"</td></tr>"
			case "pic" '上传图片
				gettypeform="<script>var editor;KindEditor.ready(function(K) {K('#image1').click(function() {editor.loadPlugin('image', function() {editor.plugin.imageDialog({imageUrl : K('#url1').val(),clickFn : function(url, title, width, height, border, align) {K('#url1').val(url);editor.hideDialog();}});});});});</script><tr><td align='right'>"&title&":</td><td><input name='"&nme&"' type='text' value='"&val&"'  id='url1' value='' style='width:388px' /> <a href='javascript:void(0);' id='image1' class='button'>选择图片</a>"&descr&"</td></tr>"
			case "cat_id" '分类下拉菜单
				gettypeform="<tr><td align='right'>"&title&":</td><td>"&getArcCatSel()&descr&"</td></tr>"
			case "static" '分类下拉菜单
				gettypeform="<tr><td align='right'>"&title&":</td><td><input name='type_id' value='"&typeid&"'  type='hidden' />"&type_name&"</td></tr>"
			case default
				gettypeform="<tr><td>"&title&":</td><td><input name='"&nme&"' value='"&val&"'  type='text' />"&descr&"</td></tr>"
		end select
	End Function
	'生成表单时默认添加的数据
function formdefaultval(func)
	select case func
		case "zhaopin"
			formdefaultval="        	                1、建筑学本科学历；<br>                2、较强的方案创作能力和建筑美感，对设计理念、市场方向能敏锐的把握；<br>                3、善于接受新设计理念及概念创新，草图表达、语言沟通能力强，熟练运用CAD，Sketchup等设计软件，对初设、施工图有一定了解；<br>                4、工作认真负责，愿意与他人合作，抗压能力强。<br><br>                <span>简历投递渠道：</span>  有意者请将个人资料发至邮箱：henanlwrn@126.com<br>          "
		case default
			formdefaultval=""
		end select
end function
%>