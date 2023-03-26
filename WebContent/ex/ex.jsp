<%@page import="com.lec.exSec.dto.ExPartDto"%>
<%@page import="com.lec.exSec.dao.ExPartDao"%>
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
		#content form .time{
			width: 150px;
			margin: 0 10px;
		}
	</style>
	<script src="https://code.jquery.com/jquery-3.6.4.min.js"></script>
	<script>
		$(function(){
			$('.addEx').click(function(){
				$('table#exList').append('<tr>'
						+'<th>운동선택</th>'
						+'<td>'
						+'	<select name="expart">'
						+'		<c:forEach var="dto" items="${expart }">'
						+'			<option value="${dto.epno }">${dto }</option>'
						+'		</c:forEach>'
						+'	</select>'
						+'</td>'
						+'<th>무게</th>'
						+'<td>'
						+'	<input type="number" name="eweight" class="ex" min="0">'
						+'</td>'
						+'<th>세트 수</th>'
						+'<td>'
						+'	<input type="number" name="eset" class="ex" required="required" min="1">'
						+'</td>'
						+'<th>운동개수</th>'
						+'<td>'
						+'	<input type="number" name="ecount"  class="ex" required="required" min="1">'
						+'</td>'
						+'<td>'
						+'	<input type="button" value="X" class="delete">'
						+'</td>'
						+'</tr>');
			});
			$(document).on('click', '.delete', function(){
				$(this).parents('tr').remove(); 
			});
		});
	</script>
	<script>
		let endTime = document.getElementById('endTime');
		let startTime = document.getElementById('startTime');
		var etime = document.getElementById('etiem');
		etime.value = endTime - startTime;
	</script>
</head>
<body>
	<c:if test="${empty member}">
		<script>
			location.href='${conPath}/loginView.do?next=exView.do';
		</script>
	</c:if>
	<jsp:include page="../main/header.jsp"/>
	<div id="content">
		<form action="ex.do">
		<input type="hidden" name="ename" value="${dto.ename }">
			<table id="exList">
				<caption><b>운동을 위한 시간을 내지 않으면,<br> 병 때문에 시간을 내야 하게 될지도 모른다. -로빈 샤머</b></caption>
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
						<input type="number" name="eweight" class="eweight" value="0" min="0" required="required">
					</td>
					<th>세트 수</th>
					<td>
						<input type="number" name="eset" class="ex" required="required" min="1">
					</td>
					<th>운동개수</th>
					<td>
						<input type="number" name="ecount"  class="ex" required="required" min="1"> 
					</td>
					<td>
						<input type="button" value="X" class="delete"> 
					</td>
				</tr>
			</table>
			<table>
				<tr>
					<th>운동시간</th>
					<td colspan="4">
						시작시간<input type="time" name="startTime" class="time"> 
						종료시간<input type="time" name="endTime" class="time"> 
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
						<input type="submit" value="오늘의 운동 완료" class="btn">
					</td>
				</tr>
				</table>
		</form>
	</div>
	<jsp:include page="../main/footer.jsp"/>
</body>
</html>