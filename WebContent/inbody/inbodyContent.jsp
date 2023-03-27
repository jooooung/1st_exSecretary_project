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
			height: auto;
			border-radius: 10px;
		}
		table tr:nth-child(2) td:first-child{
			display: none;
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
			location.href='${conPath}/loginView.do?next=inbodyContent.do';
		</script>
	</c:if>
	<jsp:include page="../main/header.jsp"/>
	<div id="content">
		<table>
			<tr>
				<th>몸무게(kg)</th><th>체지방률(kg)</th><th>골격근량(kg)</th><th>날짜</th>
			</tr>
			<tr>
				<td>${inbody.inum }</td>
				<td>${inbody.iweight }kg</td>
				<td>${inbody.ifat }kg</td>
				<td>${inbody.imuscle }kg</td>
				<td>${inbody.idate }</td>
			</tr>
			<tr>
				<td colspan="5">
					<input type="button" value="기록 수정" class="btn" onclick="location.href='${conPath}/inbodyModifyView.do'">
					<input type="button" value="목록" class="btn" onclick="location.href='${conPath}/inbodyList.do'">
					<input type="button" value="기록 삭제" class="btn" onclick="location.href='${conPath}/inbodyDelete.do'">
				</td>
			</tr>
		</table>
	</div>
	<jsp:include page="../main/footer.jsp"/>	
</body>
</html>