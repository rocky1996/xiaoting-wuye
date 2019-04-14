<%@ page contentType="text/html;charset=GBK" %>
<%@ page import="java.sql.*"%>
<%@ page import="java.util.*" %>
<%@ page import="java.io.*"%>
<%@ page session="true" %>
<%@ page import="wygl.op.*" %>
<%@ page language="java" import="java.sql.*, wygl.util.*" %>
<jsp:useBean id="db" scope="page" class="wygl.util.DataBase" />
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
	if (build.delete(Integer.parseInt(chkbx[i]))){
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
keyword1 = build.to_String(keyword1);

String keyword2 = request.getParameter("keyword2");
if (keyword2==null){ keyword2="";}else{mesg=mesg+keyword2;}
keyword2 = build.to_String(keyword2);

%>
<script language="javascript">
function openScript(url,name, width, height){
	var Win = window.open(url,name,'width=' + width + ',height=' + height + ',top=150,left=250,resizable=1,scrollbars=yes,menubar=no,status=yes' );
}

</script>
<html>
<%@include file="../inc/session.inc"%>
<%@ include file="../inc/gs.inc"%>
<body bgcolor="#43CD80">
<center><form name="a1" method="post" action="build.jsp?page=1">
<table width="95%" border="0" cellspacing="0" bgcolor="#DEF3CE"  bordercolor="white" align="center" valign="top">

<tr align="center" bgcolor="#DEF3CE"> 
<td width=20% align=left><font size=2 color=green><b>::楼盘信息::</b></font></td>
<td width=60% align=center>
<font size=2 color=green>楼盘名称：<INPUT TYPE="text" NAME="keyword1" size=15 maxlength=40 value="<%= keyword1 %>">
&nbsp;楼盘位置：<INPUT TYPE="text" NAME="keyword2" size=15 maxlength=40 value="<%= keyword2 %>">&nbsp;<a href="#" style="color:green;" onclick="javascript:a1.submit();">查询</a>
</font></td>
<td width=20% align=right>
<%if(acl.equals("管理员")) {	%>
<a href="#" style="color:red;" onclick="javascript:a2.submit();"><font size=2 color=green>删除记录</font></a>
<%}%></td>
</tr>

</table></form><form name="a2" method="post" action="build.jsp">
<table width="95%" border="0" cellspacing="0" bgcolor="#E4EDFB"  bordercolor="white" align="center">

<tr height=23 align="center">
<input type=hidden name=io value=1>
<td width=10% align="left" style="border-left:none; border-right:none; border-top:2 solid green ; border-bottom:2 solid green">
<font size=2 color=green>编号</font></td>
<td width=40% align="left" style="border-left:none; border-right:none; border-top:2 solid green ; border-bottom:2 solid green">
<font size=2 color=green>楼盘名称</font></td>
<td width=30% align="left" style="border-left:none; border-right:none; border-top:2 solid green; border-bottom:2 solid green">
<font size=2 color=green>楼盘位置</font></td>
<td width=10% align="left" style="border-left:none; border-right:none; border-top:2 solid green; border-bottom:2 solid green">
<font size=2 color=green>楼盘编号</font></td>
<td width=10% align="left" style="border-left:none; border-right:none; border-top:2 solid green; border-bottom:2 solid green">
<font size=2 color=green>&nbsp;</font></td>
</tr>
<% if (build.build_search(request)) {
	for (int i=0;i<build.getbuildlist().size();i++){
	     build bk = (build) build.getbuildlist().elementAt(i);
   if(build.getrecordCount()<1){
	   %>&nbsp;<%
   }else{
%>
<tr  bgcolor="#DEF3CE" onMouseOver=this.style.backgroundColor='#FFFFFF' onMouseOut=this.style.backgroundColor=''>
<td width=10% align="left" style="border-left:none; border-right:none; border-top:none; border-bottom:1 solid white">
<input name="checkbox" type="checkbox"  value=<%=bk.getId() %>>
<font size=2 color=green><%=(i+1)+(pages-1)*build.getPageSize()%></font></td>
<td width=40% align="left" style="border-left:none; border-right:none; border-top:none; border-bottom:1 solid white">
<font size=2 color=green><a href="#" onclick="openScript('build_detail.jsp?id=<%=bk.getId() %>','sop',600,400);">
<font size=2 color=green><%= trun.truncate(bk.getname(),40,"......")%></a></font></td>
<td width=30% align="left" style="border-left:none; border-right:none; border-top:none; border-bottom:1 solid white">
<font size=2 color=green><%= bk.getaddr() %></font></td>
<td width=10% align="left" style="border-left:none; border-right:none; border-top:none; border-bottom:1 solid white">
<font size=2 color=green><%= bk.getbuildnum() %></font></td>

<td width=10% align="right" style="border-left:none; border-right:none; border-top:none; border-bottom:1 solid white">
<%
if(acl.equals("管理员") ) {%>
<a href="#" onclick="openScript('build_modify.jsp?id=<%=bk.getId() %>','sop',600,400);"><font size=2 color=green>编辑</font></a>
&nbsp;&nbsp;<a href="#" onclick="openScript('build_detail.jsp?id=<%=bk.getId() %>','sop',600,400);">查看</a>
<%}else{%>
<font size=2 color=green>
<a href="#" onclick="openScript('build_detail.jsp?id=<%=bk.getId() %>','sop',600,400);">查看</a></font>
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
<%if(build.getrecordCount()<1){%>
<table align="center" width="95%" border="0" cellspacing="0" cellpadding="0"  bgcolor="#E4EDFB">
<tr bgcolor="#DEF3CE">
<td width="50%" align="left" ><font size=2 color=green>没有记录!</font></td>
<td width="50%" align="right">&nbsp;</td>
</tr>
</table>
<%}else{%>
<table align="center" width="95%" border="0" cellspacing="0" cellpadding="0"  bgcolor="#E4EDFB">
<tr bgcolor="#DEF3CE">
 <td width="50%" align="left" ><font size=2 color=green>&nbsp提示:共<%= build.getrecordCount()%>条记录</font></td>
<td width="50%" align="right"><font size=2 color=green>共<%= build.getPageCount() %>页&nbsp;当前页第<%= build.getPage() %>页　
<a href="build.jsp?keyword1=<%=keyword1%>&keyword2=<%=keyword2%>">首页</a>&nbsp;
<% if (build.getPage()>1) {%>
<a href="build.jsp?keyword1=<%=keyword1%>&keyword2=<%=keyword2%>&page=<%= build.getPage()-1 %>">上一页</a>&nbsp;<% }else{ %>上一页&nbsp;<%}%>
<% if (build.getPage()<build.getPageCount()-1) {%>
<a href="build.jsp?keyword1=<%=keyword1%>&keyword2=<%=keyword2%>&page=<%= build.getPage()+1 %>">下一页</a>&nbsp;<% }else{ %>下一页<%}%>
<a href="build.jsp?keyword1=<%=keyword1%>&keyword2=<%=keyword2%>&page=<%= build.getPageCount() %>">未页</a>&nbsp;</font></td>
</tr>
</table>
<%}%>
</center>
</body>
</html>