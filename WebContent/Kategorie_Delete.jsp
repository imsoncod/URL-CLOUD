<%@page import="Java.Oracle_DAO"%>
<%@page import="java.io.PrintWriter"%>
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
request.setCharacterEncoding("UTF-8");
if(session.getAttribute("__id") == null){
	PrintWriter script = response.getWriter();
	script.println("<script>");
	script.println("alert('Error')");
	script.println("history.back();");
	script.println("</script>");
	script.close();
}
	Oracle_DAO oracle = new Oracle_DAO();
	oracle.OracleDeleteKategorie(session.getAttribute("__id").toString(), session.getAttribute("__kategorie").toString());

%>
		<form action = "ExampleBoard.jsp" method = "post" name = "deleteform">
			<input type = "hidden" name = "_kategorie">
		</form>	
		<script>
			alert('카테고리가 삭제되었습니다');
			parent.location.reload();
			document.deleteform.submit();
		</script>
</body>
</html>