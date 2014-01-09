<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>{$catinfo.cat_seotitle|empty=$catinfo.cat_name}_{$indexseo.cfg_webname}</title>
<meta name="keywords" content="{$catinfo.cat_seokeys|empty=$indexseo.cfg_keywords}" />
<meta name="description" content="{$catinfo.cat_seodescr|empty=$indexseo.cfg_description}" />
<link type="text/css" rel="stylesheet" href="css/index.css" />
<script type="text/javascript" language="javascript" src="js/iepng.js"></script>
<script type="text/javascript" language="javascript">
	EvPNG.fix('.zy_bannernr,.fwzc_left .bt,img');
</script>
</head>

<body>
<!--{include file="public/header.tpl"}-->
<!--banner-->
<div class="zy_banner">
<div class="zy_bannernr"><img src="images/zy_bannernr1.png" width="394" height="50" /></div>
</div>
<!---->
<div class="content_kj">
	<!--{include file="public/newgd.tpl"}-->
    <div style="clear:both"></div>
    <!---->
    <div class="zy_znav">
    	<div class="left"></div>
      <div class="center">
        	<a href="cat.asp?catid=23">案例展示</a>
            <a href="cat.asp?catid=25">合作伙伴</a>
        </div>
        <div class="right"></div>
        <div style="clear:both"></div>
    </div>
    
    <!--内容-->
  <div class="alzs">
   	  
           <!--{arclist catid="{$catinfo.cat_id}"  pagenav="pagenav" pagesize="28"}-->
           <div class="alzs_kj"> <a href="view.asp?id={$id}"><img src="{$arcpic|empty=/images/default.jpg}" width="315" height="118" alt="{$arctitle}" title="{$arctitle}" /></a>
        <div class="alzs_kjnr">
        <h3><a href="view.asp?id={$id}"></a></h3>
        <p>{$arccontent|left=15} ...</p>
        <a href="view.asp?id={$id}">[详情查看]</a>
        </div>
        </div>
            <!--{/arclist}-->
		<div style="clear:both"></div>
        <div class="fy">
        	{$pagenav}<div style="clear:both"></div>
        </div>      
  </div>
  
</div>
<!--{include file="public/footer.tpl"}-->
</body>
</html>
