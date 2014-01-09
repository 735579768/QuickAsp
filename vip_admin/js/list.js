// JavaScript Document
function selAll(){
	$(".np").each(function(index, element) {
        $(this).attr('checked','checked');	
    });
	setBatchIdStr();
	}
function noSelAll(){
	$(".np").each(function(index, element) {
		$(this).removeAttr('checked');
    });
	setBatchIdStr();
	}
//设置批量id字符串
function setBatchIdStr(){
		var selidstr="";
				$(".checkid").each(function(index, element) {
					if($(this).attr("checked")){
						if(selidstr==""){
							selidstr+=$(this).val();
							}else{
							selidstr+=','+$(this).val();
								}
					}
				});
				$("#batchidstr").val(selidstr);
				console.log($("#batchidstr").val());
	}
