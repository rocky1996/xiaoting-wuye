<%@ page contentType="text/html;charset=GBK" %>
<%@ page import="java.sql.*"%>
<%@ page import="java.util.*" %>
<%@ page import="java.io.*"%>
<%@ page session="true" %>
<%@ page import="wygl.op.*" %>
<%@ page language="java" import="java.sql.*, wygl.util.*" %>
<jsp:useBean id="db" scope="page" class="wygl.util.DataBase" />
<jsp:useBean id="fee" scope="page" class="wygl.run.op_fee" />
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
		mesg = "��Ҫ�ҵ�ҳ�����!";
	}
}


String io = request.getParameter("io");
	if(io==null || io=="") {io="";}

if(io.equals("1"))
{
String chkbx[]=request.getParameterValues("checkbox");
if(chkbx!=null){
for(int i = 0; i < chkbx.length; i++){
	if (fee.delete(Integer.parseInt(chkbx[i]))){
			mesg = "ɾ���ɹ�!";

	} else {
			mesg = "ɾ������!";
		}	
			}
}else{
%>
<script language="JavaScript">
  alert("��ѡ�м�¼!");
 </script>
<%
}
}

String keyword1 = request.getParameter("keyword1");
if (keyword1==null){ keyword1="";}else{mesg=mesg+keyword1;}
keyword1 = fee.to_String(keyword1);

String keyword2 = request.getParameter("keyword2");
if (keyword2==null){ keyword2="";}else{mesg=mesg+keyword2;}
keyword2 = fee.to_String(keyword2);

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
<center><form name="a1" method="post" action="fee.jsp?page=1">
<table width="95%" border="0" cellspacing="0" bgcolor="#DEF3CE"  bordercolor="white" align="center" valign="top">

<tr align="center" bgcolor="#DEF3CE"> 
<td width=20% align=left><font size=2 color=green><b>::��ҵ����Ϣ::</b></font></td>
<td width=60% align=center>
<font size=2 color=green>��ҵ�����ƣ�<INPUT TYPE="text" NAME="keyword1" size=15 maxlength=40 value="<%= keyword1 %>">
&nbsp;��ҵ�ѽ�<INPUT TYPE="text" NAME="keyword2" size=15 maxlength=40 value="<%= keyword2 %>">&nbsp;<a href="#" style="color:green;" onclick="javascript:a1.submit();">��ѯ</a>
</font></td>
<td width=20% align=right>
<%
if(acl.equals("����Ա"))
{%><a href="#" onclick="openScript('add_fee.jsp','sop',600,400);"><font size=2 color=green>�����Ϣ</font></a><%}%>
&nbsp;&nbsp;
<%if(acl.equals("����Ա")) {	%>
<a href="#" style="color:red;" onclick="javascript:a2.submit();"><font size=2 color=green>ɾ����¼</font></a>
<%}%></td>
</tr>

</table></form><form name="a2" method="post" action="fee.jsp">
<table width="95%" border="0" cellspacing="0" bgcolor="#E4EDFB"  bordercolor="white" align="center">

<tr height=23 align="center">
<input type=hidden name=io value=1>
<td width=10% align="left" style="border-left:none; border-right:none; border-top:2 solid green ; border-bottom:2 solid green">
<font size=2 color=green>���</font></td>
<td width=40% align="left" style="border-left:none; border-right:none; border-top:2 solid green ; border-bottom:2 solid green">
<font size=2 color=green>��ҵ������</font></td>
<td width=20% align="left" style="border-left:none; border-right:none; border-top:2 solid green; border-bottom:2 solid green">
<font size=2 color=green>��ҵ�ѽ��</font></td>
<td width=20% align="left" style="border-left:none; border-right:none; border-top:2 solid green; border-bottom:2 solid green">
<font size=2 color=green>��ȡʱ��</font></td>
<td width=10% align="left" style="border-left:none; border-right:none; border-top:2 solid green; border-bottom:2 solid green">
<font size=2 color=green>&nbsp;</font></td>
</tr>
<% if (fee.fee_search(request)) {
	for (int i=0;i<fee.getfeelist().size();i++){
	     fee bk = (fee) fee.getfeelist().elementAt(i);
   if(fee.getrecordCount()<1){
	   %>&nbsp;<%
   }else{
%>
<tr  bgcolor="#DEF3CE" onMouseOver=this.style.backgroundColor='#FFFFFF' onMouseOut=this.style.backgroundColor=''>
<td width=10% align="left" style="border-left:none; border-right:none; border-top:none; border-bottom:1 solid white">
<input name="checkbox" type="checkbox"  value=<%=bk.getId() %>>
<font size=2 color=green><%=(i+1)+(pages-1)*fee.getPageSize()%></font></td>
<td width=40% align="left" style="border-left:none; border-right:none; border-top:none; border-bottom:1 solid white">
<font size=2 color=green><a href="#" onclick="openScript('fee_detail.jsp?id=<%=bk.getId() %>','sop',600,400);">
<font size=2 color=green><%=bk.getfeename()%></a></font></td>
<td width=20% align="left" style="border-left:none; border-right:none; border-top:none; border-bottom:1 solid white">
<font size=2 color=green><%= bk.getmoneynum() %>(Ԫ)</font></td>
<td width=20% align="left" style="border-left:none; border-right:none; border-top:none; border-bottom:1 solid white">
<font size=2 color=green><%= bk.getshouqutime() %></font></td>

<td width=10% align="right" style="border-left:none; border-right:none; border-top:none; border-bottom:1 solid white">
<%
if(acl.equals("����Ա") ) {%>
<a href="#" onclick="openScript('fee_modify.jsp?id=<%=bk.getId() %>','sop',600,400);"><font size=2 color=green>�༭</font></a>
&nbsp;&nbsp;<a href="#" onclick="openScript('fee_detail.jsp?id=<%=bk.getId() %>','sop',600,400);">�鿴</a>
<%}else{%>
<font size=2 color=green>
<a href="#" onclick="openScript('fee_detail.jsp?id=<%=bk.getId() %>','sop',600,400);">�鿴</a></font>
<a href="#" onclick="openScript('fee_alipay.jsp?id=<%=bk.getId() %>','sop',600,400);">����֧��</a></font>
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
<!--��ҳ��ҳ-->
<%if(fee.getrecordCount()<1){%>
<table align="center" width="95%" border="0" cellspacing="0" cellpadding="0"  bgcolor="#E4EDFB">
<tr bgcolor="#DEF3CE">
<td width="50%" align="left" ><font size=2 color=green>û�м�¼!</font></td>
<td width="50%" align="right">&nbsp;</td>
</tr>
</table>
<%}else{%>
<table align="center" width="95%" border="0" cellspacing="0" cellpadding="0"  bgcolor="#E4EDFB">
<tr bgcolor="#DEF3CE">
 <td width="50%" align="left" ><font size=2 color=green>&nbsp��ʾ:��<%= fee.getrecordCount()%>����¼</font></td>
<td width="50%" align="right"><font size=2 color=green>��<%= fee.getPageCount() %>ҳ&nbsp;��ǰҳ��<%= fee.getPage() %>ҳ��
<a href="fee.jsp?keyword1=<%=keyword1%>&keyword2=<%=keyword2%>">��ҳ</a>&nbsp;
<% if (fee.getPage()>1) {%>
<a href="fee.jsp?keyword1=<%=keyword1%>&keyword2=<%=keyword2%>&page=<%= fee.getPage()-1 %>">��һҳ</a>&nbsp;<% }else{ %>��һҳ&nbsp;<%}%>
<% if (fee.getPage()<fee.getPageCount()-1) {%>
<a href="fee.jsp?keyword1=<%=keyword1%>&keyword2=<%=keyword2%>&page=<%= fee.getPage()+1 %>">��һҳ</a>&nbsp;<% }else{ %>��һҳ<%}%>
<a href="fee.jsp?keyword1=<%=keyword1%>&keyword2=<%=keyword2%>&page=<%= fee.getPageCount() %>">δҳ</a>&nbsp;</font></td>
</tr>
</table>
<%}%>
</center>
</body>
</html>