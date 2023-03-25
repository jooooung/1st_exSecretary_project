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
			margin:20px auto;
			border-radius: 10px;
		}
		table tr:first-child {
			border-bottom: 1px dashed;	
		}
		.paging, .paging a{
			color: white;
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
	<c:if test="${not empty exResult }">
		<script>
			alert('${exResult}');
		</script>
	</c:if>
	<c:if test="${not empty exFailResult }">
		<script>
			alert('${exFailResult}');
			history.back();
		</script>
	</c:if>
	<jsp:include page="../main/header.jsp"/>
	<div id="content">
		<table>
			<tr>
				<th>운동</th><th>무게</th><th>세트수</th><th>개수</th><th>시간</th><th>날짜</th>
			</tr>
			<c:if test="${exList.size() eq 0 }">
				<tr><td colspan="6">운동기록이 없습니다</td></tr>
			</c:if>
			<c:if test="${exList.size() != 0 }">
				<c:forEach var="dto" items="${exList }">
					<tr>
						<td>${dto.ename}</td>
						<td>${dto.eweight}</td>
						<td>${dto.eset}</td>
						<td>${dto.ecount}</td>
						<td>${dto.etime}</td>
						<td>${dto.edate}</td>
					</tr>
				</c:forEach>
			</c:if>
				<tr>
					<td colspan="6">
						<input type="button" value="기록추가" class="btn" onclick="location.href='exRecordWriteView.do'">
					</td>
				</tr>
		</table>
		<div class="paging">
	  	<c:if test="${startPage > BLOCKSIZE }">
	  		[ <a href="${conPath }/exRecordList.do?pageNum=${startPage-1}">이전</a>]
	  	</c:if>
	  	<c:forEach var="i" begin="${startPage}" end="${endPage }">
	  		<c:if test="${i eq pageNum }">
	  			[ <b>${i }</b> ]
	  		</c:if>
	  		<c:if test="${i != pageNum }">
	  			[ <a href="${conPath }/exRecordList.do?pageNum=${i}">${i }</a> ]
	  		</c:if>
	  	</c:forEach>
	 		<c:if test="${endPage < pageCnt }">
	 			[ <a href="${conPath }/exRecordList.do?pageNum=${endPage+1}">다음</a> ]
	 		</c:if>
 		</div>
	</div>
	<jsp:include page="../main/footer.jsp"/>
</body>
</html>