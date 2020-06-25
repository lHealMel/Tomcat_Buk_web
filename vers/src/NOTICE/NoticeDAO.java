package NOTICE;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

public class NoticeDAO {

	private Connection conn;
	private ResultSet rs;

	public NoticeDAO() {

		try {

			String dbURL = "jdbc:mysql://localhost/mtn2072?&useSSL=false&allowPublicKeyRetrieval=true";
			String dbID = "mtn2072";
			String dbPassword = "Man2704020_";
			Class.forName("com.mysql.jdbc.Driver");
			conn = DriverManager.getConnection(dbURL, dbID, dbPassword);
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	// �쁽�옱�쓽 �떆媛꾩쓣 媛��졇�삤�뒗 �븿�닔
	public String getDate() {
		String SQL = "SELECT NOW()";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				return rs.getString(1);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return ""; // �뜲�씠�꽣踰좎씠�뒪 �삤瑜�
	}

	// noticeID 寃뚯떆湲� 踰덊샇 媛��졇�삤�뒗 �븿�닔
	public int getNext() {
		String SQL = "SELECT noticeID FROM NOTICE ORDER BY noticeID DESC";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				return rs.getInt(1) + 1;
			}
			return 1;// 泥� 踰덉㎏ 寃뚯떆臾쇱씤 寃쎌슦
		} catch (Exception e) {
			e.printStackTrace();
		}
		return -1; // �뜲�씠�꽣踰좎씠�뒪 �삤瑜�
	}

	// �떎�젣濡� 湲��쓣 �옉�꽦�븯�뒗 �븿�닔
	public int write(String noticeTitle, String userID, String noticeContent) {
		String SQL = "INSERT INTO NOTICE VALUES(?, ?, ?, ?, ?, ?)";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, getNext());
			pstmt.setString(2, noticeTitle);
			pstmt.setString(3, userID);
			pstmt.setString(4, getDate());
			pstmt.setString(5, noticeContent);
			pstmt.setInt(6, 1);
			return pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return -1; // �뜲�씠�꽣踰좎씠�뒪 �삤瑜�
	}

	public ArrayList<Notice> getList(int pageNumber) {
		String SQL = "SELECT * FROM NOTICE WHERE noticeID < ? AND noticeAvailable = 1 ORDER BY noticeID DESC LIMIT 10";
		ArrayList<Notice> list = new ArrayList<Notice>();
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, getNext() - (pageNumber - 1) * 10);
			rs = pstmt.executeQuery();
			while (rs.next()) {
				Notice NOTICE = new Notice();
				NOTICE.setNoticeID(rs.getInt(1));
				NOTICE.setNoticeTitle(rs.getString(2));
				NOTICE.setUserID(rs.getString(3));
				NOTICE.setNoticeDate(rs.getString(4));
				NOTICE.setNoticeContent(rs.getString(5));
				NOTICE.setNoticeAvailable(rs.getInt(6));
				list.add(NOTICE);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return list;
	}

	public boolean nextPage(int pageNumber) {
		String SQL = "SELECT * FROM NOTICE WHERE noticeID < ? AND noticeAvailable = 1";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, getNext() - (pageNumber - 1) * 10);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				return true;
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return false;
	}

	public Notice getNotice(int noticeID) {
		String SQL = "SELECT * FROM NOTICE WHERE noticeID = ?";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, noticeID);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				Notice NOTICE = new Notice();
				NOTICE.setNoticeID(rs.getInt(1));
				NOTICE.setNoticeTitle(rs.getString(2));
				NOTICE.setUserID(rs.getString(3));
				NOTICE.setNoticeDate(rs.getString(4));
				NOTICE.setNoticeContent(rs.getString(5));
				NOTICE.setNoticeAvailable(rs.getInt(6));
				return NOTICE;
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return null;
	}

	public int update(int noticeID, String noticeTitle, String noticeContent) {
		String SQL = "UPDATE NOTICE SET noticeTitle = ?, noticeContent = ? WHERE noticeID = ?";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, noticeTitle);
			pstmt.setString(2, noticeContent);
			pstmt.setInt(3, noticeID);
			return pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return -1;
	}

	public int delete(int noticeID) {
		String SQL = "UPDATE NOTICE SET noticeAvailable = 0 WHERE noticeID = ?";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, noticeID);
			return pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return -1;

	}

}
