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
<script>
function Check(){
	if($("#allcheck").is(':checked')){
		$("input[name=rowcheck]").prop("checked", true);
	}else{
		$("input[name=rowcheck]").prop("checked", false);
	}
}
</script>
		<script>
					function Check2(){
						if(document.getElementById("_즐겨찾기").checked==true){
							document.favoriteForm.submit();
						}
					}
		</script>
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
						String kategorie;
						if(request.getParameter("_kategorie") != null){
							kategorie = request.getParameter("_kategorie");
							session.setAttribute("__kategorie", kategorie);
						}else{
							kategorie = "URL CLOUD";
							session.setAttribute("__kategorie", kategorie);
						}
					%>
					<form action = "FavoriteBoard.jsp" method = "post" name = "favoriteForm">
						<input type = "hidden" name = "_kategorie" value = "<%=kategorie %>">
					</form>
					<form action = "Kategorie_Update.jsp" method = "post" name = "KategorieUpdateForm">
						<input type = "hidden" name = "_kategoriename">
					</form>
					<h1 style="margin-top:40px; margin-left:100px"><%=kategorie %>
					&ensp;<a href="#" onclick = "UpdateK()" style="text-decoration:none; color:gray; font-size: 12pt">수정</a>
					<script>
						function UpdateK(){
							var updatename = prompt("수정할 카테고리명을 입력해주세요");
							if(updatename != null){
								document.KategorieUpdateForm._kategoriename.value = updatename;
								KategorieUpdateForm.submit();	
							}
						}
					</script>
					<a href="#" onclick = "DeleteK()" style="text-decoration:none; color:gray; font-size: 12pt">삭제</a></h1>
					<script>
						function DeleteK(){
							var ok = confirm("정말 삭제하시겠습니까?\n(카테고리 내의 모든 URL이 삭제됩니다)");
							if(ok){
								location.replace("Kategorie_Delete.jsp");
							}else{
								return;
							}
						}
					</script>
					<div align="left" style = "margin-bottom:4px; margin-top:30px; margin-left:15px">
						<form action = "SearchBoard.jsp" method = "post" name = "searchForm">
						<input type = "checkbox" id = "_즐겨찾기" onclick = "Check2()" value = "즐겨찾기"> <span style = "color:orange"><b>즐겨찾기</b></span>만 보기
							<input type = "submit" onclick = "search()" value = " " style = "float:right;height:26px;width:26px; border:0; background-image: url('img/Search.png'); outline: none;">		
							<input id = "searchtext" type = "text" name = "_search" placeholder = "　　　　　　　　　　검색 " style = "margin-bottom:2px; text-align:left; float:right; margin-right:2px">
							
							<input type = "hidden" name = "_searchtype">
							<input type = "hidden" name = "_searchtext">
							<input type = "hidden" name = "_kategorie" value = "<%=kategorie %>">
							<select style="margin-left:347px; height:26px; float:right; margin-right:2px" id = "typeselect">
								<option value = "explanation">설명</option>
								<option value = "URL">URL</option>
							</select>
						</form>
					</div>
						<script>
							function search(){
								document.searchForm._searchtype.value = document.getElementById("typeselect").options[document.getElementById("typeselect").selectedIndex].value;
								document.searchForm._searchtext.value = document.getElementById("searchtext").value;
								document.searchForm.submit();
							}
						</script>
						<div>
							<table id = "boardtable" class="table table-striped"
								style="text-align: center; border: 1px solid #dddddd; margin-top:7px; table-layout: fixed;">
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
									oracle.OracleGetURL(session.getAttribute("__id").toString(), kategorie);
									for(int i = start_num; i < end_num; i++){
										out.println("<tr height=\"42px\">");
										if(!Oracle_DAO.explanation[i].equals(" ")){
											out.println("<td><input type = \"checkbox\" name = \"rowcheck\"></td>");
											out.println("<td>" + Oracle_DAO.explanation[i] + "</td>");
											out.println("<td style=\"overflow:hidden;white-space:nowrap;text-overflow:ellipsis;\"><a style = text-decoration:none href = \"" + Oracle_DAO.URL[i] + "\"target = \"_blank\">" + Oracle_DAO.URL[i] + "</a></td>");
											out.println("<td>" + Oracle_DAO.rgdate[i] + "</td>");	
											if(!Oracle_DAO.favorites[i].equals(" ")){
												if(Oracle_DAO.favorites[i].equals("Y")){
													out.println("<td><a style = \"color:orange;  text-decoration:none\"  onClick=\"favorite()\">"+"★"+"</a></td>");
												}else{
													out.println("<td><a style = \"color:orange;  text-decoration:none\"  onClick=\"favorite()\">"+"☆"+"</a></td>");
												}
											}else out.println("<td>　</td>");
											out.println("</tr>");
										}else {
											out.println("<td>　</td>");
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
							<div style="display: inline">
							<span style = "margin-left:170px">
								<a href="#" style="text-decoration:none; color:black">&nbsp;◀&nbsp;</a>
								<a href="#" onclick = "pagenation1()" style="text-decoration:none; color:black">&nbsp;1&nbsp;</a>
								<a href="#" onclick = "pagenation2()" style="text-decoration:none; color:black">&nbsp;2&nbsp;</a>
								<a href="#" onclick = "pagenation3()" style="text-decoration:none; color:black">&nbsp;3&nbsp;</a>
								<a href="#" onclick = "pagenation4()" style="text-decoration:none; color:black">&nbsp;4&nbsp;</a>
								<a href="#" onclick = "pagenation5()" style="text-decoration:none; color:black">&nbsp;5&nbsp;</a>
								<a href="#" style="text-decoration:none; color:black">&nbsp;▶&nbsp;</a>
							</span>
							</div>
							<input type = "Button" class="btn btn-primary pull-right" onclick = "Delete()" value = "삭제" style="background-color: #358791; border: 0">
							<input type = "Button" class="btn btn-primary pull-right" style = "margin-right:4px; background-color: #358791; border: 0" onclick = "update()" value = "수정">
							<a href="Url_Regist.jsp" target = "Board" class="btn btn-primary pull-right" style = "margin-right:4px; background-color: #358791; border: 0">등록</a>
							<form action = "Board.jsp" method = "post" name = "pageForm">
								<input type = "hidden" name = "_startnum" value = "0">
								<input type = "hidden" name = "_endnum" value = "15">
								<input type = "hidden" name = "_kategorie" value = "<%=session.getAttribute("__kategorie")%>">
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

							<form action = "Url_Delete.jsp" method = "post" name = "deleteForm" target = "Board">
								<input type = "hidden" name = "_explanation">
								<input type = "hidden" name = "_url">								
							</form>
							<script>
							function Delete(){
								if($("input:checkbox[name='rowcheck']:checked").length==0){
									alert('URL을 선택해주세요');
								}else{
									var checkbox = $("input:checkbox[name=rowcheck]:checked");
									checkbox.each(function(i) {
										var tr = checkbox.parent().parent().eq(i);
										var td = tr.children();
										
										document.deleteForm._explanation.value = document.deleteForm._explanation.value + td.eq(1).text() + "##";
										document.deleteForm._url.value = document.deleteForm._url.value + td.eq(2).text()  + "##";
									});
									document.deleteForm.submit();	
								}
							}
							</script>
							
							
							<form action = "Url_Update.jsp" method = "post" name = "updateForm" target = "Board">
								<input type = "hidden" name = "_explanation">
								<input type = "hidden" name = "_url">								
								<input type = "hidden" name = "_favorite">					
							</form>
							<script>
								function update(){
									if($("input:checkbox[name='rowcheck']:checked").length==0){
										alert('URL을 선택해주세요');
									}else if($("input:checkbox[name='rowcheck']:checked").length>1){
										alert('하나의 URL을 선택해주세요');
									}else{
										var checkbox = $("input:checkbox[name=rowcheck]:checked");
										checkbox.each(function(i) {
											var tr = checkbox.parent().parent().eq(i);
											var td = tr.children();
											
											document.updateForm._explanation.value = td.eq(1).text();
											document.updateForm._url.value = td.eq(2).text();
											document.updateForm._favorite.value = td.eq(4).text();										
										});
										document.updateForm.submit();
									}
								}
							</script>

						</div>

					</div>

				</div>
 <script src="https://code.jquery.com/jquery-3.1.1.min.js"></script> 
 <script src="js/bootstrap.js"></script>
</body>
</html>