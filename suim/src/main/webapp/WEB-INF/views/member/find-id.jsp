<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>아이디 찾기</title>
<%@ include file="/WEB-INF/views/common/include.jsp" %>
<link rel="stylesheet" href="/resources/css/user/login.css">
</head>
<body>

	<jsp:include page="/WEB-INF/views/common/header.jsp"/>
    
    <div class="container py-5" style="margin-top: 120px;">
  <div class="row justify-content-center">
    <div class="col-md-4">
      <div class="text-center mb-4">
        <h2 style="margin-bottom: 50px;">아이디 찾기</h2>
      </div>
      <div id="result-container" class="text-center"></div>
      <form>
        <div class="row">
          <div class="col-md-12">
            <div class="mb-4">
              <label for="inputName" class="form-label">이름</label>
              <input type="text" class="form-control" id="inputName" placeholder="이름을 입력하세요" style="height: 56px;">
            </div>
          </div>
          <div class="col-md-12">
            <div class="mb-4">
              <label for="inputEmail" class="form-label">이메일</label>
              <input type="email" class="form-control" id="inputEmail" placeholder="이메일을 입력하세요" style="height: 56px;">
            </div>
          </div>
          <div class="col-md-12">
            <div class="mb-4 text-center">
              <button type="submit" class="btn btn-primary" style="width: 100%;">아이디 찾기</button>
            </div>
          </div>
        </div>
      </form>
    </div>
  </div>
</div>

      
      
    <script>
    
    $(document).ready(function() {
      $('form').submit(function(event) {
        event.preventDefault(); // 폼 제출 이벤트 막기

        var name = $('#inputName').val();
        var email = $('#inputEmail').val();

        // AJAX 요청 수행
        $.ajax({
          type: 'POST',
          url: '/member/findId', // 서버 측 파일 경로
          data: { memberName : name, email: email }, // 전송할 데이터
          success: function(response) {
        	  console.log(response)
            if (response.length != 0) {
              // 일치하는 아이디가 있을 경우
            	$('#result-container').html('<p style="margin-bottom : 50px; margin-top : 120px;">회원님의 아이디는 <span style="color: red;">' + response + '</span> 입니다.</p>');
    
            	// 로그인 버튼 생성
            	var loginButton = $('<a/>', {
            	  class: 'btn btn-primary',
            	  style: 'margin-right: 10px',
            	  text: '로그인하기',
            	  href: '/member/login'
            	});

            	// 비밀번호 찾기 버튼 생성
            	var passwordButton = $('<a/>', {
            	  class: 'btn btn-primary',
            	  text: '비밀번호 찾기',
            	  href: '/member/findPw'
            	});

            	// 생성한 버튼들을 'result-container'에 추가
            	$('#result-container').append(loginButton, passwordButton);

            	$('form').remove(); // 폼 요소 제거
            } else {
              // 일치하는 아이디가 없을 경우
              alert('일치하는 회원이 없습니다.');
            }
          },
          error: function() {
            alert('요청을 처리하는 동안 오류가 발생했습니다.');
          }
        });
      });
    });
    
    </script>     
	
	<jsp:include page="/WEB-INF/views/common/footer.jsp"/>

</body>
</html>