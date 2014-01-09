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
<div class="container">
<div class="left">
<ul>
<!--{arclist sql="select * from kl_cats where parent_id={$catinfo.cat_id}"}-->
<li><a href="cat.asp?catid={$cat_id}">{$cat_name}</a></li>
<!--{/arclist}-->
</ul>
</div>
<div class="right">
<div class="dabox">
    	<div class="title"><img src="/images/title_ico.gif" height="12" width="21" /><span>{$catinfo.cat_name}</span></div>
        <div class="content">
             <!--{arclist catid="{$catinfo.cat_id}" parentid="{$catinfo.cat_id}" pagesize="12" pagenav="pagenav"}-->
          <div class="box">
        		<div class="imgbox">
                	<a href="view.asp?id={$id}" target="_blank"><img src="{$arcpic}"  alt="{$arctitle}" title="{$var.arctitle}" /></a>
                </div>
            <a href="view.asp?id={$id}" target="new" class="smtitle">{$arctitle}</a>
          </div>
            <!--{/arclist}-->
        </div>
        <div class="pagenav">{$pagenav}</div>
        </div>
</div>
<div style="clear:both;"></div>
</div>
<!--{include file="public/footer.tpl"}-->
</body>
</html>
