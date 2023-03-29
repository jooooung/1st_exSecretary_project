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
			location.href='${conPath}/loginView.do?next=exRecordModifyView.do';
		</script>
	</c:if>
	<div id="content">
	<jsp:include page="../main/header.jsp"/>
		<form action="exRecordModify.do">
			<input type="hidden" name="eno" value="${modifyExRecord.eno }">
			<input type="hidden" name="epno" value="${modifyExRecord.epno }">
			<input type="hidden" name="edate" value="${modifyExRecord.edate }">
			<table>
				<caption><b>운동기록 수정</b></caption>
				<tr>
					<th>운동</th>
					<td>
						<input type="text" name="ename" value="${modifyExRecord.ename }">
					</td>						
					<th>무게</th>
					<td>
						<input type="number" name="eweight" class="eweight" min="0" required="required" value=${modifyExRecord.eweight }> 
					</td>
					<th>세트 수</th>
					<td>
						<input type="number" name="eset" class="ex" required="required" min="0" value="${modifyExRecord.eset }">
					</td>
					<th>운동개수</th>
					<td>
						<input type="number" name="ecount"  class="ex" required="required" min="0" value="${modifyExRecord.ecount }"> 
					</td>
				</tr>
				<tr>
					<td colspan="2"></td>
					<th>운동시간</th>
					<td>
						<input type="number" name="ehour" min="00" max="24" placeholder="시간" value="${modifyExRecord.ehour }">
					</td>
					<td>
						<input type="number" name="emin" min="00" max="59" placeholder="분" value="${modifyExRecord.emin }">
					</td>
					<td>
						<input type="number" name="esec" min="00" max="59" placeholder="초" value="${modifyExRecord.esec }">
					</td>
					<td colspan="2"></td>
				</tr>
			</table>
			<table>
				<tr>
					<td colspan="7">
						<input type="submit" value="저장하기" class="btn">
						<input type="button" value="취소" class="btn" onclick="history.back()">
					</td>
				</tr>
				</table>
		</form>
	</div>
	<jsp:include page="../main/footer.jsp"/>
</body>
</html>