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
	if(session.getAttribute("__id")==null){
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('Error')");
		script.println("history.back();");
		script.println("</script>");
		script.close();
	}
	Oracle_DAO oracle = new Oracle_DAO();
	session.invalidate();
	PrintWriter script = response.getWriter();
	script.println("<script>");
	script.println("alert('로그아웃 되었습니다.')");
	script.println("window.top.location.href = \"http://"+Oracle_DAO.ip+":8087/UrlCloud/Login.jsp\"");
	script.println("</script>");
	script.close();
%>

</body>
</html>