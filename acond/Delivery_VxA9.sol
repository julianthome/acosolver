# From 36(var987) to 123(var914)
var string var914;
var string var916;
var string var917;
var string var919;
var string var920;
var string var921;
var string var923;
var int var924;
var string var925;
var string var927;
var int var928;
var string var929;
var string var931;
var string var932;
var string var933;
var int var935;
var string var939;
var string var940;
var string var941;
var string var942;
var string var943;
var string var944;
var string var945;
var string var946;
var string var947;
var string var949;
var string var951;
var int var953;
var int var954;
var int var955;
var int var957;
var int var958;
var int var959;
var int var962;
var string var964;
var string var965;
var string var966;
var string var968;
var string var970;
var string var971;
var string var973;
var string var974;
var string var976;
var string var978;
var string var980;
var int var983;
var int var982;
var string var987;
var string var988;

&(var987,sqlistr);
==(var914,var916);
==(var916,concat(var917,"'"));
==(var917,concat(var919,var920));
==(var919,concat(var921,"AND o_w_id = '"));
==(var921,concat(var923,tostr(var924)));
==(var923,concat(var925,"AND o_d_id ="));
==(var925,concat(var927,tostr(var928)));
==(var927,concat(var929,"' WHERE o_id ="));
==(var929,concat(var931,var932));
==(var931,concat(var933,"UPDATE tpcc_orderr SET o_carrier_id = '"));
!=(var935,0);
==(var939,var940);
==(var940,concat(var941,"'"));
==(var941,concat(var942,var920));
==(var942,concat(var943,"AND o_w_id = '"));
==(var943,concat(var944,tostr(var924)));
==(var944,concat(var945,"AND o_d_id ="));
==(var945,concat(var946,tostr(var928)));
==(var946,concat(var947,"WHERE o_id ="));
==(var947,concat(var949,"FROM tpcc_orderr"));
==(var949,concat(var951,"SELECT o_c_id"));
!=(var953,0);
==(var954,0);
or(==(var955,0),==(var955,1));
==(var957,0);
==(var958,sub(var959,1));
==(var959,var924);
==(var928,-1);
==(var962,0);
==(var964,var965);
==(var965,concat(var966,"\) WHERE rownum = 1"));
==(var966,concat(var968,"' ORDER BY no_o_id ASC"));
==(var968,concat(var970,var920));
==(var970,concat(var971,"AND no_w_id = '"));
==(var971,concat(var973,tostr(var924)));
==(var973,concat(var974,"WHERE no_d_id ="));
==(var974,concat(var976,"FROM tpcc_new_order"));
==(var976,concat(var978,"SELECT no_o_id"));
==(var978,concat(var980,"SELECT \* FROM \("));
<=(var983,0);
==(var982,1);
==(var987,var920);
==(var988,var932);
