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
		}
		#content form td{
			width: 130px;
			padding: 10px 0;
		}
		#content form .delete{
			width: 50px;
			padding: 0;
			border-radius: 25px;
		}
	</style>
	<script src="https://code.jquery.com/jquery-3.6.4.min.js"></script>
	<script>
		$(function(){

		});
	</script>
</head>
<body>
	<c:if test="${empty admin }">
		<script>
			alert('관리자 계정으로 로그인해주세요');
			location.href="aLoginView.do";
		</script>
	</c:if>
	<div id="content">
	<jsp:include page="../main/header.jsp"/>
 		<form action="exPartWrite.do">
 			<table id="exList">
 				<caption>새 운동 등록하기</caption>
 				<tr>
 					<th>부위</th>
 					<td>
 						<input type="text" name="eppart">
 					</td>
 					<th>운동명</th>
 					<td>
 						<input type="text" name="ename">
 					</td>
 				</tr>
 			</table>
 			<table>
 				<tr>
 					<td colspan="4">
 						<input type="submit" value="등록하기" class="btn">
 					</td>
 				</tr>
 				<tr>
 				</tr>
 			</table>
 		</form>
	</div>
	<jsp:include page="../main/footer.jsp"/>
</body>
</html>