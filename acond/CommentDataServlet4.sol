# From 106 to 120
var string var95;
var string var97;
var string var98;
var string var100;
var string var101;
var string var102;
var string var87;
var string var88;
var string var89;
var string var91;
var string var92;
var string var93;


fun "org.snt.helix.wrappers.VirtualWrapper.wrapEscapeHtml(Ljava/lang/String;)Ljava/lang/String;" wrapEscapeHtml;

&(var101, xss);
==(var102,apache_escecma(var101));
==(search(wrapEscapeHtml(var102),var95), true);
==(var91,concat(var93,"content: \""));
==(var93,concat(var95,"\","));
==(var95,concat(var97,var98));
==(var97,concat(var100,"\{ id: \""));
==(var87,tostr(var88));
==(var88,concat(var89,"\" \}"));
==(var89,concat(var91,var92));
