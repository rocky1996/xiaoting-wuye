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

d.add(88,0,'楼盘信息管理','');
d.add(801,88,'楼盘信息管理','../build/build.jsp','','show');
d.add(802,88,'新增楼盘信息','../build/add_build.jsp','','show');


d.add(9,0,'住户信息管理','');
d.add(601,9,'住户信息管理','../resident/resident.jsp','','show');
d.add(602,9,'新增住户信息','../resident/add_resident.jsp','','show');

d.add(6,0,'物业收费管理','');
d.add(901,6,'物业收费项目','../fee/fee.jsp','','show');
d.add(902,6,'物业收费记录','../fee/wyfee.jsp','','show');
d.add(903,6,'新增物业收费','../fee/add_wyfee.jsp','','show');

d.add(7,0,'用户报修管理','');
d.add(701,7,'报修记录管理','../sendrepair/sendrepair.jsp','','show');
d.add(703,7,'新增报修单','../sendrepair/add_sendrepair.jsp','','show');


d.add(5,0,'用户投诉管理','');
d.add(14,5,'用户投诉信息','../lodgecomplaint/lodgecomplaint.jsp','','show');
d.add(15,5,'新增投诉单','../lodgecomplaint/add_lodgecomplaint.jsp','','show');

d.add(8,0,'小区公告管理','');
d.add(80,8,'公告信息管理','../news/news.jsp','','show');


d.add(60,0,'系统管理','#');
d.add(171,60,'用户管理','../system/user.jsp','','show');
d.add(172,60,'系统帮助','../help.htm','','show');
document.write(d);
//-->
</script>
</div>
</body>
</html>