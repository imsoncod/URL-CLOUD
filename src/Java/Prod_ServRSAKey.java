package Java;

import java.security.KeyFactory;
import java.security.KeyPair;
import java.security.KeyPairGenerator;
import java.security.PrivateKey;
import java.security.PublicKey;
import java.security.SecureRandom;

public class Prod_ServRSAKey {
	public static void main(String[] args) {
		Prod_ServRSAKeyFunction();
	}
	
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
	public static void Prod_ServRSAKeyFunction() {
		try{
			String algorithm = "URLCLOUD";
			SecureRandom srand = new SecureRandom();
			byte[] b = algorithm.getBytes();
			srand.setSeed(b); //URLCLOUD���ڿ��� byte�� seed�� ���
			KeyPairGenerator tool = KeyPairGenerator.getInstance("RSA");
			KeyFactory keyFactory = KeyFactory.getInstance("RSA");
			tool.initialize(1024,srand);
			KeyPair keypair = tool.genKeyPair();
			PublicKey publickey = keypair.getPublic();
			PrivateKey privatekey = keypair.getPrivate();		
			String pbkey = new String(byteArrayToHex(publickey.getEncoded()));
			String pvkey = new String(byteArrayToHex(privatekey.getEncoded()));
		}catch(Exception e) {
			e.printStackTrace();
		}
	}
}
