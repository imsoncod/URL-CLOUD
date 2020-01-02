package Java;

public class Convert {
	//키를 바이트로 바꾸는 함수
	 public static byte[] hexToByteArray(String hex) {
	     if (hex == null || hex.length() == 0) {
	         return null;
	     }
	     byte[] ba = new byte[hex.length() / 2];
	     for (int i = 0; i < ba.length; i++) {
	         ba[i] = (byte) Integer.parseInt(hex.substring(2 * i, 2 * i + 2), 16);
	     }
	     return ba;
	 }

	//암호화된 문자열을 byte로 바꿔주는 함수
	public static byte[] hexStringToByteArray(String s) {
	    int len = s.length();
	    byte[] data = new byte[len / 2];
	    for (int i = 0; i < len; i += 2) {
	        data[i / 2] = (byte) ((Character.digit(s.charAt(i), 16) << 4)
	                             + Character.digit(s.charAt(i+1), 16));
	    }
	    return data;
	}
	
	//byte배열을 HEX로 바꿔주는 함수, 키를 변환할때 사용
	public static String byteArrayToHex(byte[] ba) {
	     if (ba == null || ba.length == 0) { 
	         return null;
	     }
	     StringBuffer sb = new StringBuffer(ba.length * 2);
	     String hexNumber = "";
	     for (int x = 0; x < ba.length; x++) {
	         hexNumber = "0" + Integer.toHexString(0xff & ba[x]);
	         sb.append(hexNumber.substring(hexNumber.length() - 2));     
	     }
	     return sb.toString();
	 } 
}
