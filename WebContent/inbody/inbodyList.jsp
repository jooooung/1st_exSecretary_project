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
	<script src="https://code.jquery.com/jquery-3.6.4.min.js"></script>
	<script>
		$(function(){
			$('tr.inbody').click(function(){
				var inum = $(this).children().eq(0).text();
				if(! isNaN(inum)){
					location.href = '${conPath }/inbodyContent.do?inum='+inum;
				}
			});
		});
	</script>
</head>
<body>
	<c:if test="${empty member}">
		<script>
			location.href='${conPath}/loginView.do?next=inbodyList.do';
		</script>
	</c:if>
	<c:if test="${not empty inbodyWriteResult }">
		<script>
			alert('${inbodyWriteResult}');
		</script>
	</c:if>
	<c:if test="${not empty inbodyWriteError }">
		<script>
			alert('${inbodyWriteError}');
			history.back();
		</script>
	</c:if>
	<c:if test="${not empty inbodyModifyResult }">
		<script>
			alert('${inbodyModifyResult }');
		</script>
	</c:if>
	<c:if test="${not empty inbodyModifyError }">
		<script>
			alert('${inbodyModifyError}');
			history.back();
		</script>
	</c:if>
	<c:if test="${not empty inbodyDeleteResult }">
		<script>
			alert('${inbodyDeleteResult }');
		</script>
	</c:if>
	<c:if test="${not empty inbodyDeleteError}">
		<script>
			alert('${inbodyDeleteError}');
			history.back();
		</script>
	</c:if>
	<jsp:include page="../main/header.jsp"/>
	<div id="content">
	<script src="https://www.gstatic.com/charts/loader.js"></script>
	<script type="text/javascript" src="${conPath }/inbody/chart.js"></script>
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