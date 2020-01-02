package Java;

import java.security.MessageDigest;

public class Hash {
	public static String Hash(String id, String plaintext, String salt) {
		StringBuffer hv = new StringBuffer();
		try {
			MessageDigest digest = MessageDigest.getInstance("SHA-256");
			if(salt == null) { //로그인시 웹서버로부터 DB에 저장된 Salt를 가져옴
				Oracle_DAO oracle = new Oracle_DAO();
				plaintext = plaintext + oracle.OracleGetData("userinfo", id, "usercode").substring(0, 4);
			}else { //회원가입시 비밀번호에 Salt를 붙여 해시 적용
				plaintext = plaintext + salt;
			}
			byte[] chars = digest.digest(plaintext.getBytes("UTF-8"));
			for(int i = 0; i < chars.length; i++) {
				String hex = Integer.toHexString(0xff & chars[i]);
				if(hex.length() == 1) hv.append('0');
				hv.append(hex);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return hv.toString();
	}
}