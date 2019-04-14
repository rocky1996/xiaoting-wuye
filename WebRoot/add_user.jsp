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
				mesg = "住户资料提交成功!";
			} else {
				mesg = "数据库操作失败!";
			}
		}else {
			mesg = "对不起，你提交的参数有错误!";
		}
	}
%>
<script language="javascript">
  function checkform() {
	if (document.form1.name.value=="") {
		alert("名称不能为空!");
		document.form1.name.focus();
		
		return false;
	}
	if (document.form1.yh.value=="") {
		alert("注册名称不能为空!");
		document.form1.yh.focus();
		
		return false;
	}
	if (document.form1.password.value=="") {
		alert("密码不能为空!");
		document.form1.password.focus();
		return false;
	}
   if (document.form1.password.value!=document.form1.passconfirm.value){
		alert("确认密码不相符!");
		document.form1.passconfirm.focus();
		return false;
	}
	return true;

  }

function winclose() { 
window.close();//关闭 
} 
</script>
<%@include file="inc/gs.inc"%>
<html>
<body bgcolor="#43CD80">
<center><form name="form1" method="post" action="add_user.jsp">
<table border="0" cellpadding="0" cellspacing="0" width="70%" >

<tr>
<td width="100%" colspan="2" style="border-left:none; border-left:none; border-top:none; border-bottom:2 solid green">
<p align="center"><font size="2" color=green><b>注册新用户</b>&nbsp;&nbsp;<%=mesg%>&nbsp;<a href="javascript: winclose()"/>关闭窗口</a></font></td>
</tr>
<tr>
<td width="50%" align="center" style="border-left:none; border-left:none; border-top:none; border-bottom:1 solid white">
<font size="2" color=green>用&nbsp;&nbsp;名:<input type="text" name="yh" maxlength="20" size="14" ></td>
<td width="50%" align="center" style="border-left:none; border-left:none; border-top:none; border-bottom:1 solid white">
<font size="2" color=green>真实姓名:<input type="text" name="name" maxlength="20" size="14" ></td>
</tr>
<tr>
    <td width="50%" align="center" style="border-left:none; border-left:none; border-top:none; border-bottom:1 solid white">
	<font size="2" color=green>密&nbsp;&nbsp;码:<input type="password" name="password" maxlength="20" size="14" ></td>
    <td width="50%" align="center" style="border-left:none; border-left:none; border-top:none; border-bottom:1 solid white">
	<font size="2" color=green>确认密码:<input type="password" name="passconfirm" maxlength="20" size="14"></td>
  </tr>
  <tr>
    <td width="50%" align="center" style="border-left:none; border-left:none; border-top:none; border-bottom:1 solid white">
	<font size="2" color=green>职&nbsp;&nbsp;务:<input type="text" name="dep" maxlength="20" size="14" value="业主" readonly></td>
    <td width="50%" align="center" style="border-left:none; border-left:none; border-top:none; border-bottom:2 solid green">
	<font size="2" color=green>角&nbsp;&nbsp;色:<select name="acl" style="width:100">
<option value="用户" >用户</option>
</select></td>
  </tr>
<tr>
<td width="100%" colspan="2">
<p align="center"><input type="submit" name="Submit" value="提交" onclick="return(checkform());">
&nbsp;&nbsp;<input type="reset" name="reset" value="重置"></td>
</tr>

</table></form>


</center>
</body>
</html>