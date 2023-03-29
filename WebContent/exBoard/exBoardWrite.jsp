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
		
	</style>
	<script src="https://code.jquery.com/jquery-3.6.4.min.js"></script>
	<script>
		$(function(){
			
		});
		function checkSize(input) {
		    if (input.files && input.files[0].size > (5 * 1024 * 1024)) {
		        alert("용량이 5mb를 넘습니다.");
		        input.value = null;
		    }
		} //  업로드 용량 제한
	</script>
</head>
<body>
	<c:if test="${empty member && empty admin}">
		<script>
			location.href='${conPath}/loginView.do?next=exBoardWriteView.do';
		</script>
	</c:if>
	<div id="content">
	<jsp:include page="../main/header.jsp"/>
		<form action="exBoardWrite.do" method="post" enctype="multipart/form-data">
	 		<table>
			<caption>글쓰기</caption>
			<tr>
				<th>제목</th>
				<td>
					<input type="text" name="btitle" required="required">
				</td>
			</tr>
			<tr>
				<th>내용</th>
				<td>
					<textarea name="bcontent" rows="10"></textarea>
				</td>
			</tr>
			<tr>
				<th>사진</th>
				<td>
					<input type="file" name="bphoto" onchange="checkSize(this)"><br>
					<span class="small">5MB 미만만 첨부가 가능합니다</span>
				</td>
			</tr>
			<tr></tr>
			<tr>
				<td colspan="2">
					<input type="submit" value="글쓰기" class="btn">
					<input type="reset" value="취소" class="btn">
					<input type="button" value="목록" class="btn" onclick="location.href='${conPath }/exBoardList.do?pageNum=${param.pageNum }'">
				</td>
			</tr>	
			<tr></tr>
		</table>
 		</form>
	</div>
	<jsp:include page="../main/footer.jsp"/>	
</body>
</html>