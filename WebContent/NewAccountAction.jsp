<%@page import="javax.crypto.Cipher"%>
<%@page import="Java.Convert"%>
<%@page import="java.security.spec.PKCS8EncodedKeySpec"%>
<%@page import="java.io.FileReader"%>
<%@page import="java.io.File"%>
<%@page import="java.security.*"%>
<%@page import="javax.mail.Transport"%>
<%@page import="javax.mail.Message"%>
<%@page import="javax.mail.internet.InternetAddress"%>
<%@page import="javax.mail.Address"%>
<%@page import="javax.mail.internet.MimeMessage"%>
<%@page import="javax.mail.Session"%>
<%@page import="Java.Mail"%>
<%@page import="javax.mail.Authenticator"%>
<%@page import="java.util.Properties"%>
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
<form action = "NewAccountAction.jsp" method = "post" name = "_decform">
	<input type = "hidden" name = "_pwhv">
</form>
	<%
		request.setCharacterEncoding("UTF-8");
		String id = null;
		String encpwhv = null;
		String name = null;
		String email = null;
		String salt = null;

		if (request.getParameter("_id") != null) {
			id = request.getParameter("_id");
		}
		if (request.getParameter("_encpwhv") != null) {
			encpwhv = request.getParameter("_encpwhv");
		}
		if (request.getParameter("_name") != null) {
			name = request.getParameter("_name");
		}
		if (request.getParameter("_email") != null) {
			email = request.getParameter("_email");
		}
		if (request.getParameter("_salt") != null) {
			salt = request.getParameter("_salt");
		}		
		
		PrintWriter script = response.getWriter();
		if (salt == null) {
			script.println("<script>");
			script.println("alert('Error')");
			script.println("history.back();");
			script.println("</script>");
			script.close();
		} else {
			Oracle_DAO oracle = new Oracle_DAO();
			String filePath = "N:Key/";
			File[] file = new File(filePath).listFiles();
			FileReader file_reader = new FileReader(file[0]);
			int cur = 0;
			String key = "";
			while((cur = file_reader.read()) != -1){
		           key += (char)cur;
		         }
		    file_reader.close();
		    String decpwhv = null;
		    try {
		    	//클라우드에 저장된 웹서버의 개인키로 암호화된 해시값을 복호화
				PKCS8EncodedKeySpec keySpec = new PKCS8EncodedKeySpec(Convert.hexStringToByteArray(key));
				KeyFactory keyFactory = KeyFactory.getInstance("RSA");
				PrivateKey privatekey = null;	
				privatekey = keyFactory.generatePrivate(keySpec);
				Cipher cipher = Cipher.getInstance("RSA");
				cipher.init(Cipher.DECRYPT_MODE, privatekey);
				byte[] decpwhvBytes = cipher.doFinal(Convert.hexStringToByteArray(encpwhv));
				decpwhv = new String(decpwhvBytes, "UTF-8");
			} catch (Exception e) {
				e.printStackTrace();
			}		
			if (oracle.OracleNewAccount(id, decpwhv, name, email, salt) == -1) {
				script.println("<script>");
				script.println("alert('이미 가입된 정보가 있습니다.')");
				script.println("history.back();");
				script.println("</script>");
				script.close();
			} else {
				String host = "http://"+Oracle_DAO.ip+":8087/UrlCloud/";
				String from = "3103915@naver.com";
				String to = email;
				String subject = "URL CLOUD 회원가입 메일 인증을 해주세요!";
				String content = "URL CLOUD 가입을 환영합니다!<p> 다음을 클릭하여 이메일 인증을 진행하세요.&ensp;" + "<a href='" + host
						+ "EmailCheckAction.jsp?&_dbwjdkdlel=" + id + "'>이메일 인증하기</a>";

				Properties p = new Properties();
				p.put("mail.smtp.user", from);
				p.put("mail.smtp.host", "smtp.naver.com");
				p.put("mail.smtp.port", "465");
				p.put("mail.smtp.starttls.enable", "true");
				p.put("mail.smtp.auth", "true");
				p.put("mail.smtp.debug", "true");
				p.put("mail.smtp.socketFactory.port", "465");
				p.put("mail.smtp.socketFactory.class", "javax.net.ssl.SSLSocketFactory");
				p.put("mail.smtp.socketFactory.fallback", "false");
				try {
					Authenticator auth = new Mail();
					Session ses = Session.getInstance(p, auth);
					ses.setDebug(true);
					MimeMessage msg = new MimeMessage(ses);
					msg.setSubject(subject);
					Address fromAddr = new InternetAddress(from);
					msg.setFrom(fromAddr);
					Address toAddr = new InternetAddress(to);
					msg.addRecipient(Message.RecipientType.TO, toAddr);
					msg.setContent(content, "text/html;charset=UTF-8");
					Transport.send(msg);
				} catch (Exception e) {
					e.printStackTrace();
				}
			}
		}
		
	%>
</body>
<div align="center" style="margin-top: 200px">
	<img src=img/login_logo.PNG><br>
	<br>
	<br>
	<p style="font-size: 14pt"><b>이메일이 전송되었습니다. 이메일에 접속하여 인증 후, 서비스를 이용하실수 있습니다.</b></p>
</div>
</html>