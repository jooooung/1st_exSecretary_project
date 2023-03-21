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
<head>
	<meta charset="UTF-8">
	<title>Insert title here</title>
	<style>
		footer {
			color: white;
			width: 500px;
			margin:0 auto;
			height: 80px;
			position : relative;
		  transform : translateY(-100%);
		}
		#footer_conts ul{
			overflow: hidden;
			text-align: center;
			
		}
		#footer_conts ul li{
			list-style: none;
			float: left;
		}
		
		
	</style>
</head>
<body>
<footer>
	<div id="footer_conts">
		<ul>
			<li>
				<img alt="로고" src="${conPath }/img/EXSecretary.png" width="115px">
			</li>
			<li>			
			<p>(주)운동비서</p>
			<p>
				경기도 고양시 어떤로 9 좋은빌딩 1-5F | <b>
			</p>
			<p>Copyright© 2023 tj . All rights reserved.</p>
			<li>
		</ul>
	</div>
</footer>
</body>
</html>