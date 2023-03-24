package com.lec.exSec.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.sql.DataSource;

import com.lec.exSec.dto.ExPartDto;

public class ExPartDao {
	public static final int FAIL = 0;
	public static final int SUCCESS = 1;
	private static ExPartDao instance = new ExPartDao();
	public static ExPartDao getInstance() {
		return instance;
	}
	private ExPartDao() {}
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
	// 운동하기 시 운동 
	public ArrayList<ExPartDto> forSelectEx(ExPartDto dto) {
		ArrayList<ExPartDto> allEx = new ArrayList<ExPartDto>();
		Connection        conn  = null;
		PreparedStatement pstmt = null;
		ResultSet         rs    = null;
		String sql = "SELECT * FROM EXPART";
		try {
			conn = getConnection();
			pstmt = conn.prepareStatement(sql);
			rs = pstmt.executeQuery();
			while(rs.next()) {
				int epno = rs.getInt("epno");
				String eppart = rs.getString("eppart");
				String ename = rs.getString("ename");
				allEx.add(new ExPartDto(epno, eppart, ename));
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
		return allEx;
	}
	
	// 1. 새 운동 등록
	public int writeExPart(ExPartDto dto) {
		int result = FAIL;
		Connection        conn  = null;
		PreparedStatement pstmt = null;
		String sql = "INSERT INTO EXPART VALUES (EXPART_SEQ.NEXTVAL, ?, ?)";
		try {
			conn = getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, dto.getEppart());
			pstmt.setString(2, dto.getEname());
			pstmt.executeUpdate();
			result = SUCCESS;
			System.out.println("운동등록 성공");
		} catch (SQLException e) {
			System.out.println(e.getMessage() + " 운동등록 실패 :");
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
	// 2. 운동 수정
	public int modifyExPart(ExPartDto dto) {
		int result = FAIL;
		Connection        conn  = null;
		PreparedStatement pstmt = null;
		String sql = "UPDATE EXPART SET EPPART = ?," + 
				"                  ENAME = ?" + 
				"            WHERE EPNO = ?";
		try {
			conn = getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, dto.getEppart());
			pstmt.setString(2, dto.getEname());
			pstmt.setInt(3, dto.getEpno());
			pstmt.executeUpdate();
			result = SUCCESS;
			System.out.println("운동수정 성공");
		} catch (SQLException e) {
			System.out.println(e.getMessage() + " 운동수정 실패 :");
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
	// 3. 운동 삭제
	public int deleteExPart(int epno) {
		int result = FAIL;
		Connection        conn  = null;
		PreparedStatement pstmt = null;
		String sql = "DELETE FROM EXPART WHERE EPNO = ?";
		try {
			conn = getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, epno);
			pstmt.executeUpdate();
			result = SUCCESS;
			System.out.println("운동삭제 성공");
		} catch (SQLException e) {
			System.out.println(e.getMessage() + " 운동삭제 실패 :");
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
	// 4. 운동 목록
	public ArrayList<ExPartDto> listExPart(int startRow, int endRow){
		ArrayList<ExPartDto> dtos = new ArrayList<ExPartDto>();
		Connection        conn  = null;
		PreparedStatement pstmt = null;
		ResultSet         rs    = null;
		String sql = "SELECT * FROM " + 
				"    (SELECT ROWNUM RN, EP.* FROM" + 
				"        (SELECT * FROM EXPART) EP)" + 
				"    WHERE RN BETWEEN ? AND ?";
		try {
			conn = getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, startRow);
			pstmt.setInt(2, endRow);
			rs = pstmt.executeQuery();
			while(rs.next()) {
				int epno = rs.getInt("epno");
				String eppart = rs.getString("eppart");
				String ename = rs.getString("ename");
				dtos.add(new ExPartDto(epno, eppart, ename));
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
	// 5. 총 개수
	public int getExPartTotCnt() {
		int totCnt = 0;
		Connection        conn  = null;
		PreparedStatement pstmt = null;
		ResultSet         rs    = null;
		String sql = "SELECT COUNT(*) FROM EXPART";
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
}
