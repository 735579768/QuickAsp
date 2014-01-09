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
			for i=0 to ubound(arr)
				'result=olddb.DeleteRecord("kl_comments","id",arr(i))
				result=newdb.table("kl_comments").where("id="&arr(i)).delete()
			next
				if result=0 then
					AlertMsg(CAOZUO_FAIL_STR)
				else
					call alertMsgGo("删除成功","comments.asp")
				end if
		end if	
		
	if G("act")="del" then
		result=newdb.table("kl_comments").where("id="&G("id")).delete()
		call alertMsgGo("删除成功","comments.asp")
		'result=olddb.query("delete from kl_comments where id="&G("id"))
	end if

sql="select * from kl_comments order by fbdate desc,id desc "
newtpl.assign "sql",sql
newtpl.assign "page",G("page")
newtpl.display("comments.html")
%>