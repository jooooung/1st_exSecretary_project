<%@page import="com.lec.exSec.dto.BcommentDto"%>
<%@page import="com.lec.exSec.dao.BcommentDao"%>
<%@page import="java.sql.Timestamp"%>
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
		out.println("<h2>BcommentDao 테스트</h2>");
		Timestamp ts = new Timestamp(System.currentTimeMillis());
		BcommentDao bDao = BcommentDao.getInstance();
		out.println("<p>1번 댓글가져오기</p>");
		BcommentDto bDto = bDao.getBcomment(1);
		out.println(bDto);
		
		out.println("<p>2번글 댓글쓰기</p>");
		int write = bDao.writeBcomment(new BcommentDto(0, 2, "member1", "dao 쓰기테스트", ts, "192.1.1.1"));
		out.println(bDao.getBcomment(2));
		
 		/* out.println("<p>1번 댓글 수정</p>");
		bDto.setCcontent("수정");
		if(bDao.modifyBcomment(bDto) == BcommentDao.SUCCESS){
			out.println(bDto); 
		}else if(bDao.modifyBcomment(bDto) == BcommentDao.FAIL){
			out.println("수정 실패"); 
		}  댓글 없을 시 널포인터익셉션 발생*/
		
		out.println("<p>1번 댓글삭제</p>");
		int delete = bDao.deleteBcomment(2);
		if(delete == BcommentDao.FAIL){
			out.println("<p>삭제실패</p>");
		}else if(delete == BcommentDao.SUCCESS){
			out.println("<p>삭제성공</p>");
		}
		
		out.println("<p>member3 댓글 삭제</p>");
		int withd = bDao.deleteWithDBcomment("member1");
		if(withd == BcommentDao.FAIL){
			out.println("<p>탈퇴회원 댓글삭제실패</p>");
		}else if(withd == BcommentDao.SUCCESS){
			out.println("<p>탈퇴회원 댓글삭제성공</p>");
		}
	%>
</body>
</html>