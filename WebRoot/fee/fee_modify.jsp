<%@ page contentType="text/html;charset=GBK" %>
<%@ page import="java.sql.*"%>
<%@ page import="java.util.*" %>
<%@ page session="true" %>
<%@include file="../inc/session.inc"%>
<%@include file="../inc/rq.inc"%>
<%@ page import="wygl.op.*" %>
<jsp:useBean id="fee" scope="page" class="wygl.run.op_fee" />
<%
if (session.getAttribute("user")==null || session.getAttribute("user")==""){
	response.sendRedirect("../error1.htm");
}
String mesg = "";



	String submit = request.getParameter("Submit");
	int Id =0;
	if (submit!=null && !submit.equals("")){		
		if(fee.getRequest(request)){
			if(fee.update()){
				mesg = "物业费信息修改成功!";
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
			if (!fee.getOnefee(Id)){
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
	if (document.main.feename.value=="") {
		alert("名称不能为空!");
		document.main.feename.focus();
		return false;
	}
	
	if (document.main.feenum.value=="") {
		alert("编号不能为空!");
		document.main.feenum.focus();
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
<center><form name="main" method="post" action="fee_modify.jsp">
<table border="0" cellpadding="0" cellspacing="0" width="70%">

<tr>
<td width="100%" colspan="3" style="border-left:none; border-right:none; border-top:none ; border-bottom:2 solid green">
<p align="center"><font size="2" color=green>物业费信息&nbsp;&nbsp;<%=mesg%>&nbsp;
<%if(mesg.equals("")){%><a href="javascript:winclose1()">关闭窗口</a><%}else{%><a href="javascript:winclose()">关闭窗口</a><%}%></font></td>
</tr>
<tr>
<td width="100%" colspan="3"><font size=2 color=green>&nbsp;</font></td>
</tr>
<% if(mesg.equals("")){
fee bk = (fee) fee.getfeelist().elementAt(0);
%>
<tr>
<td width="25%" style="border-left:none; border-right:none; border-top:none ; border-bottom:1 solid white">
<p align="center"><font size=2 color=green>物业费编号:</font></td>
<td width="25%" style="border-left:none; border-right:none; border-top:none ; border-bottom:1 solid white"><font size=2 color=green><input type=text size=10 maxlength=100 name="feenum" value=<%=bk.getfeenum()%>></font></td>
<td width="50%" style="border-left:none; border-right:none; border-top:none ; border-bottom:1 solid white">
<p align="center"><font size=2 color=red>* 系统自动生成</font></td>
</tr>
<tr>
<td width="25%" style="border-left:none; border-right:none; border-top:none ; border-bottom:1 solid white">
<p align="center"><font size=2 color=green>物业费名称:</font></td>
<td width="75%" colspan="2" style="border-left:none; border-right:none; border-top:none ; border-bottom:1 solid white"><font size=2 color=green><input type=text size=30 maxlength=100 name="feename" value=<%=bk.getfeename()%>></font></td>
</tr>
<tr>
<td width="25%" style="border-left:none; border-right:none; border-top:none ; border-bottom:1 solid white">
<p align="center"><font size=2 color=green>物业费金额:</font></td>
<td width="75%" colspan="2" style="border-left:none; border-right:none; border-top:none ; border-bottom:1 solid white"><font size=2 color=green><input type=text size=10 maxlength=100 name="moneynum" value=<%=bk.getmoneynum()%>>(元)</font></td>
</tr>
<tr>
<td width="25%" style="border-left:none; border-right:none; border-top:none ; border-bottom:1 solid white">
<p align="center"><font size=2 color=green>收取时间:</font></td>
<td width="75%" colspan="2" style="border-left:none; border-right:none; border-top:none ; border-bottom:1 solid white"><font size=2 color=green><input type=text size=20 maxlength=100 name="shouqutime" value=<%=bk.getshouqutime()%>></font></td>
</tr>
<tr>
<td width="100%" height=23 colspan="3" style="border-left:none; border-right:none; border-top:none ; border-bottom:2 solid green">
<p align="center"><font size=2 color=green>物业费介绍</font></td>
</tr>
<tr>
<td width="100%" colspan="3" style="border-left:none; border-right:none; border-top:none ; border-bottom:1 solid white">
<p align="center"><font size=2 color=green><textarea name="info" cols="70" rows="10"><%=bk.getinfo()%></textarea></font></td>
</tr>
<tr>
<td width="100%" colspan="3"><font size=2 color=green>&nbsp;</font></td>
</tr>
<tr>
<td width="100%" colspan="3" style="border-left:none; border-right:none; border-top:2 solid green ; border-bottom:none">
<p align="center"><font size=2 color=green>
<input type="hidden" name="id" value="<%= Id %>">
<input type="submit" name="Submit" value="提交" onclick="return(checkform());">
&nbsp;&nbsp;<input type="reset" name="reset" value="重置"></font></td>
</tr>
<%}%>

</table></form>

</center>
</body>