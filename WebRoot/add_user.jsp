<%@ page contentType="text/html;charset=GBK" %>
<%@ page import="java.sql.*"%>
<%@ page import="java.util.*" %>
<%@ page session="true" %>
<%@ page import="wygl.op.*"%>
<jsp:useBean id="user" scope="page" class="wygl.run.op_user" />
<%

String mesg = "";

String submit = request.getParameter("Submit");
	if (submit!=null && !submit.equals("")){		
		if(user.getRequest(request)){
			if(user.insert()){
				mesg = "ס�������ύ�ɹ�!";
			} else {
				mesg = "���ݿ����ʧ��!";
			}
		}else {
			mesg = "�Բ������ύ�Ĳ����д���!";
		}
	}
%>
<script language="javascript">
  function checkform() {
	if (document.form1.name.value=="") {
		alert("���Ʋ���Ϊ��!");
		document.form1.name.focus();
		
		return false;
	}
	if (document.form1.yh.value=="") {
		alert("ע�����Ʋ���Ϊ��!");
		document.form1.yh.focus();
		
		return false;
	}
	if (document.form1.password.value=="") {
		alert("���벻��Ϊ��!");
		document.form1.password.focus();
		return false;
	}
   if (document.form1.password.value!=document.form1.passconfirm.value){
		alert("ȷ�����벻���!");
		document.form1.passconfirm.focus();
		return false;
	}
	return true;

  }

function winclose() { 
window.close();//�ر� 
} 
</script>
<%@include file="inc/gs.inc"%>
<html>
<body bgcolor="#43CD80">
<center><form name="form1" method="post" action="add_user.jsp">
<table border="0" cellpadding="0" cellspacing="0" width="70%" >

<tr>
<td width="100%" colspan="2" style="border-left:none; border-left:none; border-top:none; border-bottom:2 solid green">
<p align="center"><font size="2" color=green><b>ע�����û�</b>&nbsp;&nbsp;<%=mesg%>&nbsp;<a href="javascript: winclose()"/>�رմ���</a></font></td>
</tr>
<tr>
<td width="50%" align="center" style="border-left:none; border-left:none; border-top:none; border-bottom:1 solid white">
<font size="2" color=green>��&nbsp;&nbsp;��:<input type="text" name="yh" maxlength="20" size="14" ></td>
<td width="50%" align="center" style="border-left:none; border-left:none; border-top:none; border-bottom:1 solid white">
<font size="2" color=green>��ʵ����:<input type="text" name="name" maxlength="20" size="14" ></td>
</tr>
<tr>
    <td width="50%" align="center" style="border-left:none; border-left:none; border-top:none; border-bottom:1 solid white">
	<font size="2" color=green>��&nbsp;&nbsp;��:<input type="password" name="password" maxlength="20" size="14" ></td>
    <td width="50%" align="center" style="border-left:none; border-left:none; border-top:none; border-bottom:1 solid white">
	<font size="2" color=green>ȷ������:<input type="password" name="passconfirm" maxlength="20" size="14"></td>
  </tr>
  <tr>
    <td width="50%" align="center" style="border-left:none; border-left:none; border-top:none; border-bottom:1 solid white">
	<font size="2" color=green>ְ&nbsp;&nbsp;��:<input type="text" name="dep" maxlength="20" size="14" value="ҵ��" readonly></td>
    <td width="50%" align="center" style="border-left:none; border-left:none; border-top:none; border-bottom:2 solid green">
	<font size="2" color=green>��&nbsp;&nbsp;ɫ:<select name="acl" style="width:100">
<option value="�û�" >�û�</option>
</select></td>
  </tr>
<tr>
<td width="100%" colspan="2">
<p align="center"><input type="submit" name="Submit" value="�ύ" onclick="return(checkform());">
&nbsp;&nbsp;<input type="reset" name="reset" value="����"></td>
</tr>

</table></form>


</center>
</body>
</html>