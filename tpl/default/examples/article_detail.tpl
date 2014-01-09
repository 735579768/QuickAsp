<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>{$arcinfo.arctitle}_{$arcinfo.cat_name}}_{$indexseo.cfg_webname}</title>
<meta name="keywords" content="{$arcinfo.arckeys|empty=$indexseo.cfg_keywords}}" />
<meta name="description" content="{$arcinfo.arcdescr|empty=$indexseo.cfg_description}" />
<link rel="stylesheet" type="text/css" href="/css/index.css">
<link rel="stylesheet" href="/css/lightbox.css" type="text/css" media="screen" />
<script src="/js/jquery-1.4.2.min.js" type="text/javascript"></script>
<script src="/js/common.js" type="text/javascript"></script>
<script src="/js/prototype.js" type="text/javascript"></script>
<script src="/js/scriptaculous.js?load=effects" type="text/javascript"></script>
<script src="/js/lightbox.js" type="text/javascript"></script>
</head>

<body>
<!--{include file="public/header.tpl"}-->
                      <!--{arclist sql="select * from kl_cats  where cat_id in(select parent_id from kl_cats where cat_id={$arcinfo.cat_id})"}-->
                      {$cat_name}
                      <!--{/arclist}-->

            <!--{arclist sql="select * from kl_cats  where parent_id in(select parent_id from kl_cats where cat_id={$arcinfo.cat_id}) and parent_id<>0"}-->
            <!--{/arclist}-->
<div class="container">
<div class="left">
             <dl>
          <dt class="title"><img src="/images/title_ico.gif" height="12" width="21" /><span>产品分类</span></dt>
            <!--{loop name="catlist" var="var"}-->
            <dd><a href="cat.asp?catid={$var.cat_id}" title="{$var.cat_name}">{$var.cat_name}</a></dd>
            <!--{/loop}-->
        </dl>
        <dl>
          <dt class="title"><img src="/images/title_ico.gif" height="12" width="21" /><span>最新产品</span></dt>
            <!--{loop name="productlist" var="var"}-->
            <dd><a href="view.asp?id={$var.id}" title="{$var.arctitle}">{$var.arctitle}</a></dd>
            <!--{/loop}-->
        </dl>
        <dl>
          <dt class="title"><img src="/images/title_ico.gif" height="12" width="21" /><span>近期案例</span></dt>
            <!--{loop name="anlilist" var="var"}-->
            <dd><a href="view.asp?id={$var.id}" title="{$var.arctitle}">{$var.arctitle}</a></dd>
            <!--{/loop}-->
        </dl>
</div>
<div class="right">
		<div class="dabox">
    	<div class="title"><img src="/images/title_ico.gif" height="12" width="21" /><span>您现在的位置：<a href="/">首页</a><position id="{$arcinfo.cat_id}" jiange="-" /></span></div>
        <div class="content">
        <div class="goodtitle">{$arcinfo.arctitle}</div>
        <div class="goodxx"><span>来源：{$arcinfo.arcsource}</span><span>编辑：{$arcinfo.arcauthor}</span><span>发布时间：{$arcinfo.fbdate}</span><span>浏览人次：{$arcinfo.archits}</span></div>
        <!--{if "{$arcinfo.arcpic}"<>""}-->
        <div class="goodimg"><a href="{$arcinfo.arcpic}" rel="lightbox" title="{$arcinfo.arctitle}" ><img src="{$arcinfo.arcpic}"  /><span>点击看大图</span></a></div>
        <!--{/if}-->
        <div class="gooddetail">{$arcinfo.arccontent}</div>
            
            
        </div>
        </div>
</div>
    <div class="arcpav">
        	     <!--{arclist sql="select top 1 * from kl_archives where  id>{$arcinfo.id} and cat_id={$arcinfo.cat_id} and recycling=0 order by id asc,fbdate asc "}-->
    <a href="view.asp?id={$id}"><b>[上一篇]</b>{$arctitle|left=20}</a>
    <!--{/arclist}-->
    
      <!--{arclist sql="select top 1 * from kl_archives where  id<{$arcinfo.id} and cat_id={$arcinfo.cat_id} and recycling=0   order by id desc,fbdate desc "}-->
    <a href="view.asp?id={$id}"><b>[下一篇]</b>{$arctitle|left=20}</a>
    <!--{/arclist}-->
    </div>
<div style="clear:both;"></div>
</div>
<!--{include file="public/footer.tpl"}-->
</body>
</html>
