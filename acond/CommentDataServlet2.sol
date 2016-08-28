# From 113 to 120
var string var54;
var string var56;
var string var57;
var string var58;
var string var60;
var string var62;
var string var63;
var string var65;
var string var52;
var string var53;
var string var66;
var string var67;


fun "org.snt.helix.wrappers.VirtualWrapper.wrapEscapeHtml(Ljava/lang/String;)Ljava/lang/String;" wrapEscapeHtml;

&(var66, xss);
==(var67,apache_escecma(var66));
==(search(wrapEscapeHtml(var67),var57), true);
==(var52,tostr(var53));
==(var53,concat(var54,"\" \}"));
==(var54,concat(var56,var57));
==(var56,concat(var58,"content: \""));
==(var58,concat(var60,"\","));
==(var60,concat(var62,var63));
==(var62,concat(var65,"\{ id: \""));
