<!--#INCLUDE FILE="lib/init.asp"-->
<%
'Declare our template variable
dim tpl

'Create the class object

'Set the main template file 加载模板文件
tpl.SetTemplateFile "layout.html"

'Add some custom tags to the template  设置一些自义标签
tpl.SetVariable "title", "ASP Template Example Script 1"

'We add some more text to this tag   给标签增加一些内容
tpl.Append "title", " - Main Page"

'Load an external file into a tag.  把一个文件加载到一个标签
tpl.SetVariableFile "content", "content.html"   

'Load another external file that will be used to draw some blocks 把文件（这个文件是用来当做一个循环输出的块来用的）加载到一个标签块里面
tpl.SetVariableFile "menu", "menu.html"

'Setup the block  /*************************开始设置一个块********************************/
tpl.UpdateBlock "menu_block"

'Set and parse the block 
tpl.SetVariable "menu_text", "HOME"
tpl.ParseBlock "menu_block"

'Do it multiple times
tpl.SetVariable "menu_text", "NEWS"
tpl.ParseBlock "menu_block"

tpl.SetVariable "menu_text", "CREDITS"
tpl.ParseBlock "menu_block"
'*************************************更新一个块**************************************


'Store the blocks in their directory service (order is important)

tpl.UpdateBlock "c_block"
tpl.UpdateBlock "b_block"
tpl.UpdateBlock "a_block"


tpl.SetVariable "inner", "666666"
tpl.SetVariable "outer", "Outer Block (A)"

tpl.SetVariable "whatever", "Block C 1"
tpl.ParseBlock "c_block"
tpl.SetVariable "whatever", "Block C 2"
tpl.ParseBlock "c_block"
tpl.SetVariable "whatever", "Block C 3"
tpl.ParseBlock "c_block"

tpl.SetVariable "into_b", "Block B 1"
tpl.ParseBlock "b_block"

tpl.SetVariable "whatever", "Block C 1(b)"
tpl.ParseBlock "c_block"
tpl.SetVariable "whatever", "Block C 2(b)"
tpl.ParseBlock "c_block"

tpl.SetVariable "inner", "999999"

tpl.SetVariable "into_b", "Block B 2"
tpl.ParseBlock "b_block"

tpl.ParseBlock "a_block"


'Generate the page
tpl.Parse

'Destroy our objects
set tpl = nothing
%>