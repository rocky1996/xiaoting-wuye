<%@ page contentType="text/html;charset=GBK" %>
<%@ page import="java.sql.*"%>
<%@ page import="java.util.*" %>
<%@ page session="true" %>
<%@ page import="wygl.op.*" %>
<jsp:useBean id="wyfee" scope="page" class="wygl.run.op_wyfee" />
<jsp:useBean id="build" scope="page" class="wygl.run.op_build" />
<jsp:useBean id="fee" scope="page" class="wygl.run.op_fee" />
<%
if (session.getAttribute("user")==null || session.getAttribute("user")==""){
	response.sendRedirect("../error1.htm");
}
String mesg = "";
int Id=0;
if (request.getParameter("id")==null || request.getParameter("id").equals("")) {
		mesg = "��Ҫ�鿴����ҵ�Ѽ�¼��Ϣ������!";
} else {
	try {
		Id = Integer.parseInt(request.getParameter("id"));
		if (!wyfee.getOnewyfee(Id)){mesg = "..��Ҫ�鿴����ҵ�Ѽ�¼��Ϣ������!";}
	    } catch (Exception e){
		mesg = "��Ҫ�鿴����ҵ�Ѽ�¼��Ϣ������!";
	 }
}

%>
<script language="javascript">

function winclose() { 
window.close();//�ر� 
} 

</script>

<%@include file="../inc/gs.inc"%>
<body bgcolor="#43CD80">
<center>
<table border="0" cellpadding="0" cellspacing="0" width="70%">
<tr>
<td width="100%" colspan="3" style="border-left:none; border-right:none; border-top:none ; border-bottom:2 solid green">
<p align="center"><font size="2" color=green>��ҵ�Ѽ�¼��Ϣ&nbsp;<%=mesg%>&nbsp;<a href="javascript:window.close()">�رմ���</a></font></td>
</tr>
<tr>
<td width="100%" colspan="3"><font size=2 color=green>&nbsp;</font></td>
</tr>
<% if(mesg.equals("")){ wyfee bk = (wyfee) wyfee.getwyfeelist().elementAt(0);%>
<tr>
<td width="25%" style="border-left:none; border-right:none; border-top:none ; border-bottom:1 solid white">
<p align="center"><font size=2 color=green>��ҵ�Ѽ�¼���:</font></td>
<td width="25%" style="border-left:none; border-right:none; border-top:none ; border-bottom:1 solid white">
<font size=2 color=green>
<select name="feenum" style="width:100">
<%if (fee.seachallfee()){for (int i=0;i<fee.getfeelist().size();i++){fee feebc = (fee) fee.getfeelist().elementAt(i);%>
<option value="<%= feebc.getfeenum()%>" <%if(bk.getfeenum().equals(feebc.getfeenum())){%>selected<%}%>><%= feebc.getfeename() %></option>
<%}}%>
</select></font></td>
<td width="50%" style="border-left:none; border-right:none; border-top:none ; border-bottom:1 solid white">
<p align="center"><font size=2 color=red>&nbsp;</font></td>
</tr>
<tr>
<td width="25%" style="border-left:none; border-right:none; border-top:none ; border-bottom:1 solid white">
<p align="center"><font size=2 color=green>��ȡ����:</font></td>
<td width="75%" colspan="2" style="border-left:none; border-right:none; border-top:none ; border-bottom:1 solid white"><font size=2 color=green><input type=text size=20 maxlength=20 name="shouqurq" value=<%= bk.getshouqurq() %>></font></td>
</tr>
<tr>
<td width="25%" style="border-left:none; border-right:none; border-top:none ; border-bottom:1 solid white">
<p align="center"><font size=2 color=green>¥��:</font></td>
<td width="75%" colspan="2" style="border-left:none; border-right:none; border-top:none ; border-bottom:1 solid white"><font size=2 color=green><select name="buildnum" style="width:100">
<%if (build.seachallbuild()){for (int i=0;i<build.getbuildlist().size();i++){build bc = (build) build.getbuildlist().elementAt(i);%>
<option value="<%= bc.getbuildnum()%>" <%if(bk.getbuildnum().equals(bc.getbuildnum())){%>selected<%}%>><%= bc.getname() %></option>
<%}}%>
</select></font></td>
</tr>
<tr>
<td width="25%" style="border-left:none; border-right:none; border-top:none ; border-bottom:1 solid white">
<p align="center"><font size=2 color=green>��Ԫ��:</font></td>
<td width="75%" colspan="2" style="border-left:none; border-right:none; border-top:none ; border-bottom:1 solid white"><font size=2 color=green><input type=text size=15 maxlength=100 name="cellnum" value=<%= bk.getcellnum() %>></font></td>
</tr>
<tr>
<td width="25%" style="border-left:none; border-right:none; border-top:none ; border-bottom:1 solid white">
<p align="center"><font size=2 color=green>�����:</font></td>
<td width="75%" colspan="2" style="border-left:none; border-right:none; border-top:none ; border-bottom:1 solid white"><font size=2 color=green><input type=text size=15 maxlength=100 name="roomnum" value=<%= bk.getroomnum() %>></font></td>
</tr>
<tr>
<td width="25%" style="border-left:none; border-right:none; border-top:none ; border-bottom:1 solid white">
<p align="center"><font size=2 color=green>�Ƿ��շ�:</font></td>
<td width="75%" colspan="2" style="border-left:none; border-right:none; border-top:none ; border-bottom:1 solid white"><font size=2 color=green><input type=radio name="ispayment" value="1" <%if(bk.getroomnum().equals("1")){%>checked<%}%>>����&nbsp;<input type=radio name="ispayment" value="0" <%if(bk.getroomnum().equals("0")){%>checked<%}%>>δ��</font></td>
</tr>
<tr>
<td width="100%" colspan="3"><font size=2 color=green>&nbsp;</font></td>
</tr>
<%}%>
</table>

</center>
</body>