<ul>
       <li><a href="/">{$indexseo.cfg_indexname}</a></li>
          <!--{arclist sql="select * from kl_cats where parent_id=0 and cat_show=1 order by sort asc"}-->
            <li><a href="{$cat_url|empty=cat.asp?catid eq $cat_id}">{$cat_name}</a></li>
            <!--{/arclist}-->
</ul>