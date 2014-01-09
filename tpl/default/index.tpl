<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>{$indexseo.cfg_home}</title>
<meta name="keywords" content="{$indexseo.cfg_keywords}" />
<meta name="description" content="{$indexseo.cfg_description}" />
<link type="text/css" rel="stylesheet" href="css/index.css" />

<SCRIPT type=text/javascript src="js/jquery.js"></SCRIPT>
<!–[if lt IE 7]>
<SCRIPT type=text/javascript src="js/jquery.pngFix.js"></SCRIPT>
<![endif]–>
<SCRIPT type=text/javascript src="js/jquery.ui.core.js"></SCRIPT>

<SCRIPT type=text/javascript src="js/fho-slideshow.js"></SCRIPT>
<script type="text/javascript" src="js/m.js"></script>
</head>

<body>
<tag:keli name="赵克立传入的参数"/>
<tag:test param="这个是传入的参数" />

<!--{include file="public/header.tpl"}-->
<!--banner-->
<div class="banner_w" style="display:none">
</div>
<div id=mainBody>
      <DIV id=main-body-bg></DIV>
      <DIV 
      style="BACKGROUND: none transparent scroll repeat 0% 0%; HEIGHT: 109px"></DIV><INPUT 
      id=hdnSlideIndex value=0 type=hidden name=hdnSlideIndex> 
</div>
<!--content-->
<div class="content_kj">
		<!--{include file="public/newgd.tpl"}-->
    <div style="clear:both"></div>
    <!--内容2-->
   
    <div class="content1">
    	<div class="left"></div>
        <div class="center">
        	<div class="kj">
            	<div class="bt"><span>01</span><a href="cat.asp?catid=115">网站建站</a></div>
                <div class="nra"><img src="images/content1_1.jpg" width="132" height="101" /></div>
                <ul>               
            <!--{arclist sql="select * from kl_cats where parent_id=115"}-->             
            	<li><a href="cat.asp?catid={$cat_id}">{$cat_name}</a></li>
                <!--{/arclist}-->
                </ul>
            </div>
            
            <div class="kj">
            	<div class="bt"><span>02</span><a href="cat.asp?catid=116">软件开发</a></div>
                <div class="nra"><img src="images/content1_2.jpg" width="132" height="101" /></div>
				<ul>
                	<li><a href="#">IOA协同办公软件</a></li>
                    <li><a href="#">CRM客户管理软件</a></li>
                    <li><a href="#">酒店管理软件</a></li>
                    <li><a href="#">美容业管理软件</a></li>
                    <li><a href="#">定制软件开发</a></li>
                </ul>
            </div>
            
            <div class="kj">
            	<div class="bt"><span>03</span><a href="cat.asp?catid=117">推广优化</a></div>
                <div class="nra"><img src="images/content1_3.jpg" width="132" height="101" /></div>
                <ul>      
            <!--{arclist sql="select * from kl_cats where parent_id=117"}-->             
            	<li><a href="cat.asp?catid={$cat_id}">{$cat_name}</a></li>
                <!--{/arclist}-->
                </ul>
            </div>
            
            <div class="kj">
            	<div class="bt"><span>04</span><a href="cat.asp?catid=28">整合营销</a></div>
                <div class="nra"><img src="images/content1_4.jpg" width="132" height="101" /></div>
                <div class="nrb"><a href="#">网络营销的重要任务之一就是在互联网上运营管理企业网站，以及让企业的网下...</a></div>
            </div>
            
            <div class="kj" style="border:none">
            	<div class="bt"><span>05</span><a href="cat.asp?catid=134">平台运营</a></div>
                <div class="nra"><img src="images/content1_5.jpg" width="132" height="101" /></div>
                <ul>    
     

                	<li><a target="_blank" href="http://www.luoyang88.com">洛阳防静电地板</a></li>
                    <li><a target="_blank" href="http://www.gxzx88.com">众鑫家具</a></li>
                    <li><a href="http://www.ruzhouba.com">汝州论坛</a></li>
                </ul>
            </div>
        </div>
        <div class="right"></div>   
    </div>
    <!--内容3-->
    <div class="content2">
		<div class="content2_left">
        	<div class="kl-tab">
            	<ul class="kl-tab-nav-block">
                  	<li class="kl-tab-nav"><a href="cat.asp?catid=31"><img src="images/tab_a1.jpg" width="131" height="50"/></a></li>
    				<li class="kl-tab-nav"><a href="cat.asp?catid=30"><img src="images/tab_a2.jpg" width="131" height="50"/></a></li>
                </ul>
                <div class="kl-tab-div-block">
                	<div class="kl-tab-div">
                    	<div class="list"  id="list-contenta-1" style="width:268px; height:182px;">
                          <div><img src="images/400dx_gg.jpg" width="268" height="90" /></div>
                          <div style="overflow:hidden; width:268px; height:92px;">
                            <div id="wsdd">
                                <div class="left_nr">
                                <ul>
                                    <!--{arclist catid="137" num="30"}-->
                                    <li>{$arctitle}</li>
                                    <!--{/arclist}-->                               
                                </ul>
                                </div>
                            </div>
                <SCRIPT>new Marquee("wsdd",0,1,268,82,29,0,300)</SCRIPT> 
                            </div>
                        </div>
                    </div>
                    <div class="kl-tab-div">
                    	<div class="list"  id="list-contenta-2"  style="width:268px; height:182px;">
                          <div><img src="images/gg1.jpg" width="268" height="90" /></div>
                          <div id="wenzi" style="overflow:hidden; width:268px; height:92px;">
                            <div class="sy_tab">
                            针对客户需要在短时间内迅速推广品牌的广告平台。网关通道，联通电信均 由内网（10655、10659）通道发送，移动由上海电信（021）广东电信 （0752、0756、0750）湖北电信（0724）发送。多通道同时发送，速度 达1000条/秒，每小时可发送350万条，到达率95%以上。
                            </div>
                <SCRIPT>new Marquee("wenzi",0,1,268,82,29,0,300)</SCRIPT> 
                            </div>
                        </div>
                    </div>
                </div>
            </div>

		</div>
      <div class="content2_right">
        	<div><img src="images/content2_2.jpg" width="677" height="112" /></div>
        <div class="right_nr">
            	<h3>企业之家愿与各界共同拓展事业的天空！！！</h3>
                <p>河南企业之家网络科技有限公司（企业之家59vip.cn）是一家专业的互联网技术与应用服务解决方案提供商。旨在为企、事业单位提供全新的互联网商务运营架构新模式。我们将策略思考、专业技术、互动咨询紧密结合，为用户设计并构建强大的互联网服务...</p>
            </div>
        </div>      
        <div style="clear:both"></div>
    </div>
    <!--内容4-->
    <div class="yxpx_bt"><a href="cat.asp?catid=29">+更多</a><img src="images/sy_bt1.jpg" width="183" height="39" /></div>
  <div class="yxpx_nr">
    <div class="yxpx_nrkj"> 
        	<h3 class="bt1"><a href="cat.asp?catid=108">微营销推广</a></h3>
			{tag:ArticleList catid="108" num="10" titlelen="15" /}
        </div>	
      <div class="yxpx_nrkj"> 
        	<h3 class="bt2"><a href="cat.asp?catid=107">SEO优化培训</a></h3>
        
{tag:ArticleList catid="107" num="10" titlelen="15" /}
        
    </div>
      <div class="yxpx_nrkj"> 
       	<h3 class="bt3"><a href="cat.asp?catid=106">电商营销</a></h3>
        {tag:ArticleList catid="106" num="10" titlelen="15" /}
            </div>
      <div class="yxpx_nrkj"> 
       	<h3 class="bt4"><a href="cat.asp?catid=118">网站建设培训</a></h3>
{tag:ArticleList catid="118" num="10" titlelen="15" /}
        
    </div>  
  </div>
  <!--内容5 客户-->
  <div class="content3"> 
  	<div class="content3_left">
    	<div class="left_bt"><a href="cat.asp?catid=25"><img src="images/sy_bt2.jpg" width="153" height="50" /></a></div>
        <table class="testtable" width="260" border="1" cellspacing="0" cellpadding="0" style=" border-collapse:collapse;">
        
        
              <!--{arclist catid="25" num="12" iteration="jishu"}-->
              <eq {$jishu} mod 2 neq 0><tr></eq>
                <td><img src="{$arcpic|empty=/images/default.jpg}" alt="{$arctitle}" title="{$arctitle}"/></td>
                <eq {$jishu} mod 2 = 0></tr></eq>
                <!--{/arclist}-->
</table>

    </div>
    <!--right-->
    <div class="content3_right">
    	<div class="right_bt"><a href="cat.asp?catid=23">+更多</a><img src="images/sy_bt3.jpg" width="227" height="49" /></div>
        
              <!--{arclist catid="23" num="3" hometj="1"}-->
                <div class="nr_kj">
        	<div class="tu"><a href="view.asp?id={$id}"><img src="{$arcpic|empty=images/default.jpg}" width="274" height="105" /></a></div>
        <div class="nr">
       	  <h3><a href="view.asp?id={$id}">{$arctitle|left=15}</a></h3>
          <p>{$arcdescr|left=70} ...<a href="view.asp?id={$id}">【详细】</a>
          </p>
        </div>
      </div>
                <!--{/arclist}-->
    </div>
  </div>
<!--{include file="public/footer.tpl"}-->
<script>
$(function(){
$.klplugin={
	/////////////////////////////////////////////////////tab切换特效/////////////////////////////////////////////
	runtab:function(options){
					var defaults={
						'navhoverclsname':'navhovercls',//nav显示时候拥有的类
						'divshowclsname':'divshowcls',//div显示的时候拥有的类
						'model':'mouseover'//tab的切换模式，默认为mouseover
						};
					var opts = $.extend(defaults, options); 
					
					$(".kl-tab .kl-tab-div").hide();
					$(".kl-tab .kl-tab-div:first-child").show();
					$(".kl-tab .kl-tab-nav").bind(opts.model,function(){
								var obj=$(this);
								 //查找要显示的div索引
								 obj.parents(".kl-tab").find(".kl-tab-nav").each(function(i) {
									if($(this).html()==obj.html()){
										//设置hover类
										obj.parents(".kl-tab").find(".kl-tab-nav").removeClass(opts.navhoverclsname);
										obj.addClass(opts.navhoverclsname);
										//隐藏掉所有的tabdiv
										obj.parents(".kl-tab").find(".kl-tab-div").hide();
										obj.parents(".kl-tab").find(".kl-tab-div").removeClass(opts.divshowclsname);
										
										obj.parents(".kl-tab").find(".kl-tab-div").eq(i).addClass(opts.divshowclsname);
										obj.parents(".kl-tab").find(".kl-tab-div").eq(i).show();
										}			 
								 });
					});
		}
	};
$.klplugin.runtab({
		'navhoverclsname':'a',//nav显示时候拥有的类
		'divshowclsname':'b',//div显示的时候拥有的类
		'model':'mouseover'
		});
	});
</script>
</body>
</html>
