<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
	
<!DOCTYPE html>
<html>
<head>
<title>마이페이지</title>
<link href="/resources/css/user/mypage.css" rel="stylesheet" />


<%@ include file="/WEB-INF/views/common/include.jsp"%>
</head>
<body>
	<jsp:include page="/WEB-INF/views/common/header.jsp" />

	<%@ include file="/WEB-INF/views/member/mypage/mypage-header.jsp"%>
	
<div class="container bg-white mb-4" style="margin-top : 50px;">
  <div class="row justify-content-center text-center">
    <div class="col-xl-4 text-center">
      <h1>내 정보</h1> 
      
  
      <table class="table table-responsive">
        <tbody>
          <tr>
            <td><i class="fa-solid fa-user"></i><strong> 이름</strong></td>
            <td><c:out value="${loginUser.memberName}" /></td>
          </tr>
          <tr>
            <td><i class="fa-solid fa-signature"></i><strong> 닉네임</strong></td>
            <td><c:out value="${loginUser.nickName}" /></td>
          </tr>
          <tr>
            <td><i class="fa-regular fa-id-badge"></i><strong> 아이디</strong></td>
            <td><c:out value="${loginUser.memberId}" /></td>
          </tr>
          <tr>
            <td><i class="fa-solid fa-envelope"></i><strong> 이메일</strong></td>
            <td><c:out value="${loginUser.email}" /></td>
          </tr>
          <tr>
            <td><i class="fa-solid fa-phone"></i><strong> 휴대폰 번호</strong></td>
            <c:set var="phone" value="${loginUser.phone}"/>
            <td><span id="formattedPhone"></span></td>
          </tr>
          <tr>
            <td><i class="fa-solid fa-venus-mars"></i><strong> 성별</strong></td>
            <td><c:out value="${loginUser.gender eq 'M' ? '남자' : '여자'}" /></td>
          </tr>
          <c:if test="${empty loginUser.naverLogin && empty loginUser.googleLogin}">
            <tr>
              <td><strong>소셜로그인 상태</strong></td>
              <td><i class="fa-solid fa-circle-xmark" style="color: #ff0000;"></i> 연결되지 않음</td>
            </tr>
          </c:if>
          <c:if test="${not empty loginUser.naverLogin}">
            <tr>
              <td><i class="fa-solid fa-check-circle" style="color: #00ff00;"></i><strong> 소셜로그인 상태</strong></td>
              <td><span style="vertical-align: -5px;"><img src="<c:url value='/resources/img/member/naverBtn.png' />" style="width: 20px; height: 20px;" /></span> 연결됨</td>
            </tr>
          </c:if>
          <c:if test="${not empty loginUser.googleLogin}">
            <tr>
              <td><i class="fa-solid fa-check-circle" style="color: #00ff00;"></i><strong> 소셜로그인 상태</strong></td>
              <td><span style="vertical-align: -5px;"><img src="<c:url value='/resources/img/common/google.jpg' />" style="width: 20px; height: 20px;" /></span> 연결됨</td>
            </tr>
          </c:if>
          <tr>
            <td><i class="fa-solid fa-coins"></i><strong> 보유 포인트</strong></td>
            <td><c:out value="${loginUser.memberPoint}" />원 보유중 <a href="<c:url value='/event.ev' />">사용하기</a></td>
          </tr>
          <tr>
            <td><i class="fa-solid fa-calendar"></i><strong> 최근 로그인 날짜</strong></td>
            <td><fmt:formatDate value="${loginUser.loginDate}" pattern="yy/MM/dd aa h시 mm분" /></td>
          </tr>
          
          <tr>
 
          <td>
			  <div class="form-check">
			    <input class="form-check-input" type="radio" name="flexRadioDefault" id="flexRadioDefault1" ${result == 1 ? 'checked' : ''}>
			    <label class="form-check-label" for="flexRadioDefault1">
			      알림 켜기
			    </label>
			  </div>
			</td>
			
			<td>
			  <div class="form-check">
			    <input class="form-check-input" type="radio" name="flexRadioDefault" id="flexRadioDefault2" ${result != 1 ? 'checked' : ''}>
			    <label class="form-check-label" for="flexRadioDefault2">
			      알림 끄기
			    </label>
			  </div>
			</td>
				
          </tr>
        </tbody>
      </table>
      
      
      
      
      
      <div class="d-flex justify-content-center" style="margin-bottom: 20px;">
        <a class="btn btn-info" data-bs-toggle="modal" data-bs-target="#myModal" style="width: 48%; margin-right : 5px;">수정하기</a>
       
        <c:choose>
			<c:when test="${loginUser.adminAuth eq 1 }">
				 <a class="btn btn-primary" data-bs-toggle="modal" data-bs-target="#confirmModal" style="width: 48%; pointer-events : none; background : gray">탈퇴하기</a>
			</c:when>
			
			<c:otherwise>
			 <a class="btn btn-primary" data-bs-toggle="modal" data-bs-target="#confirmModal" style="width: 48%;">탈퇴하기</a>
			</c:otherwise>
		</c:choose>
		

      </div>
    </div>
  </div>
</div>
<div style="height : 150px;"></div>

<div class="modal fade" id="confirmModal" tabindex="-1" aria-labelledby="confirmModalLabel" aria-hidden="true">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-header bg-danger text-white">
        <h5 class="modal-title" id="confirmModalLabel">
          <span class="text-warning"><i class="fas fa-exclamation-triangle me-2"></i></span>
          탈퇴 확인
        </h5>
        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
      </div>
      <form action="/mypage/deleteMember" method="POST">
      <div class="modal-body">
        <p>아이디를 삭제하면 다시 복구할 수 없습니다.</p>
        <p>탈퇴를 진행하려면 비밀번호를 입력해주세요</p>
        <input type="password" id="passwordInput" name="memberPwd" class="form-control">
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">취소하기</button>
        <button type="submit" class="btn btn-danger" onclick="return confirmWithdrawal()">탈퇴하기</button>
      </div>
     </form>
      
    </div>
  </div>
  
  
</div>


<script>
function confirmWithdrawal() {
  // 비밀번호 입력값 가져오기
  var password = document.getElementById("passwordInput").value;
  
  if (password.trim().length === 0) {
	    alert("비밀번호를 입력해주세요.");
	    return false; // 함수 종료
	  }
  
var confirmed = confirm("정말로 삭제하시겠습니까? 삭제 시 되돌릴 수 없습니다.");
  
  if (confirmed) {
    return true; // submit 계속 진행
  } else {
    return false; // submit 취소
  }
  
}


</script>


<script>
  // 휴대폰 번호 포맷팅 함수
  function formatPhoneNumber(phoneNumber) {
    let formattedNumber = '';
    if (phoneNumber.length === 10) {
      formattedNumber = phoneNumber.replace(/(\d{3})(\d{3})(\d{4})/, '$1-$2-$3');
    } else if (phoneNumber.length === 11) {
      formattedNumber = phoneNumber.replace(/(\d{3})(\d{4})(\d{4})/, '$1-$2-$3');
    }
    return formattedNumber;
  }

  // 페이지 로드 시 휴대폰 번호 포맷팅
  window.onload = function() {
    const phoneNumber = "${phone}";
    const formattedPhoneNumber = formatPhoneNumber(phoneNumber);
    document.getElementById("formattedPhone").textContent = formattedPhoneNumber;
  };
</script>

<script>
  $(document).ready(function() {
    $('.form-check-input').on('change', function() {
      var setAlarmValue = $(this).val(); // Assuming the form check inputs have a value attribute
      var email = '${loginUser.email}'; // Replace with the actual memberId value
      
      // AJAX request
      $.ajax({
        type: 'POST',
        url: '/mypage/setAlarm',
        data: {
        	email: email,
        },
        success: function(response) {
        	console.log(response);
        },
        error: function(xhr, status, error) {
          console.log('An error occurred during the AJAX request.');
        }
      });
    });
  });
</script>



	<jsp:include page="/WEB-INF/views/common/footer.jsp" />
</body>
</html>
