<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>

<head>
<meta charset="UTF-8">
<title>쉐어하우스 쉼</title>
<%@ include file="/WEB-INF/views/common/include.jsp"%>
<link href="/resources/css/user/signup.css" rel="stylesheet" />

<style>
.error {
	color: red;
}

.error-text {
	font-size : 0.75rem;
	margin-bottom : 0;
}

.form-error {
	color : red;
	font-size : 0.75rem;

}
</style>
</head>

<body>
	<jsp:include page="/WEB-INF/views/common/header.jsp" />

	<div class="container" style="margin-bottom: 60px; margin-top : 120px;">
		<div class="row justify-content-center">
			<div class="col">
				<h2 class="text-center mb-4" style="margin-left: 60px;">회원가입</h2>
				<form:form action="/member/joinSuccess" modelAttribute="member"
					method="POST" onsubmit="return validate()">

					<div class="form-group row mb-3">
						<label for="id" class="col-sm-4 col-form-label text-end">아이디<span
							class="text-red">*</span></label>
						<div class="col-sm-5">

							<form:input type="text" autocomplete="on" class="form-control"
								id="id" placeholder="아이디를 입력해주세요" path="memberId" />
							
							<p class="error-text error-msg" id="info_id"></p>
							<form:errors class="form-error" path="memberId"/>
						</div>
						<div class="col-sm-3 p-0">
							<button type="button" class="join-btn" id="idDuplicateButton">중복확인</button>
						</div>
					</div>
					<div class="form-group row mb-3">
						<label for="password" class="col-sm-4 col-form-label text-end">비밀번호<span
							class="text-red">*</span></label>
						<div class="col-sm-5">
							<form:input type="password" autocomplete="new-password"
								class="form-control" id="password" placeholder="비밀번호를 입력해주세요"
								path="memberPwd" />

							<!-- <p class="error-text">최소 10자 이상 입력</p> -->
							<p class="error-text" id="info_pw"></p>
							<form:errors class="form-error" path="memberPwd"/>
						</div>
					</div>
					<div class="form-group row mb-3">
						<label for="password-check"
							class="col-sm-4 col-form-label text-end">비밀번호확인<span
							class="text-red">*</span></label>
						<div class="col-sm-5">
							<form:input type="password" autocomplete="new-password"
								class="form-control" id="password-check" name="pwdConfirm"
								placeholder="비밀번호를 한번 더 입력해주세요" path="pwdConfirm" />
							<!-- <p class="error-text">최소 10자 이상 입력</p> -->
							<p class="error-text" id="info_pw_check"></p>
							<form:errors class="form-error" path="pwdConfirm"/>
						</div>
					</div>
					<div class="form-group row mb-3">
						<label for="name" class="col-sm-4 col-form-label text-end">이름<span
							class="text-red">*</span></label>
						<div class="col-sm-5">
							<form:input type="text" autocomplete="off" class="form-control"
								id="name" placeholder="이름을 입력해주세요" path="memberName" />
							<p class="error-text" id="info_name"></p>
							<form:errors class="form-error" path="memberName"/>
						</div>
					</div>

					<div class="form-group row mb-3">
						<label for="email" class="col-sm-4 col-form-label text-end">이메일<span
							class="text-red">*</span></label>
						<div class="col-sm-5">
							<form:input type="email" class="form-control" id="email"
								placeholder="이메일을 입력해주세요" path="email" />
							<p class="error-text" id="info_email"></p>
							<form:errors class="form-error" path="email"/>
						</div>
						<div class="col-sm-3 p-0">
							<button type="button" class="join-btn" id="emailDuplicateButton">중복확인</button>
						</div>
					</div>

					<div class="form-group row mb-3">
						<label for="phone" class="col-sm-4 col-form-label text-end">휴대폰<span
							class="text-red">*</span></label>
						<div class="col-sm-5">
							<form:input type="text" class="form-control" id="phone"
								placeholder="번호를 입력해주세요" path="phone" />
							<p class="error-text" id="info_phone"></p>
							<form:errors class="form-error" path="phone"/>
						</div>
						<div class="col-sm-3 p-0">
							<button type="button" class="join-btn" id="phoneDuplicateButton">중복확인</button>
						</div>
					</div>

					<div class="form-group row mb-3">
						<label for="area" class="col-sm-4 col-form-label text-end">희망지역</label>
						<div class="col-sm-5">
							<input type="text" class="form-control" name="area"
								id="area" placeholder="희망지역을 입력해주세요" readonly onclick="triggerSearch();">
							<p class="good-text" id="info_area">희망지역의 쉐어하우스를 우선적으로
								추천해드려요!</p>
						</div>
						<div class="col-sm-3 p-0">
							<button type="button" class="join-btn" onclick="searchAddr();">
								<i class="fa-solid fa-magnifying-glass" style="font-size: 12px"></i>
								검색
							</button>
						</div>
					</div>
					<div class="form-group row">
						<label for="flexRadioDefault1"
							class="col-sm-4 col-form-label text-end">성별<span
							class="text-red">*</span></label>
						<div class="col-sm-5 d-flex align-items-center">
							<input class="form-check-input offset-3"
								style="width: 25px; height: 25px;" type="radio" value="M"
								name="gender" id="flexRadioDefault1" checked>
							<label class="form-check-label" for="flexRadioDefault1">
								&nbsp;남자 </label> <input class="form-check-input offset-3"
								style="width: 25px; height: 25px;" type="radio" value="F"
								name="gender" id="flexRadioDefault2"> <label
								class="form-check-label" for="flexRadioDefault2">
								&nbsp;여자 </label>
						</div>

					</div>
					<br>
					<div class="form-group row">
						<label for="birth-year" class="col-sm-4 col-form-label text-end">생년월일<span
							class="text-red">*</span></label>
						<div class="col-sm-5 d-flex align-items-center offset-1">
							<div class="info" id="info__birth" align="center">
								<div style="display: inline-block">
									<select class="form-select" id="birth-year">
										<option disabled selected>출생 연도</option>
									</select>
								</div>
								<div style="display: inline-block">
									<select class="form-select" id="birth-month">
										<option disabled selected>월</option>
									</select>
								</div>
								<div style="display: inline-block">
									<select class="form-select" id="birth-day">
										<option disabled selected>일</option>
									</select>
								</div>
								<div class="error-msg"></div>
                
								<form:input type="hidden" name="birthDate" id="birth-date-input"
									path="birth" />
								<form:errors class="form-error" path="birth"/>

							</div>
						</div>
					</div>

					<br>
					<br>


					<div class="text-center mt-4">

						<button type="submit" class="btn btn-primary btn-block submit-btn"
							disabled>가입하기</button>

					</div>
				</form:form>
			</div>
		</div>
	</div>
	

	<script>
	// Function to enable/disable the duplicateButton
	function setDuplicateButtonState(enabled, field) {
	  $("#" + field + "DuplicateButton").prop("disabled", !enabled);
	}

	// Function to enable/disable the submit button
	function setSubmitButtonState(enabled) {
	  $(".submit-btn").prop("disabled", !enabled);
	}

	var isIdAvailable = false;
	var isEmailAvailable = false;
	var isPhoneAvailable = false;

	// Function to check ID duplication
	function checkIdDuplicate(id) {
	  return $.ajax({
	    url: "/member/idCheck",
	    type: "post",
	    data: {
	      id: id
	    }
	  });
	}

	// Function to check email duplication
	function checkEmailDuplicate(email) {
	  return $.ajax({
	    url: "/member/emailCheck",
	    type: "post",
	    data: {
	      email: email
	    }
	  });
	}
	
	
	function checkPhoneDuplicate(phone) {
		  return $.ajax({
		    url: "/member/phoneCheck",
		    type: "post",
		    data: {
		      phone: phone
		    }
		  });
		}

	// Function to handle ID changes
	function handleIdChange() {
	  var id = $("#id").val();
	  var isValidId = /^[a-zA-Z0-9]{6,20}$/.test(id);

	  const idErrorMsgEl = document.querySelector('#info_id');

	  setDuplicateButtonState(isValidId, "id"); // Enable/disable duplicateButton based on ID validity
	  setSubmitButtonState(false); // Disable the submit button when ID changes
	  idErrorMsgEl.style.color = 'rgba(255,0,0, 0.8)';
	  idErrorMsgEl.textContent = errMsg.id.invalid;
	  isIdAvailable = false;
	}

	// Function to handle email changes
	function handleEmailChange() {
	  var email = $("#email").val();
	  var isValidEmail = /^[A-Z0-9._%+-]+@[A-Z0-9.-]+\.[A-Z]{2,}$/i.test(email);

	  setDuplicateButtonState(isValidEmail, "email"); // Enable/disable duplicateButton based on email validity
	  setSubmitButtonState(false); // Disable the submit button when email changes
	  isEmailAvailable = false;
	}
	
	function handlePhoneChange() {
		  var phone = $("#phone").val();
		  var isValidPhone = /^01([0|1|6|7|8|9])-?([0-9]{3,4})-?([0-9]{4})$/.test(phone);

		  setDuplicateButtonState(isValidPhone, "phone"); // Enable/disable duplicateButton based on ID validity
		  setSubmitButtonState(false); // Disable the submit button when ID changes
		  isPhoneAvailable = false;
		}
	

	
	
	

	// Function to handle ID duplicateButton clicks
	function handleIdDuplicateButtonClick() {
	  var id = $("#id").val();

	  if (id && !$("#idDuplicateButton").prop("disabled")) {
	    checkIdDuplicate(id).then(function(data) {
	      const idErrorMsgEl = document.querySelector('#info_id');

	      if (data === 'Duplicate') {
	        toastr.error("이미 사용중인 아이디입니다.");
	        setDuplicateButtonState(true, "id"); // Enable ID duplicateButton
	        setSubmitButtonState(false); // Disable the submit button when ID is duplicate
	        idErrorMsgEl.style.color = 'rgba(255,0,0, 0.8)';
	        idErrorMsgEl.textContent = errMsg.id.fail;
	        isIdAvailable = false;
	      } else {
	        toastr.success("사용 가능한 아이디입니다.");
	        setDuplicateButtonState(false, "id"); // Enable ID duplicateButton
	        isIdAvailable = true;
	        checkSubmitButtonState(); // Check if both ID and email are validated for enabling submit button
	        idErrorMsgEl.style.color = 'rgb(113, 197, 98)';
	        idErrorMsgEl.textContent = errMsg.id.success;
	      }
	    });
	  } else {
	    setSubmitButtonState(false); // Disable the submit button if ID duplicateButton is disabled
	  }
	}

	// Function to handle email duplicateButton clicks
	function handleEmailDuplicateButtonClick() {
	  var email = $("#email").val();

	  if (email && !$("#emailDuplicateButton").prop("disabled")) {
	    checkEmailDuplicate(email).then(function(data) {
	      const emailErrorMsgEl = document.querySelector('#info_email');

	      if (data === 'Duplicate') {
	        toastr.error("이미 사용중인 이메일입니다.");
	        setDuplicateButtonState(true, "email"); // Enable ID duplicateButton
	        setSubmitButtonState(false); // Disable the submit button when email is duplicate
	        emailErrorMsgEl.style.color = 'rgba(255,0,0, 0.8)';
	        emailErrorMsgEl.textContent = errMsg.email.fail;
	        isEmailAvailable = false;
	      } else {
	        toastr.success("사용 가능한 이메일입니다.");
	        setDuplicateButtonState(false, "email"); // Enable ID duplicateButton
	        isEmailAvailable = true;
	        checkSubmitButtonState(); // Check if both ID and email are validated for enabling submit button
	        emailErrorMsgEl.style.color = 'rgb(113, 197, 98)';
	        emailErrorMsgEl.textContent = errMsg.email.success;
	      }
	    });
	  } else {
	    setSubmitButtonState(false); // Disable the submit button if email duplicateButton is disabled
	  }
	}
	
	function handlePhoneDuplicateButtonClick() {
		  var phone = $("#phone").val();

		  if (phone && !$("#phoneDuplicateButton").prop("disabled")) {
		    checkPhoneDuplicate(phone).then(function(data) {
		    	const phoneErrorMsgEl = document.querySelector('#info_phone');
		    	console.log(data);
		      if (data === 'Duplicate') {
		        toastr.error("이미 사용중인 번호입니다.");
		        setDuplicateButtonState(true, "phone"); // Enable ID duplicateButton
		        setSubmitButtonState(false); // Disable the submit button when email is duplicate
		        phoneErrorMsgEl.style.color = 'rgba(255,0,0, 0.8)';
		        phoneErrorMsgEl.textContent = errMsg.phone.fail;
		        isPhoneAvailable = false;
		      } else {
		        toastr.success("사용 가능한 번호입니다.");
		        setDuplicateButtonState(false, "phone"); // Enable ID duplicateButton
		        isPhoneAvailable = true;
		        checkSubmitButtonState(); // Check if both ID and email are validated for enabling submit button
		        phoneErrorMsgEl.style.color = 'rgb(113, 197, 98)';
		        phoneErrorMsgEl.textContent = errMsg.phone.success;
		      }
		    });
		  } else {
		    setSubmitButtonState(false); // Disable the submit button if email duplicateButton is disabled
		  }
		}
	

	// Function to check both ID and email validations for enabling submit button
	function checkSubmitButtonState() {
	  if (isIdAvailable && isEmailAvailable && isPhoneAvailable) {
	    setSubmitButtonState(true); // Enable the submit button when both ID and email are available
	  } else {
	    setSubmitButtonState(false); // Disable the submit button if either ID or email is not available
	  }
	}

	// Event handler for ID changes
	$("#id").on("input", handleIdChange);

	// Event handler for email changes
	$("#email").on("input", handleEmailChange);
	
	$("#phone").on("input", handlePhoneChange);

	// Event handler for ID duplicateButton clicks
	$("#idDuplicateButton").on("click", handleIdDuplicateButtonClick);

	// Event handler for email duplicateButton clicks
	$("#emailDuplicateButton").on("click", handleEmailDuplicateButtonClick);
	
	$("#phoneDuplicateButton").on("click", handlePhoneDuplicateButtonClick);

	// Initialize button states
	setDuplicateButtonState(true, "id");
	setDuplicateButtonState(true, "email");
	setDuplicateButtonState(true, "phone");
	setSubmitButtonState(false);

	

	const errMsg = {
    	    id: { 
    	        invalid: "6~20자의 영문 소문자와 숫자만 사용 가능합니다",
    	        success: "사용 가능한 아이디입니다",
    	        fail: "이미 사용중인 아이디입니다."
    	    },
    	    pw: "8~20자의 영문, 숫자, 특수문자를 모두 포함한 비밀번호를 입력해주세요",
    	    pwRe: {
    	        success: "비밀번호가 일치합니다",
    	        fail: "비밀번호가 일치하지 않습니다",
    	        check: "비밀번호를 다시 확인해주세요"
    	    },
    	    name : {
    	        success : "사용 가능한 이름입니다",
    	        fail : "이름을 다시 확인해주세요",
    	    },

    	    email : {
    	        success : "사용 가능한 이메일입니다",
    	        fail : "이미 사용중인 이메일입니다",
    	    },

    	    phone : {
    	        success : "사용 가능한 휴대폰번호입니다",
    	        fail : "휴대폰번호를 다시 확인해주세요",
    	    },
    	    birth: "생년월일을 다시 확인해주세요",
    	    mobile: "‘-’ 제외 11자리를 입력해주세요"
    	    };
	

	// 핸드폰 정규식 검사
    const phoneInputEl = document.querySelector('#phone');
    const phoneErrorMsgEl = document.querySelector('#info_phone');

    	phoneInputEl.addEventListener('change', () => {
        const regPhone = /^01([0|1|6|7|8|9])-?([0-9]{3,4})-?([0-9]{4})$/;

        //핸드폰번호가 12글자를넘어서면
        if(phoneInputEl.value.length > 11) {
            phoneErrorMsgEl.style.color = 'rgba(255,0,0, 0.8)';
            alert("휴대폰 번호를 다시 확인해주세요");
            //11글자전까지 다 지운다
            phoneInputEl.value = phoneInputEl.value.slice(0,11);
            phoneInputEl.focus();
            //숫자 이외에 다른 문자가 들어오면
        } 
        
        if(isNaN(phoneInputEl.value)) {
            phoneErrorMsgEl.style.color = 'rgba(255,0,0, 0.8)';
            alert("숫자만 입력해주세요");
            phoneInputEl.value = "";
            phoneInputEl.focus();
        }
        });
    	
    	
    	function triggerSearch() {
		    document.getElementById("area").blur(); // input 박스의 포커스 해제
		    searchAddr(); // 검색 함수 호출
		}
	</script>

	<script src="/resources/js/user/signup.js"></script>
	

	<jsp:include page="/WEB-INF/views/common/footer.jsp" />

</body>
</html>