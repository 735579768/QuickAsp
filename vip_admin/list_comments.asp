<!--#include file="lib/AdminInIt.asp"-->
<%
'oldtpl.SetTemplatesDir("")
'包含文件
'oldtpl.setVariableFile "TOP_HTML","public/top.html"
'oldtpl.setVariableFile "FOOTER_HTML","public/footer.html"

'Generate the page
oldtpl.Parse
'Destroy our objects
set oldtpl = nothing
%>