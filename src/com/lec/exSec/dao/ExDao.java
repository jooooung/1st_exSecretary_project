package com.lec.exSec.dao;

import java.sql.Connection;
import java.sql.Date;
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
import com.lec.exSec.dto.ExDto;

public class ExDao {
	public static final int FAIL = 0;
	public static final int SUCCESS = 1;
	private static ExDao instance = new ExDao();
	public static ExDao getInstance() {
		return instance;
	}
	private ExDao() {}
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
	// 1. 운동회차 목록
	public ArrayList<ExDto> listEx(String mid, int startRow, int endRow){
		ArrayList<ExDto> dtos = new ArrayList<ExDto>();
		Connection        conn  = null;
		PreparedStatement pstmt = null;
		ResultSet         rs    = null;
		String sql = "SELECT * FROM" + 
				"    (SELECT ROWNUM RN, E.* " + 
				"        FROM (SELECT E.*, ENAME FROM EX E, EXPART EP" + 
				"              WHERE E.EPNO = EP.EPNO " + 
				"                AND MID = ? ORDER BY EDATE DESC) E)" + 
				"    WHERE RN BETWEEN ? AND ?";
		try {
			conn = getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, mid);
			pstmt.setInt(2, startRow);
			pstmt.setInt(3, endRow);
			rs = pstmt.executeQuery();
			while(rs.next()) {
				int eno = rs.getInt("eno");
				mid = rs.getString("mid");
				int epno = rs.getInt("epno");
				double eweight = rs.getDouble("eweight");
				int eset = rs.getInt("eset");
				int ecount = rs.getInt("ecount");
				Timestamp etime = rs.getTimestamp("etime");
				Date edate = rs.getDate("edate");
				String ename = rs.getString("ename");
				dtos.add(new ExDto(eno, mid, epno, eweight, eset, ecount, etime, edate, ename));
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
	// mid 별 총 개수
	public int getExTotCnt(String mid) {
		int totCnt = 0;
		Connection        conn  = null;
		PreparedStatement pstmt = null;
		ResultSet         rs    = null;
		String sql = "SELECT COUNT(*) FROM EX WHERE MID = ?";
		try {
			conn = getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, mid);
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
	// 2. 운동회차 상세보기
	public ExDto contentEx(int eno, String mid) {
		ExDto dto = null;
		Connection        conn  = null;
		PreparedStatement pstmt = null;
		ResultSet         rs    = null;
		String sql = "SELECT E.*, ENAME " + 
				"    FROM EX E, EXPART EP" + 
				"    WHERE E.EPNO = EP.EPNO " + 
				"      AND MID = ? AND ENO = ?";
		try {
			conn = getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, mid);
			pstmt.setInt(2, eno);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				eno = rs.getInt("eno");
				mid = rs.getString("mid");
				int epno = rs.getInt("epno");
				double eweight = rs.getDouble("eweight");
				int eset = rs.getInt("eset");
				int ecount = rs.getInt("ecount");
				Timestamp etime = rs.getTimestamp("etime");
				Date edate = rs.getDate("edate");
				String ename = rs.getString("ename");
				dto = new ExDto(eno, mid, epno, eweight, eset, ecount, etime, edate, ename);
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
	// 3. 운동회차 등록
	public int writeEx(ExDto dto) {
		int result = FAIL;
		Connection        conn  = null;
		PreparedStatement pstmt = null;
		String sql = "INSERT INTO EX VALUES (EX_SEQ.NEXTVAL, ?, ?, ?, ?, ?, ?, ?)";
		try {
			conn = getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, dto.getMid());
			pstmt.setInt(2, dto.getEpno());
			pstmt.setDouble(3, dto.getEweight());
			pstmt.setInt(4, dto.getEset());
			pstmt.setInt(5, dto.getEcount());
			pstmt.setTimestamp(6, dto.getEtime());
			pstmt.setDate(7, dto.getEdate());
			pstmt.executeUpdate();
			result = SUCCESS;
			System.out.println("ex등록 성공");
		} catch (SQLException e) {
			System.out.println(e.getMessage() + " ex등록 실패 :");
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
	// 4. 운동회차 수정
	public int modifyEx(ExDto dto) {
		int result = FAIL;
		Connection        conn  = null;
		PreparedStatement pstmt = null;
		String sql = "UPDATE EX SET EPNO = ?," + 
				"              EWEIGHT = ?," + 
				"              ESET = ?," + 
				"              ECOUNT = ?," + 
				"              ETIME = ?," + 
				"              EDATE = " + 
				"        WHERE MID = ? AND ENO = ?";
		try {
			conn = getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, dto.getEpno());
			pstmt.setDouble(2, dto.getEweight());
			pstmt.setInt(3, dto.getEset());
			pstmt.setInt(4, dto.getEcount());
			pstmt.setTimestamp(5, dto.getEtime());
			pstmt.setDate(6, dto.getEdate());
			pstmt.setString(7, dto.getMid());
			pstmt.setInt(8, dto.getEno());
			result = pstmt.executeUpdate();
			System.out.println(result == SUCCESS ? "ex수정 성공":"eno나mid 오류");
		} catch (SQLException e) {
			System.out.println(e.getMessage() + "ex 수정 실패 ");
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
	// 5. 운동회차 삭제
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
			pstmt.setString(3, "삭제된 글입니다");
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
	// 6. 회원 탈퇴 시 탈퇴회원 정보 삭제
	public int deleteWithDExBoard(String mid) {
		int result = FAIL;
		Connection        conn  = null;
		PreparedStatement pstmt = null;
		String sql = "DELETE FROM EX WHERE MID = ?";
		try {
			conn = getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, mid);
			result = pstmt.executeUpdate();
		} catch (SQLException e) {
			System.out.println(e.getMessage() + "탈퇴회원 ex 삭제 실패 ");
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