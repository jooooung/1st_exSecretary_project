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
	<script src="https://code.jquery.com/jquery-3.6.4.min.js"></script>
	<script>
		$(function(){
			
		});
	</script>
</head>
<body>
	<c:if test="${empty member}">
		<script>
			location.href='${conPath}/loginView.do?next=inbodyWriteView.do';
		</script>
	</c:if>
	<div id="content">
	<jsp:include page="../main/header.jsp"></jsp:include>
		<form action="inbodyWrite.do">
			<table>
				<caption>inbody 등록</caption>
				<tr>
					<th>몸무게</th><th>체지방률</th><th>골격근량</th>
				</tr>
				<tr>
					<td>
						<input type="number" name="iweight" required="required">
					</td>
					<td>
						<input type="number" name="ifat" value="0">
					</td>
					<td>
						<input type="number" name="imuscle" value="0">
					</td>
				</tr>
				<tr>
				</tr>
				<tr>
					<td colspan="3">
						<input type="submit" value="등록" class="btn">
						<input type="reset" value="초기화" class="btn">
						<input type="button" value="목록" onclick="location.href='${conPath}/inbodyList.do'" class="btn">
					</td>
				</tr>
				<tr>
				</tr>
			</table>
		</form>
	</div>
	<jsp:include page="../main/footer.jsp"></jsp:include>
</body>
</html>