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

d.add(88,0,'¥����Ϣ����','');
d.add(801,88,'¥����Ϣ����','../build/build.jsp','','show');
d.add(802,88,'����¥����Ϣ','../build/add_build.jsp','','show');


d.add(9,0,'ס����Ϣ����','');
d.add(601,9,'ס����Ϣ����','../resident/resident.jsp','','show');
d.add(602,9,'����ס����Ϣ','../resident/add_resident.jsp','','show');

d.add(6,0,'��ҵ�շѹ���','');
d.add(901,6,'��ҵ�շ���Ŀ','../fee/fee.jsp','','show');
d.add(902,6,'��ҵ�շѼ�¼','../fee/wyfee.jsp','','show');
d.add(903,6,'������ҵ�շ�','../fee/add_wyfee.jsp','','show');

d.add(7,0,'�û����޹���','');
d.add(701,7,'���޼�¼����','../sendrepair/sendrepair.jsp','','show');
d.add(703,7,'�������޵�','../sendrepair/add_sendrepair.jsp','','show');


d.add(5,0,'�û�Ͷ�߹���','');
d.add(14,5,'�û�Ͷ����Ϣ','../lodgecomplaint/lodgecomplaint.jsp','','show');
d.add(15,5,'����Ͷ�ߵ�','../lodgecomplaint/add_lodgecomplaint.jsp','','show');

d.add(8,0,'С���������','');
d.add(80,8,'������Ϣ����','../news/news.jsp','','show');


d.add(60,0,'ϵͳ����','#');
d.add(171,60,'�û�����','../system/user.jsp','','show');
d.add(172,60,'ϵͳ����','../help.htm','','show');
document.write(d);
//-->
</script>
</div>
</body>
</html>