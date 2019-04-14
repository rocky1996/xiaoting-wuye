<%@ page contentType="text/html;charset=GBK" %>
<%@ page import="java.sql.*"%>
<%@ page import="java.util.*" %>
<%@ page import="java.io.*"%>
<%@ page session="true" %>
<%@ page import="wygl.op.*" %>
<%@ page language="java" import="java.sql.*, wygl.util.*" %>
<jsp:useBean id="db" scope="page" class="wygl.util.DataBase" />
<jsp:useBean id="resident" scope="page" class="wygl.run.op_resident" />
<jsp:useBean id="build" scope="page" class="wygl.run.op_build" />
<jsp:useBean id="trun" scope="page" class="wygl.util.Truncate" />   
<%
if (session.getAttribute("user")==null || session.getAttribute("user")==""){
	response.sendRedirect("../error1.htm");
}
String mesg="";
mesg= request.getParameter("mesg");
if (mesg==null) {mesg="";}

int pages=1;
if (request.getParameter("page")!=null && !request.getParameter("page").equals("")) {
	String requestpage = request.getParameter("page");	
	try {
		pages = Integer.parseInt(requestpage);
	} catch(Exception e) {
		mesg = "你要找的页码错误!";
	}
}


String io = request.getParameter("io");
	if(io==null || io=="") {io="";}

if(io.equals("1"))
{
String chkbx[]=request.getParameterValues("checkbox");
if(chkbx!=null){
for(int i = 0; i < chkbx.length; i++){
	if (resident.delete(Integer.parseInt(chkbx[i]))){
			mesg = "删除成功!";

	} else {
			mesg = "删除出错!";
		}	
			}
}else{
%>
<script language="JavaScript">
  alert("请选中记录!");
 </script>
<%
}
}

String keyword1 = request.getParameter("keyword1");
if (keyword1==null){ keyword1="";}else{mesg=mesg+keyword1;}
keyword1 = resident.to_String(keyword1);

String keyword2 = request.getParameter("keyword2");
if (keyword2==null){ keyword2="";}else{mesg=mesg+keyword2;}
keyword2 = resident.to_String(keyword2);

%>
<script language="javascript">
function openScript(url,name, width, height){
	var Win = window.open(url,name,'width=' + width + ',height=' + height + ',top=150,left=200,resizable=1,scrollbars=yes,menubar=no,status=yes' );
}

</script>
<html>
<%@include file="../inc/session.inc"%>
<%@ include file="../inc/gs.inc"%>
<body bgcolor="#43CD80">
<center><form name="a1" method="post" action="resident.jsp?page=1">
<table width="95%" border="0" cellspacing="0" bgcolor="#DEF3CE"  bordercolor="white" align="center" valign="top">

<tr align="center" bgcolor="#DEF3CE"> 
<td width=10% align=left><font size=2 color=green><b>::住户信息::</b></font></td>
<td width=70% align=center><font size=2 color=green>住户姓名：<INPUT type="text" NAME="keyword1" size=15 maxlength=40 value="<%= keyword1%>">
&nbsp;楼盘：<select name="keyword2" style="width:100">
<option value="">所有</option>
<%if (build.seachallbuild()){for (int i=0;i<build.getbuildlist().size();i++){build bc = (build) build.getbuildlist().elementAt(i);%>
<option value="<%= bc.getbuildnum()%>" ><%= bc.getname() %></option>
<%}}%>
</select>&nbsp;<a href="#" style="color:green;" onclick="javascript:a1.submit();">查询</a>
</font></td>
<td width=20% align=right>
<%if(acl.equals("管理员")) {	%>
<a href="#" style="color:red;" onclick="javascript:a2.submit();"><font size=2 color=green>删除记录</font></a>
<%}%></td>
</tr>

</table></form><form name="a2" method="post" action="resident.jsp">
<table width="95%" border="0" cellspacing="0" bgcolor="#E4EDFB"  bordercolor="white" align="center">

<tr height=23 align="center">
<input type=hidden name=io value=1>
<td width=8% align="left" style="border-left:none; border-right:none; border-top:2 solid green ; border-bottom:2 solid green">
<font size=2 color=green>编号</font></td>
<td width=10% align="left" style="border-left:none; border-right:none; border-top:2 solid green ; border-bottom:2 solid green">
<font size=2 color=green>住户名称</font></td>
<td width=30% align="left" style="border-left:none; border-right:none; border-top:2 solid green; border-bottom:2 solid green">
<font size=2 color=green>楼盘名称</font></td>
<td width=10% align="left" style="border-left:none; border-right:none; border-top:2 solid green; border-bottom:2 solid green">
<font size=2 color=green>单元号</font></td>
<td width=10% align="left" style="border-left:none; border-right:none; border-top:2 solid green; border-bottom:2 solid green">
<font size=2 color=green>房间号</font></td>
<td width=20% align="left" style="border-left:none; border-right:none; border-top:2 solid green; border-bottom:2 solid green">
<font size=2 color=green>面积</font></td>
<td width=12% align="left" style="border-left:none; border-right:none; border-top:2 solid green; border-bottom:2 solid green">
<font size=2 color=green>&nbsp;</font></td>
</tr>
<% if (resident.resident_search(request)) {
	for (int i=0;i<resident.getresidentlist().size();i++){
	     resident bk = (resident) resident.getresidentlist().elementAt(i);
   if(resident.getrecordCount()<1){
	   %>&nbsp;<%
   }else{
%>
<tr  bgcolor="#DEF3CE" onMouseOver=this.style.backgroundColor='#FFFFFF' onMouseOut=this.style.backgroundColor=''>
<td width=8% align="left" style="border-left:none; border-right:none; border-top:none; border-bottom:1 solid white">
<input name="checkbox" type="checkbox"  value=<%=bk.getId() %>>
<font size=2 color=green><%=(i+1)+(pages-1)*build.getPageSize()%></font></td>
<td width=10% align="left" style="border-left:none; border-right:none; border-top:none; border-bottom:1 solid white">
<font size=2 color=green><a href="#" onclick="openScript('resident_detail.jsp?id=<%=bk.getId() %>','sop',660,405);">
<%= bk.getname()%></a></font></td>
<td width=30% align="left" style="border-left:none; border-right:none; border-top:none; border-bottom:1 solid white">
<font size=2 color=green><%if (!build.getOnebuild1(bk.getbuildnum())){%>&nbsp;<%}else{build buildbk = (build) build.getbuildlist().elementAt(0);%><%= buildbk.getname() %><%}%></font></td>
<td width=10% align="left" style="border-left:none; border-right:none; border-top:none; border-bottom:1 solid white">
<font size=2 color=green><%= bk.getcellnum() %></font></td>
<td width=10% align="left" style="border-left:none; border-right:none; border-top:none; border-bottom:1 solid white">
<font size=2 color=green><%= bk.getroomnum() %></font></td>
<td width=20% align="left" style="border-left:none; border-right:none; border-top:none; border-bottom:1 solid white">
<font size=2 color=green><%= bk.getarea() %>(平米)</font></td>
<td width=12% align="left" style="border-left:none; border-right:none; border-top:none; border-bottom:1 solid white">
<%
if(acl.equals("管理员") ) {%>
<font size=2 color=green>
<a href="#" onclick="openScript('resident_modify.jsp?id=<%=bk.getId() %>','sop',660,405);">编辑
</a></font>&nbsp;
<font size=2 color=green>
<a href="#" onclick="openScript('resident_detail.jsp?id=<%=bk.getId() %>','sop',660,405);">查看</a></font>
<%}else{%>
<font size=2 color=green>
<a href="#" onclick="openScript('resident_detail.jsp?id=<%=bk.getId() %>','sop',660,405);">查看</a></font>
<%}%></td>
</tr>
<%}}

} else {%>
<tr>
<td align="center" colspan=8>&nbsp;</td>
</tr>
<% } %>

</table> </form>
<br>
<!--分页跳页-->
<%if(resident.getrecordCount()<1){%>
<table align="center" width="95%" border="0" cellspacing="0" cellpadding="0"  bgcolor="#E4EDFB">
<tr bgcolor="#DEF3CE">
<td width="50%" align="left" ><font size=2 color=green>没有记录!</font></td>
<td width="50%" align="right">&nbsp;</td>
</tr>
</table>
<%}else{%>
<table align="center" width="95%" border="0" cellspacing="0" cellpadding="0"  bgcolor="#E4EDFB">
<tr bgcolor="#DEF3CE">
 <td width="50%" align="left" ><font size=2 color=green>&nbsp提示:共<%= resident.getrecordCount()%>条记录</font></td>
<td width="50%" align="right"><font size=2 color=green>共<%= resident.getPageCount() %>页&nbsp;当前页第<%= resident.getPage() %>页　
<a href="resident.jsp?keyword1=<%=keyword1%>&keyword2=<%=keyword2%>">首页</a>&nbsp;
<% if (resident.getPage()>1) {%>
<a href="resident.jsp?keyword1=<%=keyword1%>&keyword2=<%=keyword2%>&page=<%= resident.getPage()-1 %>">上一页</a>&nbsp;<% }else{ %>上一页&nbsp;<%}%>
<% if (resident.getPage()<resident.getPageCount()-1) {%>
<a href="resident.jsp?keyword1=<%=keyword1%>&keyword2=<%=keyword2%>&page=<%= resident.getPage()+1 %>">下一页</a>&nbsp;<% }else{ %>下一页<%}%>
<a href="resident.jsp?keyword1=<%=keyword1%>&keyword2=<%=keyword2%>&page=<%= resident.getPageCount() %>">未页</a>&nbsp;</font></td>
</tr>
</table>
<%}%>
</center>
</body>
</html>