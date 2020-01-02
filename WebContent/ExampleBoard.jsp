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
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/js/bootstrap.min.js"></script>
<link rel="stylesheet" href="css/bootstrap.min.css">
<script>
	function Check(){
			if(document.getElementById("allcheck").checked == false){	
				document.getElementById("rowcheck").checked = false;	
			}else{
				document.getElementById("rowcheck").checked = true;	
			}
	}
</script>
<title>URL CLOUD</title>
</head>
<body>
				<div align="center" style="width: 844px; height: 890px; background: white; border: 2px solid #358791;">
					<div class="container" style="width:800px; height:670px">
					<% String kategorie = "URL CLOUD";%>
					<h1 style="margin-top:40px"><%=kategorie %></h1>
					<div align="left" style = "margin-bottom:4px; margin-top:30px; margin-left:15px">
						<input type = "checkbox" name = "_즐겨찾기" value = "즐겨찾기"> <span style = "color:orange"><b>즐겨찾기</b></span>만 보기
						<input type = "submit" value = "" style = "float:right; height:26px;width:26px; border:0; background-image: url('img/Search.png'); outline: none;">
						<input type = "text" name = "_search" placeholder = "　　　　　　　　　　검색 " style = "margin-bottom:2px; text-align:left; float:right; margin-right:2px">
						<select style="float:right ;height:26px; margin-right:2px">
							<option>설명</option>
							<option>URL</option>
						</select>
					</div>
						<div>
							<table class="table table-striped"
								style="text-align: center; border: 1px solid #dddddd; margin-top:7px">
								<thead>
									<tr>
										<th style="width: 1%; background-color: #eeeeee; text-align: center;"><input type = "checkbox" id = "allcheck" onclick ="Check()"></th>
										<th style="width: 10%; background-color: #eeeeee; text-align: center;">설명</th>
										<th style="width: 10%; background-color: #eeeeee; text-align: center;">URL</th>
										<th style="width: 5%; background-color: #eeeeee; text-align: center;">작성일</th>
										<th style="width: 3%; background-color: #eeeeee; text-align: center;">즐겨찾기</th>
									</tr>
								</thead>
								<tbody>
								<%
									Oracle_DAO oracle = new Oracle_DAO();
									oracle.OracleGetURL(session.getAttribute("__id").toString(), kategorie);
									out.println("<tr height=\"42px\">");
									out.println("<td><input type = \"checkbox\" id = \"rowcheck\"></td>");		 				
									out.println("<td>" + "URL CLOUD 이용가이드" + "</td>");
									out.println("<td><a style = text-decoration:none href = \"#\">" + "이곳에 등록한 URL이 나타납니다" + "</a></td>");
									out.println("<td>" + "2020-01-01" + "</td>");	
									out.println("<td><a style = \"color:orange;  text-decoration:none\" href = \"#\" onClick=\"favorite()\">"+"★"+"</a></td>");
									out.println("</tr>");
									for(int i = 0; i < 14; i++){
										out.println("<tr height=\"42px\">");	
										out.println("<td>　</td>");
										out.println("<td>　</td>");	
										out.println("<td>　</td>");	
										out.println("<td>　</td>");	
										out.println("<td>　</td>");	
										out.println("</tr>");	
									}
								%>
								</tbody>

							</table>
							<div style="display: inline">
							<span style="margin-left:170px">
								<a href="#" style="text-decoration:none; color:black">&nbsp;◀&nbsp;</a>
								<a href="#" style="text-decoration:none; color:black">&nbsp;1&nbsp;</a>
								<a href="#" style="text-decoration:none; color:black">&nbsp;2&nbsp;</a>
								<a href="#" style="text-decoration:none; color:black">&nbsp;3&nbsp;</a>
								<a href="#" style="text-decoration:none; color:black">&nbsp;4&nbsp;</a>
								<a href="#" style="text-decoration:none; color:black">&nbsp;5&nbsp;</a>
								<a href="#" style="text-decoration:none; color:black">&nbsp;▶&nbsp;</a>
							</span>	
							</div>
							<a href="#" class="btn btn-primary pull-right" style = "background-color: #358791; border: 0">삭제</a>
							<a href="#" class="btn btn-primary pull-right" style = "margin-right:4px;background-color: #358791;border: 0">수정</a>
							<a href="#" target = "Board" class="btn btn-primary pull-right" style = "margin-right:4px;background-color: #358791;border: 0">등록</a>
						</div>

					</div>

				</div>
</body>
</html>