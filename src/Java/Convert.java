package Java;

public class Convert {
	//Ű�� ����Ʈ�� �ٲٴ� �Լ�
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

	//��ȣȭ�� ���ڿ��� byte�� �ٲ��ִ� �Լ�
	public static byte[] hexStringToByteArray(String s) {
	    int len = s.length();
	    byte[] data = new byte[len / 2];
	    for (int i = 0; i < len; i += 2) {
	        data[i / 2] = (byte) ((Character.digit(s.charAt(i), 16) << 4)
	                             + Character.digit(s.charAt(i+1), 16));
	    }
	    return data;
	}
	
	//byte�迭�� HEX�� �ٲ��ִ� �Լ�, Ű�� ��ȯ�Ҷ� ���
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
