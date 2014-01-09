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
catid=tpl.tagparam("catid")
num=tpl.tagparam("num")
titlelen=tpl.tagparam("titlelen")

str="<ul>"
sql="select top "&num&"  * from kl_archives  where cat_id="&catid&" order by id desc"
set rs=db.query(sql)
do while not rs.eof
	str=str&"<li>.<a title='"&rs("arctitle")&"' href='view.asp?id="&rs("id")&"'>"&left(rs("arctitle"),titlelen)&"...</a></li>"
rs.movenext
loop
str=str&"</ul>"

'取参数
'param=tpl.tagparam("param")
'本文件内不能输出内容下面这一句把内容传进去就可以啦
tpl.assign "tagcontent",str
%>