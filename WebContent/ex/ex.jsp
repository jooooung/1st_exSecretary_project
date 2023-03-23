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
	</style>
	<script>
    let timer_hour;
    let timer_min;
		let timer_sec;
		let timer = 0;
		function startClock() {
			var sec = parseInt(document.getElementById("sec").innerText);
      var min = parseInt(document.getElementById("min").innerText);
      var hour = parseInt(document.getElementById("hour").innerText);
    //start seconds
      timer_sec = setInterval(function(){
          sec++;
          if(sec == 60) {
              sec = "00";
          } else if(sec < 10){
              sec = "0" + sec;
          }
          document.getElementById("sec").innerText = sec;
      }, 1000);

      //start minutes
      timer_min = setInterval(function(){
          min++;

          if(min == 60) {
              min = 0;
          } else if(min < 10){
              min = "0" + min;
          }

          document.getElementById("min").innerText = min;
      }, 60000);

      //start hours
      timer_hour = setInterval(function(){
          //console.log(hour);
          hour++;
          if(hour < 10){
              hour = "0" + hour;
          }
          document.getElementById("hour").innerText = hour;
      }, 3600000);

      timer++;
		}
		function stopClock() {
      clearInterval(timer_sec);
      clearInterval(timer_min);
      clearInterval(timer_hour);

      timer--;
      if(timer < 0)
          timer = 0;
		}
		function resetClock() {
			stopClock();
			document.getElementById("sec").innerText = "00";
      document.getElementById("min").innerText = "00";
      document.getElementById("hour").innerText = "00";
		}
	</script>
	<script src="https://code.jquery.com/jquery-3.6.4.min.js"></script>
	<script>
		$(function(){
			$('.addEx').click(function(){
				$('table#exList').append('<tr class="oneEx">'
						+'<th>운동선택</th>'
						+'<td>'
						+'	<select name="expart">'
						+'		<c:forEach var="item" items="${expart}">'
						+'			<option>${item}</option>'
						+'		</c:forEach>'
						+'	</select>'
						+'</td>'
						+'<th>무게</th>'
						+'<td>'
						+'	<input type="number" name="eweight" class="ex">'
						+'</td>'
						+'<th>세트 수</th>'
						+'<td>'
						+'	<input type="number" name="eset" class="ex">'
						+'</td>'
						+'<th>운동개수</th>'
						+'<td>'
						+'	<input type="number" name="ecount"  class="ex">'
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
			<table id="exList">
				<caption><b>운동을 위한 시간을 내지 않으면,<br> 병 때문에 시간을 내야 하게 될지도 모른다. -로빈 샤머</b></caption>
				<tr class="oneEx">
					<th>운동선택</th>
					<td>
						<select name="expart">
							<c:forEach var="item" items="${expart}">
								<option>${item}</option>
							</c:forEach>
						</select>	
					</td>						
					<th>무게</th>
					<td>
						<input type="number" name="eweight" class="eweight">
					</td>
					<th>세트 수</th>
					<td>
						<input type="number" name="eset" class="ex">
					</td>
					<th>운동개수</th>
					<td>
						<input type="number" name="ecount"  class="ex"> 
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
						<input type="submit" value="오늘의 운동 완료" class="btn">
					</td>
				</tr>
				</table>
		</form>
	</div>
	<jsp:include page="../main/footer.jsp"/>
</body>
</html>