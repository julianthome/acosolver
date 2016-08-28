# From 155(var5) to 192(var1)
var string var5;
var string var1;

fun "org.snt.helix.wrappers.StringUtils.stripScriptTags(Ljava/lang/String;)Ljava/lang/String;" stripScriptTags;

&(var1,xss);
&(var5,xss);
==(stripScriptTags(var1),var5);
