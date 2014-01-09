function autowh() {
	var imgnum=0;
	var imgsetwhnum=0;
	var defaults = {
			'autoW' : 138, //nav显示时候拥有的类
			'autoH' : 130, //div显示的时候拥有的类
			'sel' : '.imgbox img' //tab的切换模式，默认为mouseover
		};
	this.run = function (options) {
		defaults = $.extend(defaults, options);
		imgnum=$(defaults.sel).length;
		$(defaults.sel).bind('load',function(){setWH($(this));});
		$(defaults.sel).each(function (index, element) {
			setWH($(this));
			});
		obj = this;
		if(imgnum!=imgsetwhnum){
		setTimeout(function () {
			obj.run({
				'autoW' : defaults.autoW, //宽
				'autoH' : defaults.autoH, //高
				'sel' : defaults.sel //选择器
			});
		}, 100);
		}
	};
	var setWH=function(thisobj){
			var w = thisobj.width();
			var h = thisobj.height();
			if (w != 0 && h != 0) {
				if (!thisobj.parent().hasClass('imgwrap')) {
					thisobj.wrap("<div class='imgwrap'></div>");
					thisobj.parent(".imgwrap").css({
						border : 'solid 1px #ccc',
						display : 'table-cell',
						'vertical-align' : 'middle',
						 width : defaults.autoW + 'px',
						 height : defaults.autoH + 'px',
						'text-align' : 'center'
					});
					thisobj.css({
						border : 'none'

					});
					if (w > h) {
						thisobj.removeAttr('height');
						if (w > defaults.autoW) {
							thisobj.attr('width', defaults.autoW - 8);
							var temh = thisobj.height();
							if (temh > defaults.autoH) {
								thisobj.removeAttr('width');
								thisobj.attr('height', defaults.autoH - 8);
							}

						} else {
							thisobj.attr('width', w);
						}

					} else {
						thisobj.removeAttr('width');
						if (h > defaults.autoH) {
							thisobj.attr('height', defaults.autoH - 8);
							var temw = thisobj.width();
							if (temw > defaults.autoW) {
								thisobj.removeAttr('height');
								thisobj.attr('width', defaults.autoW - 8);
							}

						} else {
							thisobj.attr('height', h);
						}
					}
				}
				imgsetwhnum++;
			}
	};


}
/*
ie6下面加入下面样式
.imgwrap{_font-family:Arial;_position:relative;}
.imgwrap img{ _top:50%; _left:50%;_position:absolute;_vertical-align: middle;_margin-left:expression(-this.width/2);_margin-top:expression(-this.height/2);}
*/
$(function () {
	var a = new autowh()
		a.run({
			'autoW' : 150, //宽
			'autoH' : 94, //高
			'sel' : '.er_1nr img' //选择器
		})
	var b = new autowh()
		b.run({
			'autoW' : 140, //宽
			'autoH' : 94, //高
			'sel' : '.fengcnr img' //选择器
		})
	var c = new autowh()
		c.run({
			'autoW' : 146, //宽
			'autoH' : 110, //高
			'sel' : '.ziznr img' //选择器
		})
	var d = new autowh()
		d.run({
			'autoW' : 162, //宽
			'autoH' : 160, //高
			'sel' : '.cpzstu img' //选择器
		})
	var e = new autowh()
		e.run({
			'autoW' : 156, //宽
			'autoH' : 160, //高
			'sel' : '.zy_cpzstu img' //选择器
		})
	var f = new autowh()
		f.run({
			'autoW' : 160, //宽
			'autoH' : 112, //高
			'sel' : '.xstdnrkj img' //选择器
		})

});

//提交表单验证
$(function () {
	$('.nonull').bind('focus', function () {
		$(this).css({
			border : 'solid 1px #ccc',
			color : '#000'
		});
		if ($(this).val() == '请输入内容')
			$(this).val('')
	});
});
function tjcheck(formname) {
	var re = true;
	$('.nonull').each(function (index, element) {
		if ($(this).val() == '' || $(this).val() == '请输入内容') {
			$(this).val('请输入内容')
			$(this).css({
				color : '#ccc',
				border : 'solid 1px #f00'
			});
			re = false;
		}
	});
	if (re) {
		$("#" + formname).submit();
	}
}
//提交表单验证
/*
<a href="javascript:void(0)" onclick="SetHome(this,window.location)">设为首页</a>
<a href="javascript:void(0)" onclick="shoucang(document.title,window.location)">加入收藏</a>
 */
// 设置为主页
function SetHome(obj, vrl) {
	try {
		obj.style.behavior = 'url(#default#homepage)';
		obj.setHomePage(vrl);
	} catch (e) {
		if (window.netscape) {
			try {
				netscape.security.PrivilegeManager.enablePrivilege("UniversalXPConnect");
			} catch (e) {
				alert("此操作被浏览器拒绝！\n请在浏览器地址栏输入“about:config”并回车\n然后将 [signed.applets.codebase_principal_support]的值设置为'true',双击即可。");
			}
			var prefs = Components.classes['@mozilla.org/preferences-service;1'].getService(Components.interfaces.nsIPrefBranch);
			prefs.setCharPref('browser.startup.homepage', vrl);
		} else {
			alert("您的浏览器不支持，请按照下面步骤操作：1.打开浏览器设置。2.点击设置网页。3.输入：" + vrl + "点击确定。");
		}
	}
}

// 加入收藏 兼容360和IE6
function shoucang(sTitle, sURL) {
	try {
		window.external.addFavorite(sURL, sTitle);
	} catch (e) {
		try {
			window.sidebar.addPanel(sTitle, sURL, "");
		} catch (e) {
			alert("加入收藏失败，请使用Ctrl+D进行添加");
		}
	}
}
//window.onerror=function(){return true;};