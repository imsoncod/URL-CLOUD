package Java;

import java.security.KeyFactory;
import java.security.PublicKey;
import java.security.SecureRandom;
import java.security.spec.X509EncodedKeySpec;
import java.util.Date;

import javax.crypto.Cipher;

public class Prod_Randnum {
	
	public static String Prod_Randnum(String id, String publickey) {
		SecureRandom srand = new SecureRandom(String.valueOf(new Date().getTime()).getBytes());
		String randnum = String.valueOf(srand.nextInt(90000000)+10000000)+ 
				         String.valueOf(srand.nextInt(90000000)+10000000)+
				         String.valueOf(srand.nextInt(90000000)+10000000)+ 
				         String.valueOf(srand.nextInt(90000000)+10000000);
		Oracle_DAO oracle = new Oracle_DAO();
		oracle.OracleInsertRandnum(id, randnum);
		String encrandnum = null;
		try {
			X509EncodedKeySpec keySpec = new X509EncodedKeySpec(Convert.hexStringToByteArray(publickey));
			KeyFactory keyFactory = KeyFactory.getInstance("RSA");
			PublicKey Apublickey = null;	
			Apublickey = keyFactory.generatePublic(keySpec);
			Cipher cipher = Cipher.getInstance("RSA");
			cipher.init(Cipher.ENCRYPT_MODE, Apublickey);
			byte[] encrandnumBytes = cipher.doFinal(randnum.getBytes());
			encrandnum = Convert.byteArrayToHex(encrandnumBytes);	
		} catch (Exception e) {
			e.printStackTrace();
		}
		return encrandnum;
	}
}
