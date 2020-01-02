<%@page import="java.io.PrintWriter"%>
<%@page import="javax.mail.SendFailedException"%>
<%@page import="Java.Oracle_DAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta name="viewport" content="width=device-width" initial-scale="1">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap.min.css">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap-theme.min.css">
<link rel="stylesheet" href="css/custom.css" />
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/js/bootstrap.min.js"></script>
<link rel="stylesheet" href="css/bootstrap.min.css">
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
%>
<div align="center">
	<div class="body-wrap" style="width:1320px">
<!-- 		<div style = "width:160px; height:955px; float:left;margin-top : 5px;">
			<a href = "https://tmi.nexon.com/kart" target = "_blank"><img src = "img/광고1.PNG" style = "width:100%; height:472px"></a>
			<a href = "https://store.musinsa.com/app/" target = "_blank"><img src = "img/광고2.PNG" style = "width:100%; height:472px; margin-top:5px"></a>
		</div> -->
		<div style="margin-top: 5px; float:left; margin-left: 10px; width:1140px; height:955px">
			<iframe src="MainCenter.jsp" style="width:100%; height:100%" frameborder = 0></iframe>	
		</div>
		<div style = "width:160px; height:955px; margin-left:0px; float:right; margin-top : 5px;">
			<a href = "https://tmi.nexon.com/kart" target = "_blank"><img src = "img/광고1.PNG" style = "width:100%; height:472px"></a>
			<a href="https://store.musinsa.com/app/" target = "_blank"><img src = "img/광고2.jpg" style = "width:100%; height:472px; margin-top:5px"></a>
		</div>	
	</div>	
</div>
</body>
</html>