<%@ page contentType="text/html;charset=GBK" %>
<%@ page import="java.sql.*"%>
<%@ page import="java.util.*" %>
<%@ page session="true" %>
<%@ page import="wygl.op.*" %>
<jsp:useBean id="news" scope="page" class="wygl.run.op_news" />
<%
if (session.getAttribute("user")==null || session.getAttribute("user")==""){
	response.sendRedirect("../error1.htm");
}
String mesg = "";
int Id=0;
if (request.getParameter("id")==null || request.getParameter("id").equals("")) {
		mesg = "��Ҫ�鿴��С��������Ϣ������!";
} else {
	try {
		Id = Integer.parseInt(request.getParameter("id"));
		if (!news.getOnenews(Id)){mesg = "..��Ҫ�鿴��С��������Ϣ������!";}
	    } catch (Exception e){
		mesg = "��Ҫ�鿴��С��������Ϣ������!";
	 }
}

%>
<script language="javascript">

function winclose() { 
window.close();//�ر� 
} 

</script>

<%@ include file="../inc/gs.inc"%>
<body bgcolor="#43CD80">
<center>
<table border="0" cellpadding="0" cellspacing="0" width="70%">
  <tr>
    <td width="100%" colspan="3" style="border-left:none; border-right:none; border-top:none ; border-bottom:2 solid green">
      <p align="center"><font size="2" color=green>С��������Ϣ&nbsp;<%=mesg%>&nbsp;<a href="javascript:window.close()">�رմ���</a></font></td>
  </tr>
  <tr>
    <td width="100%" colspan="3"><font size=2 color=green>&nbsp;</font></td>
  </tr>
  <% if(mesg.equals("")){ news bk = (news) news.getnewslist().elementAt(0);%>
  <tr>
    <td width="25%" style="border-left:none; border-right:none; border-top:none ; border-bottom:1 solid white">
      <p align="center"><font size=2 color=green>�������:</font></td>
    <td width="75%" colspan="2" style="border-left:none; border-right:none; border-top:none ; border-bottom:1 solid white"><font size=2 color=green><input type=text size=50 maxlength=100 name="title" value=<%=bk.gettitle()%>></font></td>
    </tr>
 <tr>
    <td width="25%" style="border-left:none; border-right:none; border-top:none ; border-bottom:1 solid white">
      <p align="center"><font size=2 color=green>��������:</font></td>
    <td width="75%" colspan="2" style="border-left:none; border-right:none; border-top:none ; border-bottom:1 solid white"><font size=2 color=green><input type=text size=20 maxlength=100 name="senddate" value=<%=bk.getsenddate()%>></font></td>
  </tr>
  <tr>
    <td width="100%" height=23 colspan="3" style="border-left:none; border-right:none; border-top:none ; border-bottom:2 solid green">
      <p align="center"><font size=2 color=green>С����������</font></td>
  </tr>
  <tr>
    <td width="100%" colspan="3" style="border-left:none; border-right:none; border-top:none ; border-bottom:1 solid white">
      <p align="center"><font size=2 color=green><textarea name="contant" cols="70" rows="10"><%=bk.getcontant()%></textarea></font></td>
  </tr>
 <tr>
    <td width="100%" colspan="3"><font size=2 color=green>&nbsp;</font></td>
  </tr>
  <%}%>
</table>

</center>
</body>