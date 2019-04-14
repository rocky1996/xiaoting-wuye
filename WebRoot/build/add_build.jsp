<%@ page contentType="text/html;charset=GBK" %>
<%@ page import="java.sql.*"%>
<%@ page import="java.util.*" %>
<%@ page session="true" %>
<%@include file="../inc/session.inc"%>
<%@include file="../inc/rq.inc"%>
<%@ page import="wygl.op.*"%>
<jsp:useBean id="build" scope="page" class="wygl.run.op_build" />
<%
if (session.getAttribute("user")==null || session.getAttribute("user")==""){
	response.sendRedirect("../error1.htm");
}
String mesg="";
Random sjs=new Random();
int buildnum=sjs.nextInt(9999);


String submit = request.getParameter("Submit");
	if (submit!=null && !submit.equals("")){		
		if(build.getRequest(request)){
			if(build.insert()){
				mesg = "楼盘信息提交成功!";
			} else {
				mesg = "数据库操作失败!";
			}
		}else {
			mesg = "对不起，你提交的参数有错误!";
		}
	}



%>

<script language="javascript">
function openScript(url,name, width, height){
	var Win = window.open(url,name,'width=' + width + ',height=' + height + ',top=150,left=250,resizable=1,scrollbars=yes,menubar=no,status=yes' );
}

function checkform() {
	if (document.main.name.value=="") {
		document.main.name.focus();
		alert("楼盘名称不能为空!");
		return false;
	}
	if (document.main.buildnum.value=="") {
		alert("楼盘编号不能为空!");
		document.main.buildnum.focus();
		return false;
	}
   
	return true;

  }

</script>

<%@ include file="../inc/gs.inc"%>
<body bgcolor="#43CD80">
<center><form name="main" method="post" action="add_build.jsp">
<table border="0" cellpadding="0" cellspacing="0" width="70%">

<tr>
<td width="100%" colspan="3" style="border-left:none; border-right:none; border-top:none ; border-bottom:2 solid green">
<p align="center"><font size="2" color=green>楼盘信息</font></td>
</tr>
<tr>
<td width="100%" colspan="3"><font size=2 color=green>&nbsp;</font></td>
</tr>
<tr>
<td width="25%" style="border-left:none; border-right:none; border-top:none ; border-bottom:1 solid white">
<p align="center"><font size=2 color=green>楼盘编号:</font></td>
<td width="25%" style="border-left:none; border-right:none; border-top:none ; border-bottom:1 solid white">
<font size=2 color=green><input type=text size=10 maxlength=100 name="buildnum" value=<%=buildnum%>></font></td>
<td width="50%" style="border-left:none; border-right:none; border-top:none ; border-bottom:1 solid white">
<p align="center"><font size=2 color=red>* 系统自动生成</font></td>
</tr>
<tr>
<td width="25%" style="border-left:none; border-right:none; border-top:none ; border-bottom:1 solid white">
<p align="center"><font size=2 color=green>楼盘名称:</font></td>
<td width="75%" colspan="2" style="border-left:none; border-right:none; border-top:none ; border-bottom:1 solid white"><font size=2 color=green><input type=text size=30 maxlength=100 name="name"></font></td>
</tr>
<tr>
<td width="25%" style="border-left:none; border-right:none; border-top:none ; border-bottom:1 solid white">
<p align="center"><font size=2 color=green>楼盘位置:</font></td>
<td width="75%" colspan="2" style="border-left:none; border-right:none; border-top:none ; border-bottom:1 solid white"><font size=2 color=green><input type=text size=40 maxlength=100 name="addr"></font></td>
</tr>
<tr>
<td width="100%" height=23 colspan="3" style="border-left:none; border-right:none; border-top:none ; border-bottom:2 solid green">
<p align="center"><font size=2 color=green>楼盘介绍</font></td>
</tr>
<tr>
<td width="100%" colspan="3" style="border-left:none; border-right:none; border-top:none ; border-bottom:1 solid white">
<p align="center"><font size=2 color=green><textarea name="info" cols="70" rows="10"></textarea></font></td>
</tr>
<tr>
<td width="100%" colspan="3"><font size=2 color=green>&nbsp;</font></td>
</tr>
<tr>
<td width="100%" colspan="3" style="border-left:none; border-right:none; border-top:2 solid green ; border-bottom:none">
<p align="center"><font size=2 color=green><input type="submit" name="Submit" value="提交" onclick="return(checkform());">
&nbsp;&nbsp;<input type="reset" name="reset" value="重置"></font></td>
</tr>

</table></form>
<br>
<div align=center><font size=2 color=green><%=mesg%></font></div>
</center>
</body>
