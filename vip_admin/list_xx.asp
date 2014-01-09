<!--#include file="lib/AdminInIt.asp"-->
<%
'接收类型id  分类id   二个参数
if G("cat_id")="" then echo "<script>alert('cat_id is not null');window.history.go(-1);</script>": die(""):end if
dim where,searchform
where=" where 1=1 and recycling=0 " 
set catrs=newdb.table("kl_cats").fild("type_id").where("cat_id="&G("cat_id")).sel()
typeid=catrs("type_id")
newtpl.assign "type_id",typeid
set catrs=nothing
'catid=G("cat_id")
set typers=newdb.table("kl_content_types").where("type_id="&typeid).sel()
fieldtag=typers("fieldtag")&""
type_name=typers("type_name")&""
datatable=typers("data_table")&""
'==========================================处理提交过来的请求start===========
if G("tj")<>"" then
	if G("tj")="yes" then newdb.query("update "&datatable&" set hometj=1 where id="&G("temid"))
	if G("tj")="no" then newdb.query("update "&datatable&" set hometj=0 where id="&G("temid"))
end if
if G("act")="del" then
'newdb.query("delete from "&datatable&" where id="&G("temid"))
newdb.query("update  "&datatable&" set recycling=1 where id="&G("temid"))
end if
if G("act")="batchdel" then
arr=split(G("batchid"),",")
for i=0 to ubound(arr)
'newdb.query("delete from "&datatable&" where id="&arr(i))
newdb.query("update  "&datatable&" set recycling=1 where id="&arr(i))
next
end if
'==========================================处理提交过来的请求 end ==========
'=====================================================
'输出添加表单
Set reg = New RegExp 
reg.IgnoreCase = True
reg.Global = True
reg.Pattern ="<field(.*?)/>"
Set Matches = reg.Execute(fieldtag)

'输出表头
'=搜索表单框
searchform=""
'======================输出表头start==================================
titledata="<tr bgcolor='#FBFCE2'><td>选择</td>"
For Each Match in Matches 
	nme=getFieldParam(Match,"name")
	title=getFieldParam(Match,"title")
	descr=getFieldParam(Match,"descr")
	datatype=getFieldParam(Match,"datatype")
	listshow=getFieldParam(Match,"listshow")
	search=getFieldParam(Match,"search")
	if listshow="1" then
	titledata=titledata&"<td>"&title&"</td>"	
	end if
	'查询要进行搜索的字段
	if search="1" then
	searchform=searchform&title&"<input type='text' name='"&nme&"' value='"&G(nme)&"'>"	
	if G(nme)<>"" then  where=where&" and "&nme&" like '%"&G(nme)&"%' "
	end if
next 
titledata=titledata&"<td width='10%'>操作</td></tr>"
newtpl.assign "titledata",titledata
'=====================输出表头 end===================================
newtpl.assign "searchform",searchform
'===========================
'=表单分类搜索条件
if G("hometj")<>"2" and G("hometj")<>""  then
if G("hometj")="1" then newtpl.assign "hometj1","selected"
if G("hometj")="0" then newtpl.assign "hometj0","selected"
where=where&" and hometj="&G("hometj")&" "
end if
where=where&" and kl_cats.cat_id="&G("cat_id")
sql="select  kl_archives.cat_id as cat_id,kl_archives.type_id as type_id,* from ("&datatable&" inner join kl_cats on "&datatable&".cat_id=kl_cats.cat_id ) inner join kl_content_types on kl_archives.type_id=kl_content_types.type_id   "&where&" order by fbdate desc,id desc"
Set mypage=new xdownpage
mypage.getconn=newdb.kl_conn
mypage.getsql=sql
mypage.pagesize=20
set arcrs=mypage.getrs()
pagenav=mypage.getshowpage()
listdata=""
'=====================输出列表数据 start===================================
	for i=0 to 19
		if not arcrs.eof then
			listdata=listdata&"<tr><td><input  type='checkbox' class='np checkid'  value='"&arcrs("id")&"' /></td>"
	
			For Each Match in Matches 
				nme=getFieldParam(Match,"name")
				title=getFieldParam(Match,"title")
				descr=getFieldParam(Match,"descr")
				datatype=getFieldParam(Match,"datatype")
				listshow=getFieldParam(Match,"listshow")
				func=getFieldParam(Match,"func")'内容过滤函数
				if listshow="1" then
					val=removehtml(arcrs(nme))	
					if nme="cat_id" then val=arcrs("cat_name")'把分类id显示成名字
					if nme="type_id" then val=arcrs("type_name")'把类型id显示成名字
					if func<>"" then
						val=funcFilter(func,val&"")
					else
						val=left(val,20)
					end if
					listdata=listdata&"<td>"&val&"</td>"	
				end if
			next 
			listdata=listdata&"<td><a href='edit_xx.asp?id="&arcrs("id")&"&type_id="&arcrs("type_id")&"&cat_id="&arcrs("cat_id")&"'><img src='images/edit.png' title='修改信息' alt='修改信息' onclick=';' style='cursor:pointer' border='0' width='16' height='16'></a>    <a href='/view.asp?id="&arcrs("id")&"_"&arcrs("type_id")&"' target='_blank'><img src='images/check.gif' title='预览' alt='预览' onclick='' style='cursor:pointer' border='0' width='16' height='16'></a>    <a href='javascript:void(0);'><img src='images/recycling.gif' dataid='"&arcrs("id")&"' title='移到回收站' class='del' alt='移到回收站' onclick=';' style='cursor:pointer' border='0' width='30' height='20' class='delarticle'></a></td></tr>"
	arcrs.movenext
	end if
	next
'=====================输出列表数据 end===================================
newtpl.assign "listdata",listdata
newtpl.assign "pagenav",pagenav
'表单过滤分类条件
newtpl.assign "selcatid",getArcCatSel()
newtpl.display("list_xx.html")
'=================================本页函数库=====================================================
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
'====================================
'=列表中的数据过滤器
'=====================================
function funcFilter(func,val)
	select case func
	'推荐文章
		case "hometj"
			if val="1" then
				 val="<a class='tj' href='javascript:void(0);' data='no' dataid='"&arcrs("id")&"'  style='color:red;'>已推荐</a>"
			else
				val="<a class='tj' data='yes' href='javascript:void(0);' dataid='"&arcrs("id")&"' style='color:#000;;'>未推荐</a>"
			end if
	'判断文章是不是有图片
		case "haveimg"
			if arcrs("arcpic")<>"" then
				val="<u><a href='edit_xx.asp?id="&arcrs("id")&"&type_id="&arcrs("type_id")&"&cat_id="&arcrs("cat_id")&"'>"&val&"</a></u><div class='catimg'><img class='haveimg' src='images/haveimg.gif' style='cursor:pointer;' width='12' height='12' alt='分类封面有图片显示' title='分类封面有图片显示' /><div class='catdaimg' ><img src='"&arcrs("arcpic")&"' width='' height='' /></div></div>"	
			else
				val="<u>"&val&"</u>"
			end if
		
		case else val=left(val,20)
	end select
	funcFilter=val
end function
%>