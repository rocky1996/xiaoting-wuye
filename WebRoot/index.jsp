<!--DiscoverySoft¹¤×÷ÊÒ-->
<!--@Copyright@2006-->
<%@ page contentType="text/html;charset=GBK" %>
<%@ page import="java.util.*" %>
<%@ page session="true" %>
<%
if(session.getValue("user")==null)
{
response.sendRedirect("login.jsp");
}else{
response.sendRedirect("wygl_main.jsp");
}
%>
