<%@page import="java.security.spec.X509EncodedKeySpec"%>
<%@page import="javax.crypto.spec.IvParameterSpec"%>
<%@page import="javax.crypto.spec.SecretKeySpec"%>
<%@page import="javax.crypto.SecretKey"%>
<%@page import="javax.crypto.KeyGenerator"%>
<%@page import="javax.crypto.Cipher"%>
<%@page import="java.security.spec.PKCS8EncodedKeySpec"%>
<%@page import="Java.Hash"%>
<%@page import="Java.Prod_Randnum"%>
<%@page import="Java.Convert"%>
<%@page import="java.security.PrivateKey"%>
<%@page import="java.security.PublicKey"%>
<%@page import="java.security.KeyPair"%>
<%@page import="java.security.KeyFactory"%>
<%@page import="java.security.KeyPairGenerator"%>
<%@page import="java.util.Date"%>
<%@page import="java.security.SecureRandom"%>
<%@page import="java.io.File"%>
<%@page import="javax.mail.Session"%>
<%@page import="java.io.PrintWriter"%>
<%@page import="Java.Oracle_DAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"

    pageEncoding="UTF-8"%>

<!DOCTYPE html>

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta name="viewport" content="width=device-width" initial-scale="1">
<link rel="stylesheet" href="css/bootstrap.min.css">
<title>URL CLOUD</title>
</head>
<body>
<%
	if(request.getParameter("_id") != null && request.getParameter("_pw") != null){
		String id = request.getParameter("_id");
		//아이디에 해당하는 Salt를 받아와 비밀번호화 함께 해시 적용
		String pwhv = Hash.Hash(id, request.getParameter("_pw"),null);
		SecureRandom srand = new SecureRandom(String.valueOf(new Date().getTime()).getBytes());		
		//아이디와 공개키를 웹서버에게 전송하고 암호화된 난수를 받아옴
		KeyPairGenerator RSAtool = KeyPairGenerator.getInstance("RSA");
		KeyFactory keyFactory = KeyFactory.getInstance("RSA");
		RSAtool.initialize(1024,srand);
		KeyPair keypair = RSAtool.genKeyPair();
		PublicKey publickey = keypair.getPublic();
		PrivateKey privatekey = keypair.getPrivate();
		String encrandnum = Prod_Randnum.Prod_Randnum(id, new String(Convert.byteArrayToHex(publickey.getEncoded())));	
		//웹서버로부터 받은 암호화된 난수를 복호화하여 난수를 얻어냄
		Cipher cipher = Cipher.getInstance("RSA");
		cipher.init(Cipher.DECRYPT_MODE, privatekey);
		privatekey = null;
		byte[] decrandnumBytes = cipher.doFinal(Convert.hexStringToByteArray(encrandnum));
		String decrandnum = new String(decrandnumBytes, "UTF-8");	
		//난수를 대칭키로 삼아 비밀번호를 AES암호화 하여 서버에게 아이디와 함께 전송
		KeyGenerator AEStool = KeyGenerator.getInstance("AES"); 
		SecretKeySpec keySpec = new SecretKeySpec(decrandnum.getBytes(), "AES");
		cipher = Cipher.getInstance("AES/ECB/PKCS5Padding"); 
		cipher.init(Cipher.ENCRYPT_MODE, keySpec);  
		byte[] encpwhvBytes = cipher.doFinal(pwhv.getBytes());
		String encpwhv = Convert.byteArrayToHex(encpwhvBytes);
		%>
		<form action = "LoginAction.jsp" method = "post" name = "form">
			<input type = "hidden" name = "_id" value = "<%=id%>">
			<input type = "hidden" name = "_pw" value = "<%=encpwhv%>">
		</form>
		<script>
			document.form.submit();
		</script>
	<%}else{
	Oracle_DAO oracle = new Oracle_DAO();
	if(oracle.OracleLoading()==-1){
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('연결 오류.')");
		script.println("history.back();");
		script.println("</script>");
		script.close();
	}
%>

 <div class="container">

  <div class="col-lg-4"></div>

  <div class="col-lg-4" align = "center"> 

   <div style="padding-top: 40px;">

   <form method="post" action="Login.jsp">

    <img src = img/login_logo.PNG><br><br><br>
	<div class="form-group">
     		<input type="text" class="form-control" placeholder="아이디" name="_id" maxlength="20" style = "width:350px">
    	</div>

   		<div class="form-group">
     		<input type="password" class="form-control" placeholder="비밀번호" name="_pw" maxlength="20" style = "width:350px">
    	</div><br>

    <input type="submit" class="btn btn-primary form-control" value="로그인 " 
    		style="background-color: #358791; border: 1px solid #358791;
    		font-size:12pt; color:#ffffff; font-weight:bold; width:350px">
	
   </form>
   
   <div style = "color:#848484;">
	<br> 아직 계정이 없으신가요?  
	<a href = "NewAccount.jsp" style = "font-weight:bold; color:#358791">계정 만들기 ></a>
	</div>
	
  </div>

 </div>

</div>

 <script src="https://code.jquery.com/jquery-3.1.1.min.js"></script> 
 <script src="js/bootstrap.js"></script>
 <script src="https://cdnjs.cloudflare.com/ajax/libs/crypto-js/3.1.2/rollups/hmac-sha256.js"></script>
<%
	}
%>
</body>

</html>