<!--#include file="lib/AdminInIt.asp"-->
<%
dim friend_id,friend_name,friend_url,sortrank,friend_weizhi,friend_email
	
if G("act")="updtfriend" then 
	newdb.table("kl_friend_link").create()
	result=newdb.where("friend_id="&G("friend_id")).save()
		if result then
			call	AlertMsgGo(UPDATE_SUCCESS_STR,"friendlink_list.asp")
		else
			call	AlertMsg(UPDATE_FAIL_STR)
		end if
end if


	friend_id=G("friend_id")
	rsarr=newdb.table("kl_friend_link").where("friend_id="&friend_id).selarr()
	newtpl.assign "obj",rsarr(0)
	newtpl.display("edit_friendlink.html")
%>