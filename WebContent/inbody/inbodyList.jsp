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
			height: auto;
			border-radius: 10px;
		}
		#chart_div{
			width: 90%;
			margin: 20px auto;
		}
		table .inbody td:first-child{
			display: none;
		}
		table .inbody:hover{
			background-color: #cfcfda;
			cursor: pointer;
		}
	</style>
	<script src="https://www.gstatic.com/charts/loader.js"></script>
	<script src="https://code.jquery.com/jquery-3.6.4.min.js"></script>
	<script>
		var inbodylist =  JSON.parse('${dataList}');
		
		google.charts.load('current', {'packages':['corechart']});
		google.charts.setOnLoadCallback(drawChart);
		
		function drawChart() {
			var data = new google.visualization.DataTable();
			data.addColumn('string', '날짜');
      data.addColumn('number', '몸무게');
      data.addColumn('number', '체지방량');
      data.addColumn('number', '골격근량');
      
      inbodylist.forEach(function(inbody, i) {
				data.addRows([
					[inbody.idate, inbody.iweight, inbody.ifat, inbody.imuscle]
				]);
			});
      
      var options = {
				title: 'Inbody 기록',
				width: '75%',
				height: 300,
        hAxis: {
          title: 'date',
        },
        vAxis: {
          title: 'kg'
        }
      };
      
		  var chart = new google.visualization.LineChart(document.getElementById('chart_div'));
	    chart.draw(data, options);
		}
		
		$(function(){
			$('tr.inbody').click(function(){
				var inum = $(this).children().eq(0).text();
				if(! isNaN(inum)){
					location.href = '${conPath }/inbodyContent.do?inum='+inum; // table tr click event
				}
			});
		});
	</script>
	<script src="https://www.gstatic.com/charts/loader.js"></script>
</head>
<body>
	<c:if test="${empty member}">
		<script>
			location.href='${conPath}/loginView.do?next=inbodyList.do';
		</script>
	</c:if>
	<c:if test="${not empty inbodyResult }">
		<script>
			alert('${inbodyResult}');
		</script>
	</c:if>
	<c:if test="${not empty inbodyError }">
		<script>
			alert('${inbodyError}');
			history.back();
		</script>
	</c:if>
	<div id="content">
	<jsp:include page="../main/header.jsp"/>
  <div id="chart_div"></div>
		<table>
			<tr>
				<th>몸무게(kg)</th><th>체지방률(kg)</th><th>골격근량(kg)</th><th>날짜</th>
			</tr>
			<c:forEach var="dto" items="${inbody }">
				<tr class="inbody">
					<td>${dto.inum }</td>
					<td>${dto.iweight}kg</td>
					<td>${dto.ifat}</td>
					<td>${dto.imuscle}</td>
					<td>${dto.idate}</td>
				</tr>
			</c:forEach>
			<tr>
				<td colspan="5">
					<input type="button" value="기록 추가" class="btn" onclick="location.href='${conPath}/inbodyWriteView.do'">
				</td>
			</tr>
		</table>
	</div>
	<jsp:include page="../main/footer.jsp"/>	
</body>
</html>