package com.lec.exSec.dao;

import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.sql.DataSource;

import com.lec.exSec.dto.InbodyDto;


public class InbodyDao {
	public static final int FAIL = 0;
	public static final int SUCCESS = 1;
	private static InbodyDao instance = new InbodyDao();
	public static InbodyDao getInstance() {
		return instance;
	}
	private InbodyDao() {}
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
	// 내 inbody 목록(mid)
	public ArrayList<InbodyDto> listInbody(String mid, int startRow, int endRow){
		ArrayList<InbodyDto> dtos = new ArrayList<InbodyDto>();
		Connection        conn  = null;
		PreparedStatement pstmt = null;
		ResultSet         rs    = null;
		String sql = "SELECT * FROM" + 
				"    (SELECT ROWNUM RN, I.* " + 
				"        FROM (SELECT * FROM INBODY WHERE MID = ? " + 
				"            ORDER BY IDATE DESC) I)" + 
				"    WHERE RN BETWEEN ? AND ?";
		try {
			conn = getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, mid);
			pstmt.setInt(2, startRow);
			pstmt.setInt(3, endRow);
			rs = pstmt.executeQuery();
			while(rs.next()) {
				int inum = rs.getInt("inum");
				mid = rs.getString("mid");
				double iweight = rs.getDouble("iweight");
				double ifat = rs.getDouble("ifat");
				double imuscle = rs.getDouble("imuscle");
				Date idate = rs.getDate("idate");
				dtos.add(new InbodyDto(inum, mid, iweight, ifat, imuscle, idate));
			}
		} catch (SQLException e) {
			System.out.println(e.getMessage() + " 내 inbody 목록 불러오기 실패");
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
	// 내 inbody 상세보기(inum)
	public InbodyDto contentInbody(int inum, String mid) {
		InbodyDto dto = null;
		Connection        conn  = null;
		PreparedStatement pstmt = null;
		ResultSet         rs    = null;
		String sql = "SELECT * FROM INBODY WHERE INUM = ? AND MID = ?";
		try {
			conn = getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, inum);
			pstmt.setString(2, mid);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				inum = rs.getInt("inum");
				mid = rs.getString("mid");
				double iweight = rs.getDouble("iweight");
				double ifat = rs.getDouble("ifat");
				double imuscle = rs.getDouble("imuscle");
				Date idate = rs.getDate("idate");
				dto = new InbodyDto(inum, mid, iweight, ifat, imuscle, idate);
			}
		} catch (SQLException e) {
			System.out.println(e.getMessage() + " inbody 상세보기 실패");
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
	// 1. inbody 등록
	public int writeInobdy(InbodyDto dto) {
		int result = FAIL;
		Connection        conn  = null;
		PreparedStatement pstmt = null;
		String sql = "INSERT INTO INBODY VALUES (INBODY_SEQ.NEXTVAL, ?, ?, ?, ?, ?)";
		try {
			conn = getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, dto.getMid());
			pstmt.setDouble(2, dto.getIweight());
			pstmt.setDouble(3, dto.getIfat());
			pstmt.setDouble(4, dto.getImuscle());
			pstmt.setDate(5, dto.getIdate());
			pstmt.executeUpdate();
			result = SUCCESS;
			System.out.println("inbody 등록 성공");
		} catch (SQLException e) {
			System.out.println(e.getMessage() + " inbody 등록 실패");
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
	// 2. 정보수정
	public int modifyInobdy(InbodyDto dto) {
		int result = FAIL;
		Connection        conn  = null;
		PreparedStatement pstmt = null;
		String sql = "UPDATE INBODY SET IWEIGHT = ?," + 
				"                  IFAT = ?," + 
				"                  IMUSCLE = ?," + 
				"                  IDATE = ?" + 
				"            WHERE MID = ?";
		try {
			conn = getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setDouble(1, dto.getIweight());
			pstmt.setDouble(2, dto.getIfat());
			pstmt.setDouble(3, dto.getImuscle());
			pstmt.setDate(4, dto.getIdate());
			pstmt.setString(5, dto.getMid());
			pstmt.executeUpdate();
			result = SUCCESS;
			System.out.println("inbody 수정 성공");
		} catch (SQLException e) {
			System.out.println(e.getMessage() + " inbody 수정 실패");
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
	// 3. inbody 삭제
	public int deleteInbody(int inum, String mid) {
		int result = FAIL;
		Connection        conn  = null;
		PreparedStatement pstmt = null;
		String sql = "DELETE FROM INBODY WHERE INUM = ? AND MID = ?";
		try {
			conn = getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, inum);
			pstmt.setString(2, mid);
			pstmt.executeUpdate();
			result = SUCCESS;
			System.out.println("inbody 삭제 성공");
		} catch (SQLException e) {
			System.out.println(e.getMessage() + " inbody 삭제 실패");
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
	// 4. 회원 탈퇴시 탈퇴회원 inbody 모두 삭제
	public int deleteWithDInbody(String mid) {
		int result = FAIL;
		Connection        conn  = null;
		PreparedStatement pstmt = null;
		String sql = "DELETE FROM INBODY WHERE MID = ?";
		try {
			conn = getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, mid);
			pstmt.executeUpdate();
			result = SUCCESS;
			System.out.println("탈퇴회원 inbody 삭제 성공");
		} catch (SQLException e) {
			System.out.println(e.getMessage() + " 탈퇴회원 inbody 삭제 실패");
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
