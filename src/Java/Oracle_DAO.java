package Java;

import java.io.File;
import java.io.FileReader;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.Arrays;

public class Oracle_DAO {
	final private String commit = "COMMIT";
	final private String driver = "oracle.jdbc.driver.OracleDriver";
	public static String ip = "localhost";
	public static String url = "jdbc:oracle:thin:@"+ip+":1521:orcl";
	private static String user;
	private static String password;

	private Connection con = null;
	private Statement stmt = null;
	private ResultSet rs = null;
	private String sql = null;
	private int check = -1;
	
	//Checking Oracle Loading
	public int OracleLoading() {
		try {
			Class.forName(driver);
			Setting();
			DriverManager.getConnection(url, user, password);
			check = 0;
		} catch (ClassNotFoundException e) {
			e.printStackTrace();
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return check;
	}
	
	//Get Oracle Info
	public void Setting() {
		try {
			String filePath = "N:Key/";
			File[] file = new File(filePath).listFiles();
			FileReader file_reader = new FileReader(file[2]);
			int cur = 0;
			String str = "";
			while((cur = file_reader.read()) != -1){
		           str += (char)cur;
		         }
		    file_reader.close();
		    String arr[] = str.split("#");
		    user = arr[0];
		    password = arr[1];
		}catch(Exception e) {
			
		}
	}
	
	//Oracle Get Data
	public String OracleGetData(String table, String userid, String attribute) {
		check = -1;
		try {
			Setting();
			con = DriverManager.getConnection(url, user, password);

			sql = "select " + attribute + " from " + table + " where userid = '" + userid + "'";
			stmt = con.createStatement();
			rs = stmt.executeQuery(sql);
			if(rs.next() == true) {
				return rs.getString(1);
			}
		}
		catch (Exception e) {
			e.printStackTrace();
		}finally {
			try{if(con!=null) con.close();}catch(Exception e){};
			try{if(stmt!=null) stmt.close();}catch(Exception e){};
			try{if(rs!=null) rs.close();}catch(Exception e){};
		}
		return null;
	}
	
	//Oracle Get Priv
	public String OracleGetPriv(String userid, String explanation, String _url) {
		check = -1;
		try {
			Setting();
			con = DriverManager.getConnection(url, user, password);

			sql = "select private from url where userid = '"+userid+"' and explanation = '"+explanation+"' and url = '"+_url+"'";
			stmt = con.createStatement();
			rs = stmt.executeQuery(sql);
			if(rs.next() == true) {
				return rs.getString(1);
			}
		}
		catch (Exception e) {
			e.printStackTrace();
		}finally {
			try{if(con!=null) con.close();}catch(Exception e){};
			try{if(stmt!=null) stmt.close();}catch(Exception e){};
			try{if(rs!=null) rs.close();}catch(Exception e){};
		}
		return null;
	}
	
	//Oracle Login
	public int OracleLogin(String userid, String userpw) {
		check = -1;
		try {
			Setting();
			con = DriverManager.getConnection(url, user, password);
			sql = "select * from userinfo where userid ='" + userid + "' and userpw = '" + userpw + "'";
			stmt = con.createStatement();
			rs = stmt.executeQuery(sql);
			if(rs.next() == true) {
				check = 1;
			}
		}
		catch (Exception e) {
			e.printStackTrace();
		}finally {
			try{if(con!=null) con.close();}catch(Exception e){};
			try{if(stmt!=null) stmt.close();}catch(Exception e){};
			try{if(rs!=null) rs.close();}catch(Exception e){};
		}
		return check;
	}
	
	//Oracle New Account
	public int OracleNewAccount(String userid, String userpw, String username, String useremail, String usercode) {
		check = -1;
		try {
			Setting();
			con = DriverManager.getConnection(url, user, password);
			sql = "Insert into userinfo values('"+userid+"','"+userpw+"','"+username+"','"+useremail+"',0,'"+usercode+"')";
			stmt = con.createStatement();
			rs = stmt.executeQuery(sql);
			rs = stmt.executeQuery(commit);
			check = 1;
		} catch (Exception e) {
			e.printStackTrace();
		}finally {
			try{if(con!=null) con.close();}catch(Exception e){};
			try{if(stmt!=null) stmt.close();}catch(Exception e){};
			try{if(rs!=null) rs.close();}catch(Exception e){};
		}
		return check;
	}
		
	//Oracle Email Check
	public void OracleEmailCheck(String userid) {
		try {
			Setting();
			con = DriverManager.getConnection(url, user, password);
			sql = "Update userinfo set useremailcheck = 1 where userid = '" + userid+"'";
			stmt = con.createStatement();
			rs = stmt.executeQuery(sql);
			rs = stmt.executeQuery(commit);
		} catch (Exception e) {
			
		}finally {
			try{if(con!=null) con.close();}catch(Exception e){};
			try{if(stmt!=null) stmt.close();}catch(Exception e){};
			try{if(rs!=null) rs.close();}catch(Exception e){};
		}
	}
			
	//Oracle Insert Randnum
	public void OracleInsertRandnum(String userid, String Randnum) {
		try {
			Setting();
			con = DriverManager.getConnection(url, user, password);
			sql = "select usercode from userinfo where userid = '"+ userid +"'";
			stmt = con.createStatement();
			rs = stmt.executeQuery(sql);
			String code = null;
			if(rs.next()) {
				code = rs.getString(1);
			}
			code = code + Randnum;
			sql = "update userinfo set usercode = '"+code+"' where userid = '"+ userid +"'";
			stmt = con.createStatement();
			rs = stmt.executeQuery(sql);
			rs = stmt.executeQuery(commit);
		} catch (Exception e) {
			e.printStackTrace();
		}finally {
			try{if(con!=null) con.close();}catch(Exception e){};
			try{if(stmt!=null) stmt.close();}catch(Exception e){};
			try{if(rs!=null) rs.close();}catch(Exception e){};
			}
		}
			
	//Oracle Delete Randnum
	public void OracleDeleteRandnum(String userid) {
		try {
			Setting();
			con = DriverManager.getConnection(url, user, password);
			sql = "select usercode from userinfo where userid = '"+ userid +"'";
			stmt = con.createStatement();
			rs = stmt.executeQuery(sql);
			String code = null;
			if(rs.next()) {
				code = rs.getString(1);
			}
			code = code.substring(0, 12);
			sql = "update userinfo set usercode = '"+code+"' where userid = '"+ userid +"'";
			stmt = con.createStatement();
			rs = stmt.executeQuery(sql);
			rs = stmt.executeQuery(commit);
		} catch (Exception e) {
			e.printStackTrace();
		}finally {
			try{if(con!=null) con.close();}catch(Exception e){};
			try{if(stmt!=null) stmt.close();}catch(Exception e){};
			try{if(rs!=null) rs.close();}catch(Exception e){};
		}
	}
			
	public static String[] kategories = new String[10];
			
	//Oracle Get Kategories
	public void OracleGetKategories(String userid) {
		check = -1;
		try {
			Setting();
			Arrays.fill(kategories, null);
			con = DriverManager.getConnection(url, user, password);

			sql = "select kategoriename from kategorie where userid = '" + userid + "'";
			stmt = con.createStatement();
			rs = stmt.executeQuery(sql);
			int i = 0;
			while(rs.next()) {
				kategories[i] = rs.getString(1);
				i++;
			}
		}
		catch (Exception e) {
			e.printStackTrace();
		}finally {
			try{if(con!=null) con.close();}catch(Exception e){};
			try{if(stmt!=null) stmt.close();}catch(Exception e){};
			try{if(rs!=null) rs.close();}catch(Exception e){};
		}
	}			
			
	//Oracle Get URL
	public static String[] explanation = new String[75];
	public static String[] URL = new String[75];
	public static String[] rgdate = new String[75];
	public static String[] favorites = new String[75];
	public void OracleGetURL(String userid, String kategorie) {
		check = -1;
		try {
			Setting();
			Arrays.fill(explanation, " ");
			Arrays.fill(URL, " ");
			Arrays.fill(rgdate, " ");
			Arrays.fill(favorites, " ");
			con = DriverManager.getConnection(url, user, password);
			sql = "select explanation, url, to_char(rgdate,'YYYY-MM-DD'), favorites from url where userid = '" + userid + "' and kategorie = '" + kategorie + "' order by rgdate desc";
			stmt = con.createStatement();
			rs = stmt.executeQuery(sql);
			int i = 0;
			while(rs.next()) {
				explanation[i] = rs.getString(1);
				URL[i] = rs.getString(2);
				rgdate[i] = rs.getString(3);
				favorites[i] = rs.getString(4);
				i++;
			}
		}
		catch (Exception e) {
			e.printStackTrace();
		}finally {
			try{if(con!=null) con.close();}catch(Exception e){};
			try{if(stmt!=null) stmt.close();}catch(Exception e){};
			try{if(rs!=null) rs.close();}catch(Exception e){};
		}
	}
			
	//Oracle Get Url Of Search
	public void OracleGetURLOfSearch(String userid, String kategorie, String searchType, String searchText) {
		check = -1;
		try {
			Setting();
			Arrays.fill(explanation, " ");
			Arrays.fill(URL, " ");
			Arrays.fill(rgdate, " ");
			Arrays.fill(favorites, " ");
			con = DriverManager.getConnection(url, user, password);
			sql = "select explanation, url, to_char(rgdate,'YYYY-MM-DD'), favorites from url where userid = '" + userid + "' and kategorie = '" + kategorie + "' and "+searchType+" like '%"+searchText+"%' order by rgdate desc";
			stmt = con.createStatement();
			rs = stmt.executeQuery(sql);
			int i = 0;
			while(rs.next()) {
				explanation[i] = rs.getString(1);
				URL[i] = rs.getString(2);
				rgdate[i] = rs.getString(3);
				favorites[i] = rs.getString(4);
				i++;
			}
		}
		catch (Exception e) {
			e.printStackTrace();
		}finally {
			try{if(con!=null) con.close();}catch(Exception e){};
			try{if(stmt!=null) stmt.close();}catch(Exception e){};
			try{if(rs!=null) rs.close();}catch(Exception e){};
		}
	}
			
	public static String userid[] = new String[75];
	//Oracle Get All Url Of Search
	public void OracleGetAllURLOfSearch(String searchType, String searchText) {
		check = -1;
		try {
			Setting();
			Arrays.fill(explanation, " ");
			Arrays.fill(URL, " ");
			Arrays.fill(rgdate, " ");
			Arrays.fill(userid, " ");
			con = DriverManager.getConnection(url, user, password);
			sql = "select explanation, url, to_char(rgdate,'YYYY-MM-DD'), userid from url where private = 'N' and "+searchType+" like '%"+searchText+"%' order by rgdate desc";
			stmt = con.createStatement();
			rs = stmt.executeQuery(sql);
			int i = 0;
			while(rs.next()) {
				explanation[i] = rs.getString(1);
				URL[i] = rs.getString(2);
				rgdate[i] = rs.getString(3);
				userid[i] = rs.getString(4);
				i++;
			}
		}
		catch (Exception e) {
			e.printStackTrace();
		}finally {
			try{if(con!=null) con.close();}catch(Exception e){};
			try{if(stmt!=null) stmt.close();}catch(Exception e){};
			try{if(rs!=null) rs.close();}catch(Exception e){};
		}
	}
			
	public static String urlcnt[] = new String[15];
	//Oracle Get TopURL
	public void OracleGetTopURL() {
		check = -1;
		try {
			Setting();
			Arrays.fill(URL, " ");
			con = DriverManager.getConnection(url, user, password);
			sql = "select * from (select url, count(url) from url group by url order by count(url) desc) where rownum <= 15";
			stmt = con.createStatement();
			rs = stmt.executeQuery(sql);
			int i = 0;
			while(rs.next()) {
				URL[i] = rs.getString(1);
				urlcnt[i] = rs.getString(2);
				i++;
			}
		}
		catch (Exception e) {
			e.printStackTrace();
		}finally {
			try{if(con!=null) con.close();}catch(Exception e){};
			try{if(stmt!=null) stmt.close();}catch(Exception e){};
			try{if(rs!=null) rs.close();}catch(Exception e){};
		}
	}
	
	//Oracle Get TopURLExplanation
	public void OracleGetTopURLExplanation(int i) {
		check = -1;
		try {
			Setting();
			Arrays.fill(explanation, " ");
			con = DriverManager.getConnection(url, user, password);
			sql = "select * from (select explanation from url where url = '"+URL[i]+"' order by length(explanation) desc) where rownum <= 1";
			stmt = con.createStatement();
			rs = stmt.executeQuery(sql);
			while(rs.next()) {
				explanation[i] = rs.getString(1);
			}
		}
		catch (Exception e) {
			e.printStackTrace();
		}finally {
			try{if(con!=null) con.close();}catch(Exception e){};
			try{if(stmt!=null) stmt.close();}catch(Exception e){};
			try{if(rs!=null) rs.close();}catch(Exception e){};
		}
	}
			
	//Oracle get Favorite URL
	public void OracleGetFavoriteURL(String userid, String kategorie) {
		check = -1;
		try {
			Setting();
			Arrays.fill(explanation, " ");
			Arrays.fill(URL, " ");
			Arrays.fill(rgdate, " ");
			Arrays.fill(favorites, " ");
			con = DriverManager.getConnection(url, user, password);
			sql = "select explanation, url, to_char(rgdate,'YYYY-MM-DD'), favorites from url where userid = '" + userid + "' and kategorie = '" + kategorie + "' and favorites = 'Y' order by rgdate desc";
			stmt = con.createStatement();
			rs = stmt.executeQuery(sql);
			int i = 0;
			while(rs.next()) {
				explanation[i] = rs.getString(1);
				URL[i] = rs.getString(2);
				rgdate[i] = rs.getString(3);
				favorites[i] = rs.getString(4);
				i++;
			}
		}
		catch (Exception e) {
			e.printStackTrace();
		}finally {
			try{if(con!=null) con.close();}catch(Exception e){};
			try{if(stmt!=null) stmt.close();}catch(Exception e){};
			try{if(rs!=null) rs.close();}catch(Exception e){};
		}
	}
			
	//Oracle Regist URL
	public void OracleRegistUrl(String userid, String kategorie, String explanation, String _url, String favorite, String priv) {
		try {
			Setting();
			con = DriverManager.getConnection(url, user, password);
			sql = "select max(urlnum) from url where userid = '"+ userid +"'";
			stmt = con.createStatement();
			rs = stmt.executeQuery(sql);
			int urlnum = 0;
			if(rs.next()) {
				urlnum = rs.getInt(1)+1;
			}
			sql = "insert into url values('"+urlnum+"','"+userid+"','"+kategorie+"','"+explanation+"','"+_url+"', sysdate,'"+favorite+"','"+priv+"')";
			stmt = con.createStatement();
			rs = stmt.executeQuery(sql);
			rs = stmt.executeQuery(commit);
		} catch (Exception e) {
			e.printStackTrace();
		}finally {
			try{if(con!=null) con.close();}catch(Exception e){};
			try{if(stmt!=null) stmt.close();}catch(Exception e){};
			try{if(rs!=null) rs.close();}catch(Exception e){};
		}
	}
			
	public static String B_explanation = null;
	public static String B_url = null;
			
	//Oracle Update URL
	public void OracleUpdateUrl(String userid, String kategorie, String explanation, String _url, String favorite, String priv) {
		try {
			Setting();
			con = DriverManager.getConnection(url, user, password);
			sql = "update url set explanation = '"+explanation+"', url = '"+_url+"', favorites = '"+favorite+"', private = '"+priv+"' where userid = '"+userid+"' and kategorie = '"+kategorie+"' and explanation = '"+B_explanation+"' and url = '"+B_url+"'";
			stmt = con.createStatement();
			rs = stmt.executeQuery(sql);
			rs = stmt.executeQuery(commit);
		} catch (Exception e) {
			e.printStackTrace();
		}finally {
			try{if(con!=null) con.close();}catch(Exception e){};
			try{if(stmt!=null) stmt.close();}catch(Exception e){};
			try{if(rs!=null) rs.close();}catch(Exception e){};
		}
	}
			
	//Oracle Delete URL
	public void OracleDeleteUrl(String userid, String kategorie, String explanation, String _url) {
		try {
			Setting();
			con = DriverManager.getConnection(url, user, password);
			sql = "Delete from url where userid = '"+userid+"' and kategorie = '"+kategorie+"' and explanation = '"+explanation+"' and url = '"+_url+"'";
			stmt = con.createStatement();
			rs = stmt.executeQuery(sql);
			rs = stmt.executeQuery(commit);
		} catch (Exception e) {
			e.printStackTrace();
		}finally {
			try{if(con!=null) con.close();}catch(Exception e){};
			try{if(stmt!=null) stmt.close();}catch(Exception e){};
			try{if(rs!=null) rs.close();}catch(Exception e){};
		}
	}
			
	//Oracle Regist Kagetorie
	public void OracleRegistKategorie(String userid, String kategorie) {
		try {
			Setting();
			con = DriverManager.getConnection(url, user, password);
			sql = "select max(kategorienum) from kategorie where userid = '"+ userid +"'";
			stmt = con.createStatement();
			rs = stmt.executeQuery(sql);
			int kategorienum = 0;
			if(rs.next()) {
				kategorienum = rs.getInt(1)+1;
			}
			sql = "insert into kategorie values('"+kategorienum+"','"+userid+"','"+kategorie+"')";
			stmt = con.createStatement();
			rs = stmt.executeQuery(sql);
			rs = stmt.executeQuery(commit);
		} catch (Exception e) {
			e.printStackTrace();
		}finally {
			try{if(con!=null) con.close();}catch(Exception e){};
			try{if(stmt!=null) stmt.close();}catch(Exception e){};
			try{if(rs!=null) rs.close();}catch(Exception e){};
		}
	}
			
	//Oracle Update Kategorie
	public void OracleUpdateKategorie(String userid, String kategorie, String B_kategorie) {
		try {
			Setting();
			con = DriverManager.getConnection(url, user, password);
			sql = "select max(kategorienum) from kategorie where userid = '"+ userid +"'";
			stmt = con.createStatement();
			rs = stmt.executeQuery(sql);
			int kategorienum = 0;
			if(rs.next()) {
				kategorienum = rs.getInt(1)+1;
			}
			sql = "create or replace trigger trg_kategorie after update on kategorie for each row begin update url set kategorie = '"+kategorie+"'where kategorie = '"+B_kategorie+"';end;";
			stmt.executeUpdate(sql);
			sql = "update kategorie set kategoriename = '"+kategorie+"' where kategoriename = '"+B_kategorie+"' and userid = '"+userid+"'";
			stmt.executeUpdate(sql);
		} catch (Exception e) {
			e.printStackTrace();
		}finally {
			try{if(con!=null) con.close();}catch(Exception e){};
			try{if(stmt!=null) stmt.close();}catch(Exception e){};
			try{if(rs!=null) rs.close();}catch(Exception e){};
		}
	}
			
	//Oracle Delete Kategorie
	public void OracleDeleteKategorie(String userid, String kategorie) {
		try {
			Setting();
			con = DriverManager.getConnection(url, user, password);
			sql = "Delete from kategorie where userid = '"+userid+"' and kategoriename = '"+kategorie+"'";
			stmt = con.createStatement();
			rs = stmt.executeQuery(sql);
			rs = stmt.executeQuery(commit);
		} catch (Exception e) {
			e.printStackTrace();
		}finally {
			try{if(con!=null) con.close();}catch(Exception e){};
			try{if(stmt!=null) stmt.close();}catch(Exception e){};
			try{if(rs!=null) rs.close();}catch(Exception e){};
		}
	}
			
}
