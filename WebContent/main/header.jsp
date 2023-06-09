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
	<link href="${conPath}/css/header.css" rel="stylesheet" type="text/css">
	<script src="https://code.jquery.com/jquery-3.6.4.min.js"></script>
	<script>
		$(function(){
			
		});
	</script>
<head>
	<meta charset="UTF-8">
	<title>Insert title here</title>
</head>
<body>
<header>
	<c:if test="${empty member and empty admin}"> <%-- 로그인 전 화면 --%>
		<div class="gnb">
			<ul>
				<li><a href="${conPath }/joinView.do">회원가입</a></li>
				<li><a href="${conPath }/loginView.do">로그인</a></li>
			</ul>
		</div>
	<div class="logo">
			<a href="${conPath}/main.do">
				<img alt="로고" src="${conPath }/img/EXSecretary.png" width="115px">
			</a>
		</div>
		<div class="lnb">
			<ul>
				<li><a href="loginView.do?next=exBoardList.do">자유게시판</a></li>
				<li><a href="loginView.do?next=inbodyList.do">나의 변화</a></li>
				<li><a href="loginView.do?next=exRecordList.do">운동기록</a></li>
				<li><a href="loginView.do?next=exView.do">운동하기</a></li>
			</ul>
		</div>
	</c:if>
	<c:if test="${not empty member and empty admin}"> <%-- 회원 로그인 화면 --%>
		<div class="gnb">
			<ul>
				<li><a href="${conPath }/logout.do">로그아웃</a></li>
				<li><span>${member.mname }님 오늘도 즐거운 운동 되세요.</span></li>
			</ul>
		</div>
		<div class="logo">
			<a href="${conPath}/main.do">
				<img alt="로고" src="${conPath }/img/EXSecretary.png" width="115px">
			</a>
		</div>
		<div class="lnb">
			<ul>
				<li><a href="memberView.do">마이페이지</a></li>
				<li><a href="exBoardList.do">자유게시판</a></li>
				<li><a href="inbodyList.do">나의 변화</a></li>
				<li><a href="exRecordList.do">운동기록</a></li>
				<li><a href="exView.do">운동하기</a></li>
			</ul>
		</div>
	</c:if>
	<c:if test="${empty member and not empty admin}"> <%-- 관리자 로그인 화면 --%>
		<div class="gnb">
			<ul>
				<li><a href="${conPath }/logout.do">로그아웃</a></li>
				<li><span>환영합니다 ${admin.aname }님</span></li>
			</ul>
		</div>
		<div class="logo">
			<a href="${conPath}/main.do">
				<img alt="로고" src="${conPath }/img/EXSecretary.png" width="115px">
			</a>
		</div>
		<div class="lnb">
			<ul>
				<li><a href="exPartList.do">운동관리</a></li>
				<li><a href="exBoardList.do">자유게시판</a></li>
				<li><a href="mAllView.do">회원목록</a></li>
			</ul>
		</div>
	</c:if>
</header>
</body>
</html>