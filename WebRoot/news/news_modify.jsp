<%@ page contentType="text/html;charset=GBK" %>
<%@ page import="java.sql.*"%>
<%@ page import="java.util.*" %>
<%@ page session="true" %>
<%@include file="../inc/session.inc"%>
<%@include file="../inc/rq.inc"%>
<%@ page import="wygl.op.*" %>
<jsp:useBean id="news" scope="page" class="wygl.run.op_news" />
<%
if (session.getAttribute("user")==null || session.getAttribute("user")==""){
	response.sendRedirect("../error1.htm");
}
String mesg = "";



	String submit = request.getParameter("Submit");
	int Id =0;
	if (submit!=null && !submit.equals("")){		
		if(news.getRequest(request)){
			if(news.update()){
				mesg = "小区公告息修改成功!";
			} else {
				mesg = "数据库操作失败";
			}
		}else {
			mesg = "对不起，你提交的参数有错误";
		}
	}
	if (request.getParameter("id")==null || request.getParameter("id").equals("")) {
		mesg = "你要修改的数据参数错误!";
	} else {
		try {
			Id = Integer.parseInt(request.getParameter("id"));
			if (!news.getOnenews(Id)){
				mesg = "你要修改的数据不存在";
			}
		} catch (Exception e){
			mesg = "你要修改的数据参数错误!";
		}
	}
%>
<script language="javascript">

function openScript(url,name, width, height){
	var Win = window.open(url,name,'width=' + width + ',height=' + height + ',top=150,left=250,resizable=1,scrollbars=yes,menubar=no,status=yes' );
}


  function checkform() {
	if (document.main.title.value=="") {
		alert("标题名称不能为空!");
		document.main.title.focus();
		return false;
	}
	
	if (document.main.senddate.value=="") {
		alert("发布日期不能为空!");
		document.main.senddate.focus();
		return false;
	}

	return true;

  }

function winclose() { 
	window.opener.location.reload();//刷新 
window.close();//关闭 


} 

function winclose1() { 
	
window.close();//关闭 
}

</script>
<head>
</head>
<%@ include file="../inc/gs.inc"%>
<body bgcolor="#43CD80">
<center><form name="main" method="post" action="news_modify.jsp">
<table border="0" cellpadding="0" cellspacing="0" width="70%">

  <tr>
    <td width="100%" colspan="3" style="border-left:none; border-right:none; border-top:none ; border-bottom:2 solid green">
      <p align="center"><font size="2" color=green>小区公告息&nbsp;&nbsp;<%=mesg%>&nbsp;
<%if(mesg.equals("")){%><a href="javascript:winclose1()">关闭窗口</a><%}else{%><a href="javascript:winclose()">关闭窗口</a><%}%></font></td>
  </tr>
  <tr>
    <td width="100%" colspan="3"><font size=2 color=green>&nbsp;</font></td>
  </tr>
  <% if(mesg.equals("")){
news bk = (news) news.getnewslist().elementAt(0);
%>
   <tr>
    <td width="25%" style="border-left:none; border-right:none; border-top:none ; border-bottom:1 solid white">
      <p align="center"><font size=2 color=green>公告标题:</font></td>
    <td width="75%" colspan="2" style="border-left:none; border-right:none; border-top:none ; border-bottom:1 solid white"><font size=2 color=green><input type=text size=50 maxlength=100 name="title" value=<%=bk.gettitle()%>></font></td>
    </tr>
 <tr>
    <td width="25%" style="border-left:none; border-right:none; border-top:none ; border-bottom:1 solid white">
      <p align="center"><font size=2 color=green>发布日期:</font></td>
    <td width="75%" colspan="2" style="border-left:none; border-right:none; border-top:none ; border-bottom:1 solid white"><font size=2 color=green><input type=text size=20 maxlength=100 name="senddate" value=<%=bk.getsenddate()%>></font></td>
  </tr>
  <tr>
    <td width="100%" height=23 colspan="3" style="border-left:none; border-right:none; border-top:none ; border-bottom:2 solid green">
      <p align="center"><font size=2 color=green>小区公告内容</font></td>
  </tr>
  <tr>
    <td width="100%" colspan="3" style="border-left:none; border-right:none; border-top:none ; border-bottom:1 solid white">
      <p align="center"><font size=2 color=green><textarea name="contant" cols="70" rows="10"><%=bk.getcontant()%></textarea></font></td>
  </tr>
  <tr>
    <td width="100%" colspan="3"><font size=2 color=green>&nbsp;</font></td>
  </tr>
  <tr>
    <td width="100%" colspan="3" style="border-left:none; border-right:none; border-top:none ; border-bottom:2 solid green">
      <p align="center"><font size=2 color=green>
	   <input type="hidden" name="id" value="<%= Id %>">
	   <input type="submit" name="Submit" value="提交" onclick="return(checkform());">
&nbsp;&nbsp;<input type="reset" name="reset" value="重置"></font></td>
  </tr>
  <%}%>
 
</table> </form>

</center>
</body>