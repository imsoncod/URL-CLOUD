<%@page import="Java.Convert"%>
<%@page import="javax.crypto.spec.IvParameterSpec"%>
<%@page import="java.util.Date"%>
<%@page import="java.security.SecureRandom"%>
<%@page import="javax.crypto.Cipher"%>
<%@page import="javax.crypto.spec.SecretKeySpec"%>
<%@page import="javax.crypto.SecretKey"%>
<%@page import="javax.crypto.KeyGenerator"%>
<%@page import="javax.mail.SendFailedException"%>
<%@page import="java.io.PrintWriter"%>
<%@page import="Java.Oracle_DAO"%>
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
	PrintWriter script = response.getWriter();
	String id = null;
	String pw = null;
	if(request.getParameter("_id") == null || request.getParameter("_pw") == null){
		script.println("<script>");
		script.println("alert('Error')");
		script.println("history.back();");
		script.println("</script>");
		script.close();
	}
	
	if(request.getParameter("_id") != null){
		id = request.getParameter("_id");
	}
	if(request.getParameter("_pw") != null){
		pw = request.getParameter("_pw");
	}
	
	Oracle_DAO oracle = new Oracle_DAO();
	if(oracle.OracleGetData("userinfo", id, "username")==null){
		script.println("<script>");
		script.println("alert('회원정보가 일치하지 않습니다.')");
		script.println("history.back();");
		script.println("</script>");
		script.close();
	}
	String emailcheck = oracle.OracleGetData("userinfo", id, "useremailcheck");
	//데이터베이스에서 ID에 해당하는 32자리 난수를 가져옴
	String randnum = oracle.OracleGetData("userinfo", id, "usercode").substring(12);
	//난수를 대칭키삼아 암호화된 해시값을 복호화
	KeyGenerator AEStool = KeyGenerator.getInstance("AES"); 
	SecretKeySpec keySpec = new SecretKeySpec(randnum.getBytes(), "AES");
	Cipher cipher = Cipher.getInstance("AES/ECB/PKCS5Padding"); 
	cipher.init(Cipher.DECRYPT_MODE, keySpec);  
	byte[] decpwhvBytes = cipher.doFinal(Convert.hexStringToByteArray(pw));
	String pwhv = new String(decpwhvBytes);
	oracle.OracleDeleteRandnum(id);
	
		if(oracle.OracleLogin(id, pwhv)!=1){
			script.println("<script>");
			script.println("alert('회원정보가 일치하지 않습니다.')");
			script.println("history.back();");
			script.println("</script>");
			script.close();
		}
		else{
			if(emailcheck.equals("0")){
				script.println("<script>");
				script.println("alert('이메일 인증 후 서비스를 이용하실 수 있습니다.')");
				script.println("history.back();");
				script.println("</script>");
				script.close();
			}else {
				session.setAttribute("__id",id);
				response.sendRedirect("Main.jsp");
			}
		}
%>
</body>
</html>