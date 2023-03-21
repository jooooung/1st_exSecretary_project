<%@page import="java.sql.Timestamp"%>
<%@page import="com.lec.exSec.dto.ExBoardDto"%>
<%@page import="java.util.ArrayList"%>
<%@page import="com.lec.exSec.dao.ExBoardDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<c:set var="conPath" value="${pageContext.request.contextPath }" />
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>Insert title here</title>
	<link href="${conPath}/css/style.css" rel="stylesheet" type="text/css">
	<script src="https://code.jquery.com/jquery-3.6.4.min.js"></script>
	<script>
		$(function(){
			
		});
	</script>
</head>
<body>
	<%
		ExBoardDao eDao = ExBoardDao.getInstance();
		out.println("<h2>ExBoardDao 테스트</h2>");
		out.println("<h4>글목록</h4>");
		ArrayList<ExBoardDto> exBoardList = eDao.listExBoard(1, 3);
		for(ExBoardDto e : exBoardList){
			out.println(e + "<br>");
		}
		
		out.println("<h4>글개수</h4>");
		int totcnt = eDao.getExBoardTotCnt();
		out.println(totcnt);
		
		out.println("<h4>글쓰기</h4>");
		Timestamp ts = new Timestamp(System.currentTimeMillis());
		int write = eDao.writeExBoard(new ExBoardDto(0, "member1", null, "테스트 제목", "테스트 본문", null, ts, 0, 5, 0, 0, "192.1.1.2", "김수호"));
		if(write == ExBoardDao.FAIL){
			out.println("글쓰기 실패");
		}else if(write == ExBoardDao.SUCCESS){
			out.println("글쓰기 성공");
		}
		
		out.println("<h4>글상세보기</h4>");
		ExBoardDto eDto = eDao.contentExBoard(1);
		out.println(eDto);
		
		out.println("<h4>글수정</h4>");
		int modify = eDao.modifyExBoard(new ExBoardDto(5, "member1", null, "수정 제목", "수정 본문", null, ts, 0, 5, 0, 0, "192.1.1.2", "김수호"));
		if(modify == ExBoardDao.FAIL){
			out.println("글수정 실패");
		}else if(modify == ExBoardDao.SUCCESS){
			out.println("글수정 성공");
		}
		
		out.println("<h4>글삭제</h4>");
		int delete = eDao.deleteExBoard(1);
		if(delete == ExBoardDao.FAIL){
			out.println("글삭제 실패");
		}else if(delete == ExBoardDao.SUCCESS){
			out.println("글삭제 성공");
		}
		
		out.println("<h4>탈퇴회원글삭제</h4>");
		int withd = eDao.deleteWithDExBoard("member1");
		if(withd == ExBoardDao.FAIL){
			out.println("탈퇴회원글삭제 실패");
		}else if(withd == ExBoardDao.SUCCESS){
			out.println("탈퇴회원글삭제 성공");
		}
	%>
</body>
</html>