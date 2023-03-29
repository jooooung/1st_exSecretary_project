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

import com.lec.exSec.dto.BcommentDto;

public class BcommentDao {
	public static final int FAIL = 0;
	public static final int SUCCESS = 1;
	private static BcommentDao instance = new BcommentDao();
	public static BcommentDao getInstance() {
		return instance;
	}
	private BcommentDao() {}
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
	// 특정글의 댓글 목록 가져오기
	public ArrayList<BcommentDto> getBcomment(int bnum) {
		ArrayList<BcommentDto> dtos = new ArrayList<BcommentDto>(); 
		Connection        conn  = null;
		PreparedStatement pstmt = null;
		ResultSet         rs    = null;
		String sql = "SELECT * FROM BCOMMENT WHERE BNUM = ? ORDER bY CDATE";
		try {
			conn = getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, bnum);
			rs = pstmt.executeQuery();
			while(rs.next()) {
				int cnum = rs.getInt("cnum");
				String mid = rs.getString("mid");
				String aid = rs.getString("aid");
				String ccontent = rs.getString("ccontent");
				Timestamp cdate = rs.getTimestamp("cdate");
				String cip = rs.getString("cip");
				dtos.add(new BcommentDto(cnum, bnum, mid, aid, ccontent, cdate, cip));
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
	// 특정 글의 특정 댓글 가져오기
	public BcommentDto getBcommentOne (int bnum, int cnum) {
		BcommentDto dto = null;
		Connection        conn  = null;
		PreparedStatement pstmt = null;
		ResultSet         rs    = null;
		String sql = "SELECT * FROM BCOMMENT WHERE BNUM = ? AND CNUM = ?";
		try {
			conn = getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, bnum);
			pstmt.setInt(2, cnum);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				String mid = rs.getString("mid");
				String aid = rs.getString("aid");
				String ccontent = rs.getString("ccontent");
				Timestamp cdate = rs.getTimestamp("cdate");
				String cip = rs.getString("cip");
				dto = new BcommentDto(cnum, bnum, mid, aid, ccontent, cdate, cip);
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
	// 1. 댓글 쓰기
	public int writeBcomment(BcommentDto dto) {
		int result = FAIL;
		Connection        conn  = null;
		PreparedStatement pstmt = null;
		String sql = "INSERT INTO BCOMMENT (CNUM, BNUM, MID, AID, CCONTENT, CDATE, CIP)" + 
				"    VALUES (BCOMMENT_SEQ.NEXTVAL, ?, ?, ?, ?, ?, ?)";
		try {
			conn = getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, dto.getBnum());
			pstmt.setString(2, dto.getMid());
			pstmt.setString(3, dto.getAid());
			pstmt.setString(4, dto.getCcontent());
			pstmt.setTimestamp(5, dto.getCdate());
			pstmt.setString(6, dto.getCip());
			pstmt.executeUpdate();
			result = SUCCESS;
			System.out.println("댓글쓰기 성공");
		} catch (SQLException e) {
			System.out.println(e.getMessage() + " 댓글쓰기 실패 :");
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
	// 2. 댓글 수정
	public int modifyBcomment(BcommentDto dto) {
		int result = FAIL;
		Connection        conn  = null;
		PreparedStatement pstmt = null;
		String sql = "UPDATE BCOMMENT SET CCONTENT = ?, CIP = ?" + 
				"                WHERE CNUM = ? AND (MID = ? OR AID = ?)";
		try {
			conn = getConnection();	
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, dto.getCcontent());
			pstmt.setString(2, dto.getCip());
			pstmt.setInt(3, dto.getCnum());
			pstmt.setString(4, dto.getMid());
			pstmt.setString(5, dto.getAid());
			pstmt.executeUpdate();
			result = SUCCESS;
			System.out.println("댓글수정 성공");
		} catch (SQLException e) {
			System.out.println(e.getMessage() + " 댓글수정 실패 :");
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
	// 3. 댓글 삭제
	public int deleteBcomment(int cnum, String mid, String aid) {
		int result = FAIL;
		Connection        conn  = null;
		PreparedStatement pstmt = null;
		String sql = "DELETE FROM BCOMMENT WHERE CNUM = ? AND (MID = ? OR AID = ?)";
		try {
			conn = getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, cnum);
			pstmt.setString(2, mid);
			pstmt.setString(3, aid);
			pstmt.executeUpdate();
			if(result == SUCCESS) {
				System.out.println("댓글삭제 성공");
			}
		} catch (SQLException e) {
			System.out.println(e.getMessage() + "댓글 삭제 실패");
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
	// 4. 회원 탈퇴 시 탈퇴 회원의 댓글 삭제
	public int deleteWithDBcomment(String mid) {
		int result = FAIL;
		Connection        conn  = null;
		PreparedStatement pstmt = null;
		String sql = "DELETE FROM BCOMMENT WHERE MID = ?";
		try {
			conn = getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, mid);
			pstmt.executeUpdate();
			if(result == SUCCESS) {
				System.out.println("탈퇴회원 댓글삭제 성공");
			}
		} catch (SQLException e) {
			System.out.println(e.getMessage() + "탈퇴회원 댓글삭제 실패");
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
	// 5. 특정 글의 댓글 개수
	public int commentCnt(int bnum) {
		int commentCnt = 0;
		Connection        conn  = null;
		PreparedStatement pstmt = null;
		ResultSet         rs    = null;
		String sql = "SELECT COUNT(*) FROM BCOMMENT WHERE BNUM = ?";
		try {
			conn = getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, bnum);
			rs = pstmt.executeQuery();
			rs.next();
			commentCnt = rs.getInt(1);
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
		return commentCnt;
	}
}
