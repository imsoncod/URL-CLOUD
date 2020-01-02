<%@page import="java.io.PrintWriter"%>
<%@page import="Java.Oracle_DAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width" initial-scale="1">
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
	request.setCharacterEncoding("UTF-8");
	String favorite = "Y";
	String priv = "Y";
	Oracle_DAO oracle = new Oracle_DAO();
	if(request.getParameter("_favorite") == null) favorite = "N";
	if(request.getParameter("_private") == null) priv = "N";
	if(request.getParameter("_explanation") != null && request.getParameter("_url") != null && request.getParameter("_update") != null){
		oracle.OracleUpdateUrl(session.getAttribute("__id").toString(), session.getAttribute("__kategorie").toString(), request.getParameter("_explanation"), request.getParameter("_url"), favorite, priv);
		%>
		<form action = "Board.jsp" method = "post" name = "form2">
			<input type = "hidden" name = "_kategorie" value = "<%=session.getAttribute("__kategorie").toString()%>">
		</form>	
		<script>
			alert('URL이 수정되었습니다');
			document.form2.submit();
		</script>
<%
	}else{
		String explanation = request.getParameter("_explanation");
		String url = request.getParameter("_url");
		Oracle_DAO.B_explanation = explanation;
		Oracle_DAO.B_url = url;
		favorite = request.getParameter("_favorite");
		priv = oracle.OracleGetPriv(session.getAttribute("__id").toString(), explanation, url);
		
	%>
	<form action = "Board.jsp" method = "post" name = "form3">
			<input type = "hidden" name = "_kategorie" value = "<%=session.getAttribute("__kategorie").toString()%>">
	</form>	
<div align = "center" style = "width: 844px; height: 890px; background: white; border: 2px solid #358791">
  <div align = "center" style ="width:400px; margin-top:20%">
	<h1>URL 수정</h1>
      <div style="padding-top: 20px;">
         <form method="post" action="Url_Update.jsp" name = "form">
           <input type = "hidden" name = "_update" value = "update">
           <input type="text" class="form-control" placeholder="<%=session.getAttribute("__kategorie") %>" disabled><br>
     	   <input type="text" class="form-control" placeholder="설명" value = "<%=explanation %>" name="_explanation" maxlength="13"><br>
     	   <input type="text" class="form-control" placeholder="URL" value = "<%=url %>" name="_url" maxlength="500"><br>
    	<%
    		if(favorite.equals("★")){
    	%>
    	   <span style = "float:center; color:orange; margin-right:60px">
     	   <input type="checkbox" name="_favorite" value = "Y" checked>&nbsp;<b>즐겨찾기</b>
     	   </span>
     	   <%     	   			
    			}else{
     	   %>
     	   <span style = "float:center; color:orange; margin-right:60px">
     	   <input type="checkbox" name="_favorite" value = "Y">&nbsp;<b>즐겨찾기</b>
     	   </span>
     	   <%
    			}
    		if(priv.equals("Y")){
     	   %>
     	   <span style = "float:center">
     	   <input type="checkbox" name="_private" value = "Y" checked>&nbsp;<b>비공개</b>
     	   </span><br><br>
     	   <% 
    			}else{
     	   %>
     	   <span style = "float:center">
     	   <input type="checkbox" name="_private" value = "Y">&nbsp;<b>비공개</b>
     	   </span><br><br>
     	   <%
    			}
     	   %>
     	   <div>
    	     <input type="Button" onClick="Check1()" class="btn btn-primary" value="수정"
    		   style="background-color: #358791; border: 1px solid #358791;
    		   font-size:12pt; color:#ffffff; font-weight:bold; width:150px; margin-right:20px">
    		   <input type="Button" onClick="Check2()" class="btn btn-primary" value="취소"
    		   style="background-color: #358791; border: 1px solid #358791;
    		   font-size:12pt; color:#ffffff; font-weight:bold; width:150px"">   
    	   </div>	   
        </form>
 	 </div>
   </div>
</div>
<script>
	function Check1(){
		if(document.form._explanation.value == ""){
			alert('설명을 입력해주세요');
		}else if(form._url.value == ""){
			alert('URL을 입력해주세요');
		}else{
			document.form.submit();
		}
	}
	function Check2(){
		document.form3.submit();
	}
</script>
 <script src="https://code.jquery.com/jquery-3.1.1.min.js"></script> 
 <script src="js/bootstrap.js"></script>
 <script src="https://cdnjs.cloudflare.com/ajax/libs/crypto-js/3.1.2/rollups/hmac-sha256.js"></script>
 <%
	}
 %>
</body>
</html>