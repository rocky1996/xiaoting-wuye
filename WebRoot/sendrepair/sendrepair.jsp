<%@ page contentType="text/html;charset=GBK" %>
<%@ page import="java.sql.*"%>
<%@ page import="java.util.*" %>
<%@ page import="java.io.*"%>
<%@ page session="true" %>
<%@ page import="wygl.op.*" %>
<%@ page language="java" import="java.sql.*, wygl.util.*" %>
<jsp:useBean id="db" scope="page" class="wygl.util.DataBase" />
<jsp:useBean id="sendrepair" scope="page" class="wygl.run.op_sendrepair" />
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
	if (sendrepair.delete(Integer.parseInt(chkbx[i]))){
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
keyword1 = sendrepair.to_String(keyword1);

String keyword2 = request.getParameter("keyword2");
if (keyword2==null){ keyword2="";}else{mesg=mesg+keyword2;}
keyword2 = sendrepair.to_String(keyword2);

String keyword3 = request.getParameter("keyword3");
if (keyword3==null){ keyword3="";}else{mesg=mesg+keyword3;}
keyword3 = sendrepair.to_String(keyword3);

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
<center><form name="a1" method="post" action="sendrepair.jsp?page=1">
<table width="95%" border="0" cellspacing="0" bgcolor="#DEF3CE"  bordercolor="white" align="center" valign="top">

<tr align="center" bgcolor="#DEF3CE"> 
<td width=20% align=left><font size=2 color=green><b>::物业报修信息::</b></font></td>
<td width=60% align=center><font size=2 color=green>楼盘：<select name="keyword1" style="width:100">
<option value="">所有</option>
<%if (build.seachallbuild()){for (int i=0;i<build.getbuildlist().size();i++){build bc = (build) build.getbuildlist().elementAt(i);%>
<option value="<%= bc.getbuildnum()%>" ><%= bc.getname() %></option>
<%}}%>
</select>
&nbsp;房间号：<input type=text size=10 name=keyword2 value=<%=keyword2%>>
&nbsp;是否修理：<select name=keyword3><option value="0">不予修理</option><option value="1">给予修理</option></select>
&nbsp;<a href="#" style="color:green;" onclick="javascript:a1.submit();">查询</a>
</font></td>
<td width=20% align=right>
<%if(acl.equals("管理员")) {	%>
<a href="#" style="color:red;" onclick="javascript:a2.submit();"><font size=2 color=green>删除记录</font></a>
<%}%></td>
</tr>

</table></form><form name="a2" method="post" action="sendrepair.jsp">
<table width="95%" border="0" cellspacing="0" bgcolor="#E4EDFB"  bordercolor="white" align="center">

<tr height=23 align="center">
<input type=hidden name=io value=1>
<td width=8% align="left" style="border-left:none; border-right:none; border-top:2 solid green ; border-bottom:2 solid green">
<font size=2 color=green>编号</font></td>
<td width=20% align="left" style="border-left:none; border-right:none; border-top:2 solid green; border-bottom:2 solid green">
<font size=2 color=green>楼盘</font></td>
<td width=10% align="left" style="border-left:none; border-right:none; border-top:2 solid green; border-bottom:2 solid green">
<font size=2 color=green>单元号</font></td>
<td width=10% align="left" style="border-left:none; border-right:none; border-top:2 solid green; border-bottom:2 solid green">
<font size=2 color=green>房间号</font></td>
<td width=10% align="left" style="border-left:none; border-right:none; border-top:2 solid green; border-bottom:2 solid green">
<font size=2 color=green>报修项目</font></td>
<td width=10% align="left" style="border-left:none; border-right:none; border-top:2 solid green; border-bottom:2 solid green">
<font size=2 color=green>是否修理</font></td>
<td width=10% align="left" style="border-left:none; border-right:none; border-top:2 solid green; border-bottom:2 solid green">
<font size=2 color=green>报修人</font></td>
<td width=10% align="left" style="border-left:none; border-right:none; border-top:2 solid green; border-bottom:2 solid green">
<font size=2 color=green>报修日期</font></td>
<td width=12% align="left" style="border-left:none; border-right:none; border-top:2 solid green; border-bottom:2 solid green">
<font size=2 color=green>&nbsp;</font></td>
</tr>
<% if (sendrepair.sendrepair_search(request)) {
	for (int i=0;i<sendrepair.getsendrepairlist().size();i++){
	     sendrepair bk = (sendrepair) sendrepair.getsendrepairlist().elementAt(i);
   if(sendrepair.getrecordCount()<1){
	   %>&nbsp;<%
   }else{
%>
<tr  bgcolor="#DEF3CE" onMouseOver=this.style.backgroundColor='#FFFFFF' onMouseOut=this.style.backgroundColor=''>
<td width=8% align="left" style="border-left:none; border-right:none; border-top:none; border-bottom:1 solid white">
<input name="checkbox" type="checkbox"  value=<%=bk.getId() %>>
<font size=2 color=green><%=(i+1)+(pages-1)*build.getPageSize()%></font></td>
<td width=20% align="left" style="border-left:none; border-right:none; border-top:none; border-bottom:1 solid white">
<font size=2 color=green><%if (!build.getOnebuild1(bk.getbuildnum())){%>&nbsp;<%}else{build buildbk = (build) build.getbuildlist().elementAt(0);%><%= buildbk.getname() %><%}%></font></td>
<td width=10% align="left" style="border-left:none; border-right:none; border-top:none; border-bottom:1 solid white">
<font size=2 color=green><%= bk.getcellnum() %></font></td>
<td width=10% align="left" style="border-left:none; border-right:none; border-top:none; border-bottom:1 solid white">
<font size=2 color=green><%= bk.getroomnum() %></font></td>
<td width=10% align="left" style="border-left:none; border-right:none; border-top:none; border-bottom:1 solid white">
<font size=2 color=green><%=bk.getrepairgoods()%></font></td>
<td width=10% align="left" style="border-left:none; border-right:none; border-top:none; border-bottom:1 solid white">
<font size=2 color=green><%if(bk.getisrepair().equals("0")){ %>不予修理<%}else{%>给予修理<%}%></font></td>
<td width=10% align="left" style="border-left:none; border-right:none; border-top:none; border-bottom:1 solid white">
<font size=2 color=green><%=bk.getrepairpersonname()%></font></td>
<td width=10% align="left" style="border-left:none; border-right:none; border-top:none; border-bottom:1 solid white">
<font size=2 color=green><%=bk.getrepairtime()%></font></td>
<td width=12% align="left" style="border-left:none; border-right:none; border-top:none; border-bottom:1 solid white">
<%
if(acl.equals("管理员") ) {%>
<font size=2 color=green><a href="#" onclick="openScript('sendrepair_modify.jsp?id=<%=bk.getId() %>','sop',660,405);">编辑
</a></font>&nbsp;
<font size=2 color=green>
<a href="#" onclick="openScript('sendrepair_detail.jsp?id=<%=bk.getId() %>','sop',660,405);">查看</a></font>
<%}else{%>
<font size=2 color=green>
<a href="#" onclick="openScript('sendrepair_detail.jsp?id=<%=bk.getId() %>','sop',660,405);">查看</a></font>
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
<%if(sendrepair.getrecordCount()<1){%>
<table align="center" width="95%" border="0" cellspacing="0" cellpadding="0"  bgcolor="#E4EDFB">
<tr bgcolor="#DEF3CE">
<td width="50%" align="left" ><font size=2 color=green>没有记录!</font></td>
<td width="50%" align="right">&nbsp;</td>
</tr>
</table>
<%}else{%>
<table align="center" width="95%" border="0" cellspacing="0" cellpadding="0"  bgcolor="#E4EDFB">
<tr bgcolor="#DEF3CE">
 <td width="50%" align="left" ><font size=2 color=green>&nbsp提示:共<%= sendrepair.getrecordCount()%>条记录</font></td>
<td width="50%" align="right"><font size=2 color=green>共<%= sendrepair.getPageCount() %>页&nbsp;当前页第<%= sendrepair.getPage() %>页　
<a href="sendrepair.jsp?keyword1=<%=keyword1%>&keyword2=<%=keyword2%>&keyword3=<%=keyword3%>">首页</a>&nbsp;
<% if (sendrepair.getPage()>1) {%>
<a href="sendrepair.jsp?keyword1=<%=keyword1%>&keyword2=<%=keyword2%>&keyword3=<%=keyword3%>&page=<%= sendrepair.getPage()-1 %>">上一页</a>&nbsp;<% }else{ %>上一页&nbsp;<%}%>
<% if (sendrepair.getPage()<sendrepair.getPageCount()-1) {%>
<a href="sendrepair.jsp?keyword1=<%=keyword1%>&keyword2=<%=keyword2%>&keyword3=<%=keyword3%>&page=<%= sendrepair.getPage()+1 %>">下一页</a>&nbsp;<% }else{ %>下一页<%}%>
<a href="sendrepair.jsp?keyword1=<%=keyword1%>&keyword2=<%=keyword2%>&keyword3=<%=keyword3%>&page=<%= sendrepair.getPageCount() %>">未页</a>&nbsp;</font></td>
</tr>
</table>
<%}%>
</center>
</body>
</html>