 <!--footer--> 
 <div class="footer">
 	<div class="footer_nr">
   	  <div class="nr_kj">
        	<h3><a href="#">网站建设</a></h3>
            <ul>
            <!--{arclist sql="select * from kl_cats where parent_id=115"}-->             
            	<li><a href="cat.asp?catid={$cat_id}">{$cat_name}</a></li>
                <!--{/arclist}-->
            </ul>
        </div>
        
        <div class="nr_kj">
        	<h3><a href="ruanjiankaifa.asp">软件开发</a></h3>
            <ul> 
            	<li><a href="#">IOA协同办公软件</a></li>
                <li><a href="#">CRM客户管理软件</a></li>
                <li><a href="#">酒店管理软件</a></li>
                <li><a href="#">美容业管理软件</a></li>
                <li><a href="#">定制软件开发</a></li>
            </ul>
        </div>
        
        <div class="nr_kj">
        	<h3><a href="cat.asp?catid=117">推广优化</a></h3>
            <ul>      
                   <!--{arclist sql="select * from kl_cats where parent_id=117"}-->             
            	<li><a href="cat.asp?catid={$cat_id}">{$cat_name}</a></li>
                <!--{/arclist}-->
            </ul>
        </div>
        
        <div class="nr_kj">
        	<h3><a href="cat.asp?catid=134">平台运营</a></h3>
            <ul>    
            	<li><a href="#">百科辅导网</a></li>
                <li><a href="#">商都采暖网</a></li>
                <li><a href="#">商都法律网</a></li>
            </ul>
        </div>
        
        <div class="nr_kj">
        	<h3><a href="cat.asp?catid=29">营销培训</a></h3>
            <ul>   
                    <!--{arclist sql="select * from kl_cats where parent_id=29"}-->             
            	<li><a href="cat.asp?catid={$cat_id}">{$cat_name}</a></li>
                <!--{/arclist}-->
            </ul>
        </div>
        
        <div class="nr_kj" style="background:none;">
        	<h3><a href="cat.asp?catid=114">服务与支持</a></h3>
            <ul>   
            	<li><a href="cat.asp?catid=133">客服支持</a></li>
                <li><a href="cat.asp?catid=114">网站备案帮助</a></li>
                <li><a href="cat.asp?catid=119">联系我们</a></li>
            </ul>
        </div>
        
        <div class="gotop"><a href="#go_top"><img src="images/gotop.jpg" width="53" height="27" /></a></div>
    </div>
 </div> 
<!--版权-->
<div class="banquan">
详情咨询电话：13633719215   服 务QQ：735579768<br />
版权所有 © 2013-2015 企业之家网站制作<br />  	
</div>
<script>
function correctPNG() // correctly handle PNG transparency in Win IE 5.5 & 6. 
{ 
    var arVersion = navigator.appVersion.split("MSIE") 
    var version = parseFloat(arVersion[1]) 
    if ((version >= 5.5) && (document.body.filters)) 
    { 
       for(var j=0; j<document.images.length; j++) 
       { 
          var img = document.images[j] 
          var imgName = img.src.toUpperCase() 
          if (imgName.substring(imgName.length-3, imgName.length) == "PNG") 
          { 
             var imgID = (img.id) ? "id='" + img.id + "' " : "" 
             var imgClass = (img.className) ? "class='" + img.className + "' " : "" 
             var imgTitle = (img.title) ? "title='" + img.title + "' " : "title='" + img.alt + "' " 
             var imgStyle = "display:inline-block;" + img.style.cssText 
             if (img.align == "left") imgStyle = "float:left;" + imgStyle 
             if (img.align == "right") imgStyle = "float:right;" + imgStyle 
             if (img.parentElement.href) imgStyle = "cursor:hand;" + imgStyle 
             var strNewHTML = "<span " + imgID + imgClass + imgTitle 
             + " style=\"" + "width:" + img.width + "px; height:" + img.height + "px;" + imgStyle + ";" 
             + "filter:progid:DXImageTransform.Microsoft.AlphaImageLoader" 
             + "(src=\'" + img.src + "\', sizingMethod='scale');\"></span>" 
             img.outerHTML = strNewHTML 
             j = j-1 
          } 
       } 
    }     
} 
if(window.attachEvent){
	window.attachEvent("onload", correctPNG);
	}
window.onerror=function(){return true;};
</script> 
{$indexseo.cfg_thirdcode}