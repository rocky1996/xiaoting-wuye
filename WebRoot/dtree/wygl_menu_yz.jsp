<%@ page contentType="text/html;charset=GBK" %>
<%@ page import="java.util.*"%>
<%@ page session="true" %>
<%@include file="../inc/session.inc"%>
<html>
<head>
<title>�˵�</title>
<link rel="StyleSheet" href="dtree.css" type="text/css" />
<script type="text/javascript" src="dtree.js"></script>
</head>
<body bgcolor="#43CD80">
<div class="dtree">
<script type="text/javascript">
<!--
d = new dTree('d');
d.add(0,-1,'�����˵�');

d.add(6,0,'��Ϣ�鿴','');
d.add(10,6,'��ҵ�շ�','../fee/fee.jsp','','show');
d.add(11,6,'���޷���','../sendrepair/add_sendrepair.jsp','','show');
d.add(12,6,'Ͷ�߷���','../lodgecomplaint/add_lodgecomplaint.jsp','','show');
d.add(13,6,'������Ϣ','../news/news.jsp','','show');


document.write(d);
//-->
</script>
</div>
</body>
</html>