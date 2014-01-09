<!--#include file="lib/AdminInIt.asp"-->
<%
''更新文章
	if G("isupdtarticle")="true" then
		id=G("id")
		cat_id=G("cat_id")
			set uprs=server.createobject("adodb.recordset")
			uprs.open "select * from kl_archives where id="&id,olddb.idbconn,0,2
			'bakon error resume next
			err.clear
		'delete pic start
		set temrs=olddb.query("select arcpic from kl_archives where id="&id)
		if not temrs.eof  then
			tempic=trim(temrs("arcpic")&"")
			set temrs=nothing
			if arcpic<>"" and trim(G("arcpic"))<>tempic then
					DeleteFile(tempic )
			end if
		end if
		'delete pic send
				for each key in request.Form()
					 if key<>"id" and key<>"isupdtarticle" then
						val=G(key)
						uprs(key)=val
					 end if
				next
				if(G("arcdescr")="") then uprs("arcdescr")=left(removehtml(G("arccontent")),30)
				uprs("uddate")=FormatDate(now,2)
				uprs.update
				uprs.close
				set uprs=nothing
				if err.number<>0 then
					AlertMsg(UPDATE_FAIL_STR)
					'echo "<script>window.history.go(-1);<\/script>"
				else
					alertMsgGo UPDATE_SUCCESS_STR,"article_list.asp?cat_id="&cat_id
					'AlertMsg(UPDATE_SUCCESS_STR)
					'echo "<script>window.location=""article_list.asp?cat_id="&cat_id&"""<\/script>"
				end if
	end if
'输出模板默认数据
	id=G("id")
	sqlstr="SELECT a.cat_id as cid,c.type_name as typename,b.type_id as typeid,*  from (kl_archives as a inner join  kl_cats as b on a.cat_id=b.cat_id) inner join kl_content_types as c on b.type_id=c.type_id where a.id="&id&" order by fbdate desc"
newtpl.assign "typeidsel",getContentTypeSel()
newtpl.assign "catidsel",getArcCatSel()
set rs=newdb.query(sqlstr)
edittpl=rs("tpl_editform")&""
arr=newdb.rsToArr(rs)
newtpl.assign "arcinfo",arr(0)
newtpl.display(edittpl)
%>