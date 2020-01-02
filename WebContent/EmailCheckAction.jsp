<%@page import="javax.script.Invocable"%>
<%@page import="javax.script.ScriptEngine"%>
<%@page import="javax.script.ScriptEngineManager"%>
<%@page import="java.io.PrintWriter"%>
<%@page import="Java.Oracle_DAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>URL CLOUD</title>
</head>
<body>
<%
	String id = null;
	String text = null;
	String hv = null;
	if(request.getParameter("_dbwjdkdlel")!=null){
		id = request.getParameter("_dbwjdkdlel");
	}else{
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('Error')");
		script.println("history.back();");
		script.println("</script>");
		script.close();
	}
	Oracle_DAO oracle = new Oracle_DAO();
	oracle.OracleEmailCheck(id);
%>
<div align = "center" style = "margin-top : 200px">
	   <img src = img/login_logo.PNG><br><br><br>
	   <p style = "font-size : 14pt"><b>인증되었습니다. 이제부터 "URL CLOUD" 서비스를 이용하실 수 있습니다.</b></p><br>
	   <form action = "Login.jsp" method = "post">
	   	<input type = "submit" value = "URL CLOUD 바로가기" style = "font-size:14pt; background-color:#358791; color:white">
	   </form>
</div>
</body>
</html>