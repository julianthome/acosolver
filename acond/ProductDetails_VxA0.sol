# From 48(var11) to 64(var1)
var string var1;
var string var2;
var string var3;
var string var4;
var string var5;
var int var7;
var int var8;
var int var10;
var string var11;
var string var12;


&(var4,sqlinum);
==(var1,var2);
==(var2,concat(var3,var4));
==(var3,var5);
==(var5,tostr("Select i_id, i_title, a_fname, a_lname, i_pub_date, i_publisher,  i_subject, i_desc, i_cost, i_srp, i_avail, i_isbn, i_page, i_dimensions, i_image from item, author where a_id = i_a_id and i_id ="));
<(var7,var8);
or(==(var7,0),==(var7,var10));
!=(var11,var12);
