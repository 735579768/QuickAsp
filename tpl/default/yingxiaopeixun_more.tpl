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
    <div class="zy_znav">
    	<div class="left"></div>
      <div class="center">
       <!--{arclist sql="select * from kl_cats where parent_id=29"}-->
        	<a href="cat.asp?catid={$cat_id}">{$cat_name}</a>
            <!--{/arclist}-->
        </div>
        <div class="right"></div>
        <div style="clear:both"></div>
    </div>
	<div class="zy_hzhb">
  	<div class="hzhb_zskj">
                <!--{arclist catid="{$catinfo.cat_id}" pagenav="pagenav" pagesize="4"}-->
            <div class="zy_wyx">
        	<h4><a href="view.asp?id={$id}">{$arctitle|left=15}</a></h4>
          <div class="wyx_nr">来源：{$arcsource}  点击：{$archits}次 时间：{$fbdate} </div>
          <p>{$arccontent|left=100}...</p>
        </div>
            <!--{/arclist}-->
        <div style="clear:both"></div>
        <div class="fy">
        	{$pagenav}<div style="clear:both"></div>
        </div>
    </div>    
        <div class="hzhb_gg"><img src="images/yxpx_gg.png" width="297" height="650"/></div>
        <div style="clear:both"></div>
  </div>

</div> 
<!--{include file="public/footer.tpl"}-->
</body>
</html>
