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
	<c:if test="${not empty next }">
		<script>
			location.href = '${conPath}/${next}';
		</script>
	</c:if>
	<div id="content">
	<jsp:include page="../main/header.jsp"/>
		<form action="aLogin.do" method="post">
			<input type="hidden" name="next" value="${param.next }">
			<table>
				<caption>관리자 로그인</caption>
				<tr>
					<td>
						<input type="text" name="aid" id="aid" class="aid" value="${aid }"
										placeholder="아이디를 입력해주세요" required="required" autofocus="autofocus">
					</td>
				</tr>
				<tr>
					<td>
						<input type="password" name="apw" id="apw" class="apw"
										placeholder="비밀번호를 입력해주세요" required="required">
					</td>
				</tr>
				<tr>
					<td>
						<input type="submit" value="로그인" class="btn">
					</td>
				</tr>
			</table>
		</form>
	</div>
	<jsp:include page="../main/footer.jsp"/>
</body>
</html>