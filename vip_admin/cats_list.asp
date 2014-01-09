<!--#include file="lib/AdminInIt.asp"-->
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<script src="js/jquery-1.8.1.min.js" type="text/javascript"></script>
<script src="js/common.js" type="text/javascript"></script>
<link href="css/jquery-webox.css" rel="stylesheet" type="text/css">
<link href="css/main.css" rel="stylesheet" type="text/css" />
<title>添加信息</title>
<script src="js/jquery-webox.js"></script>
<script type="text/javascript">
function popup(catid){
		//iframe弹出层调用
		$.webox({
			height:400,
			width:600,
			bgvisibel:true,
			title:'快速编辑分类属性',
			iframe:'quickeditcat.asp?cat_id='+catid
		});
	}
</script>
</head>
<style>
.biaotou {
	background: url(images/tbg.gif) repeat-x;
	height: 28px;
}
table {
	border-color: #FBFCE2;
}
table td table td, table td table {
	border: none;
	text-align: left;
	line-height: 28px;
	height: 28px;
}
td {
	border-bottom: 1px dotted #BCBCBC;
	height: 28px;
	padding: 2px;
	font-size: 12px;
	font-family: "宋体";
	background-color: #FFF;
}
.catimg{ position:relative;display: inline-block;}
.catimg span{ background:#fff; border:solid 1px #ccc; padding:5px;}
.catimg .catdaimg{ display:none; position:absolute; left:-150px; top:0px; z-index:999;}

.lanmu{ margin:0 auto; 
min-width:1000px;
_width:expression(this.width <1000 && this.height < this.width ? 1000: true);}
.lanmu,.lanmu dt,.lanmu dd{display:block;  width:100%; margin:0px; padding:0px;}
.lanmu dt,.lanmu dd{ height:30px; line-height:30px;}
.lanmu dt{ background:url(images/lanmubg.gif) repeat-x;padding:0px 40px;}
.lanmu dd{padding:0px 90px;border-bottom: 1px dotted #BCBCBC;}
.lanmu dt .left{ width:530px; float:left;}
.lanmu dt .right{ float:left;}

.lanmu dd .left{ width:480px; float:left;}
.lanmu dd .right{ float:left;}
.lanmu dt .jiajian{ display:block; float:left; margin:10px; cursor:pointer;}
.haveimg{ display:inline-block;}
</style>
<body>

<dl class="lanmu">
<dt style=" background:url(images/tbg.gif) repeat-x;"><a href="javascript:zall();" class="button zhankai">全部展开</a>
<a href="javascript:hall();" class="button hebing">全部合并</a>
<a href="add_cats.asp?parent_id=0&type_id=1" class="button hebing">添加顶级分类</a>
<form name="addmsg" action="add_article.asp" id="addmsg" style="display:inline; margin-left:130px;">
请选择分类：<%=getArcCatSel()%>
<a href='javascript:tjaddmsg();'  id="addmsgbtn"  title='在此分类下添加信息'  class='button red'>添加信息</a> 
</form>
</dt>
</dl>
<script type="text/javascript">
function tjaddmsg(){
	if($('#cat_id').val()=="0"){
				alert('请首先选择分类，再添加信息!');
				return false;
			}else{
				document.addmsg.submit();
				//$('#addmsg').submit();
				}
	}
</script>
<%
dim menujibie,icoimgid

menujibie=1
icoimgid=0
sql="select cat_id from kl_cats where parent_id=0 order by sort asc "
set xhrs=olddb.query(sql)
if xhrs.recordcount>0 then
	do while not xhrs.eof
		menujibie=1
		echo "<dl class='lanmu'>"
		call getcatlist(xhrs("cat_id"),"","")
		echo "</dl>"
	xhrs.movenext
	loop
end if
%>

<script type="text/javascript">

$(function(){
		$(".lanmu dd").bind("mouseover",function(){
			$(this).css('background','#FBFCE2');
		});
		$(".lanmu dd").bind("mouseout",function(){
			$(this).css('background','#ffffff');
		});
	
	
	$('.jiajian').bind('click',function(){
		var a=$(this).attr('src')
		if(a=='images/jia.gif'){
			$(this).attr('state',1);
			$(this).attr('src','images/jian.gif');
			bianlistate();
			$(this).parent().parent().parent().children('dd').show();
			}else{
			$(this).attr('state',0);
			$(this).attr('src','images/jia.gif');
			bianlistate();
			$(this).parent().parent().parent().children('dd').hide();	
				}
		
		});
//ajax删除前台菜单
	$(".delcat").bind("click",function(){
		if(!confirm('确认要删除吗？'))return;
		var obj=$(this);
		var id=obj.prev().val();
		$.get('./',{
			'act':'ajax',
			'action':'delcat',
			'id':id
			},function(data){
					if(data=='1'){
							alert("删除成功！");
							obj.parent().parent().remove();	
						}else{
							alert(data);
							}
				})
		});
		$(".haveimg").bind("mouseover",function(){
			$(this).next().show();
			});
		$(".catdaimg img").bind("mouseover",function(){
			$(this).parent().show();
			});
		$(".catdaimg").bind("mouseout",function(){
			$(this).hide();
			});
		//查询栏目打开状态start
		//1是打开啦0是还没有打开 
		var menustate=null
		menustate=readCookie("menustate")
		if (menustate==""){
			hall();
			bianlistate()
		}else{
			obje=eval("a={"+menustate+"}");
			for(var i in obje){
				//1是打开啦0是还没有打开 
				if(obje[i]===1){
					$("#"+i).parent().parent().parent().children('dd').show();
					$("#"+i).attr('src','images/jian.gif');
					$("#"+i).attr('state',1);
					}else{
					$("#"+i).parent().parent().parent().children('dd').hide();
					$("#"+i).attr('src','images/jia.gif');
					$("#"+i).attr('state',0);	
						}
				}
				bianlistate()
			}
		//查询栏目打开状态start
		//writeCookie("test","text");
		//alert(readCookie("test"))
	})
	//遍历节点状态写成json保存到cookies
function bianlistate(){
	statestr=""
		$(".jiajian").each(function(index, element) {
            if(statestr==""){
				statestr=$(".jiajian").eq(index).attr("stateid")+":"+$(".jiajian").eq(index).attr("state")
				}else{
				statestr+=","+$(".jiajian").eq(index).attr("stateid")+":"+$(".jiajian").eq(index).attr("state")
				}
        });
			writeCookie("menustate",statestr,10);
	}
function zall(){
	$('.jiajian').attr('src','images/jian.gif');
	$('.lanmu dd,.lanmu .senondmenu').show();
	$('.jiajian').each(function(index, element) {
    $(this).attr('state',1); 
    });
	bianlistate();
	}
function hall(){
	$('.jiajian').attr('src','images/jia.gif');
	$('.lanmu dd,.lanmu .senondmenu').hide();
	$('.jiajian').each(function(index, element) {
     $(this).attr('state',0); 
    });
	bianlistate();
	}
</script>
</body>
</html>

<%
'////////////////////////////////////////////////////////本页函数库///////////////////////////////////////////////////////////
''文章列表内容输输出
function getcatshow(str)
	if "1"=str then
		getcatshow=NAVSHOW
	else
		getcatshow="<span style='color:red;'>"&NAVHIDDEN&"</span>"
	end if
end function
'判断分类封面是否有图
function getcatimg(str)
	if str<>"" then
		getcatimg="<span class='catimg'><img class='haveimg' style='display:inline-block; float:left;' src='images/haveimg.gif' style='cursor:pointer;' width='12' height='12' alt='分类封面有图片显示' title='分类封面有图片显示' /><span class='catdaimg' ><img src='"&str&"' width='150' height='150' /></span></span>"
	else
		getcatimg=NOIMG
	end if
end function
'查询分类文章数量
function getarcnum(catid)
	sql="select count(*) as  a from kl_archives where cat_id="&catid&" and recycling=0"
	set bbbb=olddb.query(sql)
	getarcnum=bbbb("a")&""
	set bbbb=nothing
end function
'查询分类是否有封面内容
	Function getcatindexcontent(catcontent)
		if catcontent<>"" then
		getcatindexcontent=YOUINDEXCONTENT
		else
		getcatindexcontent=MEIINDEXCONTENT
		end if
	end Function
'无限分类调用函数
Function getcatlist(catid,padding,divleft)
		if padding="" then padding=40
		if divleft="" then divleft=580
sqlstr="select a.cat_name as catname,a.type_id as typeid,* from kl_cats as a inner join kl_content_types as b on a.type_id=b.type_id   where a.cat_id="&catid&" order by sort asc "
set wraprs=olddb.query(sqlstr) 
cid1=wraprs("cat_id")&""'分类id
cname1=wraprs("catname")&""'分类name
typeid1=wraprs("typeid")&""'类型id
arcnum1=getarcnum(wraprs("cat_id")&"")
sort1=wraprs("sort")&""
havepic1=getcatimg(wraprs("cat_pic")&"")
navshow1=getcatshow(wraprs("cat_show")&"")
catflag1=wraprs("catflag")&""
'catsinglecontent=getcatindexcontent(wraprs("cat_singlecontent")&"")'封面内容获取

icoimgid=icoimgid+1
%>
		<dt style='padding-left:<%=padding%>px'>
        	<div class='left' style='width:<%=divleft%>px;'>
                <img class='jiajian' stateid="icoimg<%=icoimgid%>" state="0" id="icoimg<%=icoimgid%>" src='images/jian.gif' width='9' height='9' />
                栏目：<u><a title='点击查看此分类下文章' href='list_xx.asp?cat_id=<%=cid1%>' target='_self'><%=cname1%></a></u>
                <span class='red'>(ID:<%=cid1%>,文档数:<%=arcnum1%>)</span>(<%=wraprs("type_sxname")%>)<img style="cursor:pointer;" onclick="popup(<%=cid1%>);" alt="编辑" src="images/edit.png" />
            </div>
            <div class='right'> 
            <%
			'如果分类有子类同时分类类型是列表，如表示输出默认类型为空不让用户添加信息列表
			if  isparentcat(cid1) and catflag1="2" then
				echo "<div style='width:80px; height:25px; float:left;'></div>"
			else
				if catflag1="0" then
					echo "<div style='width:80px; height:25px; float:left;'></div>"
				elseif catflag1="1" then
					echo "<a href='edit_cats.asp?cat_id="&cid1&"&type_id="&typeid1&"&tabid=3' title='添加栏目内容'  class='button red' style='color:green;'>封面内容</a>"
				elseif catflag1="2" then
					echo "<a href='add_xx.asp?cat_id="&cid1&"&type_id="&typeid1&"' title='在此分类下添加信息'  class='button red'>添加信息</a>"
				end if
			
			end if
'				if not isparentcat(cid1) then
'					echo "<a href='add_xx.asp?cat_id="&cid1&"&type_id="&typeid1&"' title='在此分类下添加信息'  class='button red'>添加信息</a>"
'				else
'					echo "<div style='width:60px; height:25px; float:left;'></div>"
'				end if
				%>
                <a href='edit_cats.asp?cat_id=<%=cid1%>&type_id=<%=typeid1%>' class='button'>更改</a>
                <input type='hidden'  value='<%=cid1%>' />
                <a href='javascript:void(0);' class='button delcat'>删除</a>
                <a href='add_cats.asp?parent_id=<%=cid1%>&type_id=<%=typeid1%>' class='button'>增加子类</a> 
                (sort:<%=sort1%>)(<%=navshow1%>)(<%=havepic1%>)
            </div>
    	</dt>
<%

		
		'如果有子菜单就去输出子菜单
	if isparentcat(catid) then
		sqlstr="select a.cat_id as catid,a.cat_name as catname,a.type_id as typeid,* from kl_cats as a inner join kl_content_types as b on a.type_id=b.type_id   where a.parent_id="&catid&" order by sort asc "
		set neirs=olddb.query(sqlstr) 
		do while not neirs.eof
			if isparentcat(neirs("catid")) then
					padding=padding+50
					divleft=divleft-50
					menujibie=menujibie+1 
					echo "<dd class='menujibie"&cstr(menujibie)&"' style='_padding-left:0px;'><dl class='lanmu'>"
					 call getcatlist(neirs("catid"),padding,divleft)
					 menujibie=menujibie-1 
					echo "</dl></dd>"
					divleft=divleft+50
					padding=padding-50
				else
					divleft=divleft-61
					padding=padding+60
					cid2=neirs("catid")&""'分类id
					cname2=neirs("catname")&""'分类name
					arcnum2=getarcnum(neirs("catid")&"")
					typeid2=neirs("typeid")&""'类型id
					sort2=neirs("sort")&""
					havepic2=getcatimg(neirs("cat_pic")&"")
					navshow2=getcatshow(neirs("cat_show")&"")
					catflag2=neirs("catflag")&""
					'catsinglecontent2=getcatindexcontent(neirs("cat_singlecontent")&"")'封面内容获取
	
	%>
		<dd style='padding-left:<%=padding%>px;'>
			<div class='left' style='width:<%=divleft%>px;'>
				栏目：<u><a title='点击查看此分类下文章'  href='list_xx.asp?cat_id=<%=cid2%>' target='_self'><%=cname2%></a></u><span class='red'>(ID:<%=cid2%>,文档数:<%=arcnum2%>)</span>(<%=neirs("type_sxname")%>)<img  style="cursor:pointer;" onclick="popup(<%=cid2%>);" alt="编辑" src="images/edit.png" />
			</div>
			<div class='right'>
			<%
			if catflag2="0" then
					echo "<div style='width:80px; height:25px; float:left;'></div>"
			elseif catflag2="1" then
			%>
			  <a href='edit_cats.asp?cat_id=<%=cid2%>&type_id=<%=typeid2%>&tabid=3' title='添加栏目内容'  class='button red' style="color:green;">封面内容</a>
		<%
		 else
		 %>
		 <a href='add_xx.asp?cat_id=<%=cid2%>&type_id=<%=typeid2%>' title='在此分类下添加信息'  class='button red'>添加信息</a>
		<%
		end if
		 %>
					<a href='edit_cats.asp?cat_id=<%=cid2%>&type_id=<%=typeid2%>' class='button'>更改</a>
					<input type='hidden'  value='<%=cid2%>' />
					<a href='javascript:void(0);' class='button delcat'>删除</a>
					<a href='add_cats.asp?parent_id=<%=cid2%>&type_id=<%=typeid2%>' class='button'>增加子类</a> 
					(sort:<%=sort2%>)(<%=navshow2%>)(<%=havepic2%>)
			</div>
		</dd>
		<%
				divleft=divleft+61
				padding=padding-60
				end if
				neirs.movenext
			loop
			set neirs=nothing
	end if
End function

Function isparentcat(catid)
	sqlstr="select * from kl_cats where  parent_id="&catid&" order by sort asc"
	set krs=olddb.query(sqlstr)
	if krs.recordcount>0 then
		isparentcat=true
	else
		isparentcat=false
	end if
	set krs=nothing
end function
%>