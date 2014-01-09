<%
'==============================================
'系统参数获取
'取标签内name参数的值
'示例
'nme=tpl.tagparam("name")
'模板中使用示例
'<tag:test param="这个是传入的参数" />
'==============================================
'标签功能说明
'
'==============================================
dim sql,str
sql="select * from kl_friend_link   order by sortrank asc"
set rs=db.query(sql)
do while not rs.eof
str=str&"<a href='"&rs("friend_url")&"'>"&rs("friend_name")&"</a>"
rs.movenext
loop
'取参数
'param=tpl.tagparam("param")
'本文件内不能输出内容下面这一句把内容传进去就可以啦
tpl.assign "tagcontent",str
%>