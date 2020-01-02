package Java;

import java.io.File;
import java.io.FileReader;

import javax.mail.Authenticator;
import javax.mail.PasswordAuthentication;

public class Mail extends Authenticator{
	String a, b;

	@Override
	protected PasswordAuthentication getPasswordAuthentication(){
		try {
			String filePath = "N:Key/";
			File[] file = new File(filePath).listFiles();
			FileReader file_reader = new FileReader(file[1]);
			int cur = 0;
			String str = "";
			while((cur = file_reader.read()) != -1){
		           str += (char)cur;
		         }
		    file_reader.close();
		    String arr[] = str.split("#");
		    a = arr[0];
		    b = arr[1];
		}catch(Exception e) {
			
		}
		return new PasswordAuthentication(a, b);
	}
}
