<%@page import="java.io.PrintWriter"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>URL CLOUD</title>
</head>
<frameset rows="6%,*" noresize border = 0>
	<frame src ="Navbar.jsp" scrolling = "no"></frame>
	<frameset cols="26%,*">
		<frame src = "Kategorie.jsp" scrolling = "no" name = "Kategorie"></frame>	
		<frame src = "ExampleBoard.jsp" scrolling = "no"  name = "Board"></frame>	
	</frameset>
</frameset>
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
%>

</body>
</html>