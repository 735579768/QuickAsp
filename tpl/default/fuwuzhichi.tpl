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
<div class="zy_bannernr"><img src="images/fuwuyuzhichi.png" width="396" height="50"/></div>
</div>
<!---->
<div class="content_kj">
	<!--{include file="public/newgd.tpl"}-->
    <div style="clear:both"></div>
    <div class="zy_fwzckj">
    	<div class="fwzc_left">
        	<div class="bt"><img src="images/wzbazcbt.png" width="379" height="83" /></div>
            <div class="wzba_nr1">企业之家—时时刻刻为您创新网络服务！！！！</div>
          <div class="wzba_nr2">尊敬的用户，您好！备案中心收到您的备案材料后，会在五个工作日内录入系统并再次电话核实您的备案信息， 请保持工作时间手机畅通，以免影响您的备案审核。若您的备案未顺利通过景安预审核，请登录景安备案系统在"备案退回"中"退回原因"自助查看您网站备案未通过审核具体原因。<br />
          <span>备案时间：</span>   周一 ---- 周五   正常工作时间<br />

<span>备案专线： </span>  0371-9618961-3<br />

<span>备案地址：</span>   郑州花园路与广电南路交叉口西南角  信息大厦7层 701 备案中心
          </div>

		   <div class="wzba_tu1"><img src="images/wzba1.png" width="405" height="384" /></div>
			<div class="wzba_tu2"><img src="images/wzba2.jpg" width="650" height="483" /></div>
            <div class="wzba_nr3">网站备案帮助</div>
            <div class="wzba_nr4">
				<ul>
                <!--{arclist catid="132" num="9"}-->
                <li><span>{$fbdate|formatdate} </span><a href="view.asp?id={$id}">{$arctitle}</a></li> 
                <!--{/arclist}-->			
                </ul>
            </div>
            
            
            
            
        </div>
    <!--right-->
    <!--{include file="public/fuwuzhichi.tpl"}-->
    <div style="clear:both"></div>
    </div>
    
</div>
<!--{include file="public/footer.tpl"}-->
</body>
</html>
