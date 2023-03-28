<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<c:set var="conPath" value="${pageContext.request.contextPath }" />
<c:set var="conPath" value="${pageContext.request.contextPath }" />
<fmt:formatDate value="${exBoard.bdate}" pattern="yy.MM.dd HH:mm"/>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>Insert title here</title>
	<link href="${conPath}/css/main.css" rel="stylesheet" type="text/css">
	<style>
		table{
			height: auto;
			border-radius: 10px;
		}
		table tr:hover:not(.title){
			background-color: #cfcfda;
			cursor: pointer;
		}
		table .title th{
			border-bottom: 2px solid;
		}
	</style>
	<script src="https://code.jquery.com/jquery-3.6.4.min.js"></script>
	<script>
		$(function(){
			$('tr').click(function(){
				var bnum = $(this).children().eq(0).text().trim();
				if(! isNaN(bnum)){
					location.href = '${conPath }/exBoardContentView.do?bnum='+bnum+'&pageNum=${pageNum}';
				}
			});
		});
	</script>
</head>
<body>
	<c:if test="${empty member}">
		<script>
			location.href='${conPath}/loginView.do?next=exBoardList.do';
		</script>
	</c:if>
	<c:if test="${not empty exBoardResult}">
		<script>
			alert('${exBoardResult}');
		</script>
	</c:if>
	<c:if test="${not empty exBoardError}">
		<script>
			alert('${exBoardResult}');
			history.back();
		</script>
	</c:if>
	<jsp:include page="../main/header.jsp"/>
	<div id="content">
		<div class="page-title">
			<h1>자유게시판</h1>
		</div>
		<table>
			<tr class="title">
				<th>no</th><th>제목</th><th>글쓴이</th><th>조회수</th><th>작성일</th>
			</tr>
			<c:if test="${exBoardList.size() eq 0 }">
				<tr><td colspan="5">해당 페이지에 글이 없습니다</td></tr>
			</c:if>
			<c:if test="${exBoardList.size() != 0 }">
				<c:forEach var="dto" items="${exBoardList}">
					<tr>
						<td><b>${dto.bnum }</b></td>
						<td class="left">
							<c:forEach var="i" begin="1" end="${dto.bindent }"><!-- 들여쓰기 -->
								<c:if test="${i != dto.bindent }"> 
									&nbsp; &nbsp; 
								</c:if> 
								<c:if test="${i eq dto.bindent }"><!-- 답글 표시 -->	
									└
								</c:if> 
							</c:forEach><!-- 답글들여쓰기 ,표시 처리 -->
							<c:if test="${dto.bhit > 10 }">
								<b>${dto.btitle }</b>
								<c:if test="${not empty dto.bphoto }">
									<img alt="첨부파일 아이콘" src="${conPath }/img/file.png" width="13">
								</c:if>
							</c:if><!-- 조회수 높은 글 효과주기 -->
							<c:if test="${dto.bhit <= 10 }">
								${dto.btitle }
							</c:if>
						</td>
						<td>${dto.writer}</td>
						<td>${dto.bhit }</td>
						<td>
							${dto.bdate }
						</td>
					</tr>
				</c:forEach>
			</c:if>
			<tr></tr>
			<tr class="title">
				<td colspan="5">
					<c:if test="${empty member}">	
						<a href="${conPath }/loginView.do?next=exBoardWriteView.do">
							글쓰기는 사용자 로그인 이후에만 가능합니다
						</a>
					</c:if><!-- 로그인 전 글쓰기는 로그인 후 -->
					<c:if test="${not empty member}">	
							<a href="${conPath }/exBoardWriteView.do">글쓰기</a>
					</c:if><!-- 로그인 후 글쓰기-->
				</td>
			</tr>
		</table>
		<p class="paging">
	  	<c:if test="${startPage > BLOCKSIZE }">
	  		[ <a href="${conPath }/boardList.do?pageNum=${startPage-1}">이전</a>]
	  	</c:if>
	  	<c:forEach var="i" begin="${startPage}" end="${endPage }">
	  		<c:if test="${i eq pageNum }">
	  			[ <b>${i }</b> ]
	  		</c:if>
	  		<c:if test="${i != pageNum }">
	  			[ <a href="${conPath }/boardList.do?pageNum=${i}">${i }</a> ]
	  		</c:if>
	  	</c:forEach>
	 		<c:if test="${endPage < pageCnt }">
	 			[ <a href="${conPath }/boardList.do?pageNum=${endPage+1}">다음</a> ]
	 		</c:if>
 		</p>
	</div>
	<jsp:include page="../main/footer.jsp"/>
</body>
</html>