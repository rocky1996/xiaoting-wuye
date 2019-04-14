<%@ page contentType="text/html;charset=GBK" %>
<%@include file="inc/session.inc"%>
<html>
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
input {
	Font-family:Verdana, Arial, Helvetica, Sans-serif,宋体; Text-decoration: None; Border-top-width: 1px; Border-left-width: 1px; Font-size: 12px; Border-bottom-width: 1px; Border-right-width: 1px
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
</style>
<body bgcolor="#43CD80" >

<div align="center">
<font size=2 color=white>
版权所有 @ XX物业管理系统:2019
&nbsp;&nbsp;&nbsp;&nbsp;<a href="#" onclick="window.parent.location = 'login.jsp'">【注销】</a>
&nbsp;<a class="x" href="pass_modify.jsp?user=<%=user%>" target="show">【修改密码】</a>
</font>
</div>
</body>
</html>
