<!--#INCLUDE FILE="lib/AspTpl.class.asp"-->
<%
data_arr=array(1,2,3,4,5,6,7,8,9,10)
'Declare our template variable
dim t

'Create the class object
set t = New ASPTemplate

'Set the main template file 加载模板文件
t.SetTemplateFile "test.html"
t.SetVariable "title", "ASP Template Example Script 1<br />"

'Load an external file into a tag.  把一个文件加载到一个标签
t.SetVariableFile "menu","content.html"

'We add some more text to this tag   给标签增加一些内容
t.Append "title", " -add text Main Page<br />"


'循环输出数据
'Setup the block
t.UpdateBlock "menu_block"
for i= 0 to 9
'Set and parse the block 
t.SetVariable "menu_text", data_arr(i)
t.ParseBlock "menu_block"
next


t.parse
set t = nothing
%>