<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>{$catinfo.cat_seotitle|empty=$catinfo.cat_name}_{$indexseo.cfg_webname}</title>
<meta name="keywords" content="{$catinfo.cat_seokeys|empty=$indexseo.cfg_keywords}" />
<meta name="description" content="{$catinfo.cat_seodescr|empty=$indexseo.cfg_description}" />
<link rel="stylesheet" type="text/css" href="/css/index.css">
<script src="/js/jquery-1.4.2.min.js" type="text/javascript"></script>
<script src="/js/common.js" type="text/javascript"></script>
</head>

<body>
<!--{include file="public/header.tpl"}-->
<!--{include file="public/zy_banner.tpl"}-->
<!--子页-->
<div class="zy">
<!--left-->
<div class="zy_left">
	<div class="fl"><img src="images/zynr_left1.png" width="11" height="162" /></div>
        <div class="zy_leftnr fl">
            <div class="zy_leftlbbt"><cat id="31">{$cat_name}</cat></div>
            <!--{arclist sql="select * from kl_cats where parent_id=31"}-->
 <div class="zy_leftlbnr2 zy_leftlbnr <eq {$cat_id}={$catinfo.cat_id}>visied</eq>"><a href="cat.asp?catid={$cat_id}">{$cat_name}</a></div>
<!--{/arclist}-->
<!--{include file="public/contact.tpl"}-->
        </div>
    <div class="fl"><img src="images/zynr_left2.png" width="7" height="430" /></div> 
</div>
<!--right-->
<div class="zy_right">
	<div class="zy_rightbt">
    	<div class="zy_btnra">{$catinfo.cat_name}</div>
        <div class="zy_btnrb"><!--{include file="public/position.tpl"}--></div>
    </div>
    <!--rightnr-->
	<div class="zy_gygs">
{$catinfo.cat_singlecontent}
    </div>
</div>









</div>

<!--{include file="public/footer.tpl"}-->
</body>
</html>
