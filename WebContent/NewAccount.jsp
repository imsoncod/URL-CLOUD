<%@page import="Java.Convert"%>
<%@page import="javax.crypto.Cipher"%>
<%@page import="java.security.spec.X509EncodedKeySpec"%>
<%@page import="Java.Hash"%>
<%@page import="java.util.Date"%>
<%@page import="java.io.File"%>
<%@page import="java.security.*" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"

    pageEncoding="UTF-8"%>

<!DOCTYPE html>

<html>

<head>
<script type="text/javascript" src="js/rsa.js"></script>
<script type="text/javascript" src="js/jsbn.js"></script>
<script type="text/javascript" src="js/prng4.js"></script>
<script type="text/javascript" src="js/rng.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/crypto-js/3.1.2/rollups/hmac-sha256.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/crypto-js/3.1.2/components/enc-base64-min.js"></script>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta name="viewport" content="width=device-width" initial-scale="1">
<link rel="stylesheet" href="css/bootstrap.min.css">
<title>URL CLOUD</title>
<script>
function check(){
	var form = document.newAccountForm;
	if(form._id.value == ""){
		alert('아이디를 입력해주세요')
	}else if(form._pw.value == "" || form._pwcheck.value == ""){
		alert('비밀번호를 입력해주세요')
	}else if(form._name.value == ""){
		alert('이름을 입력해주세요')
	}else if(form._email.value == ""){
		alert('이메일을 입력해주세요')
	}else if(!form._agree.checked){
		alert('개인정보 제공에 동의하지 않으셨습니다')
	}else if(form._pw.value != form._pwcheck.value){
		alert('비밀번호를 확인해주세요')
	}else{
		form.submit();
	}
}
</script>
</head>

<body>
<%
	request.setCharacterEncoding("UTF-8");
	if(request.getParameter("_id") != null && request.getParameter("_pw") != null && request.getParameter("_pwcheck") != null
		&& request.getParameter("_name") != null && request.getParameter("_email") != null && request.getParameter("_agree") != null
		&& request.getParameter("_salt") != null && request.getParameter("_salt1") != null){
		String id = request.getParameter("_id");
		//비밀번호에 Salt를 붙여 해시 적용
		String pwhv = Hash.Hash(id, request.getParameter("_pw"), request.getParameter("_salt1"));
		String name = request.getParameter("_name");
		String email = request.getParameter("_email");
		String agree = request.getParameter("_agree");
		String salt = request.getParameter("_salt");
		//웹서버의 공개키로 해시값을 암호화
		X509EncodedKeySpec keySpec = new X509EncodedKeySpec(Convert.hexStringToByteArray("30819f300d06092a864886f70d010101050003818d0030818902818100b6d02a48b0dc03733ff7d042fc6740ecbd2c39377bca3c1aab6f9c220c745714d512bb3461952cde825dff5c7838fb7789314a860570f078d8ec1f0db07c6c70d7ee8b15fd2741c8df375fb53a373f257b9539c4f7efe0ed4b60753cea148ba2ec8a9ca4c67f70703164215440515184ab36ead5c2e3b6c28ce206f090d3d2170203010001"));
		KeyFactory keyFactory = KeyFactory.getInstance("RSA");
		PublicKey publickey = null;	
		publickey = keyFactory.generatePublic(keySpec);
		Cipher cipher = Cipher.getInstance("RSA");
		cipher.init(Cipher.ENCRYPT_MODE, publickey);
		byte[] encpwhvBytes = cipher.doFinal(pwhv.getBytes());
		String encpwhv = Convert.byteArrayToHex(encpwhvBytes);
		%>
		<form action = "NewAccountAction.jsp" method="post" name = "form">
			<input type = "hidden" name = "_id" value = "<%=id %>">
			<input type = "hidden" name = "_encpwhv" value = "<%=encpwhv %>">
			<input type = "hidden" name = "_name" value = "<%=name %>">
			<input type = "hidden" name = "_email" value = "<%=email %>">
			<input type = "hidden" name = "_salt" value = "<%=salt %>">
		</form>
		<script>
			document.form.submit();
		</script>
	<% 
	}else{
		SecureRandom srand = new SecureRandom(String.valueOf(new Date().getTime()).getBytes());
		String salt1 = String.valueOf(srand.nextInt(9000)+1000);
		String salt2 = String.valueOf(srand.nextInt(9000)+1000);
		String salt3 = String.valueOf(srand.nextInt(9000)+1000);
		String salt = salt1 + salt2 + salt3;
%>
 <div class="container">

  <div class="col-lg-4"></div>

  <div class="col-lg-4" align = "center">

   <div style="padding-top: 40px;">

   <form method="post" action="NewAccount.jsp" name="newAccountForm">
    <input type = "hidden" name = "_salt" value = <%=salt %>>
	<input type = "hidden" name = "_salt1" value = <%=salt1 %>>
	<input type = "hidden" name = "_pwhv">

    <img src = img/login_logo.PNG><br><br><br>
    
    <div class="form-group">
	
     <input type="text" class="form-control" placeholder="아이디" name="_id" maxlength="20" style = "width:350px">

    </div>

    <div class="form-group">

     <input type="password" class="form-control" placeholder="비밀번호" name="_pw" maxlength="20" style = "width:350px">

    </div>
    
    <div class="form-group">

     <input type="password" class="form-control" placeholder="비밀번호 확인" name="_pwcheck" maxlength="20" style = "width:350px">

    </div>
    
    <div class="form-group">

     <input type="text" class="form-control" placeholder="이름" name="_name" maxlength="4" style = "width:350px">

    </div>
    
    <div class="form-group">

     <input type="text" class="form-control" placeholder="E-Mail (이메일인증에 사용됩니다)" name="_email" maxlength="30" style = "width:350px">

    </div>
	<input type = "checkbox" name = "_agree" value = "동의"> 위 내용의 개인정보를 제공함에 동의합니다.
    <br><br>
    <input type="Button" onClick="check()" class="btn btn-primary form-control" value="회원 가입 " 
    style="background-color: #358791; border: 1px solid #358791;
    font-size:12pt; color:#ffffff; font-weight:bold;width:350px">
	
   </form>
	
  </div>

 </div>

</div>

 <script src="https://code.jquery.com/jquery-3.1.1.min.js"></script> 
 <script src="js/bootstrap.js"></script>
 <%
	}
 %>
</body>

</html>