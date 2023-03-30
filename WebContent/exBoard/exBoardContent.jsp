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
		#content form{
			border-bottom: 1px solid #e7e7e7;
			border-top: 1px solid #e7e7e7;
			border-radius: 0;
		}
		#content input.commentBtn{
			width: 70px;
			height: 30px;
			line-height: 30px;
			padding: 0;
			cursor: pointer;
			border-radius: 25px;
		}
		#content input.commentBtn:hover{
			background-color: #e7e7e7;
		}
	</style>
	<script src="https://code.jquery.com/jquery-3.6.4.min.js"></script>
	<script>
		$(function(){
			
		});
	</script>
</head>
<body>
	<c:if test="${empty member && empty admin}">
		<script>
			location.href='${conPath}/loginView.do?next=exBoardContentView.do';
		</script>
	</c:if>
	<c:if test="${not empty exBoardResult }">
		<script>
		alert('${exBoardResult}');
		</script>
	</c:if>
	<div id="content">
	<jsp:include page="../main/header.jsp"/>
 		<table>
 			<tr>
 				<th><h1>${exBoard.btitle }</h1></th>
 			</tr>
 			<tr></tr>
 			<tr>
 				<td class="right">
 					<b>${exBoard.writer }&nbsp; &nbsp;</b>
 				</td>
 			</tr>
 			<tr></tr>
 			<tr>
 				<td>
 					<c:if test="${not empty exBoard.bphoto}">
 						<img alt="${exBoard.mid }첨부파일" src="${conPath }/exBoardUp/${exBoard.bphoto}" width="300px">
 					</c:if>
 				</td>
 			</tr>
 			<tr>
 				<td style="float: left;">&nbsp; &nbsp; &nbsp;${exBoard.bcontent }</td>
 			</tr>
 			<tr></tr>
 			<tr>
 				<td class="right">
					<fmt:formatDate value="${exBoard.bdate}" pattern="YY.MM.dd HH:mm" type="both"/>
				</td>
 			</tr>
 			<tr>
 				<td class="right">조회수 : ${exBoard.bhit }</td>
 			</tr>
 			<tr>
				<td>
				<c:if test="${not empty member || not empty admin }">
					<button class="btn" onclick="location.href='${conPath }/exBoardReplyView.do?bnum=${exBoard.bnum}&pageNum=${param.pageNum }'">
						답변
					</button>
				</c:if>
					<button class="btn" onclick="location.href='${conPath }/exBoardList.do?pageNum=${param.pageNum }'">
						목록
					</button>
				<c:if test="${member.mid eq exBoard.mid || not empty admin }">
					<button class="btn" onclick="location.href='${conPath }/exBoardDelete.do?bnum=${exBoard.bnum}&pageNum=${param.pageNum }'">
						삭제
					</button>
				</c:if>
				<c:if test="${member.mid eq exBoard.mid || admin.aid eq exBoard.mid }">
					<button class="btn" onclick="location.href='${conPath }/exBoardModifyView.do?bnum=${exBoard.bnum}&pageNum=${param.pageNum }'">
						수정
					</button>
				</c:if>	
				</td>
			</tr>
 		</table>
 		<form action="bComment.do">
 			<input type="hidden" name="bnum" value="${exBoard.bnum }">
 			<input type="hidden" name="pageNum" value="${param.pageNum}">
 			<table>
 				<tr>
 					<td class="left"><b>${member.mid } ${admin.aid }</b></td>
 				</tr>
 				<tr>
 					<td class="left">
 						<textarea rows="5" name="ccontent" required="required"></textarea>
 					</td>
 				</tr>
 				<tr>
 					<td class="right small">
 						<input type="submit" value="댓글쓰기" class="commentBtn">
 					</td>
 				</tr>
 			</table>
 		</form>
 		<c:if test="${not empty comment }">
 			<c:forEach var="item" items="${comment }">
		 		<table class="comment">
		 			<tr>
		 				<td class="left">
		 					<b>${item.mid }</b>
		 					<p class="small">
								<fmt:formatDate value="${item.cdate}" pattern="YY.MM.dd HH:mm" type="both"/>
							</p>
		 				</td>
		 			</tr>
		 			<tr>
						<td class="left">
								${item.ccontent }
							<div class="right small">
			 					<c:if test="${member.mid eq item.mid || admin.aid eq item.mid}">
			 						<a href="${conPath }/bCommentModifyView.do?bnum=${exBoard.bnum}&cnum=${item.cnum}">
			 							수정
			 						</a>
			 					</c:if>
			 					<c:if test="${member.mid eq item.mid || not empty admin}">
			 						<a href="${conPath }/bCommentDelete.do?bnum=${exBoard.bnum}&cnum=${item.cnum}">삭제</a>
			 					</c:if>
							</div>
						</td>
		 			</tr>
		 		</table>
	 		</c:forEach>
 		</c:if>
	</div>
	<jsp:include page="../main/footer.jsp"/>
</body>
</html>