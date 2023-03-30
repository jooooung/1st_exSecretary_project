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
	<link href="${conPath }/css/main.css" rel="stylesheet">
	<script src="https://code.jquery.com/jquery-3.6.4.min.js"></script>
	<script>
		$(function(){
			
		});
	</script>
<head>
	<meta charset="UTF-8">
	<title>Insert title here</title>
</head>
<body>
	<c:if test="${not empty loginErrorMsg }">
		<script>
			alert('${loginErrorMsg}');
			history.back();
		</script>
	</c:if>
	<c:if test="${not empty withdrawalResult}">
		<script>
			alert('${withdrawalResult}');
		</script>
	</c:if>
	<div id="content">
	<jsp:include page="../main/header.jsp"/>
 		<div id="main_title">
 			<h1>당신을 위한 단 하나의 운동비서</h1>
 			<br>
 			<h2>맨몸운동과 덤벨 위주의 운동을 도와드립니다</h2>
 			<div id="main_img">
 			
 			</div>
 			<div id="main_info">
 			
 			</div>
 		</div>
	</div>
	<jsp:include page="../main/footer.jsp"/>
</body>
</html>