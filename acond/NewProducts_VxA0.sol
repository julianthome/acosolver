# From 75(var16) to 82(var1)
var string var1;
var string var2;
var string var3;
var string var5;
var string var7;
var string var9;
var string var10;
var string var11;
var string var13;
var string var15;
var string var16;

&(var16,sqlistr);
==(var1,var2);
==(var2,concat(var3,"order by i_pub_date desc, i_title asc"));
==(var3,concat(var5,"and i_a_id = a_id"));
==(var5,concat(var7,"', 'YYYY\-MM\-DD HH24:MI:SS'\)"));
==(var7,concat(var9,var10));
==(var9,concat(var11,"and i_pub_date \> to_timestamp\('"));
==(var11,concat(var13,"'\)"));
==(var13,concat(var15,var16));