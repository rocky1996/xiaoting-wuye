<%@ page contentType="text/html;charset=GBK" %>
<%@ page import="java.sql.*"%>
<%@ page import="java.util.*" %>
<%@ page session="true" %>
<%@include file="../inc/session.inc"%>
<%@include file="../inc/rq.inc"%>
<%@ page import="wygl.op.*" %>
<jsp:useBean id="lodgecomplaint" scope="page" class="wygl.run.op_lodgecomplaint" />
<jsp:useBean id="build" scope="page" class="wygl.run.op_build" />
<%
if (session.getAttribute("user")==null || session.getAttribute("user")==""){
	response.sendRedirect("../error1.htm");
}
String mesg = "";



	String submit = request.getParameter("Submit");
	int Id =0;
	if (submit!=null && !submit.equals("")){		
		if(lodgecomplaint.getRequest(request)){
			if(lodgecomplaint.update()){
				mesg = "Ͷ����Ϣ�޸ĳɹ�!";
			} else {
				mesg = "���ݿ����ʧ��";
			}
		}else {
			mesg = "�Բ������ύ�Ĳ����д���";
		}
	}
	if (request.getParameter("id")==null || request.getParameter("id").equals("")) {
		mesg = "��Ҫ�޸ĵ����ݲ�������!";
	} else {
		try {
			Id = Integer.parseInt(request.getParameter("id"));
			if (!lodgecomplaint.getOnelodgecomplaint(Id)){
				mesg = "��Ҫ�޸ĵ����ݲ�����";
			}
		} catch (Exception e){
			mesg = "��Ҫ�޸ĵ����ݲ�������!";
		}
	}
%>
<script language="javascript">

function openScript(url,name, width, height){
	var Win = window.open(url,name,'width=' + width + ',height=' + height + ',top=150,left=250,resizable=1,scrollbars=yes,menubar=no,status=yes' );
}


  function checkform() {
	if (document.main.lodgeusername.value=="") {
		alert("Ͷ���˲���Ϊ��!");
		document.main.lodgeusername.focus();
		return false;
	}
	
	if (document.main.buildnum.value=="") {
		alert("��Ų���Ϊ��!");
		document.main.buildnum.focus();
		return false;
	}

	return true;

  }

function winclose() { 
	window.opener.location.reload();//ˢ�� 
window.close();//�ر� 


} 

function winclose1() { 
	
window.close();//�ر� 
}

</script>
<head>
</head>
<%@ include file="../inc/gs.inc"%>
<body bgcolor="#43CD80">
<center><form name="main" method="post" action="lodgecomplaint_modify.jsp">
<table border="0" cellpadding="0" cellspacing="0" width="70%">

<tr>
<td width="100%" colspan="3" style="border-left:none; border-right:none; border-top:none ; border-bottom:2 solid green">
<p align="center"><font size="2" color=green>&gt;hͶ����Ϣ&nbsp;&nbsp;<%=mesg%>&nbsp;
<%if(mesg.equals("")){%><a href="javascript:winclose1()">�رմ���</a><%}else{%><a href="javascript:winclose()">�رմ���</a><%}%></font></td>
</tr>
<tr>
<td width="100%" colspan="3"><font size=2 color=green>&nbsp;</font></td>
</tr>
<% if(mesg.equals("")){
lodgecomplaint bk = (lodgecomplaint) lodgecomplaint.getlodgecomplaintlist().elementAt(0);
%>
<tr>
<td width="25%" style="border-left:none; border-right:none; border-top:none ; border-bottom:1 solid white">
<p align="center"><font size=2 color=green>¥�̱��:</font></td>
<td width="25%" style="border-left:none; border-right:none; border-top:none ; border-bottom:1 solid white"><font size=2 color=green><select name="buildnum" style="width:100">
<%if (build.seachallbuild()){for (int i=0;i<build.getbuildlist().size();i++){build bc = (build) build.getbuildlist().elementAt(i);%>
<option value="<%= bc.getbuildnum()%>" <%if(bk.getbuildnum().equals(bc.getbuildnum())){%>selected<%}%>><%= bc.getname() %></option>
<%}}%>
</select></font></td>
<td width="50%" style="border-left:none; border-right:none; border-top:none ; border-bottom:1 solid white">
<p align="center">&nbsp;</td>
</tr>
<tr>
<td width="25%" style="border-left:none; border-right:none; border-top:none ; border-bottom:1 solid white">
<p align="center"><font size=2 color=green>��Ԫ��:</font></td>
<td width="75%" colspan="2" style="border-left:none; border-right:none; border-top:none ; border-bottom:1 solid white"><font size=2 color=green><input type=text size=30 maxlength=100 name="cellnum" value=<%=bk.getcellnum()%>></font></td>
</tr>
<tr>
<td width="25%" style="border-left:none; border-right:none; border-top:none ; border-bottom:1 solid white">
<p align="center"><font size=2 color=green>�����:</font></td>
<td width="75%" colspan="2" style="border-left:none; border-right:none; border-top:none ; border-bottom:1 solid white"><font size=2 color=green><input type=text size=30 maxlength=100 name="roomnum" value=<%=bk.getroomnum()%>></font></td>
</tr>
<tr>
<td width="25%" style="border-left:none; border-right:none; border-top:none ; border-bottom:1 solid white">
<p align="center"><font size=2 color=green>Ͷ����:</font></td>
<td width="75%" colspan="2" style="border-left:none; border-right:none; border-top:none ; border-bottom:1 solid white"><font size=2 color=green><input type=text size=30 maxlength=100 name="lodgeusername" value=<%=bk.getlodgeusername()%>></font></td>
</tr>
<tr>
<td width="100%" height=23 colspan="3" style="border-left:none; border-right:none; border-top:none ; border-bottom:2 solid green">
<p align="center"><font size=2 color=green>Ͷ������</font></td>
</tr>
<tr>
<td width="100%" colspan="3" style="border-left:none; border-right:none; border-top:none ; border-bottom:1 solid white">
<p align="center"><font size=2 color=green><textarea name="reason" cols="70" rows="10"><%=bk.getreason()%></textarea></font></td>
</tr>
<tr>
<td width="100%" colspan="3"><font size=2 color=green>&nbsp;</font></td>
</tr>
<tr>
<td width="100%" colspan="3" style="border-left:none; border-right:none; border-top:none ; border-bottom:2 solid green">
<p align="center"><font size=2 color=green>
<input type="hidden" name="id" value="<%= Id %>">
<input type="submit" name="Submit" value="�ύ" onclick="return(checkform());">
&nbsp;&nbsp;<input type="reset" name="reset" value="����"></font></td>
</tr>
<%}%>

</table></form>

</center>
</body>