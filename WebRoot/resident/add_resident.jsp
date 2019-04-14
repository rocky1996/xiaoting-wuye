<%@ page contentType="text/html;charset=GBK" %>
<%@ page import="java.sql.*"%>
<%@ page import="java.util.*" %>
<%@ page session="true" %>
<%@include file="../inc/session.inc"%>
<%@include file="../inc/rq.inc"%>
<%@ page import="wygl.op.*"%>
<jsp:useBean id="resident" scope="page" class="wygl.run.op_resident" />
<jsp:useBean id="build" scope="page" class="wygl.run.op_build" />
<%
if (session.getAttribute("user")==null || session.getAttribute("user")==""){
response.sendRedirect("../error1.htm");
}
String mesg="";
Random sjs=new Random();
int residentnum=sjs.nextInt(9999);


String submit = request.getParameter("Submit");
if (submit!=null && !submit.equals("")){
if(resident.getRequest(request)){
if(resident.insert()){
mesg = "住户信息提交成功!";
} else {
mesg = "数据库操作失败";
}
}else {
mesg = "对不起，你提交的参数有错误";
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
alert("住户名称不能为空!");
return false;
}
if (document.main.residentnum.value=="") {
alert("住户编号不能为空!");
document.main.residentnum.focus();
return false;
}

return true;

}

</script>

<%@ include file="../inc/gs.inc"%>
<body bgcolor="#43CD80">
<center><form name="main" method="post" action="add_resident.jsp">
<table border="0" cellpadding="0" cellspacing="0" width="70%">

<tr>
<td width="100%" colspan="3" style="border-left:none; border-right:none; border-top:none ; border-bottom:2 solid green">
<p align="center"><font size="2" color=green>住户信息</font></td>
</tr>
<tr>
<td width="100%" colspan="3"><font size=2 color=green>&nbsp;</font></td>
</tr>
<tr>
<td width="25%" style="border-left:none; border-right:none; border-top:none ; border-bottom:1 solid white">
<p align="center"><font size=2 color=green>住户编号:</font></td>
<td width="25%" style="border-left:none; border-right:none; border-top:none ; border-bottom:1 solid white"><font size=2 color=green><input type=text size=10 maxlength=100 name="residentnum" value=<%=residentnum%>></font></td>
<td width="50%" style="border-left:none; border-right:none; border-top:none ; border-bottom:1 solid white">
<p align="center"><font size=2 color=red>* 系统自动生成</font></td>
</tr>
<tr>
<td width="25%" style="border-left:none; border-right:none; border-top:none ; border-bottom:1 solid white">
<p align="center"><font size=2 color=green>住户名称:</font></td>
<td width="75%" colspan="2" style="border-left:none; border-right:none; border-top:none ; border-bottom:1 solid white"><font size=2 color=green><input type=text size=30 maxlength=100 name="name"></font></td>
</tr>
<tr>
<td width="25%" style="border-left:none; border-right:none; border-top:none ; border-bottom:1 solid white">
<p align="center"><font size=2 color=green>楼盘:</font></td>
<td width="75%" colspan="2" style="border-left:none; border-right:none; border-top:none ; border-bottom:1 solid white"><font size=2 color=green><select name="buildnum" style="width:100">
<%if (build.seachallbuild()){for (int i=0;i<build.getbuildlist().size();i++){build bc = (build) build.getbuildlist().elementAt(i);%>
<option value="<%= bc.getbuildnum()%>" ><%= bc.getname() %></option>
<%}}%>
</select></font></td>
</tr>
<tr>
<td width="25%" style="border-left:none; border-right:none; border-top:none ; border-bottom:1 solid white">
<p align="center"><font size=2 color=green>单元号:</font></td>
<td width="75%" colspan="2" style="border-left:none; border-right:none; border-top:none ; border-bottom:1 solid white"><font size=2 color=green><input type=text size=15 maxlength=100 name="cellnum"></font></td>
</tr>
<tr>
<td width="25%" style="border-left:none; border-right:none; border-top:none ; border-bottom:1 solid white">
<p align="center"><font size=2 color=green>房间号:</font></td>
<td width="75%" colspan="2" style="border-left:none; border-right:none; border-top:none ; border-bottom:1 solid white"><font size=2 color=green><input type=text size=15 maxlength=100 name="roomnum"></font></td>
</tr>
<tr>
<td width="25%" style="border-left:none; border-right:none; border-top:none ; border-bottom:1 solid white">
<p align="center"><font size=2 color=green>房间面积:</font></td>
<td width="75%" colspan="2" style="border-left:none; border-right:none; border-top:none ; border-bottom:1 solid white"><font size=2 color=green><input type=text size=15 maxlength=100 name="area">(平米)</font></td>
</tr>
<tr>
<td width="100%" height=23 colspan="3" style="border-left:none; border-right:none; border-top:none ; border-bottom:2 solid green">
<p align="center"><font size=2 color=green>住户介绍</font></td>
</tr>
<tr>
<td width="100%" colspan="3" style="border-left:none; border-right:none; border-top:none ; border-bottom:1 solid white">
<p align="center"><font size=2 color=green><textarea name="otherinfo" cols="70" rows="10"></textarea></font></td>
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
