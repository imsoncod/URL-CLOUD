<%@page import="Java.Oracle_DAO"%>
<%@page import="java.io.PrintWriter"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap.min.css">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap-theme.min.css">
<link rel="stylesheet" href="css/custom.css" />
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/js/bootstrap.min.js"></script>
<title>URL CLOUD</title>
</head>
<body>
<%
if(session.getAttribute("__id") == null){
	PrintWriter script = response.getWriter();
	script.println("<script>");
	script.println("alert('Error')");
	script.println("history.back();");
	script.println("</script>");
	script.close();
}
Oracle_DAO oracle = new Oracle_DAO();
%>
			<nav class="navbar navbar-custom" role="navigation" style = "width:100%">
				<div>
					<div class="navbar-header">
						<a class="navbar-brand" style = "color:white; font-size:20pt">URL CLOUD</a>
					</div>
					<div class="collapse navbar-collapse" id="bs-example-navbar-collapse-1">
						<ul class="nav navbar-nav">
							<li><a class="navbar-custom" href="ExampleBoard.jsp" target="Board" style = "font-size: 13pt; background-color: #358791; color:white;">My URL</a></li>
							<li><a class="navbar-custom" href="TopUrl.jsp" target = "Board" style = "font-size: 13pt; background-color: #358791; color:white;">TOP URL</a></li>
						</ul>
						<ul class="nav navbar-nav navbar-right">
							<li style="padding-top: 9%; font-size: 12pt"><%=oracle.OracleGetData("userinfo", session.getAttribute("__id").toString(), "username") %>님</li>
							<li><a class="navbar-custom" href="Logout.jsp" style = "font-size: 12pt; background-color: #358791; color:white;">로그아웃</a></li>
						</ul>
					</div>
				</div>
			</nav>
</body>
</html>