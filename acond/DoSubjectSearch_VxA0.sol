# From 110(var9) to 29(var1)
var string var1;
var string var3;
var string var4;
var string var6;
var string var7;
var string var9;

&(var9,sqlistr);
==(var1,var3);
==(var3,concat(var4,"' AND ROWNUM \<= 50 ORDER BY tpcw_item\.i_title"));
==(var4,concat(var6,var7));
==(var6,"SELECT \* FROM tpcw_item, tpcw_author WHERE tpcw_item\.i_a_id = tpcw_author\.a_id AND tpcw_item\.i_subject = '");
==(var9,var7);
