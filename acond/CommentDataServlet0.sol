# From 114 to 120
var string var1;
var string var2;
var string var3;
var string var5;
var string var6;
var string var7;
var string var9;
var string var11;
var string var12;
var string var13;
var string var14;
var string var15;

fun "org.snt.helix.wrappers.VirtualWrapper.wrapEscapeHtml(Ljava/lang/String;)Ljava/lang/String;" wrapEscapeHtml;

&(var6, xss);
==(var15,apache_escecma(var13));
==(wrapEscapeHtml(var15),var6);
==(var1,tostr(var2));
==(var2,concat(var3,"\" \}"));
==(var3,concat(var5,var6));
==(var5,concat(var7,"content: \""));
==(var7,concat(var9,"\","));
==(var9,concat(var11,var12));
==(var11,concat(var14,"\{ id: \""));
