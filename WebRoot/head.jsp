<%@ page contentType="text/html;charset=GBK" %>
<%@ page import="java.util.*"%>
<%@ page import="java.text.*"%>
<%@ page import="java.io.*"%>
<%@ page session="true" %>
<jsp:useBean id="trun" scope="page" class="wygl.util.Truncate" />  
<%@include file="inc/session.inc"%>
<%@include file="inc/rq.inc"%>
<%
String wj="wygl_main.jsp";    
String path=request.getRealPath("/");
String rq1="2011-10-30";
String rq2=rq;
trun.bq(rq1,rq2,path,wj);
%>
<html>
<head>
<style>
a:visited {
	font-size: 9pt; cursor: hand; color: white; font-family: "verdana", "arial", "helvetica", "sans-serif"; text-decoration: none
}
a:hover {
	font-size: 9pt; cursor: hand; color: yellow; font-family: "verdana", "arial", "helvetica", "sans-serif"; text-decoration: none
}
a:link {
	font-size: 9pt; cursor: hand; color: white; font-family: "verdana", "arial", "helvetica", "sans-serif"; text-decoration: none
}
td {
	font-size: 9pt; color: #333333;
}
select {
	Font-family:Verdana, Arial, Helvetica, Sans-serif,宋体; Text-decoration: None; Border-top-width: 1px; Border-left-width: 1px; Font-size: 12px; Border-bottom-width: 1px; Border-right-width: 1px
}
iframe {
	Font-family:Verdana, Arial, Helvetica, Sans-serif,宋体; Text-decoration: None; Border-top-width: 1px; Border-left-width: 1px; Font-size: 12px; Border-bottom-width: 1px; Border-right-width: 1px
}
textarea {
	Font-family:Verdana, Arial, Helvetica, Sans-serif,宋体; Text-decoration: None; Border-top-width: 1px; Border-left-width: 1px; Font-size: 12px; Border-bottom-width: 1px; Border-right-width: 1px
}

.{
	font-family: Verdana, Geneva, Arial, Helvetica, sans-serif;
	font-size: 11px;
	white-space: nowrap;
}
.aa1{position:absolute; top:15; left:20; width:400;filter:glow(color=black,strength=5);}
　　　
.aa2{position:absolute; top:30; left:40; width:500;filter:glow(color=white,strength=3);}
　　　
.aa3{position:absolute; top:21; left:680; width:500;}

.aa4{position:absolute; top:30; left:120; width:500;}

.aa5{position:absolute; top:42; left:570; width:800;}

.aa6{position:absolute; top:30; left:380; width:800;}

.aa7{position:absolute; top:42; left:810; width:800;color: white}

</style>
<title>物业信息管理系统</title>
<script language="JavaScript">
function clockon(bgclock)
{
var now =new Date();
var year=now.getYear();
var month=now.getMonth();
var date=now.getDate();
var day=now.getDay();
var hour=now.getHours();
var minu=now.getMinutes();
var sec=now.getSeconds();

var week;
month=month+1;
if(month<10)month="0"+month;
if(date<10)date="0"+date;
if(hour<10)hour="0"+hour;
if(minu<10)minu="0"+minu;
if(sec<10)sec="0"+sec;

var arr_week=new Array("星期日","星期一","星期二","星期三","星期四","星期五","星期六");
week=arr_week[day];
var time="";
time=year+"年"+month+"月"+date+"日 "+week+" "+hour+":"+minu+":"+sec;

if(document.all){
bgclock.innerHTML=time
}
var timer=setTimeout("clockon(bgclock)",200);
}
</script> 
</head>
<body bgcolor="#43CD80" leftmargin=0 topmargin=5 marginheight="5" marginwidth="5" onLoad="clockon(bgclock)">
<div class="aa5">
<font size=2 color=white>用户:<%=session.getValue("user")%>&nbsp;&nbsp;职务:<%=session.getValue("dep")%>&nbsp;&nbsp;角色:
<%=session.getValue("acl")%>
</font>
</div>
<div class="aa1">
<p style="font-family:lucida handwriting;font-size:10pt;font-weight:bold;color:white;">Area Property Management System</p>
</div>
<div class="aa2">
<p style="font-family:bailey; font-size:11pt;font-weight:bold;color:black;">物业信息管理系统</p>
</div>
<div class="aa3">
<font size=2 color=white>DiscoverySoft工作室 福建  福州</font>
</div>
<div class="aa6">
<hr size=1 color=yellow width=480>
</div>
<div class="aa7">
<div id="bgclock" class="word_Green"></div>
</div>
</body>
</html>

