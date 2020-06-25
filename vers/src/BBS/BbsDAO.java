package BBS;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

public class BbsDAO {

	private Connection conn; // connection:db에접근하게 해주는 객체
	private PreparedStatement pstmt;
	private ResultSet rs;

	// mysql 처리부분
	public BbsDAO() {
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
	

	//현재의 시간을 가져오는 함수
	public String getDate() {
		String SQL = "SELECT NOW()";
		try {
			pstmt = conn.prepareStatement(SQL);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				return rs.getString(1);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return ""; //DB 오류
	}

	
	//bbsID 게시글 번호 가져오는 함수
	public int getNext() {
		String SQL = "SELECT bbsID FROM BBS ORDER BY bbsID DESC";
		try {
			pstmt = conn.prepareStatement(SQL);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				return rs.getInt(1) + 1;
			}
			return 1; //첫 번째 게시물인 경우
		} catch (Exception e) {
			e.printStackTrace();
		}
		return -1; //DB 오류
	}

	
	//실제로 글을 작성하는 함수
	public int write(String bbsTitle, String userID, String bbsContent) {
		String SQL = "INSERT INTO BBS VALUES(?, ?, ?, ?, ?, ?)";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, getNext());
			pstmt.setString(2, bbsTitle);
			pstmt.setString(3, userID);
			pstmt.setString(4, getDate());
			pstmt.setString(5, bbsContent);
			pstmt.setInt(6, 1);
			return pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return -1; //DB 오류
	}
	
	
	//게시글 *목록*을 ArrayList로 불러오는 함수: 자신의 글만 불러온다.
	 public ArrayList<Bbs> getList(int pageNumber, String userID) {
	        String SQL = "SELECT * FROM BBS WHERE bbsID < ? AND userID = ? AND bbsAvailable = 1 ORDER BY bbsID DESC LIMIT 10";
	        ArrayList<Bbs> list = new ArrayList<Bbs>();
	        try {
	            pstmt = conn.prepareStatement(SQL);
	            pstmt.setInt(1, getNext() - (pageNumber - 1) * 10);
	            pstmt.setString(2, userID);
	            rs = pstmt.executeQuery();
	            while (rs.next()) {
	                Bbs BBS = new Bbs();
	                BBS.setBbsID(rs.getInt(1));
	                BBS.setBbsTitle(rs.getString(2));
	                BBS.setUserID(rs.getString(3));
	                BBS.setBbsDate(rs.getString(4));
	                BBS.setBbsContent(rs.getString(5));
	                BBS.setBbsAvailable(rs.getInt(6));
	                list.add(BBS);
	            }
	        } catch (Exception e) {
	            e.printStackTrace();
	        }
	        return list;
	    }
	 
	 
	//Admin일때 게시글 *목록*을 ArrayList로 불러오는 함수: 모든 글을 불러온다.
	 public ArrayList<Bbs> getListA(int pageNumber) {
	        String SQL = "SELECT * FROM BBS WHERE bbsID < ? AND bbsAvailable = 1 ORDER BY bbsID DESC LIMIT 10";
	        ArrayList<Bbs> Alist = new ArrayList<Bbs>();
	        try {
	            pstmt = conn.prepareStatement(SQL);
	            pstmt.setInt(1, getNext() - (pageNumber - 1) * 10);
	            rs = pstmt.executeQuery();
	            while (rs.next()) {
	                Bbs BBS = new Bbs();
	                BBS.setBbsID(rs.getInt(1));
	                BBS.setBbsTitle(rs.getString(2));
	                BBS.setUserID(rs.getString(3));
	                BBS.setBbsDate(rs.getString(4));
	                BBS.setBbsContent(rs.getString(5));
	                BBS.setBbsAvailable(rs.getInt(6));
	                Alist.add(BBS);
	            }
	        } catch (Exception e) {
	            e.printStackTrace();
	        }
	        return Alist;
	    }

	 
	//그다음 페이지 불러오는 함수: 10 단위 페이징 처리
	public boolean nextPage(int pageNumber) {
		String SQL = "SELECT * FROM BBS WHERE bbsID < ? AND bbsAvailable = 1";
		try {
			pstmt = conn.prepareStatement(SQL);
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

	//글 *내용*을 불러오는 함수
	public Bbs getBbs(int bbsID) {
		String SQL = "SELECT * FROM BBS WHERE bbsID = ?";
		try {
			pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, bbsID);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				Bbs BBS = new Bbs();
				BBS.setBbsID(rs.getInt(1));
				BBS.setBbsTitle(rs.getString(2));
				BBS.setUserID(rs.getString(3));
				BBS.setBbsDate(rs.getString(4));
				BBS.setBbsContent(rs.getString(5));
				BBS.setBbsAvailable(rs.getInt(6));
				return BBS;
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return null;
	}

	// 업데이트 하는 함수
	public int update(int bbsID, String bbsTitle, String bbsContent) {
		String SQL = "UPDATE BBS SET bbsTitle = ?, bbsContent = ? WHERE bbsID = ?";
		try {
			pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, bbsTitle);
			pstmt.setString(2, bbsContent);
			pstmt.setInt(3, bbsID);
			return pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return -1; //DB 오류
	}

    // 삭제하는 함수: bbsAvailable 값을 통해 *목록*에는 뜨지 않지만 DB에는 존재한다.
	public int delete(int bbsID) {
		String SQL = "UPDATE BBS SET bbsAvailable = 0 WHERE bbsID = ?";
		try {
			pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, bbsID);
			return pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return -1; //DB 오류
	}
}
