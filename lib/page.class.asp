<%
'更新日期2013-04-24 10:52
'更新日志：添加getshowpage()以方便模板调用返回导航
'===================================================================
'XDOWNPAGE   ASP版本
'版本   1.00
'Code by  zykj2000
'Email:   zykj_2000@163.net
'BBS:   http://bbs.513soft.net
'本程序可以免费使用、修改，希望我的程序能为您的工作带来方便
'但请保留以上请息
'
'程序特点
'本程序主要是对数据分页的部分进行了封装，而数据显示部份完全由用户自定义，
'支持URL多个参数
'
'使用说明
'程序参数说明
'PapgeSize      定义分页每一页的记录数
'GetRS       返回经过分页的Recordset此属性只读
'GetConn      得到数据库连接
'GetSQL       得到查询语句
'程序方法说明
'ShowPage      显示分页导航条,唯一的公用方法
'
'===================================================================

Btn_First="<font>"&pg_index&"</font>"  '定义第一页按钮显示样式
Btn_Prev="<font>"&pg_prev&"</font>"  '定义前一页按钮显示样式
Btn_Next="<font>"&pg_next&"</font>"  '定义下一页按钮显示样式
Btn_Last="<font>"&pg_end&"&nbsp;</font>"  '定义最后一页按钮显示样式
XD_Align="Center"     '定义分页信息对齐方式
XD_Width="100%"     '定义分页信息框大小

Class Xdownpage
Private XD_PageCount,XD_Conn,XD_Rs,XD_SQL,XD_PageSize,Str_errors,int_curpage,str_URL,int_totalPage,int_totalRecord,XD_sURL


'=================================================================
'PageSize 属性
'设置每一页的分页大小
'=================================================================
Public Property Let PageSize(int_PageSize)
 If IsNumeric(Int_Pagesize) Then
  XD_PageSize=CLng(int_PageSize)
 Else
  str_error=str_error & "PageSize的参数不正确"
  ShowError()
 End If
End Property
Public Property Get PageSize
 If XD_PageSize="" or (not(IsNumeric(XD_PageSize))) Then
  PageSize=10     
 Else
  PageSize=XD_PageSize
 End If
End Property

'=================================================================
'GetRS 属性
'返回分页后的记录集
'=================================================================
Public Property Get GetRs()
 Set XD_Rs=Server.createobject("adodb.recordset")
 XD_Rs.PageSize=PageSize
 XD_Rs.Open XD_SQL,XD_Conn,1,1
 If not(XD_Rs.eof and XD_RS.BOF) Then
  If int_curpage>XD_RS.PageCount Then
   int_curpage=XD_RS.PageCount
  End If
  XD_Rs.AbsolutePage=int_curpage
 int_totalPage=XD_RS.PageCount 
 End If
 Set GetRs=XD_RS
End Property

'================================================================
'GetConn  得到数据库连接
'
'================================================================ 
Public Property Let GetConn(obj_Conn)
 Set XD_Conn=obj_Conn
End Property

'================================================================
'GetSQL   得到查询语句
'
'================================================================
Public Property Let GetSQL(str_sql)
 XD_SQL=str_sql
End Property

 

'==================================================================
'Class_Initialize 类的初始化
'初始化当前页的值
'
'================================================================== 
Private Sub Class_Initialize
 '========================
 '设定一些参数的黙认值
 '========================
 XD_PageSize=10  '设定分页的默认值为10
 '========================
 '获取当前面的值
 '========================
 If request("page")="" Then
  int_curpage=1
 ElseIf not(IsNumeric(request("page"))) Then
  int_curpage=1
 ElseIf CInt(Trim(request("page")))<1 Then
  int_curpage=1
 Else
  Int_curpage=CInt(Trim(request("page")))
 End If
  
End Sub

'====================================================================
'ShowPage  创建分页导航条
'有首页、前一页、下一页、末页、还有数字导航
'
'====================================================================
Public Sub ShowPage()
 Dim str_tmp
 XD_sURL = GetUrl()
 int_totalRecord=XD_RS.RecordCount
 If int_totalRecord<=0 Then
  str_error=str_error & "总记录数为零，请输入数据"
  Call ShowError()
 End If
 If int_totalRecord="" then
     int_TotalPage=1
 End If
 
 If Int_curpage>int_Totalpage Then
  int_curpage=int_TotalPage
 End If
 
 '==================================================================
 '显示分页信息，各个模块根据自己要求更改显求位置
 '==================================================================
 response.write ""
 str_tmp=ShowFirstPrv
 response.write str_tmp
 str_tmp=showNumBtn
 response.write str_tmp
 str_tmp=ShowNextLast
 response.write str_tmp
 str_tmp=ShowPageInfo
 response.write str_tmp
 
 response.write ""
End Sub
'===================================================================
'返回分页导航
'===================================================================
Public function GetShowPage()
 Dim str_tmp

 XD_sURL = GetUrl()
 int_totalRecord=XD_RS.RecordCount
 If int_totalRecord<=0 Then
  str_error=str_error & "总记录数为零，请输入数据"
  Call ShowError()
 End If
 If int_totalRecord="" then
     int_TotalPage=1
 End If
 
 If Int_curpage>int_Totalpage Then
  int_curpage=int_TotalPage
 End If
 
 '==================================================================
 '显示分页信息，各个模块根据自己要求更改显求位置
 '==================================================================
 str_tmp="<div class='pagenav'>"
 str_tmp=str_tmp&ShowFirstPrv
 str_tmp=str_tmp&showNumBtn
 str_tmp=str_tmp&ShowNextLast
 str_tmp=str_tmp&ShowPageInfo
 str_tmp=str_tmp&"</div>"
GetShowPage=str_tmp
End function
'====================================================================
'ShowFirstPrv  显示首页、前一页
'
'
'====================================================================
Private Function ShowFirstPrv()
 Dim Str_tmp,int_prvpage
 If int_curpage=1 Then
 	int_prvpage=1
  str_tmp="<a href="""&XD_sURL & "1" & """>" & Btn_First&"</a> <a href=""" & XD_sURL & CStr(int_prvpage) & """>" & Btn_Prev&"</a>"
 Else
  int_prvpage=int_curpage-1
  str_tmp="<a href="""&XD_sURL & "1" & """>" & Btn_First&"</a> <a href=""" & XD_sURL & CStr(int_prvpage) & """>" & Btn_Prev&"</a>"
 End If
 ShowFirstPrv=str_tmp
End Function

'====================================================================
'ShowNextLast  下一页、末页
'
'
'====================================================================
Private Function ShowNextLast()
 Dim str_tmp,int_Nextpage
 If Int_curpage>=int_totalpage Then
  str_tmp=Btn_Next & " " & Btn_Last
 Else
  Int_NextPage=int_curpage+1
  str_tmp="<a href=""" & XD_sURL & CStr(int_nextpage) & """>" & Btn_Next&"</a> <a href="""& XD_sURL & CStr(int_totalpage) & """>" &  Btn_Last&"</a>"
 End If
 ShowNextLast=str_tmp
End Function


'====================================================================
'ShowNumBtn  数字导航
'
'
'====================================================================
Private Function showNumBtn()
 Dim i,str_tmp,style

' For i=1 to int_totalpage
'  if G("page")=CStr(i) then
'  	style="style='color:#f00;'"
'  else
'  	style=""
'  end if
'  str_tmp=str_tmp & "[<a "&style&" href=""" & XD_sURL & CStr(i) & """>"&i&"</a>] "
' Next
curpage=cstr(G("page"))
if curpage="" then curpage=1
str_tmp=""
For i=1 to 5
  a=curpage
  b=a-i
  if b>0 then str_tmp= "<a "&style&" href=""" & XD_sURL & b & """>"&b&"</a> "&str_tmp
  if b<=1 then exit for
Next
 str_tmp=str_tmp & "<a style='color:red;' href=""" & XD_sURL &curpage & """>"&curpage&"</a> "
For i=1 to 5
  a=curpage
  b=a+i
  if b<=int_totalpage then str_tmp=str_tmp & "<a "&style&" href=""" & XD_sURL & b & """>"&b&"</a> "
  if b>int_totalpage then exit for
Next
';on error goto 0
'str_tmp=""
'str_tmp=str_tmp & "[<a style='color:#f00;' href=""" & XD_sURL &G("page") & """>"&i&"</a>] "
 showNumBtn=str_tmp
End Function


'====================================================================
'ShowPageInfo  分页信息
'更据要求自行修改
'
'====================================================================
Private Function ShowPageInfo()
 Dim str_tmp
 str_tmp=pg_yeci&int_curpage&"/"&int_totalpage&pg_yegong&int_totalrecord&pg_tiaojilu&XD_PageSize&pg_tiaomy
 ShowPageInfo=str_tmp
End Function
'==================================================================
'GetURL  得到当前的URL
'更据URL参数不同，获取不同的结果
'
'==================================================================
Private Function GetURL()
 Dim strurl,str_url,i,j,search_str,result_url
 search_str="page="
 
 strurl=Request.ServerVariables("URL")
 Strurl=split(strurl,"/")
 i=UBound(strurl,1)
 str_url=strurl(i)'得到当前页文件名
 
 str_params=Trim(Request.ServerVariables("QUERY_STRING"))
 If str_params="" Then
  result_url=str_url & "?page="
 Else
  If InstrRev(str_params,search_str)=0 Then
   result_url=str_url & "?" & str_params &"&page="
  Else
   j=InstrRev(str_params,search_str)-2
   If j=-1 Then
    result_url=str_url & "?page="
   Else
    str_params=Left(str_params,j)
    result_url=str_url & "?" & str_params &"&page="
   End If
  End If
 End If
 GetURL=result_url
End Function

'====================================================================
' 设置 Terminate 事件。
'
'====================================================================
Private Sub Class_Terminate  
 XD_RS.close
 Set XD_RS=nothing
End Sub
'====================================================================
'ShowError  错误提示
'
'
'====================================================================
Private Sub ShowError()
 If str_Error <> "" Then
  Response.Write("" & str_Error & "")
  Response.End
 End If
End Sub
End class



''set conn = server.CreateObject("adodb.connection")
''conn.open "driver={microsoft access driver (*.mdb)};dbq=" & server.Mappath("pages.mdb")
'
''#############类调用样例#################
''创建对象
'Set mypage=new xdownpage
''得到数据库连接
'mypage.getconn=conn
''sql语句
'mypage.getsql="select * from [test] order by id asc"
''设置每一页的记录条数据为5条
'mypage.pagesize=5
''返回Recordset
'set rs=mypage.getrs()
''显示分页信息，这个方法可以，在set rs=mypage.getrs()以后,可在任意位置调用，可以调用多次
'mypage.showpage()
'
''显示数据
'Response.Write("<br/>")
'for i=1 to mypage.pagesize
''这里就可以自定义显示方式了
'    if not rs.eof then 
'        response.write rs(0) & "<br/>"
'        rs.movenext
'    else
'         exit for
'    end if
'next
'.pagenav{ margin:10px 0px;}
'.pagenav,.pagenav a,.pagenav font{ font-size:12px; color:#666;text-align: center;}
'.pagenav a:hover,.pagenav a:hover font{ color:#000; background:#ebebeb;}
'.pagenav a,.pagenav font{ display:inline-block; height:20px; height:20px; padding:0px 6px; line-height:20px;border: 1px solid #E7ECF0;}
'.pagenav a font{ margin:0px; padding:0px; border:none;}
'.ahover{ background:#ededed; color:#000;}
'导航样式
%>