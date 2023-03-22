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
		#content form{height: 1100px;}
	</style>
	<script src="https://code.jquery.com/jquery-3.6.4.min.js"></script>
	<script>
		$(function(){
			$('#mpw, #mpwChk').keyup(function(){
	  			var mpw = $('#mpw').val();
	  			var mpwChk = $('#mpwChk').val();
	  			if(mpw != '' && mpwChk != '' && mpw == mpwChk){
	  				$('#mpwChkResult').text('비밀번호 일치');
	  			}else if(mpw == '' && mpwChk ==''){
	  				$('#mpwChkResult').html('');
	  			}else {
	  				$('#mpwChkResult').html('<b>비밀번호 불일치</b>');
	  			}  // if
	  		}); // mpw, mpwChk keyup
		$('form').submit(function(){
  			var mpwChkResult = $('#mpwChkResult').text().trim();
  			if(mpwChkResult != '비밀번호 일치' && mpwChkResult != ''){
  				alert('비밀번호를 확인하세요');
  				$('#mpw').focus();
  				return false;		// submit 제한
  			} // if(비밀번호 변경 시)
  		}); // form submit event
		});
		function checkSize(input) {
		    if (input.files && input.files[0].size > (3 * 1024 * 1024)) {
		        alert("용량이 3mb를 넘습니다.");
		        input.value = null;
		    }
			} // mphoto 업로드 용량 제한
	</script>
</head>
<body>
	<c:choose>
		<c:when test="${empty member}">
			<script>
				location.href='${conPath}/loginView.do?next=memberView.do';
			</script>
		</c:when>
		<c:when test="${not empty modifyErrorMsg}">
			<script>
				alert('${modifyErrorMsg}');
			</script>
		</c:when>
		<c:when test="${not empty modifyResult}">
			<script>
				alert('${modifyResult}');
			</script>
		</c:when>
	</c:choose>
	<jsp:include page="../main/header.jsp"/>
	<div id="content">
		<form action="modify.do" method="post" enctype="multipart/form-data">
			<input type="hidden" name="dbMpw" value="${member.mpw }">	<!-- 비밀번호 미 변경시 현 비밀번호로 -->
			<input type="hidden" name="dbMphoto" value="${member.mphoto }">	<!-- 프로필 미 변경시 현 프로필로 -->
			<table>
				<caption>마이페이지</caption>
				<tr>
					<th>아이디</th>
					<td>
						<input type="text" name="mid" id="mid" class="mid" value="${member.mid }"
										readonly="readonly">
					</td>
					<c:if test="${not empty member.mphoto }">
						<td rowspan="2">
	  					<img alt="${member.mname }사진" src="${conPath }/memberPhotoUp/${member.mphoto}" width="130px">
	  				</td>
					</c:if>
				</tr>
				<tr>
						<th><label for="oldMpw">비밀번호</label></th>
						<td>
							<input type="password" name="oldMpw" required="required">
						</td>
					</tr>
					<tr>
						<th><label for="mpw">새 비밀번호</label></th>
						<td colspan="2">
							<input type="password" name="mpw" id="mpw" class="mpw" size="30">
							<div id="mpwChkResult"> &nbsp; &nbsp; &nbsp; </div>
						</td>
					</tr>
					<tr>
						<th><label for="mpwChk">새 비밀번호 확인</label></th>
						<td colspan="2">
							<input type="password" name="mpwChk" id="mpwChk" class="mpwChk">
							<div id="mpwChkResult"> &nbsp; &nbsp; &nbsp; </div>
						</td>
					</tr>
					<tr>
						<th><label for="mname">이름</label></th>
						<td colspan="2">
							<input type="text" name="mname" id="mname" class="mname" required="required" value="${member.mname }">
						</td>
					</tr>
					<tr>
						<th><label for="mphoto">사진</label></th>
						<td colspan="2">
							<input type="file" name="mphoto" id="mphoto" class="mphoto" onchange="checkSize(this)">
						</td>
					</tr>
					<tr>
						<th>전화번호</th>
						<td colspan="2">
							<input type="text" name="mtel" id="mtel" class="mtel" value="${member.mtel }">
						</td>
					</tr>
					<tr>
						<th><label for="memail">메일</label></th>
						<td colspan="2">
							<input type="email" name="memail" id="memail" class="memail" value="${member.memail }">
							<div id="memailConfirmResult"> &nbsp; &nbsp; &nbsp; </div>
						</td>
					</tr>
					<tr>
						<th>성별</th>
						<td colspan="2">
						<c:if test="${member.mgender eq 'm'}">
							<input type="radio" name="mgender" class="mgender" value="m" checked="checked"><b>남자</b>
							<input type="radio" name="mgender" class="mgender" value="f"><b>여자</b>
						</c:if>
						<c:if test="${member.mgender eq 'f'}">
							<input type="radio" name="mgender" class="mgender" value="m"><b>남자</b>
							<input type="radio" name="mgender" class="mgender" value="f" checked="checked"><b>여자</b>
						</c:if>
						</td>
					</tr>
					<tr>
						<th><label for="mbirth">생년월일</label></th>
						<td colspan="2">
							<input type="text" name="mbirth" id="datepicker" class="mbirth" value="${member.mbirth }">
						</td>
					</tr>
					<tr>
						<th><label for="mrdate">가입일</label></th>
						<td colspan="2">
							<input type="text" name="mrdate" id="mrdate" class="mrdate" value="${member.mrdate}" readonly="readonly">
						</td>
					</tr>
					<tr>
						<td colspan="3">
							<input type="submit" value="정보수정" class="btn">
							<input type="button" value="회원탈퇴" class="btn" onclick="location.href='${conPath}/withdrawal.do'">
						</td>
					</tr>
			</table>
		</form>
	</div>
	<jsp:include page="../main/footer.jsp"/>
</body>
</html>
<link rel="stylesheet" href="//code.jquery.com/ui/1.13.2/themes/base/jquery-ui.css">
  <script src="https://code.jquery.com/ui/1.13.2/jquery-ui.js"></script>
	<script>
  $( function() {
	  $( "#datepicker" ).datepicker({
	    	dateFormat: "yy-mm-dd",
	    	monthNamesShort: ['1월', '2월', '3월', '4월', '5월', '6월', '7월', '8월', '9월', '10월', '11월', '12월'],
	    	dayNamesMin: [ "일", "월", "화", "수", "목", "금", "토" ],
	    	changeMonth: true, // 월을 바꿀수 있는 셀렉트 박스를 표시한다.
	    	changeYear: true, // 년을 바꿀 수 있는 셀렉트 박스를 표시한다.
	    	showMonthAfterYear: true,
	    	yearSuffix: '년',
	    	showOtherMonths: true, // 현재 달이 아닌 달의 날짜도 회색으로 표시
	    	minDate: '-100y',	 // 현재날짜로부터 100년이전까지 년을 표시한다.
	    	maxDate: 'y', // 'y' 또는 0 : 지금 이전의 날짜만 선택
	    	yearRange: 'c-100:c+10', // 년도 선택 셀렉트박스를 현재 년도에서 이전, 이후로 얼마의 범위를 
    }); // datepicker
  });
   </script>