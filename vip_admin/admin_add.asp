<!--#include file="lib/AdminInIt.asp"-->
<%
	if G("act")="addadmin" then
		newpwd=G("newpwd")
		uname=G("uname")
		qx_id=G("qx_id")
		nicheng=G("nicheng")
		set yzrs=olddb.query("select * from kl_admin where username='"&uname&"'")
		if yzrs.recordcount>0 then
			AlertMsg(EXISTADMIN)
		else
			result=olddb.AddRecord("kl_admin",array("username:"&uname,"qx_id:"&qx_id,"nicheng:"&nicheng,"password:"&md5(newpwd,32)))
		end if
		if result<>0 then
			AlertMsg(ADD_SUCCESS_STR)
		end if
	end if


oldtpl.setvariable "qx_idsel",getQxsel()
oldtpl.Parse
'Destroy our objects
set oldtpl = nothing
%>