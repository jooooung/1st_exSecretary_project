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
		#content form{height: 1000px;}
		#content input[type="radio"]{
			width: 15px;
			margin: 5px;
		}
	</style>
  <script src="https://code.jquery.com/jquery-3.6.0.js"></script>
	<script>
		$(function(){
			$('#mid').keyup(function(){
	  			var mid = $(this).val();
	  			if(mid.length < 3){
	  				$('#midConfirmResult').text('id를 3글자 이상 입력하세요')
	  			}else{
	  				$.ajax({
	  					url : "${conPath}/midConfirm.do",
	  					type : 'get',
	  					data : 'mid='+mid,
	  					dataType : 'html',
	  					success : function(data){
	  						$('#midConfirmResult').html(data);
	  					},
	  				}); // $.ajax
	  			} // if
	  		}); // #mid keyup event
	  		
	  		$('#mpw, #mpwChk').keyup(function(){
	  			var mpw = $('#mpw').val();
	  			var mpwChk = $('#mpwChk').val();
	  			if(mpw != '' && mpwChk != '' && mpw == mpwChk){
	  				$('#mpwChkResult').text('비밀번호 일치');
	  			}else{
	  				$('#mpwChkResult').html('<b>비밀번호 불일치</b>');
	  			}  // if
	  		}); // mpw, mpwChk keyup
		
		$('form').submit(function(){
  			var midConfirmResult = $('#midConfirmResult').text().trim();
  			var mpwChkResult = $('#mpwChkResult').text().trim();
  			if(midConfirmResult != '사용가능한 ID입니다'){
  				alert('ID를 확인하세요');
  				$('#mid').focus();
  				return false;		// submit 제한
  			}else if(mpwChkResult != '비밀번호 일치'){
  				alert('비밀번호를 확인하세요');
  				$('#mpw').focus();
  				return false;		// submit 제한
  			} // if
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
	<jsp:include page="../main/header.jsp"/>
	<div id="content">
		<form action="join.do" method="post" enctype="multipart/form-data">
			<input type="hidden" name="next" value="${param.next }">
			<table>
				<caption>회원가입</caption>
				<tr>
					<th>아이디</th>
					<td>
						<input type="text" name="mid" id="mid" class="mid""
										placeholder="아이디를 입력해주세요" required="required">
						<div id="midConfirmResult"> &nbsp; &nbsp; &nbsp; </div>
					</td>
				</tr>
				<tr>
						<th><label for="mpw">비밀번호</label></th>
						<td>
							<input type="password" name="mpw" id="mpw" class="mpw" required="required">
						</td>
					</tr>
					<tr>
						<th><label for="mpwChk">확인비밀번호</label></th>
						<td>
							<input type="password" name="mpwChk" id="mpwChk" class="mpwChk" required="required">
							<div id="mpwChkResult"> &nbsp; &nbsp; &nbsp; </div>
						</td>
					</tr>
					<tr>
						<th><label for="mname">이름</label></th>
						<td>
							<input type="text" name="mname" id="mname" class="mname" required="required">
						</td>
					</tr>
					<tr>
						<th><label for="mphoto">사진</label></th>
						<td>
							<input type="file" name="mphoto" id="mphoto" class="mphoto" onchange="checkSize(this)">
						</td>
					</tr>
					<tr>
						<th>전화번호</th>
						<td>
							<input type="text" name="mtel" id="mtel" class="mtel">
						</td>
					</tr>
					<tr>
						<th><label for="memail">메일</label></th>
						<td>
							<input type="email" name="memail" id="memail" class="memail">
							<div id="memailConfirmResult"> &nbsp; &nbsp; &nbsp; </div>
						</td>
					</tr>
					<tr>
						<th>성별</th>
						<td>
							<input type="radio" name="mgender" class="mgender" value="m"><b>남자</b>
							<input type="radio" name="mgender" class="mgender" value="f"><b>여자</b>
						</td>
					</tr>
					<tr>
						<th><label for="mbirth">생년월일</label></th>
						<td>
							<input type="text" name="mbirth" id="datepicker" class="mbirth">
						</td>
					</tr>
					<tr>
						<td colspan="2">
							<input type="submit" value="회원가입" class="btn">
							<input type="button" value="로그인" class="btn"
										 onclick="location.href='${conPath}/loginView.do'">
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