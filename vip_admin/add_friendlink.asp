<!--#include file="lib/AdminInIt.asp"-->
<%	
if G("act")="addfriend" then 

	newdb.table("kl_friend_link").create()
	result=newdb.add()
		if result then
			call	AlertMsgGo(ADD_SUCCESS_STR,"friendlink_list.asp")
		else
			call	AlertMsg(ADD_FAIL_STR)
		end if
end if
newtpl.display("add_friendlink.html")
%>