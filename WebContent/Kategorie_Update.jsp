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
	oracle.OracleUpdateKategorie(session.getAttribute("__id").toString(), request.getParameter("_kategoriename"), session.getAttribute("__kategorie").toString());
%>
		<form action = "Board.jsp" method = "post" name = "updateform">
			<input type = "hidden" name = "_kategorie" value = "<%=request.getParameter("_kategoriename")%>">
		</form>	
		<script>
			alert('카테고리가 수정되었습니다');
			parent.location.reload();
			document.updateform.submit();
		</script>
</body>
</html>