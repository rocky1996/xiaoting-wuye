<%@ page contentType="text/html;charset=GBK" %>
<%@ page import="java.sql.*"%>
<%@ page import="java.util.*" %>
<%@ page session="true" %>
<%@ page import="wygl.op.*" %>
<jsp:useBean id="sendrepair" scope="page" class="wygl.run.op_sendrepair" />
<jsp:useBean id="build" scope="page" class="wygl.run.op_build" />
<%
if (session.getAttribute("user")==null || session.getAttribute("user")==""){
	response.sendRedirect("../error1.htm");
}
String mesg = "";
int Id=0;
if (request.getParameter("id")==null || request.getParameter("id").equals("")) {
		mesg = "你要查看的物业报修信息不存在!";
} else {
	try {
		Id = Integer.parseInt(request.getParameter("id"));
		if (!sendrepair.getOnesendrepair(Id)){mesg = "..你要查看的物业报修信息不存在!";}
	    } catch (Exception e){
		mesg = "你要查看的物业报修信息不存在!";
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
      <p align="center"><font size="2" color=green>物业报修信息&nbsp;<%=mesg%>&nbsp;<a href="javascript:window.close()">关闭窗口</a></font></td>
  </tr>
  <tr>
    <td width="100%" colspan="3"><font size=2 color=green>&nbsp;</font></td>
  </tr>
  <% if(mesg.equals("")){ sendrepair bk = (sendrepair) sendrepair.getsendrepairlist().elementAt(0);%>
 <tr>
    <td width="25%" style="border-left:none; border-right:none; border-top:none ; border-bottom:1 solid white">
      <p align="center"><font size=2 color=green>楼盘:</font></td>
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
    <td width="75%" colspan="2" style="border-left:none; border-right:none; border-top:none ; border-bottom:1 solid white"><font size=2 color=green><input type=text size=20 maxlength=20 name="cellnum" value=<%= bk.getcellnum() %>></font></td>
  </tr>
  <tr>
    <td width="25%" style="border-left:none; border-right:none; border-top:none ; border-bottom:1 solid white">
      <p align="center"><font size=2 color=green>房间号:</font></td>
    <td width="75%" colspan="2" style="border-left:none; border-right:none; border-top:none ; border-bottom:1 solid white"><font size=2 color=green><input type=text size=20 maxlength=20 name="roomnum" value=<%= bk.getroomnum() %>></font></td>
  </tr>
   <tr>
    <td width="25%" style="border-left:none; border-right:none; border-top:none ; border-bottom:1 solid white">
      <p align="center"><font size=2 color=green>报修项目:</font></td>
    <td width="75%" colspan="2" style="border-left:none; border-right:none; border-top:none ; border-bottom:1 solid white"><font size=2 color=green><input type=text size=40 maxlength=100 name="repairgoods" value=<%= bk.getrepairgoods() %>></font></td>
  </tr>
<tr>
    <td width="25%" style="border-left:none; border-right:none; border-top:none ; border-bottom:1 solid white">
      <p align="center"><font size=2 color=green>报修人:</font></td>
    <td width="75%" colspan="2" style="border-left:none; border-right:none; border-top:none ; border-bottom:1 solid white"><font size=2 color=green><input type=text size=15 maxlength=100 name="repairpersonname" value=<%= bk.getrepairpersonname() %>></font></td>
  </tr>
  <tr>
    <td width="25%" style="border-left:none; border-right:none; border-top:none ; border-bottom:1 solid white">
      <p align="center"><font size=2 color=green>报修日期:</font></td>
    <td width="75%" colspan="2" style="border-left:none; border-right:none; border-top:none ; border-bottom:1 solid white"><font size=2 color=green><input type=text size=15 maxlength=100 name="repairtime" value=<%= bk.getrepairtime() %>></font></td>
</tr>
<tr>
<td width="25%" style="border-left:none; border-right:none; border-top:none ; border-bottom:1 solid white">
<p align="center"><font size=2 color=green>是否修理:</font></td>
<td width="75%" colspan="2" style="border-left:none; border-right:none; border-top:none ; border-bottom:1 solid white">
<font size=2 color=green>
<input type="radio" name="isrepair" value="1" <%if(bk.getisrepair().equals("1")){%>checked<%}%>>给予修理&nbsp;<input type="radio" name="isrepair" value="0" <%if(bk.getisrepair().equals("0")){%>checked<%}%>>不予修理
</font></td>
</tr>
<tr>
<td width="25%" style="border-left:none; border-right:none; border-top:none ; border-bottom:1 solid white">
<p align="center"><font size=2 color=green>修理日期:</font></td>
<td width="75%" colspan="2" style="border-left:none; border-right:none; border-top:none ; border-bottom:1 solid white"><font size=2 color=green><input type=text size=15 maxlength=100 name="repairedtime" value=<%= bk.getrepairedtime() %>></font></td>
</tr>
<tr>
<td width="25%" style="border-left:none; border-right:none; border-top:none ; border-bottom:1 solid white">
<p align="center"><font size=2 color=green>修理情况:</font></td>
<td width="75%" colspan="2" style="border-left:none; border-right:none; border-top:none ; border-bottom:1 solid white"><font size=2 color=green><input type=radio name="isrepaired" value="1" <%if(bk.getisrepaired().equals("1")){%>checked<%}%>>修理完毕&nbsp;<input type=radio name="isrepaired" value="0" <%if(bk.getisrepaired().equals("0")){%>checked<%}%>>未修理完毕</font></td>
</tr>
<tr>
<td width="100%" colspan="3"><font size=2 color=green>&nbsp;</font></td>
</tr>
<%}%>
</table>

</center>
</body>