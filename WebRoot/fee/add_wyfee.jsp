<%@ page contentType="text/html;charset=GBK" %>
<%@ page import="java.sql.*"%>
<%@ page import="java.util.*" %>
<%@ page session="true" %>
<%@include file="../inc/session.inc"%>
<%@include file="../inc/rq.inc"%>
<%@ page import="wygl.op.*"%>
<jsp:useBean id="wyfee" scope="page" class="wygl.run.op_wyfee" />
<jsp:useBean id="build" scope="page" class="wygl.run.op_build" />
<jsp:useBean id="fee" scope="page" class="wygl.run.op_fee" />
<%
if (session.getAttribute("user")==null || session.getAttribute("user")==""){
	response.sendRedirect("../error1.htm");
}
String mesg="";

Random sjs=new Random();
int wyfeenum=sjs.nextInt(9999);


String submit = request.getParameter("Submit");
	if (submit!=null && !submit.equals("")){		
		if(wyfee.getRequest(request)){
			if(wyfee.insert()){
				mesg = "��ҵ�Ѽ�¼��Ϣ�ύ�ɹ�!";
			} else {
				mesg = "���ݿ����ʧ��";
			}
		}else {
			mesg = "�Բ������ύ�Ĳ����д���";
		}
	}



%>

<script language="javascript">
function openScript(url,name, width, height){
	var Win = window.open(url,name,'width=' + width + ',height=' + height + ',top=150,left=250,resizable=1,scrollbars=yes,menubar=no,status=yes' );
}

function checkform() {
	if (document.main.feenum.value=="") {
		document.main.feenum.focus();
		alert("��ҵ�����Ʋ���Ϊ��!");
		return false;
	}
	if (document.main.buildnum.value=="") {
		alert("¥�̼�¼��Ų���Ϊ��!");
		document.main.buildnum.focus();
		return false;
	}
   
	return true;

  }

</script>

<%@ include file="../inc/gs.inc"%>
<body bgcolor="#43CD80">
<center><form name="main" method="post" action="add_wyfee.jsp">
<table border="0" cellpadding="0" cellspacing="0" width="70%">

<tr>
<td width="100%" colspan="3" style="border-left:none; border-right:none; border-top:none ; border-bottom:2 solid green">
<p align="center"><font size="2" color=green>��ҵ�Ѽ�¼��Ϣ</font></td>
</tr>
<tr>
<td width="100%" colspan="3"><font size=2 color=green>&nbsp;</font></td>
</tr>
<tr>
<td width="25%" style="border-left:none; border-right:none; border-top:none ; border-bottom:1 solid white">
<p align="center"><font size=2 color=green>��ҵ����Ŀ:</font></td>
<td width="25%" style="border-left:none; border-right:none; border-top:none ; border-bottom:1 solid white"><font size=2 color=green><select name="feenum" style="width:100">
<%if (fee.seachallfee()){for (int i=0;i<fee.getfeelist().size();i++){fee feebc = (fee) fee.getfeelist().elementAt(i);%>
<option value="<%= feebc.getfeenum()%>" ><%= feebc.getfeename() %></option>
<%}}%>
</select></font></td>
<td width="50%" style="border-left:none; border-right:none; border-top:none ; border-bottom:1 solid white">
<p align="center">&nbsp;</td>
</tr>
<tr>
<td width="25%" style="border-left:none; border-right:none; border-top:none ; border-bottom:1 solid white">
<p align="center"><font size=2 color=green>��ȡ����:</font></td>
<td width="75%" colspan="2" style="border-left:none; border-right:none; border-top:none ; border-bottom:1 solid white"><font size=2 color=green><input type=text size=20 maxlength=20 name="shouqurq"></font></td>
</tr>
<tr>
<td width="25%" style="border-left:none; border-right:none; border-top:none ; border-bottom:1 solid white">
<p align="center"><font size=2 color=green>¥��:</font></td>
<td width="75%" colspan="2" style="border-left:none; border-right:none; border-top:none ; border-bottom:1 solid white"><font size=2 color=green><select name="buildnum" style="width:100">
<%if (build.seachallbuild()){for (int i=0;i<build.getbuildlist().size();i++){build bc = (build) build.getbuildlist().elementAt(i);%>
<option value="<%= bc.getbuildnum()%>" ><%= bc.getname() %></option>
<%}}%>
</select></font></td>
</tr>
<tr>
<td width="25%" style="border-left:none; border-right:none; border-top:none ; border-bottom:1 solid white">
<p align="center"><font size=2 color=green>��Ԫ��:</font></td>
<td width="75%" colspan="2" style="border-left:none; border-right:none; border-top:none ; border-bottom:1 solid white"><font size=2 color=green><input type=text size=15 maxlength=100 name="cellnum"></font></td>
</tr>
<tr>
<td width="25%" style="border-left:none; border-right:none; border-top:none ; border-bottom:1 solid white">
<p align="center"><font size=2 color=green>�����:</font></td>
<td width="75%" colspan="2" style="border-left:none; border-right:none; border-top:none ; border-bottom:1 solid white"><font size=2 color=green><input type=text size=15 maxlength=100 name="roomnum"></font></td>
</tr>
<tr>
<td width="25%" style="border-left:none; border-right:none; border-top:none ; border-bottom:1 solid white">
<p align="center"><font size=2 color=green>�Ƿ��շ�:</font></td>
<td width="75%" colspan="2" style="border-left:none; border-right:none; border-top:none ; border-bottom:1 solid white"><font size=2 color=green><input type=radio name="ispayment" value="1">����&nbsp;<input type=radio name="ispayment" value="0">δ��</font></td>
</tr>
<tr>
<td width="100%" colspan="3"><font size=2 color=green>&nbsp;</font></td>
</tr>
<tr>
<td width="100%" colspan="3" style="border-left:none; border-right:none; border-top:2 solid green ; border-bottom:none">
<p align="center"><font size=2 color=green><input type="submit" name="Submit" value="�ύ" onclick="return(checkform());">
&nbsp;&nbsp;<input type="reset" name="reset" value="����"></font></td>
</tr>

</table></form>
<br>
<div align=center><font size=2 color=green><%=mesg%></font></div>
</center>
</body>
