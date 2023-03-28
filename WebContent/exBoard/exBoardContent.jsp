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
		#content table:first-child{
			border-radius: 10px 10px 0 0;
		} 
		#content table:last-child{
			border-radius: 0 0 10px 10px;
		} 
		#content form{
			border-bottom: 1px solid;
			border-top: 1px solid;
			border-radius: 0;
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
	<jsp:include page="../main/header.jsp"/>
	<div id="content">
 		<table>
 			<tr>
 				<th><h1>${exBoard.btitle }</h1></th>
 			</tr>
 			<tr></tr>
 			<tr>
 				<td class="right"><b>${exBoard.writer }&nbsp; &nbsp;</b></td>
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
 						<textarea rows="5" name="bcontent"></textarea>
 					</td>
 				</tr>
 				<tr>
 					<td class="right">
 						<input type="submit" value="등록" class="btn"> 
 					</td>
 				</tr>
 			</table>
 		</form>
 		<c:if test="${not empty comment }">
	 		<table>
	 			<tr>
	 				<td class="left">
	 					<b>${comment.mid }</b>
	 				</td>
	 			</tr>
	 			<tr>
					<td class="left">
						${comment.ccontent }<br>
						<span class="small">
							<fmt:formatDate value="${comment.cdate}" pattern="YY.MM.dd HH:mm" type="both"/>
						</span>
						<div class="right small">
								<a>댓글달기</a>
		 					<c:if test="${member.mid eq comment.mid || admin.aid eq comment.mid}">
		 						<a>수정</a>
		 					</c:if>
		 					<c:if test="${member.mid eq comment.mid || not empty admin}">
		 						<a>삭제</a>
		 					</c:if>
						</div>
					</td>
	 			</tr>
	 		</table>
 		</c:if>
	</div>
	<jsp:include page="../main/footer.jsp"/>
</body>
</html>