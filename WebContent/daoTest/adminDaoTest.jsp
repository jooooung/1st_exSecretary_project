<%@page import="com.lec.exSec.dao.ExBoardDao"%>
<%@page import="com.lec.exSec.dto.ExBoardDto"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.sql.Timestamp"%>
<%@page import="com.lec.exSec.dto.BcommentDto"%>
<%@page import="com.lec.exSec.dao.BcommentDao"%>
<%@page import="com.lec.exSec.dto.AdminDto"%>
<%@page import="com.lec.exSec.dao.AdminDao"%>
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
		AdminDao aDao = AdminDao.getInstance();
		out.println("<h2>adminDao 테스트</h2>");
		out.println("admin 로그인");
		if(AdminDao.LOGIN_FAIL == aDao.loginCheck("admin", "admin")){
			out.println("로그인 실패");
		}else if(AdminDao.LOGIN_SUCCESS == aDao.loginCheck("admin", "admin")){
			out.println("로그인 성공");
		}
		out.println("dto 가져오기");
		AdminDto aDto = aDao.getAdmin("admin");
		out.println("<p>" + aDto + "</p>");
	%>
</body>
</html>