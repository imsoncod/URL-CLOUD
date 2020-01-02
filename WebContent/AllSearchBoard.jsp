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
	request.setCharacterEncoding("UTF-8");
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
					<% 
						String searchType = "";
						String searchText = "";
						if(request.getParameter("_searchtype") != null){
							searchType = request.getParameter("_searchtype");
						}
						if(request.getParameter("_searchtext") != null){
							searchText = request.getParameter("_searchtext");
						}
					%>
					<h1 style="margin-top:40px">검색 : <%=searchText %></h1>
						<div>
							<table id = "boardtable" class="table table-striped"
								style="text-align: center; border: 1px solid #dddddd; margin-top:40px; table-layout: fixed;">
								<thead>
									<tr>
										<th style="width: 7%; background-color: #eeeeee; text-align: center;">설명</th>
										<th style="width: 7%; background-color: #eeeeee; text-align: center;">URL</th>
										<th style="width: 3%; background-color: #eeeeee; text-align: center;">등록일</th>
										<th style="width: 4%; background-color: #eeeeee; text-align: center;">등록자</th>
									</tr>
								</thead>
								<tbody>
								<%
									int start_num;
									if(request.getParameter("_startnum")!=null){
										start_num = Integer.parseInt(request.getParameter("_startnum"));
									}else{
										start_num = 0;
									}
									int end_num;
									if(request.getParameter("_endnum")!=null){
										end_num = Integer.parseInt(request.getParameter("_endnum"));
									}else{
										end_num = 15;
									}
									Oracle_DAO oracle = new Oracle_DAO();
									oracle.OracleGetAllURLOfSearch(searchType,searchText);
									for(int i = start_num; i < end_num; i++){
										out.println("<tr height=\"42px\">");
										if(!Oracle_DAO.explanation[i].equals(" ")){
											out.println("<td>" + Oracle_DAO.explanation[i] + "</td>");
											out.println("<td style=\"overflow:hidden;white-space:nowrap;text-overflow:ellipsis;\"><a style = text-decoration:none href = \"" + Oracle_DAO.URL[i] + "\"target = \"_blank\">" + Oracle_DAO.URL[i] + "</a></td>");
											out.println("<td>" + Oracle_DAO.rgdate[i] + "</td>");	
											out.println("<td>" + Oracle_DAO.userid[i] + "</td>");	
											out.println("</tr>");
										}else {
											out.println("<td>　</td>");
											out.println("<td>　</td>");
											out.println("<td>　</td>");
											out.println("<td>　</td>");
											out.println("</tr>");
										}
									}
								%>
								</tbody>

							</table>
							<div>
								<a href="#" style="text-decoration:none; color:black">&nbsp;◀&nbsp;</a>
								<a href="#" onclick = "pagenation1()" style="text-decoration:none; color:black">&nbsp;1&nbsp;</a>
								<a href="#" onclick = "pagenation2()" style="text-decoration:none; color:black">&nbsp;2&nbsp;</a>
								<a href="#" onclick = "pagenation3()" style="text-decoration:none; color:black">&nbsp;3&nbsp;</a>
								<a href="#" onclick = "pagenation4()" style="text-decoration:none; color:black">&nbsp;4&nbsp;</a>
								<a href="#" onclick = "pagenation5()" style="text-decoration:none; color:black">&nbsp;5&nbsp;</a>
								<a href="#" style="text-decoration:none; color:black">&nbsp;▶&nbsp;</a>
							</div>
							<form action = "AllSearchBoard.jsp" method = "post" name = "pageForm">
								<input type = "hidden" name = "_startnum" value = "0">
								<input type = "hidden" name = "_endnum" value = "15">
								<input type = "hidden" name = "_searchtype" value = "<%=searchType%>">
								<input type = "hidden" name = "_searchtext" value = "<%=searchText%>">
							</form>
							<script>
								function pagenation1(){
									document.pageForm._startnum.value = 0;
									document.pageForm._endnum.value = 15;
									document.pageForm.submit();
								}
							</script>
							<script>
								function pagenation2(){
									document.pageForm._startnum.value = 15;
									document.pageForm._endnum.value = 30;
									document.pageForm.submit();
								}
							</script>
							<script>
								function pagenation3(){
									document.pageForm._startnum.value = 30;
									document.pageForm._endnum.value = 45;
									document.pageForm.submit();
								}
							</script>
							<script>
								function pagenation4(){
									document.pageForm._startnum.value = 45;
									document.pageForm._endnum.value = 60;
									document.pageForm.submit();
								}
							</script>
							<script>
								function pagenation5(){
									document.pageForm._startnum.value = 60;
									document.pageForm._endnum.value = 75;
									document.pageForm.submit();
								}
							</script>
						</div>
					</div>
				</div>
 <script src="https://code.jquery.com/jquery-3.1.1.min.js"></script> 
 <script src="js/bootstrap.js"></script>
</body>
</html>