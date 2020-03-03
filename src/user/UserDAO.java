package user;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

public class UserDAO {

	// dao : �뜲�씠�꽣踰좎씠�뒪 �젒洹� 媛앹껜�쓽 �빟�옄濡쒖꽌

	// �떎吏덉쟻�쑝濡� db�뿉�꽌 �쉶�썝�젙蹂� 遺덈윭�삤嫄곕굹 db�뿉 �쉶�썝�젙蹂� �꽔�쓣�븣
	private Connection conn; // connection:db�뿉�젒洹쇳븯寃� �빐二쇰뒗 媛앹껜
	private PreparedStatement pstmt;
	private ResultSet rs;

	// mysql�뿉 �젒�냽�빐 二쇰뒗 遺�遺�
	public UserDAO() { // �깮�꽦�옄 �떎�뻾�맆�븣留덈떎 �옄�룞�쑝濡� db�뿰寃곗씠 �씠猷⑥뼱 吏� �닔 �엳�룄濡앺븿

		try {
			String dbURL = "jdbc:mysql://localhost/mtn2072?&useSSL=false";
			String dbID = "mtn2072";
			String dbPassword = "Man2704020_";
			Class.forName("com.mysql.jdbc.Driver");
			conn = DriverManager.getConnection(dbURL, dbID, dbPassword);
		} catch (Exception e) {
			e.printStackTrace(); // �삤瑜섍� 臾댁뾿�씤吏� 異쒕젰
		}

	}

	// 濡쒓렇�씤�쓣 �떆�룄�븯�뒗 �븿�닔****
	public int login(String userID, String userPassword) {

		String SQL = "SELECT userPassword FROM USER WHERE userID = ?";

		try {

			// pstmt : prepared statement �젙�빐吏� sql臾몄옣�쓣 db�뿉 �궫�엯�븯�뒗 �삎�떇�쑝濡� �씤�뒪�꽩�뒪媛��졇�샂
			pstmt = conn.prepareStatement(SQL);

			// sql�씤�젥�뀡 媛숈� �빐�궧湲곕쾿�쓣 諛⑹뼱�븯�뒗寃�... pstmt�쓣 �씠�슜�빐 �븯�굹�쓽 臾몄옣�쓣 誘몃━ 以�鍮꾪빐�꽌(臾쇱쓬�몴�궗�슜)
			// 臾쇱쓬�몴�빐�떦�븯�뒗 �궡�슜�쓣 �쑀���븘�씠�뵒濡�, 留ㅺ컻蹂��닔濡� �씠�슜.. 1)議댁옱�븯�뒗吏� 2)鍮꾨�踰덊샇臾댁뾿�씤吏�
			pstmt.setString(1, userID);

			// rs:result set �뿉 寃곌낵蹂닿�
			rs = pstmt.executeQuery();

			// 寃곌낵媛� 議댁옱�븳�떎硫� �떎�뻾
			if (rs.next()) {

				// �뙣�뒪�썙�뱶 �씪移섑븳�떎硫� �떎�뻾

				if (rs.getString(1).equals(userPassword)) {
					return 1; // 濡쒓렇�씤 �꽦怨�
				} else
					return 0; // 鍮꾨�踰덊샇 遺덉씪移�
			}
			return -1; // �븘�씠�뵒媛� �뾾�쓬 �삤瑜�
		} catch (Exception e) {
			e.printStackTrace();
		}
		return -2; // �뜲�씠�꽣踰좎씠�뒪 �삤瑜섎�� �쓽誘�
	}
    public int join(User user) {
    	String SQL = "INSERT INTO USER VALUES (?, ?, ?)";
    	try {
    		pstmt = conn.prepareStatement(SQL);
    		pstmt.setString(1, user.getUserID());
    		pstmt.setString(2, user.getUserPassword());
    		pstmt.setString(3, user.getUserName());
    		return pstmt.executeUpdate();
    	}catch(Exception e) {
    		e.printStackTrace();
    	}
    	return -1 ; //DB �삤瑜�
    	
    }

}