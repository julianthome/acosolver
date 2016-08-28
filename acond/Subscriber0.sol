var string var26;
var string var27;
var string var28;

fun "org.snt.helix.wrappers.URLEncodeFormEntity.encode(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;" encode;

&(var26,urli);
&(var28,urli);
==(var27,concat(var26,"/push/"));
==(encode("hub.callback",var27),var28));
