<%@ page contentType="text/html;charset=GBK" %>
<%@ page import="java.util.*"%>
<%@ page session="true" %>
<%@include file="../inc/session.inc"%>
<html>
<head>
<title>菜单</title>
<link rel="StyleSheet" href="dtree.css" type="text/css" />
<script type="text/javascript" src="dtree.js"></script>
</head>
<body bgcolor="#43CD80">
<div class="dtree">
<script type="text/javascript">
<!--
d = new dTree('d');
d.add(0,-1,'操作菜单');

d.add(6,0,'信息查看','');
d.add(10,6,'物业收费','../fee/fee.jsp','','show');
d.add(11,6,'报修服务','../sendrepair/add_sendrepair.jsp','','show');
d.add(12,6,'投诉服务','../lodgecomplaint/add_lodgecomplaint.jsp','','show');
d.add(13,6,'公告信息','../news/news.jsp','','show');


document.write(d);
//-->
</script>
</div>
</body>
</html>