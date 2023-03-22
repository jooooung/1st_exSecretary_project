<%@page import="com.lec.exSec.dto.ExPartDto"%>
<%@page import="com.lec.exSec.dao.ExPartDao"%>
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
	<link href="${conPath}/css/main.css" rel="stylesheet" type="text/css">
	<style>
		#content form{
			width: 1000px;
			background-color: #dfcfdb;
		}
	</style>
	<script src="https://code.jquery.com/jquery-3.6.4.min.js"></script>
	<script>
		$(function(){
			
		});
	</script>
</head>
<body>
	<c:if test="${empty member}">
		<script>
			location.href='${conPath}/loginView.do?next=exView.do';
		</script>
	</c:if>
	<jsp:include page="../main/header.jsp"/>
	<div id="content">
		<form action="ex.do">
			상체
			<select>
				<optgroup label="상체">
					<option>sss</option>
				</optgroup>
			</select>
		</form>
	</div>
	<jsp:include page="../main/footer.jsp"/>
</body>
</html>