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
'面包屑导航
'==============================================


'取参数
catid=tpl.tagparam("catid")
jiange=tpl.tagparam("jiange")

content=getcat(catid,jiange)
'本文件内不能输出内容下面这一句把内容传进去就可以啦
tpl.assign "tagcontent",content
%>