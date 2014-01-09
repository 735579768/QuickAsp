<!--#INCLUDE FILE="init.asp"-->
<%

'输出页面优化内容
set rs=db.table("kl_meta").where("meta_key='cfg_system'").fild("meta_value").sel()
jsonstr=rs(0)&""
set seoobj=jsontoobj(jsonstr)
tpl.assign "indexseo",seoobj

hotkeys=split(server.HTMLEncode(seoobj("cfg_hotkeywords")),",")
tpl.assign "hotkeys",hotkeys


themes=seoobj("cfg_df_style")
tpl.p_tpl_dir=TPL_PATH&"/"&themes
tpl.p_tpl_suffix=".tpl"'为啦安全把模板改为tpl
'伪静态规则
'在模板最终输出时进行正则替换第一组替换中间用##隔开
dim url_suffex:url_suffex=".html"
redim regarr(6)
regarr(0)="cat\.asp\?catid\=(\d+)\&page\=(\d+)##cat_$1_$2"&url_suffex
regarr(1)="cat\.asp\?catid\=(\d+)##cat-$1"&url_suffex
regarr(2)="view\.asp\?id\=(\d+)##view-$1"&url_suffex
regarr(3)="charset=gb2312##charset=utf-8"
regarr(4)="search\.asp##search"
regarr(5)="comments\.asp##comments"


tpl.assign "qikannian",getqikannian()
tpl.assign "qikanyue",getqikanyue()
tpl.assign "qikanfenqi",getqikanfenqi()
%>