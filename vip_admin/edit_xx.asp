<!--#include file="lib/AdminInIt.asp"-->
<% if session("APP")<>"true" then reurl("/") end if %>
<%
'接收类型id  分类id  id 三个参数
typeid=G("type_id")
id=G("id")
newtpl.assign "id",id

set typers=newdb.table("kl_content_types").where("type_id="&typeid).sel()
fieldtag=typers("fieldtag")&""
type_name=typers("type_name")&""
data_table=typers("data_table")&""
'===============================
'更新数据
	if G("act")="updxx"  then
		set formobj=newdb.table(data_table).where("id="&id).create()
		

		
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
		else
		
			'delete pic start
			set temrs=newdb.query("select arcpic from kl_archives where id="&id)
			if not temrs.eof  then
				tempic=trim(temrs("arcpic")&"")
				set temrs=nothing
				if  tempic<>"" and trim(G("arcpic"))<>tempic then
						DeleteFile(tempic )
				end if
			end if
			'delete pic send
				
		end if
		'如果图片为空则从文章中提取第一个图片 end
		
		formobj("uddate")=FormatDate(now,2)&""
		newdb.formdata=formobj
		result=newdb.save()
		if result then
			alertMsgGo UPDATE_SUCCESS_STR,"list_xx.asp?cat_id="&G("cat_id")
			'echo "<script>alert('"&&"');window.location='list_xx.asp?cat_id="&G("cat_id")&"';<\/script>"
		else
			echoErr()
			AlertMsg UPDATE_FAIL_STR
		end if
	end if

'====================

set datars=newdb.table(data_table).where("id="&id).sel()

if datars.eof then :echo "<script>window.history.go(-1);</script>":die(""):end if
'====================
'输出添加表单
Set reg = New RegExp 
reg.IgnoreCase = True
reg.Global = True
reg.Pattern ="<field(.*?)/>"
Set Matches = reg.Execute(fieldtag)
editform=""
For Each Match in Matches 
	nme=getFieldParam(Match,"name")
	title=getFieldParam(Match,"title")
	descr=getFieldParam(Match,"descr")
	datatype=getFieldParam(Match,"datatype")
	addshow=getFieldParam(Match,"addshow")
	if addshow="1" then
	editform=editform&gettypeform(nme,datars(nme),title,descr,datatype)
	end if
next 
newtpl.assign "editform",editform
'输出添加表单
'===============================
	if G("isaddxx")="true"  then
		err.clear
		cat_id=G("cat_id")
		sql="select b.data_table as datatable from kl_cats as a inner join kl_content_types as b on a.type_id=b.type_id where a.cat_id="&cat_id
		set rs=newdb.query(sql)
		datatable=rs("datatable")
		
				set uprs=server.createobject("adodb.recordset")
				uprs.open "select * from "&datatable,olddb.idbconn,1,3
				uprs.addNew
				for each key in request.Form()
					 if  key<>"isaddarticle" then
						val=G(key)
						uprs(key)=val
					 end if
				next
				uprs("fbdate")=FormatDate(now,2)
				uprs("uddate")=FormatDate(now,2)
				if(G("arcdescr")="") then uprs("arcdescr")=left(removehtml(G("arccontent")),30)
				uprs.update
				
				if err.number<>0 then
					echoErr()
					AlertMsg(ADD_FAIL_STR)
					err.clear
				else
					AlertMsg(ADD_SUCCESS_STR)
				end if
	end if
newtpl.display("edit_xx.html")
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
				gettypeform="<tr><td align='right'>"&title&":</td><td><input name='"&nme&"' value='"&val&"'  type='text' />"&descr&"</td></tr>"
		end select
	End Function
%>