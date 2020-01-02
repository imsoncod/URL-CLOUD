<%@page import="Java.Oracle_DAO"%>
<%@page import="java.io.PrintWriter"%>
<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
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
	String explanation[] = request.getParameter("_explanation").split("##");
	String url[] = request.getParameter("_url").split("##");
	for(int i = 0; i < explanation.length; i++){
		oracle.OracleDeleteUrl(session.getAttribute("__id").toString(), session.getAttribute("__kategorie").toString(), explanation[i], url[i]);		
	}

%>
		<form action = "ExampleBoard.jsp" method = "post" name = "deleteform">
			<input type = "hidden" name = "_kategorie">
		</form>	
		<script>
			alert('URL이 삭제되었습니다');
			document.deleteform.submit();
		</script>
</body>
</html>