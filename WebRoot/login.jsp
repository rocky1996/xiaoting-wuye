<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="java.util.*"%>
<%@ page import="java.text.*"%>
<%@ page import="java.io.*"%>
<%@ page session="true" %>
<%
//session.invalidate();
%>
<html>
<head>
<title>XX物业信息管理系统</title>
<style>
<!--
.aa1{position:absolute; top:150; left:220; width:400;filter:glow(color=black,strength=5);}
　　　
.aa2{position:absolute; top:190; left:160; width:700;filter:glow(color=green,strength=3);}

　　
.aa5{position:absolute; top:520; left:310;}

.aa6{position:absolute; top:500; left:150;}

.aa7{position:absolute; top:80; left:650;}

.aa4{position:absolute; top:300; left:170;}

.aa9{position:absolute; top:489; left:350;}


a:visited {
	font-size: 9pt; cursor: hand; color: red; font-family: "verdana", "arial", "helvetica", "sans-serif"; text-decoration: none
}
a:hover {
	font-size: 9pt; cursor: hand; color: black; font-family: "verdana", "arial", "helvetica", "sans-serif"; text-decoration: none
}
a:link {
	font-size: 9pt; cursor: hand; color: green; font-family: "verdana", "arial", "helvetica", "sans-serif"; text-decoration: none
}

td {
	font-size: 9pt; color: #333333;style="border-left:none; border-right:none; border-top:none ; border-bottom:1 solid white"
}
input {
	Font-family:Verdana, Arial, Helvetica, Sans-serif,宋体; Text-decoration: None; Border-top-width: 1px; Border-left-width: 1px; Font-size: 12px; Border-bottom-width: 1px; Border-right-width: 1px
}
-->
</style>

<script language="javascript">
function doSubmit() {
	document.form1.submit();;
  }

function login() {
	document.form1.user.focus();
  }


 function checkform() {
	if (document.form1.user.value=="" || document.form1.password.value==""){
		alert("用户名或密码为空！");
		return false;
	}
	return true;
  }

  function openScript(url,name, width, height){
	var Win = window.open(url,name,'width=' + width + ',height=' + height + ',top=100,left=250,resizable=1,scrollbars=yes,menubar=no,status=yes' );
}
</script>

</head>
<body bgcolor="#43CD80" onload="login();">
<div class="aa1">
<p style="font-family:lucida handwriting;font-size:24pt;font-weight:bold;color:white;">XX物业信息管理系统</p>
</div>
<div class="aa2">
<p style="font-family:bailey; font-size:18pt;font-weight:bold;color:white;">Area Property Management System</p>
</div>

<div class="aa4">
<form name=form1 action="reg.jsp" method=post>
<p><table width="400" border="0" cellspacing="1" cellpadding="1" align="center">
	<tr> 
      <td width="147" align="right"><font size=2 style="font-family:bailey; font-size:9pt;color:green">用户名：<br>
      </font></td>
      <td width="246" valign="top">
          <input type="text" name="user" size="16" maxlength="25">
        </td>
    </tr>
    <tr> 
      <td width="147" align="right"><font size=2 style="font-family:bailey; font-size:9pt;color:green">密&nbsp;&nbsp码：</font></td>
      <td width="246" valign="top">
          <input type="password" name="password" maxlength="20" size="16" onkeydown="if   (event.keyCode==13)doSubmit();"   >
        </td>
    </tr>
	<tr> 
      <td width="147" align="right">&nbsp;</td>
      <td width="246" valign="top">
          <input type="submit" name="Submit" value="登录" onclick="javascript:return(checkform());">
          <input type="reset" name="Submit2" value="取消">
        </td>
    </tr>
	<tr> 
      <td width="147" align="right">&nbsp;</td>
      <td width="246" valign="top">&nbsp;</td>
    </tr>
	<tr> 
      <td width="147" align="right">&nbsp;</td>
      <td width="246" valign="top">
           <p><font size=2 style="font-family:bailey; font-size:9pt;color:red"><a href="#" onclick="openScript('add_user.jsp','sop',600,200);">住户请在此注册</a></font></p> 
        </td>
    </tr>
    	
</table>
</form>
</div>
<div class="aa6">
<hr size=1 color=white width=700>
</div>
<div class="aa5">
<p>
<font size=2 style="font-family:bailey; font-size:9pt;color:green">
	版权所有 © XX物业信息管理系统/<a href="http://www.xatu.cn/" target="_blank">西安工业大学</a>
</font>
</p>
</div>

<div class="aa7">
<pre>
<font size=2 style="font-family:bailey; font-size:9pt;color:green">
系统特点:

1.基于免费环境运行 jdk1.8+Tomcat1.8
2.客户端基于浏览器访问，产品模块化设计
3.代码全开放，易于二次开发
4.信息集中处理，操作简单

系统结构：

.三层结构设计  程序逻辑结构分用户界面、业务逻
 辑处理和数据存储
.面向对象设计
.人性化设计

系统主要功能简介:

.楼盘信息管理
.住户信息管理
.物业收费管理
.用户报修管理
.用户投诉管理
.小区公告管理
.系统帮助
</font>
</pre>
</div>


<div class="aa9">
<font size=2 style="font-family:bailey; font-size:9pt;color:red">本系统仅供技术交流、学习参考,严禁商业目的使用!</font>
</div>
</body>
</html>
