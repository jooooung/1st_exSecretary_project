<%@page import="java.sql.Date"%>
<%@page import="com.lec.exSec.dao.ExDao"%>
<%@page import="com.lec.exSec.dto.ExDto"%>
<%@page import="java.util.ArrayList"%>
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
	out.println("<h2>ExDao 테스트</h2>");
	out.println("<h4>운동회차 목록</h4>");
	ExDao eDao = ExDao.getInstance();
	ArrayList<ExDto> exList = eDao.listEx("member1",1, 3);
	for(ExDto e : exList){
		out.println(e + "<br>");
	}
	out.println("<h4>mid별 총 개수</h4>");
	int totcnt = eDao.getExTotCnt("member1");
	out.println(totcnt);
	
	out.println("<h4>상세보기</h4>");
	ExDto eDto = eDao.contentEx(1, "member1");
	out.println(eDto);
	%>
</body>
</html>