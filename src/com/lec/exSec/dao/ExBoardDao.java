package com.lec.exSec.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.util.ArrayList;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.sql.DataSource;

import com.lec.exSec.dto.ExBoardDto;

public class ExBoardDao {
	public static final int FAIL = 0;
	public static final int SUCCESS = 1;
	private static ExBoardDao instance = new ExBoardDao();
	public static ExBoardDao getInstance() {
		return instance;
	}
	private ExBoardDao() {}
	private Connection getConnection() throws SQLException {
		Connection conn = null;
		try {
			Context ctx = new InitialContext();
			DataSource ds = (DataSource) ctx.lookup("java:comp/env/jdbc/Oracle11g");
			conn = ds.getConnection();
		} catch (NamingException e) {
			System.out.println(e.getMessage());
		}
		return conn;
	}
	// (1) 글목록(startRow~endRow)
		public ArrayList<ExBoardDto> listExBoard(int startRow, int endRow){
			ArrayList<ExBoardDto> dtos = new ArrayList<ExBoardDto>();
			Connection        conn  = null;
			PreparedStatement pstmt = null;
			ResultSet         rs    = null;
			String sql = "SELECT V.*, " + 
					"    	  (SELECT MNAME FROM MEMBER WHERE V.MID=MID) ||" + 
					"         (SELECT ANAME FROM ADMIN WHERE V.AID=AID) WRITER" + 
					"    	FROM (SELECT ROWNUM RN, B.* FROM (SELECT * FROM EXBOARD ORDER BY BGROUP DESC, BSTEP) B) V" + 
					"    	WHERE RN BETWEEN ? AND ?";
			try {
				conn = getConnection();
				pstmt = conn.prepareStatement(sql);
				pstmt.setInt(1, startRow);
				pstmt.setInt(2, endRow);
				rs = pstmt.executeQuery();
				while(rs.next()) {
					int    bnum      = rs.getInt("bnum");
					String mid      = rs.getString("mid");
					String aid      = rs.getString("aid");
					String btitle   = rs.getString("btitle");
					String bcontent = rs.getString("bcontent");
					String bphoto= rs.getString("bphoto");
					Timestamp bdate = rs.getTimestamp("bdate");
					int    bhit     = rs.getInt("bhit");
					int    bgroup   = rs.getInt("bgroup");
					int    bstep    = rs.getInt("bstep");
					int    bindent  = rs.getInt("bindent");
					String bip      = rs.getString("bip");
					String writer      = rs.getString("writer");
					dtos.add(new ExBoardDto(bnum, mid, aid, btitle, bcontent, bphoto, bdate, 
									bhit, bgroup, bstep, bindent, bip, writer));
				}
			} catch (SQLException e) {
				System.out.println(e.getMessage());
			} finally {
				try {
					if(rs    != null) rs.close();
					if(pstmt != null) pstmt.close();
					if(conn  != null) conn.close();
				} catch (SQLException e) {
					System.out.println(e.getMessage());
				} 
			}
			return dtos;
		}
		// (2) 글개수
		public int getExBoardTotCnt() {
			int totCnt = 0;
			Connection        conn  = null;
			PreparedStatement pstmt = null;
			ResultSet         rs    = null;
			String sql = "SELECT COUNT(*) FROM EXBOARD";
			try {
				conn = getConnection();
				pstmt = conn.prepareStatement(sql);
				rs = pstmt.executeQuery();
				rs.next();
				totCnt = rs.getInt(1);
			} catch (SQLException e) {
				System.out.println(e.getMessage());
			} finally {
				try {
					if(rs    != null) rs.close();
					if(pstmt != null) pstmt.close();
					if(conn  != null) conn.close();
				} catch (SQLException e) {
					System.out.println(e.getMessage());
				} 
			}
			return totCnt;
		}
		// (3) 글쓰기(원글쓰기)
		public int writeExBoard(ExBoardDto dto) {
			int result = FAIL;
			Connection        conn  = null;
			PreparedStatement pstmt = null;
			String sql = "INSERT INTO EXBOARD (BNUM, MID, AID, BTITLE, BCONTENT, BPHOTO, BDATE, BHIT, BGROUP, BSTEP, BINDENT, BIP)" + 
					"    VALUES (EXBOARD_SEQ.NEXTVAL, ?, ?, ?, ?, ?, ?, ?, EXBOARD_SEQ.CURRVAL, 0, 0, ?)";
			try {
				conn = getConnection();
				pstmt = conn.prepareStatement(sql);
				pstmt.setString(1, dto.getMid());
				pstmt.setString(2, dto.getAid());
				pstmt.setString(3, dto.getBtitle());
				pstmt.setString(4, dto.getBcontent());
				pstmt.setString(5, dto.getBphoto());
				pstmt.setTimestamp(6, dto.getBdate());
				pstmt.setInt(7, dto.getBhit());
				pstmt.setString(8, dto.getBip());
				pstmt.executeUpdate();
				result = SUCCESS;
				System.out.println("원글쓰기 성공");
			} catch (SQLException e) {
				System.out.println(e.getMessage() + " 원글쓰기 실패 :");
			} finally {
				try {
					if(pstmt != null) pstmt.close();
					if(conn  != null) conn.close();
				} catch (SQLException e) {
					System.out.println(e.getMessage());
				} 
			}
			return result;
		}
		// (4) hit 1회 올리기
		private void hitUpExBoard(int bnum) {
			Connection        conn  = null;
			PreparedStatement pstmt = null;
			String sql = "UPDATE EXBOARD SET BHIT = BHIT + 1 WHERE BNUM = ?";
			try {
				conn = getConnection();
				pstmt = conn.prepareStatement(sql);
				pstmt.setInt(1, bnum);
				pstmt.executeUpdate();
			} catch (SQLException e) {
				System.out.println(e.getMessage() + " 조회수 up 실패");
			} finally {
				try {
					if(pstmt != null) pstmt.close();
					if(conn  != null) conn.close();
				} catch (SQLException e) {
					System.out.println(e.getMessage());
				} 
			}
		}
		// (5) bnum으로 ExBoardDto 가져오기 - 글상세보기용
		public ExBoardDto contentExBoard(int bnum) {
			ExBoardDto dto = null;
			hitUpExBoard(bnum); // 글 상세보기 시 조회수 1 올리기
			Connection        conn  = null;
			PreparedStatement pstmt = null;
			ResultSet         rs    = null;
			String sql = "SELECT V.*, " + 
					"    (SELECT MNAME FROM MEMBER WHERE V.MID=MID) ||" + 
					"    (SELECT ANAME FROM ADMIN WHERE V.AID=AID) WRITER" + 
					"    FROM EXBOARD V WHERE BNUM = ?";
			try {
				conn = getConnection();
				pstmt = conn.prepareStatement(sql);
				pstmt.setInt(1, bnum);
				rs = pstmt.executeQuery();
				if(rs.next()) {
					String mid = rs.getString("mid");
					String aid = rs.getString("aid");
					String btitle = rs.getString("btitle");
					String bcontent = rs.getString("bcontent");
					String bphoto = rs.getString("bphoto");
					Timestamp bdate = rs.getTimestamp("bdate");
					int    bhit = rs.getInt("bhit");
					int    bgroup= rs.getInt("bgroup");
					int    bstep= rs.getInt("bstep");
					int    bindent= rs.getInt("bindent");
					String bip = rs.getString("bip");
					String writer      = rs.getString("writer");
					dto = new ExBoardDto(bnum, mid, aid, btitle, bcontent, bphoto, bdate, 
									bhit, bgroup, bstep, bindent, bip, writer);
				}
			} catch (SQLException e) {
				System.out.println(e.getMessage());
			} finally {
				try {
					if(rs    != null) rs.close();
					if(pstmt != null) pstmt.close();
					if(conn  != null) conn.close();
				} catch (SQLException e) {
					System.out.println(e.getMessage());
				} 
			}
			return dto;
		}
		// (6) 글번호(fid)로 글전체 내용(ExBoardDto) 가져오기 - 글수정VIEW, 답변글VIEW 용
		public ExBoardDto modifyViewExBoard_replyViewExBoard(int bnum) {
			ExBoardDto dto = null;
			Connection        conn  = null;
			PreparedStatement pstmt = null;
			ResultSet         rs    = null;
			String sql = "SELECT V.*, " + 
					"    (SELECT MNAME FROM MEMBER WHERE V.MID=MID) ||" + 
					"    (SELECT ANAME FROM ADMIN WHERE V.AID=AID) WRITER" + 
					"    FROM EXBOARD V WHERE BNUM = ?";
			try {
				conn = getConnection();
				pstmt = conn.prepareStatement(sql);
				pstmt.setInt(1, bnum);
				rs = pstmt.executeQuery();
				if(rs.next()) {
					String mid = rs.getString("mid");
					String aid = rs.getString("aid");
					String btitle = rs.getString("btitle");
					String bcontent = rs.getString("bcontent");
					String bphoto = rs.getString("bphoto");
					Timestamp bdate = rs.getTimestamp("bdate");
					int    bhit = rs.getInt("bhit");
					int    bgroup= rs.getInt("bgroup");
					int    bstep= rs.getInt("bstep");
					int    bindent= rs.getInt("bindent");
					String bip = rs.getString("bip");
					String writer      = rs.getString("writer");
					dto = new ExBoardDto(bnum, mid, aid, btitle, bcontent, bphoto, bdate, 
									bhit, bgroup, bstep, bindent, bip, writer);
				}
			} catch (SQLException e) {
				System.out.println(e.getMessage());
			} finally {
				try {
					if(rs    != null) rs.close();
					if(pstmt != null) pstmt.close();
					if(conn  != null) conn.close();
				} catch (SQLException e) {
					System.out.println(e.getMessage());
				} 
			}
			return dto;
		}
		// (7) 글 수정하기
		public int modifyExBoard(ExBoardDto dto) {
			int result = FAIL;
			Connection        conn  = null;
			PreparedStatement pstmt = null;
			String sql = "UPDATE EXBOARD SET BTITLE = ?," + 
					"                   BCONTENT = ?," + 
					"                   BPHOTO = ?," + 
					"                   BDATE = ?," + 
					"                   BIP = ?" + 
					"             WHERE BNUM = ?";
			try {
				conn = getConnection();
				pstmt = conn.prepareStatement(sql);
				pstmt.setString(1, dto.getBtitle());
				pstmt.setString(2, dto.getBcontent());
				pstmt.setString(3, dto.getBphoto());
				pstmt.setTimestamp(4, dto.getBdate());
				pstmt.setString(5, dto.getBip());
				pstmt.setInt(6, dto.getBnum());
				result = pstmt.executeUpdate();
				System.out.println(result == SUCCESS ? "글수정 성공":"글번호 오류");
			} catch (SQLException e) {
				System.out.println(e.getMessage() + "글 수정 실패 ");
			} finally {
				try {
					if(pstmt != null) pstmt.close();
					if(conn  != null) conn.close();
				} catch (SQLException e) {
					System.out.println(e.getMessage());
				} 
			}
			return result;
		}
		// (8) 글 삭제하기(bnum)
		public int deleteExBoard(int bnum) {
			int result = FAIL;
			Connection        conn  = null;
			PreparedStatement pstmt = null;
			String sql = "UPDATE EXBOARD SET MID = ?," + 
					"                   AID = ?," + 
					"                   BTITLE = ?," + 
					"                   BCONTENT = ?," + 
					"                   BPHOTO = ?," + 
					"                   BHIT = ?" + 
					"             WHERE BNUM = ?";
			try {
				conn = getConnection();
				pstmt = conn.prepareStatement(sql);
				pstmt.setString(1, null);
				pstmt.setString(2, null);
				pstmt.setString(3, "(삭제된 글입니다)");
				pstmt.setString(4, null);
				pstmt.setString(5, null);
				pstmt.setInt(6, 0);
				pstmt.setInt(7, bnum);
				result = pstmt.executeUpdate();
				System.out.println(result == SUCCESS ? "글삭제 성공":"글번호 오류");
			} catch (SQLException e) {
				System.out.println(e.getMessage() + "글 삭제 실패 ");
			} finally {
				try {
					if(pstmt != null) pstmt.close();
					if(conn  != null) conn.close();
				} catch (SQLException e) {
					System.out.println(e.getMessage());
				} 
			}
			return result;
		}
		// 9. 답글 쓰기 전 단계
		private void preReplyExBoard(int bgroup, int bstep) {
			Connection        conn  = null;
			PreparedStatement pstmt = null;
			String sql = "UPDATE EXBOARD SET BSTEP = BSTEP + 1" + 
					"    WHERE BGROUP = ? AND BSTEP>?";
			try {
				conn = getConnection();
				pstmt = conn.prepareStatement(sql);
				pstmt.setInt(1, bgroup);
				pstmt.setInt(2, bstep);
				pstmt.executeUpdate();
			} catch (SQLException e) {
				System.out.println(e.getMessage() + " preReplyStep에서 오류");
			} finally {
				try {
					if(pstmt != null) pstmt.close();
					if(conn  != null) conn.close();
				} catch (SQLException e) {
					System.out.println(e.getMessage());
				} 
			}
		}
		// 10 답글쓰기
		public int reply(ExBoardDto dto) {
			int result = FAIL;
			preReplyExBoard(dto.getBgroup(), dto.getBstep());
			Connection        conn  = null;
			PreparedStatement pstmt = null;
			String sql = "INSERT INTO EXBOARD " + 
					"    VALUES (EXBOARD_SEQ.NEXTVAL, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
			try {
				conn = getConnection();
				pstmt = conn.prepareStatement(sql);
				pstmt.setString(1, dto.getMid());
				pstmt.setString(2, dto.getAid());
				pstmt.setString(3, dto.getBtitle());
				pstmt.setString(4, dto.getBcontent());
				pstmt.setString(5, dto.getBphoto());
				pstmt.setTimestamp(6, dto.getBdate());
				pstmt.setInt(7, dto.getBhit());
				pstmt.setInt(8, dto.getBgroup());
				pstmt.setInt(9, dto.getBstep() + 1);
				pstmt.setInt(10, dto.getBindent() + 1);
				pstmt.setString(11, dto.getBip());
				pstmt.executeUpdate();
				result = SUCCESS;
				System.out.println("답변글쓰기 성공");
			} catch (SQLException e) {
				System.out.println(e.getMessage() + " 답변글쓰기 실패 ");
			} finally {
				try {
					if(pstmt != null) pstmt.close();
					if(conn  != null) conn.close();
				} catch (SQLException e) {
					System.out.println(e.getMessage());
				} 
			}
			return result;
		}
		// 11 회원 탈퇴 시 탈퇴회원 글 모두 삭제
		public int deleteWithDExBoard(String mid) {
			int result = FAIL;
			Connection        conn  = null;
			PreparedStatement pstmt = null;
			String sql = "UPDATE EXBOARD B SET MID = ?," + 
					"                     BTITLE = ?," + 
					"                     BCONTENT = ?," + 
					"                     BPHOTO = ?," + 
					"                     BHIT = ?" + 
					"               WHERE MID = ?";
			try {
				conn = getConnection();
				pstmt = conn.prepareStatement(sql);
				pstmt.setString(1, null);
				pstmt.setString(2, "삭제된 글입니다");
				pstmt.setString(3, null);
				pstmt.setString(4, null);
				pstmt.setInt(5, 0);
				pstmt.setString(6, mid);
				result = pstmt.executeUpdate();
				System.out.println(result == SUCCESS ? "탈퇴회원 글삭제 성공":"아이디 오류");
			} catch (SQLException e) {
				System.out.println(e.getMessage() + "탈퇴회원 글 삭제 실패 ");
			} finally {
				try {
					if(pstmt != null) pstmt.close();
					if(conn  != null) conn.close();
				} catch (SQLException e) {
					System.out.println(e.getMessage());
				} 
			}
			return result;
		}
	}
