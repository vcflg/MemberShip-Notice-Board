package user;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

public class UserDAO {
	private Connection conn;
	private PreparedStatement pstmt;
	private ResultSet rs;
	
	String jdbc_driver = "oracle.jdbc.driver.OracleDriver";
	String jdbc_url = "jdbc:oracle:thin:@127.0.0.1:1521:XE";


	public UserDAO() {
		try {
			Class.forName(jdbc_driver);

			conn = DriverManager.getConnection(jdbc_url,"ora_user","dbpass");
		}catch(Exception e) {
			e.printStackTrace();
		}
	}
	
	public int login(String userID,String userPassword) {
		String SQL = "select userPassword from USERS where userID=?";
		try {
			pstmt = conn.prepareStatement(SQL);
			pstmt .setString(1, userID);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				if(rs.getString(1).equals(userPassword)) {
					return 1;//로그인성공
				}else {
					return 0;//비밀번호 틀림
				}
			}
			return -1;//아이디없음
		}catch(Exception e) {
			e.printStackTrace();
		}
		return -2; //DB오류
	}
	
	public int join(User user) {
		String SQL = "insert into USERS values(?,?,?,?,?)";
		
		try {
			pstmt=conn.prepareStatement(SQL);
			pstmt.setString(1, user.getUserID());
			pstmt.setString(2, user.getUserPassword());
			pstmt.setString(3, user.getUserName());
			pstmt.setString(4, user.getUserGender());
			pstmt.setString(5, user.getUserEmail());
			return pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return -1; //DB오류
	}
}
