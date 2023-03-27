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
			width: 1300px;
		}
		#content form td{
			width: 130px;
			padding: 10px 0;
		}
		#content form .timer{
			width: 70px;
			padding: 0;
			cursor: pointer;
			border-radius: 70px;
		}
		#content form .delete{
			width: 50px;
			padding: 0;
			border-radius: 25px;
		}
	</style>
	<script src="https://code.jquery.com/jquery-3.6.4.min.js"></script>
	<script>
		$(function(){
			
		});
	</script>
</head>
<body>
	<c:if test="${empty member }">
		<script>
			location.href='${conPath}/loginView.do?next=exRecordWriteView.do';
		</script>
	</c:if>
	<jsp:include page="../main/header.jsp"/>
	<div id="content">
		<form action="exRecordWrite.do">
			<table id="exList">
				<caption><b>운동을 하는것만큼 기록하는 것도 중요합니다</b></caption>
				<tr>
					<th>운동선택</th>
					<td>
						<select name="expart">
							<c:forEach var="dto" items="${expart }">
								<option value="${dto.epno }">${dto }</option>
							</c:forEach>
						</select>	
					</td>						
					<th>무게</th>
					<td>
						<input type="number" name="eweight" class="eweight" min="0" required="required" value="0"> 
					</td>
					<th>세트 수</th>
					<td>
						<input type="number" name="eset" class="ex" required="required" min="0">
					</td>
					<th>운동개수</th>
					<td>
						<input type="number" name="ecount"  class="ex" required="required" min="0"> 
					</td>
					<td>
						<input type="button" value="X" class="delete"> 
					</td>
				</tr>
				<tr>
					<td colspan="2"></td>
					<th>운동시간</th>
					<td>
						<input type="number" name="ehour" min="00" max="24" placeholder="시간">
					</td>
					<td>
						<input type="number" name="emin" min="00" max="59" placeholder="분">
					</td>
					<td>
						<input type="number" name="esec" min="00" max="59" placeholder="초">
					</td>
					<td colspan="2"></td>
				</tr>
			</table>
			<table>
				<tr>
					<td colspan="7">
						<input type="button" value="운동 추가" class="btn addEx">
						<input type="submit" value="저장하기" class="btn">
					</td>
				</tr>
				</table>
		</form>
	</div>
	<jsp:include page="../main/footer.jsp"/>
</body>
</html>