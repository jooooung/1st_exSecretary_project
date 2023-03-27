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
		table{
			background-color: white;
			width: 700px;
			height: auto;
			margin:0 auto;
			border-radius: 10px;
		}
	</style>
	<script src="https://code.jquery.com/jquery-3.6.4.min.js"></script>
	<script>
		$(function(){
			
		});
	</script>
</head>
<body>
	<c:if test="${empty member }">
		<script>
			location.href='${conPath}/loginView.do?next=exContent.do?eno=${exContent.eno}';
		</script>
	</c:if>
	<jsp:include page="../main/header.jsp"/>
	<div id="content">
		<table>
			<caption><b>${exContent.edate}(${exContent.ename })</b></caption>
			<tr></tr>
			<tr>
				<th>운동명</th><th>세트수</th><th>개수</th><th>시간</th><th>날짜</th>
			</tr>
			<tr>
				<td>${exContent.ename }</td>
				<td>${exContent.eset }</td>
				<td>${exContent.ecount }</td>
				<td>
					<c:if test="${exContent.ehour < 10}">0${exContent.ehour}</c:if>
					<c:if test="${exContent.ehour >= 10}">${exContent.ehour}</c:if>
					 : 
					<c:if test="${exContent.emin < 10}">0${exContent.emin}</c:if>
					<c:if test="${exContent.emin >= 10}">${exContent.emin}</c:if>
					 :
					<c:if test="${exContent.esec < 10}">0${exContent.esec}</c:if>
					<c:if test="${exContent.esec >= 10}">${exContent.esec}</c:if>
				</td>
				<td>${exContent.edate }</td>
			</tr>
			<tr></tr>
			<tr>
				<td colspan="5">
					<button class="btn">운동기록 수정</button>
					<button class="btn">운동기록 삭제</button>
					<button class="btn">운동기록 목록</button>
				</td>
			</tr>
		</table>
	</div>
	<jsp:include page="../main/footer.jsp"/>
</body>
</html>