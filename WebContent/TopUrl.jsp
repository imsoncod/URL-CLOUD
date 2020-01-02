<%@page import="java.io.PrintWriter"%>
<%@page import="Java.Oracle_DAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap.min.css">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap-theme.min.css">
<link rel="stylesheet" href="css/custom.css" />
<script src="https://code.jquery.com/jquery-1.12.4.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/js/bootstrap.min.js"></script>
<link rel="stylesheet" href="css/bootstrap.min.css">
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
%>
				<div align="center"
					style="width: 844px; height: 890px; background: white; border: 2px solid #358791;">
					<div class="container" style="width:800px; height:890px">
					<h1 style="margin-top:40px">Top URL</h1>
						<div>
							<table id = "boardtable" class="table table-striped"
								style="text-align: center; border: 1px solid #dddddd; margin-top:40px; table-layout: fixed">
								<thead>
									<tr>
										<th style="width: 2%; background-color: #eeeeee; text-align: center;">순위</th>
										<th style="width: 7%; background-color: #eeeeee; text-align: center;">설명</th>
										<th style="width: 10%; background-color: #eeeeee; text-align: center;">URL</th>
										<th style="width: 2%; background-color: #eeeeee; text-align: center;">등록수</th>
									</tr>
								</thead>
								<tbody>
								<%
									Oracle_DAO oracle = new Oracle_DAO();
									oracle.OracleGetTopURL();
									for(int i = 0; i < 15; i++){
										out.println("<tr height=\"42px\">");
										if(!Oracle_DAO.URL[i].equals(" ")){
											if(i==0){
												out.println("<td style = \"color:orange\"><b>​♔</b></td>");
											}else{
												out.println("<td>"+(i+1)+"</td>");
											}
											oracle.OracleGetTopURLExplanation(i);
											out.println("<td>" + Oracle_DAO.explanation[i] + "</td>");
											out.println("<td style=\"overflow:hidden;white-space:nowrap;text-overflow:ellipsis;\"><a style = text-decoration:none href = \"" + Oracle_DAO.URL[i] + "\"target = \"_blank\">" + Oracle_DAO.URL[i] + "</a></td>");
											out.println("<td>" + Oracle_DAO.urlcnt[i] + "</td>");
											out.println("</tr>");
										}
									}
								%>
								</tbody>

							</table>
							<div style = "margin-top : 30px; font-size: 14pt">
								<font face="맑은 고딕"><b>많은 유저들이 등록하는 URL을 방문해보세요!</b></font>
							</div>
						</div>
					</div>
				</div>
 <script src="https://code.jquery.com/jquery-3.1.1.min.js"></script> 
 <script src="js/bootstrap.js"></script>
</body>
</html>