<%
session.putValue("enter","true");
String user,acl,dep,name;
user=(String)session.getValue("user");
acl=(String)session.getValue("acl");
dep=(String)session.getValue("dep");
name=(String)session.getValue("name");
String pagename=request.getRequestURI(); 
     	
%>