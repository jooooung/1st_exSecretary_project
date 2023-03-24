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
	<jsp:include page="../main/header.jsp"/>
	<div id="content">
		<form action="exRecordWrite.do">
			<table id="exList">
				<caption><b>운동을 하는것만큼 기록하는 것도 중요합니다</b></caption>
				<tr>
					<th>운동선택</th>
					<td>
						<select name="expart">
								<option>${expart}</option>
						</select>	
					</td>						
					<th>무게</th>
					<td>
						<input type="number" name="eweight" class="eweight">
					</td>
					<th>세트 수</th>
					<td>
						<input type="number" name="eset" class="ex" required="required">
					</td>
					<th>운동개수</th>
					<td>
						<input type="number" name="ecount"  class="ex" required="required"> 
					</td>
					<td>
						<input type="button" value="X" class="delete"> 
					</td>
					<th>운동시간</th>
					<td>
						<input type="time" name="etime"  value="00" placeholder="">
					</td>
				</tr>
			</table>
			<table>
				<tr>
					<td colspan="4">
						<span id="hour">00</span> :
						<span id="min">00</span> :
						<span id="sec">00</span>
					</td>
					<td colspan="3">
						<input type="button" onclick="startClock()" value="start" class="timer">
						<input type="button" onclick="stopClock()" value="stop" class="timer">
						<input type="button" onclick="resetClock()" value="reset" class="timer">
					</td>
				</tr>
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