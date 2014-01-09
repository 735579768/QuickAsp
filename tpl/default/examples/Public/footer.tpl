<ul>
       <li><a href="/">{$indexseo.cfg_indexname}</a></li>
          <!--{arclist sql="select * from kl_cats where parent_id=0 and cat_show=1 order by sort asc"}-->
            <li><a href="{$cat_url|empty=cat.asp?catid eq $cat_id}">{$cat_name}</a></li>
            <!--{/arclist}-->
       	<h3>友情链接：</h3>
             <!--{arclist sql="select * from kl_friend_link   order by sortrank asc"}-->
            <a href="{$friend_url|empty=#}">{$friend_name}</a>
            <!--{/arclist}-->
</ul>
{$indexseo.cfg_thirdcode}{$indexseo.cfg_beian}{$indexseo.cfg_webname}{$indexseo.cfg_powerby}