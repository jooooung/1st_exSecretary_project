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
		.paging, .paging a{
			color: white;
		}
		table .expart:hover{
			background-color: #cfcfda;
			cursor: pointer;
		}
	</style>
	<script src="https://code.jquery.com/jquery-3.6.4.min.js"></script>
	<script>
		$(function(){
			$('tr.expart').click(function(){
				var epno = $(this).children().eq(0).text();
				if(! isNaN(epno)){
					location.href = '${conPath }/exPartModifyView.do?epno='+epno+'&pageNum=${pageNum}';
				}
			});
		});
	</script>
</head>
<body>
	<c:if test="${empty admin }">
		<script>
			alert('관리자 계정으로 로그인해주세요');
			location.href='${conPath}/aLoginView.do?next=exPartList.do';
		</script>
	</c:if>	
	<c:if test="${not empty exPartWriteResult }">
		<script>
			alert('${exPartWriteResult}');
		</script>
	</c:if>
	<c:if test="${not empty exPartWriteError }">
		<script>
			alert('${exPartWriteError}');
			history.back();
		</script>
	</c:if>
	<c:if test="${not empty expartModifyResult }">
		<script>
			alert('${expartModifyResult}');
		</script>
	</c:if>
	<c:if test="${not empty expartModifyError }">
		<script>
			alert('${expartModifyError}');
			history.back();
		</script>
	</c:if>
	<c:if test="${not empty deleteExPartResult }">
		<script>
			alert('${deleteExPartResult}');
		</script>
	</c:if>
	<c:if test="${not empty deleteExPartError}">
		<script>
			alert('${deleteExPartError}');
			history.back();
		</script>
	</c:if>
	<jsp:include page="../main/header.jsp"/>
	<div id="content">
 		<table>
 			<tr>
 				<th>운동번호</th><th>부위</th><th>운동명</th>
 			</tr>
			<c:forEach var="exPartList" items="${exPartList }">
 			<tr class="expart">
				<td>${exPartList.epno }</td>
				<td>${exPartList.eppart }</td>
				<td>${exPartList.ename }</td>
 			</tr>
			</c:forEach>
 			<tr>
 				<td colspan="3">
 					<button class="btn" onclick="location.href='exPartWriteView.do'">운동추가</button>
 				</td>
 			</tr>
 		</table>
	<div class="paging">
	  	<c:if test="${startPage > BLOCKSIZE }">
	  		[ <a href="${conPath }/exPartList.do?pageNum=${startPage-1}">이전</a> ]
	  	</c:if>
	  	<c:forEach var="i" begin="${startPage}" end="${endPage }">
	  		<c:if test="${i eq pageNum }">
	  			[ <b>${i }</b> ]
	  		</c:if>
	  		<c:if test="${i != pageNum }">
	  			[ <a href="${conPath }/exPartList.do?pageNum=${i}">${i }</a> ]
	  		</c:if>
	  	</c:forEach>
	 		<c:if test="${endPage < pageCnt }">
	 			[ <a href="${conPath }/exPartList.do?pageNum=${endPage+1}">다음</a> ]
	 		</c:if>
 		</div>
	</div>
	<jsp:include page="../main/footer.jsp"/>
</body>
</html>