<!--DiscoverySoft¹¤×÷ÊÒ-->
<!--@Copyright@2006-->
<%@ page contentType="text/html;charset=GBK" %>
<%@ page import="java.sql.*"%>
<%@ page import="java.util.*" %>
<%@ page session="true" %>
<jsp:useBean id="db" scope="page" class="wygl.util.DataBase" />
<%request.setCharacterEncoding("GBK");%>
<html>
<body>
<%
String check,password,user,name,acl,dep;

user=request.getParameter("user");
password=request.getParameter("password");

System.out.println("********");
System.out.println(user);
System.out.println(password);
System.out.println("********");

String sql="select * from dbo.users where yh='"+user+"' or name='"+user+"'";
ResultSet rs=db.execQuery(sql);
if(rs.next())
{
	check=rs.getString("password");
	user=rs.getString("yh");
	name=rs.getString("name");
	acl=rs.getString("acl");
	dep=rs.getString("dep");
		
    if(check==null||!password.equals(check))
       {
		rs.close();
        db.closeStmt();
		db.closeConn();
        response.sendRedirect("index.jsp");
        }else{		
        session.putValue("user",user);	
		session.putValue("name",name);	
		session.putValue("acl",acl);
		session.putValue("dep",dep);
		rs.close();
        db.closeStmt();
		db.closeConn();
		response.sendRedirect("wygl_main.jsp");	
	    }
}else{	
	check="";
	user="";
	name="";
	acl="";
	dep="";
	rs.close();
   db.closeStmt();
   db.closeConn();
	response.sendRedirect("index.jsp");
}


%> 
</body>
</html>
