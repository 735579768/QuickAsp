<!--#include file="lib/AdminInIt.asp"-->
<%
'oldtpl.SetTemplatesDir("")
'包含文件
'oldtpl.setVariableFile "TOP_HTML","public/top.html"
'oldtpl.setVariableFile "FOOTER_HTML","public/footer.html"
'判断要包含的文件是否存在
				temstr=""
				set FSO = createobject("Scripting.FileSystemObject")
				filepath=server.mappath("/"&TPL_PATH&"oldtpl.ini")
				if FSO.FileExists(filepath) then
					'读取包含的文件并替换标签
					set oFile = FSO.OpenTextFile(filepath, 1)
					temstr = oFile.ReadAll
					oFile.Close
					set oFile = nothing
				end if
	arr=split(temstr,vbCrLf)
	oldtpl.updateBlock "tpllist"
	for each a in arr
		arr1=split(a,",")
		if ubound(arr1)>0 then
			setVarArr(array("name:"&arr1(0),"descr:"&arr1(1)))
		end if
		oldtpl.parseBlock "tpllist"
	next
'Generate the page
oldtpl.Parse
'Destroy our objects
set oldtpl = nothing
%>