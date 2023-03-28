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
	<c:if test="${empty admin }">
		<script>
			location.href='${conPath}/aLoginView.do';
		</script>
	</c:if>
	<jsp:include page="../main/header.jsp" />
	<div id="content">
		<table>
			<caption style="color: white; font-size:3em;">전체회원보기</caption>
			<tr>
	  		<c:forEach var="dto" items="${members }" >
		  		<td>
		  			<c:if test="${not empty member.mphoto }">
							<td rowspan="2">
		  					<img alt="${dto.mname }사진" src="${conPath }/memberPhotoUp/${dto.mphoto}" width="130px">
		  				</td>
						</c:if>
		  			<table>
			  			<tr>
			  				<th>이름</th>
			  				<td>${dto.mname }</td>
			  			</tr>
			  			<tr>
			  				<th>아이디 </th>
			  				<td>${dto.mid}</td>
			  			</tr>
			  			<c:if test="${empty dto.mtel}">
			  				<tr>
				  				<th>전화번호 </th>
			  					<td>-</td>
			  				</tr>
			  			</c:if>
			  			<c:if test="${not empty dto.mtel}">
			  				<tr>
				  				<th>전화번호 </th>
			  					<td>${dto.mtel }</td>
			  				</tr>
			  			</c:if>
			  			<c:if test="${empty dto.memail}">
			  				<tr>
				  				<th>이메일</th>
			  					<td>-</td>
			  				</tr>
			  			</c:if>
			  			<c:if test="${not empty dto.memail}">
			  				<tr>
				  				<th>이메일 </th>
			  					<td>${dto.memail}</td>
			  				</tr>
			  			</c:if>
			  			<c:if test="${dto.mgender eq 'm' }">
			  				<tr>
				  				<th>성별</th>
			  					<td>남자</td>
			  				</tr>
			  			</c:if>
			  			<c:if test="${dto.mgender eq 'f' }">
			  				<tr>
				  				<th>성별</th>
			  					<td>여자</td>
			  				</tr>
			  			</c:if>
			  			<c:if test="${empty dto.mbirth}">
			  				<tr>
				  				<th>생년월일</th>
			  					<td>-</td>
			  				</tr>
			  			</c:if>
			  			<c:if test="${not empty dto.mbirth}">
			  				<tr>
				  				<th>생년월일 </th>
			  					<td>${dto.mbirth}</td>
			  				</tr>
			  			</c:if>
		  				<tr>
		  					<th>가입일</th>
		  					<td>${dto.mrdate }</td>
		  				</tr>
			  		</table>
		  		</td>
	  		</c:forEach>
	  	</tr>
  </table>
  <p class="paging">
  	<a href="${conPath }/mAllView.do?pageNum=1">	<!-- 맨 앞으로( << ) -->
  		&lt;&lt;
  	</a>
  	&nbsp; &nbsp; 
  	<c:if test="${BLOCKSIZE < startPage }">	<!-- 이전 페이지 있을 경우 ( < ) -->
  		<a href="${conPath }/mAllView.do?pageNum=${startPage-1}">&lt;</a>
  	</c:if>
  	<c:if test="${BLOCKSIZE >= startPage }">	<!-- 이전 페이지 없을 겨우( < ) -->
  		&lt;
  	</c:if>
  	&nbsp; &nbsp; 
  	<c:forEach var="i" begin="${startPage }" end="${endPage }"><!-- 페이지 숫자 -->
  		<c:if test="${i eq pageNum }"><!-- 현재 페이지 -->
  			<b>[${i }]</b>
  		</c:if>
  		<c:if test="${i != pageNum }"><!-- 다른 페이지 -->
  			<a href="${conPath }/mAllView.do?pageNum=${i}">[${i }]</a>
  		</c:if>
  	</c:forEach>
  	&nbsp; &nbsp; 
  	<c:if test="${endPage < pageCnt }"><!-- 다음페이지( > ) -->
	  	<a href="${conPath }/mAllView.do?pageNum=${endPage+1}">&gt;</a>
  	</c:if>
  	<c:if test="${endPage eq pageCnt }">
	  	&gt;
  	</c:if>
  	&nbsp; &nbsp; 
  	<a href="${conPath }/mAllView.do?pageNum=${pageCnt}">&gt;&gt;</a> <!-- 끝 페이지 (>>) -->
  </p>
	</div>
	<jsp:include page="../main/footer.jsp"/>
</body>
</html>