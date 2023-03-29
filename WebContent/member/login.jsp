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
<head>
	<meta charset="UTF-8">
	<title>Insert title here</title>
</head>
<body>
	<c:choose>
		<c:when test="${not empty member || not empty admin}">
			<script>
				location.href="main.do"
			</script>
		</c:when>
		<c:when test="${not empty joinResult}">
			<script>
				alert('${joinResult}')
				location.href="loginView.do"
			</script>
		</c:when>
		<c:when test="${not empty joinError}">
			<script>
				alert('${joinError}')
				history.back();
			</script>
		</c:when>
		<c:when test="${not empty next }">
			<script>
				location.href = '${conPath}/${next}';
			</script>
		</c:when>
	</c:choose>
	<div id="content">
	<jsp:include page="../main/header.jsp"/>
		<form action="login.do" method="post">
			<input type="hidden" name="next" value="${param.next }">
			<table>
				<caption>로그인</caption>
				<tr>
					<td>
						<input type="text" name="mid" id="mid" class="mid" value="${mid }"
										placeholder="아이디를 입력해주세요" required="required" autofocus="autofocus">
					</td>
				</tr>
				<tr>
					<td>
						<input type="password" name="mpw" id="mpw" class="mpw"
										placeholder="비밀번호를 입력해주세요" required="required">
					</td>
				</tr>
				<tr>
					<td>
						<input type="submit" value="로그인" class="btn">
					</td>
				</tr>
				<tr>
					<td>
						아직 운동비서가 없으신가요?
						<a href="joinView.do"><b>회원가입</b></a>
					</td>
				</tr>
				<tr>
					<td>
						<a href="aLoginView.do"><b>관리자모드</b></a>
					</td>
				</tr>
			</table>
		</form>
	</div>
	<jsp:include page="../main/footer.jsp"/>
</body>
</html>