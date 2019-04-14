<%@ page contentType="text/html;charset=GBK" %>
<%@ page import="java.sql.*"%>
<%@ page import="java.util.*" %>
<%@ page session="true" %>
<%@ page import="wygl.op.*" %>
<%@ page import="wygl.config.*" %>
<%@ page import="wygl.util.*" %>
<jsp:useBean id="fee" scope="page" class="wygl.run.op_fee" />

<html>
	<body>
		<%
			if (session.getAttribute("user")==null || session.getAttribute("user")==""){
				response.sendRedirect("../error1.htm");
			}
			String mesg = "";
			int Id=0;
			if (request.getParameter("id")==null || request.getParameter("id").equals("")) {
				mesg = "你要查看的物业费信息不存在!";
			} else {
				try {
					Id = Integer.parseInt(request.getParameter("id"));
					if (!fee.getOnefee(Id)){
						mesg = "..你要查看的物业费信息不存在!";
					}
	    		} catch (Exception e){
					mesg = "你要查看的物业费信息不存在!";
	 			}
			}
			
			fee bk = null;
			
			if(mesg.equals("")){ 
				bk = (fee) fee.getfeelist().elementAt(0);
			}
		
			String money = bk.getmoneynum();
			System.out.println(money);
			String info = bk.getinfo();
			System.out.println(info);
			String name = bk.getfeename();
			System.out.println(name);
			String orderId = RandomUtil.getRandomString2(25);
			System.out.println(orderId);
			
			String result = AlipayUtil.pay(response, money, info, name, orderId);
			request.setAttribute("result", result);
			request.getRequestDispatcher("/fee/alipay_detail.jsp").forward(request,response);
		%>		
	</body>
</html>


