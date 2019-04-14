<%@ page contentType="text/html;charset=GBK" %>
<%@ page import="java.sql.*"%>
<%@ page import="java.util.*" %>
<%@ page session="true" %>
<%@ page import="wygl.op.*" %>
<jsp:useBean id="lodgecomplaint" scope="page" class="wygl.run.op_lodgecomplaint" />
<jsp:useBean id="build" scope="page" class="wygl.run.op_build" />
<%
if (session.getAttribute("user")==null || session.getAttribute("user")==""){
	response.sendRedirect("../error1.htm");
}
String mesg = "";
int Id=0;
if (request.getParameter("id")==null || request.getParameter("id").equals("")) {
		mesg = "你要查看的投诉信息不存在!";
} else {
	try {
		Id = Integer.parseInt(request.getParameter("id"));
		if (!lodgecomplaint.getOnelodgecomplaint(Id)){mesg = "..你要查看的投诉信息不存在!";}
	    } catch (Exception e){
		mesg = "你要查看的投诉信息不存在!";
	 }
}

%>
<script language="javascript">

function winclose() { 
window.close();//关闭 
} 

</script>

<%@ include file="../inc/gs.inc"%>
<body bgcolor="#43CD80">
<center>
<table border="0" cellpadding="0" cellspacing="0" width="70%">
<tr>
<td width="100%" colspan="3" style="border-left:none; border-right:none; border-top:none ; border-bottom:2 solid green">
<p align="center"><font size="2" color=green>投诉信息&nbsp;<%=mesg%>&nbsp;<a href="javascript:window.close()">关闭窗口</a></font></td>
</tr>
<tr>
<td width="100%" colspan="3"><font size=2 color=green>&nbsp;</font></td>
</tr>
<% if(mesg.equals("")){ lodgecomplaint bk = (lodgecomplaint) lodgecomplaint.getlodgecomplaintlist().elementAt(0);%>
<tr>
<td width="25%" style="border-left:none; border-right:none; border-top:none ; border-bottom:1 solid white">
<p align="center"><font size=2 color=green>楼盘编号:</font></td>
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
<p align="center"><font size=2 color=green>单元号:</font></td>
<td width="75%" colspan="2" style="border-left:none; border-right:none; border-top:none ; border-bottom:1 solid white"><font size=2 color=green><input type=text size=30 maxlength=100 name="cellnum" value=<%=bk.getcellnum()%>></font></td>
</tr>
<tr>
<td width="25%" style="border-left:none; border-right:none; border-top:none ; border-bottom:1 solid white">
<p align="center"><font size=2 color=green>房间号:</font></td>
<td width="75%" colspan="2" style="border-left:none; border-right:none; border-top:none ; border-bottom:1 solid white"><font size=2 color=green><input type=text size=30 maxlength=100 name="roomnum" value=<%=bk.getroomnum()%>></font></td>
</tr>
<tr>
<td width="25%" style="border-left:none; border-right:none; border-top:none ; border-bottom:1 solid white">
<p align="center"><font size=2 color=green>投诉人:</font></td>
<td width="75%" colspan="2" style="border-left:none; border-right:none; border-top:none ; border-bottom:1 solid white"><font size=2 color=green><input type=text size=30 maxlength=100 name="lodgeusername" value=<%=bk.getlodgeusername()%>></font></td>
</tr>
<tr>
<td width="100%" height=23 colspan="3" style="border-left:none; border-right:none; border-top:none ; border-bottom:2 solid green">
<p align="center"><font size=2 color=green>投诉内容</font></td>
</tr>
<tr>
<td width="100%" colspan="3" style="border-left:none; border-right:none; border-top:none ; border-bottom:1 solid white">
<p align="center"><font size=2 color=green><textarea name="reason" cols="70" rows="10"><%=bk.getreason()%></textarea></font></td>
</tr>
<tr>
<td width="100%" colspan="3"><font size=2 color=green>&nbsp;</font></td>
</tr>
<%}%>
</table>

</center>
</body>