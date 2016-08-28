var string var1;
var string var2;

fun "org.snt.helix.wrappers.StringUtils.filterHTML(Ljava/lang/String;)Ljava/lang/String;" filterHTML;

&(var1,xss);
&(var2,xss);
==(filterHTML(var1),var2);

