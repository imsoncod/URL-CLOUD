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
<title>URL CLOUD</title>
</head>
<body>
	<div align="center" style="width: 99%; height: 890px; background: #358791; border: 2px solid #358791;">
					<div align="center"
						style="width: 98%; font-size:12pt; height: auto; border: 2px solid #358791; padding: 10px">
						<font face="한컴 윤체 M">
						<span style = "margin-left : 40px; color:white; font-size: 20pt;">Kategorie</span>&ensp;
						</font>
						<font face = "맑은 고딕">
						<a href="#" onclick = "RegistK()" style="color:white; font-size: 10pt">등록</a>
						</font>
					</div>
					
					<div style = "width:94%; height:1.5px; background-color: white">
					
					</div>
					
					<form action = "Kategorie_Regist.jsp" method = "post" name = "KategorieRegistForm">
						<input type = "hidden" name = "_kategoriename">
					</form>
					
					<script>
						function RegistK(){
							var registname = prompt("카테고리명을 입력해주세요");
							if(registname != null){
								document.KategorieRegistForm._kategoriename.value = registname;
								KategorieRegistForm.submit();	
							}
						}
					</script>
					
					<font face="한컴 윤체 M">
					<div align="center"
						style="width: 98%; height: 775px; border: 2px solid #358791; padding: 10px; font-size: 14pt">
						<%
							Oracle_DAO oracle = new Oracle_DAO();
							oracle.OracleGetKategories(session.getAttribute("__id").toString());
							for(int i = 0; i < 10; i++){
								if(Oracle_DAO.kategories[i] != null){
									out.println("<div><a style = \"text-decoration:none; color:white; font-size:18pt\" href = \"Board.jsp?_kategorie="+ Oracle_DAO.kategories[i] +"\" target = 'Board'>" + Oracle_DAO.kategories[i] + "</a></div><br>");
								}
							}
						%>
					</div>
					</font>
					<div align="center" style = "margin-bottom:4px;">
						<form action = "AllSearchBoard.jsp" method = "post" name = "searchForm" target="Board">
							<select id = "typeselect" style="height:35px; border: 0; float:left; margin-left:10px">
								<option value = "explanation">설명</option>
								<option value = "URL">URL</option>
							</select>
							<input type = "submit" onclick = "search()" value = " " style="margin-left:0px; height:35px;width:35px; border:0; background-image: url('img/AllSearch.png'); float:right;  outline: none;  margin-right:10px">
							<input id = "searchtext" type = "text" name = "_search" placeholder = "　　　　　　　　　　검색" style = "width:180px;margin-bottom:2px; text-align:left; height:35px; border: 0; float:right; outline: none;">
							<input type = "hidden" name = "_searchtype">
							<input type = "hidden" name = "_searchtext">
						</form>
					</div>
						<script>
							function search(){
								document.searchForm._searchtype.value = document.getElementById("typeselect").options[document.getElementById("typeselect").selectedIndex].value;
								document.searchForm._searchtext.value = document.getElementById("searchtext").value;
								document.searchForm.submit();
							}
						</script>
				</div>
</body>
</html>