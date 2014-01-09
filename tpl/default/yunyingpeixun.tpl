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
<div class="zy_bannernr"><img src="images/yingxiaopeixun.png" width="394" height="49" /></div>
</div>
<!---->
<div class="content_kj">
	<!--{include file="public/newgd.tpl"}-->
    <div style="clear:both"></div>
    <!---->
    <div class="zy_yxpxtop"><img src="images/zy_yxpx1.jpg" width="1000" height="224" /></div>
  <div class="zy_yxpxnr">
   	  <div class="nr_kj nr_kjbj1">
        	<h3><a href="cat.asp?catid=108">+更多</a>微营销推广</h3>
            <ul>
            <!--{arclist catid="108" num="9"}-->
            <li><a href="view.asp?id={$id}">·{$arctitle|left=15}</a></li>
            <!--{/arclist}-->
            </ul>
      </div>
      <div class="nr_kj nr_kjbj2">
        	<h3><a href="cat.asp?catid=107">+更多</a>SEO优化培训</h3>
            <ul>
            <!--{arclist catid="107" num="9"}-->
            <li><a href="view.asp?id={$id}">·{$arctitle|left=15}</a></li>
            <!--{/arclist}-->
            </ul>
      </div>
      <div class="nr_kj nr_kjbj3">
        	<h3><a href="cat.asp?catid=106">+更多</a>电商营销</h3>
            <ul>
            <!--{arclist catid="106" num="9"}-->
            <li><a href="view.asp?id={$id}">·{$arctitle|left=15}</a></li>
            <!--{/arclist}-->
            </ul>
      </div>
      <div class="nr_kj nr_kjbj4">
        	<h3><a href="cat.asp?catid=118">+更多</a>网站建设培训 </h3>
            <ul>
            <!--{arclist catid="118" num="9"}-->
            <li><a href="view.asp?id={$id}">·{$arctitle|left=15}</a></li>
            <!--{/arclist}-->
            </ul>
      </div>
        
        
        
        <div style="clear:both"></div>
    </div>
    


</div>    

<!--{include file="public/footer.tpl"}-->
</body>
</html>
