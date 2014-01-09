<!--#include file="lib/AdminInIt.asp"-->
<%
'oldtpl.SetTemplatesDir("")
'包含文件
'Generate the page

		'批量删除
		if G("batchid")<>"" then
			str=G("batchid")
			arr=split(str,",")
			result=""
'			for i=0 to ubound(arr)
'				result=olddb.DeleteRecord("kl_order","id",arr(i))
'			next
			rewsult=newdb.query("delete * from kl_order where id in("&str&")")
'				if result then
					call AlertMsggo(CAOZUO_SUCCESS_STR,"order.asp")
'				else
'					call AlertMsggo(CAOZUO_FAIL_STR,"order.asp")
'				end if
		end if	
		
	if G("act")="del" then
		result=	newdb.table("kl_order").where("id="&G("id")).delete()
		if result then
			call AlertMsggo(CAOZUO_SUCCESS_STR,"order.asp")
		else
			call AlertMsggo(CAOZUO_FAIL_STR,"order.asp")
		end if
	end if
	
sql="select * from kl_order order by fbdate desc "
newtpl.assign "sql",sql
newtpl.assign "page",G("page")
newtpl.display("order.html")
%>