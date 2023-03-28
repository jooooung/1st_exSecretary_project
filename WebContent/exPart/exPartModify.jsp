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
	<c:if test="${empty admin }">
		<script>
			alert('관리자 계정으로 로그인해주세요');
			location.href="aLoginView.do";
		</script>
	</c:if>
	<jsp:include page="../main/header.jsp"/>
	<div id="content">
 		<form action="exPartModify.do" style="width: 1200px;">
 			<table>
 				<caption>${modifyExPart.ename } 수정하기</caption>
 				<tr>
 					<th>no</th>
 					<td>
 						<input type="number" name="epno" value="${modifyExPart.epno }" readonly="readonly">
 					</td>
 					<th>운동명</th>
 					<th>부위</th>
 					<td>
 						<input type="text" name="eppart" value="${modifyExPart.eppart }" required="required">
 					</td>
 					<th>운동명</th>
 					<td>
 						<input type="text" name="ename" value="${modifyExPart.ename }" required="required">
 					</td>
 				</tr>
 			</table>
 			<table>
 				<tr>
 					<td colspan="4">
 						<input type="submit" value="수정" class="btn">
 						<input type="button" value="취소" class="btn" onclick="location.href='${conPath}/exPartList.do'">
 						<input type="button" value="삭제" class="btn" onclick="location.href='${conPath}/exPartDelete.do?epno='+${modifyExPart.epno }">
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