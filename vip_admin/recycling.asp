<!--#include file="lib/AdminInIt.asp"-->
<%
'移出回收站
	'首先是单个移出
	if G("act")="huanyuan" then
			if G("id")<>"" then 
				id=G("id")
				'result=olddb.UpdateRecord("kl_archives","id="&id,array("recycling:0"))
				result=newdb.query("update kl_archives set recycling=0 where id="&id)
				'	if result="true" then
						call AlertMsggo(CAOZUO_SUCCESS_STR,"recycling.asp")
				'	else
				'		call	AlertMsg(CAOZUO_FAIL_STR)
				'	end if
			end if
		'批量移出
		if G("batchid")<>"" then		
			str=G("batchid")
			arr=split(str,",")
			dim result
			for i=0 to ubound(arr)
				'result=olddb.UpdateRecord("kl_archives","id="&arr(i),array("recycling:0"))
				result=newdb.query("update kl_archives set recycling=0 where id="&arr(i))
			next
			call AlertMsggo(CAOZUO_SUCCESS_STR,"recycling.asp")
		end if
	end if
'彻底删除
	if G("act")="del" then
			if G("id")<>"" then 
				id=G("id")
				'result=olddb.DeleteRecord("kl_archives","id",id)
				result=newdb.query("delete from kl_archives  where id="&id)
'				echo "delete kl_archives  where id="&id
'				die("")
'					if result=0 then
'						AlertMsg(CAOZUO_FAIL_STR)
'					end if
						call AlertMsggo("删除成功！","recycling.asp")
			end if
		'批量删除
		if G("batchid")<>"" then
			str=G("batchid")
			arr=split(str,",")
			result=""
			for i=0 to ubound(arr)
				'result=olddb.DeleteRecord("kl_archives","id",arr(i))
				result=newdb.query("delete from kl_archives  where id="&arr(i))
			next
						call AlertMsggo("批量删除成功！","recycling.asp")
'				if result=0 then
'					AlertMsg(CAOZUO_FAIL_STR)
'				end if
		end if	
	end if

sql="SELECT a.id,a.arctitle,a.fbdate,a.arcflag,a.uddate,b.cat_name,c.type_name,a.arccontent,a.arcpic,a.recycling  from (kl_archives as a inner join  kl_cats as b on a.cat_id=b.cat_id) inner join kl_content_types as c on b.type_id=c.type_id  where recycling=1 order by fbdate desc"

newtpl.assign "sql",sql
newtpl.assign "page",G("page")
newtpl.display("recycling.html")
%>