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
</style>
</head>

<body>
	<jsp:include page="/WEB-INF/views/common/header.jsp" />

	<div class="container main" style="margin-bottom: 120px;">
		<div class="row justify-content-center">
			<div class="col">
				<h2 class="text-center mb-4" style="margin-left: 60px;">회원가입</h2>
				<form:form action="/member/joinSuccess" modelAttribute="member"
					method="POST" onsubmit="return validate()">

					<div class="form-group row">
						<label for="id" class="col-sm-4 col-form-label text-end">아이디<span
							class="text-red">*</span></label>
						<div class="col-sm-5">

							<form:input type="text" autocomplete="on" class="form-control"
								id="id" placeholder="아이디를 입력해주세요" path="memberId" />
              
							<p class="error-text error-msg" id="info_id"></p>
						</div>
						<div class="col-sm-3 p-0">
							<button type="button" class="join-btn" id="idDuplicateButton">중복확인</button>
						</div>
					</div>
					<div class="form-group row">
						<label for="password" class="col-sm-4 col-form-label text-end">비밀번호<span
							class="text-red">*</span></label>
						<div class="col-sm-5">
							<form:input type="password" autocomplete="new-password"
                          
								class="form-control" id="password" placeholder="비밀번호를 입력해주세요"
								path="memberPwd" />

							<!-- <p class="error-text">최소 10자 이상 입력</p> -->
							<p class="error-text" id="info_pw"></p>
						</div>
					</div>
					<div class="form-group row">
						<label for="password-check"
							class="col-sm-4 col-form-label text-end">비밀번호확인<span
							class="text-red">*</span></label>
						<div class="col-sm-5">
							<input type="password" autocomplete="new-password"
								class="form-control" id="password-check"
								placeholder="비밀번호를 한번 더 입력해주세요">
							<!-- <p class="error-text">최소 10자 이상 입력</p> -->
							<p class="error-text" id="info_pw_check"></p>
						</div>
					</div>
					<div class="form-group row">
						<label for="name" class="col-sm-4 col-form-label text-end">이름<span
							class="text-red">*</span></label>
						<div class="col-sm-5">
							<form:input type="text" autocomplete="off" class="form-control"
								id="name" placeholder="이름을 입력해주세요" path="memberName" />
							<p class="error-text" id="info_name"></p>
						</div>
					</div>

					<div class="form-group row">
						<label for="email" class="col-sm-4 col-form-label text-end">이메일<span
							class="text-red">*</span></label>
						<div class="col-sm-5">
							<form:input type="email" class="form-control" id="email"
								placeholder="이메일을 입력해주세요" path="email" />
							<p class="error-text" id="info_email"></p>
						</div>
						<div class="col-sm-3 p-0">
							<button type="button" class="join-btn" id="emailDuplicateButton">중복확인</button>
						</div>
					</div>

					<div class="form-group row">
						<label for="phone" class="col-sm-4 col-form-label text-end">휴대폰<span
							class="text-red">*</span></label>
						<div class="col-sm-5">
							<form:input type="text" class="form-control" id="phone"
								placeholder="번호를 입력해주세요" path="phone" />
							<p class="error-text" id="info_phone"></p>
						</div>
						<div class="col-sm-3 p-0">
							<button type="button" class="join-btn">인증하기</button>
						</div>
					</div>

					<div class="form-group row">
						<label for="area" class="col-sm-4 col-form-label text-end">희망지역<span
							class="text-red">*</span></label>
						<div class="col-sm-5">
							<input type="text" class="form-control" name="area"
								id="area" placeholder="희망지역을 입력해주세요" disabled>
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
				<br> <br> <br>
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

	// Function to handle ID changes
	function handleIdChange() {
	  var id = $("#id").val();
	  var isValidId = /^[a-z0-9]{6,20}$/.test(id);

	  setDuplicateButtonState(isValidId, "id"); // Enable/disable duplicateButton based on ID validity
	  setSubmitButtonState(false); // Disable the submit button when ID changes
	}

	// Function to handle email changes
	function handleEmailChange() {
	  var email = $("#email").val();
	  var isValidEmail = /^[A-Z0-9._%+-]+@[A-Z0-9.-]+\.[A-Z]{2,}$/i.test(email);

	  setDuplicateButtonState(isValidEmail, "email"); // Enable/disable duplicateButton based on email validity
	  setSubmitButtonState(false); // Disable the submit button when email changes
	}

	// Function to handle ID duplicateButton clicks
	function handleIdDuplicateButtonClick() {
	  var id = $("#id").val();

	  if (id) {
	    checkIdDuplicate(id);
	  }
	}

	// Function to handle email duplicateButton clicks
	function handleEmailDuplicateButtonClick() {
	  var email = $("#email").val();

	  if (email) {
	    checkEmailDuplicate(email);
	  }
	}

	// Function to check ID duplication
	function checkIdDuplicate(id) {
	  $.ajax({
	    url: "/member/idCheck",
	    type: "post",
	    data: {
	      id: id
	    },
	    success: function(data) {
	      console.log(data);
	      if (data === 'Duplicate') {
	        toastr.error("이미 사용중인 아이디입니다.");
	        setSubmitButtonState(true); // Enable the submit button when ID is not duplicate
	        setDuplicateButtonState(true, "id"); // Disable ID duplicateButton
	      } else {
	        toastr.success("사용 가능한 아이디입니다.");
	        setDuplicateButtonState(false, "id"); // Enable ID duplicateButton
	      }
	    }
	  });
	}

	// Function to check email duplication
	function checkEmailDuplicate(email) {
	  $.ajax({
	    url: "/member/emailCheck",
	    type: "post",
	    data: {
	      email: email
	    },
	    success: function(data) {
	      console.log(data);
	      if (data === 'Duplicate') {
	        toastr.error("이미 사용중인 이메일입니다.");
	        setSubmitButtonState(true); // Enable the submit button when email is not duplicate
	        setDuplicateButtonState(true, "email"); // Disable email duplicateButton
	      } else {
	        toastr.success("사용 가능한 이메일입니다.");
	        setDuplicateButtonState(false, "email"); // Enable email duplicateButton
	      }
	    }
	  });
	}

	// Event handler for ID changes
	$("#id").on("input", handleIdChange);

	// Event handler for email changes
	$("#email").on("input", handleEmailChange);

	// Event handler for ID duplicateButton clicks
	$("#idDuplicateButton").on("click", handleIdDuplicateButtonClick);

	// Event handler for email duplicateButton clicks
	$("#emailDuplicateButton").on("click", handleEmailDuplicateButtonClick);

	// Initialize button states
	setDuplicateButtonState(false, "id");
	setDuplicateButtonState(false, "email");
	setSubmitButtonState(false);

	<script>

	// Function to enable/disable the duplicateButton
	function setDuplicateButtonState(enabled, field) {
	  $("#" + field + "DuplicateButton").prop("disabled", !enabled);
	}

	// Function to enable/disable the submit button
	function setSubmitButtonState(enabled) {
	  $(".submit-btn").prop("disabled", !enabled);
	}

	// Function to handle ID changes
	function handleIdChange() {
	  var id = $("#id").val();
	  var isValidId = /^[a-z0-9]{6,20}$/.test(id);

	  setDuplicateButtonState(isValidId, "id"); // Enable/disable duplicateButton based on ID validity
	  setSubmitButtonState(false); // Disable the submit button when ID changes
	}

	// Function to handle email changes
	function handleEmailChange() {
	  var email = $("#email").val();
	  var isValidEmail = /^[A-Z0-9._%+-]+@[A-Z0-9.-]+\.[A-Z]{2,}$/i.test(email);

	  setDuplicateButtonState(isValidEmail, "email"); // Enable/disable duplicateButton based on email validity
	  setSubmitButtonState(false); // Disable the submit button when email changes
	}

	// Function to handle ID duplicateButton clicks
	function handleIdDuplicateButtonClick() {
	  var id = $("#id").val();

	  if (id && !$("#idDuplicateButton").prop("disabled")) {
	    checkIdDuplicate(id);
	  } else {
	    setSubmitButtonState(false); // Disable the submit button if ID duplicateButton is disabled
	  }
	}

	// Function to handle email duplicateButton clicks
	function handleEmailDuplicateButtonClick() {
	  var email = $("#email").val();

	  if (email && !$("#emailDuplicateButton").prop("disabled")) {
	    checkEmailDuplicate(email);
	  } else {
	    setSubmitButtonState(false); // Disable the submit button if email duplicateButton is disabled
	  }
	}

	// Function to check ID duplication
	function checkIdDuplicate(id) {
	  $.ajax({
	    url: "/member/idCheck",
	    type: "post",
	    data: {
	      id: id
	    },
	    success: function(data) {
	      console.log(data);
	      if (data === 'Duplicate') {
	        toastr.error("이미 사용중인 아이디입니다.");
	        setDuplicateButtonState(true, "id"); // Enable ID duplicateButton
	        setSubmitButtonState(false); // Disable the submit button when ID is duplicate
	      } else {
	        toastr.success("사용 가능한 아이디입니다.");
	        setDuplicateButtonState(false, "id"); // Enable ID duplicateButton
	        checkSubmitButtonState(); // Check if both ID and email are validated for enabling submit button
	      }
	    }
	  });
	}

	// Function to check email duplication
	function checkEmailDuplicate(email) {
	  $.ajax({
	    url: "/member/emailCheck",
	    type: "post",
	    data: {
	      email: email
	    },
	    success: function(data) {
	      console.log(data);
	      if (data === 'Duplicate') {
	        toastr.error("이미 사용중인 이메일입니다.");
	        setDuplicateButtonState(true, "email"); // Enable ID duplicateButton
	        setSubmitButtonState(false); // Disable the submit button when email is duplicate
	      } else {
	        toastr.success("사용 가능한 이메일입니다.");
	        setDuplicateButtonState(false, "email"); // Enable ID duplicateButton
	        checkSubmitButtonState(); // Check if both ID and email are validated for enabling submit button
	      }
	    }
	  });
	}

	// Function to check both ID and email validations for enabling submit button
	function checkSubmitButtonState() {
	  var isIdValid = $("#idDuplicateButton").prop("disabled");
	  var isEmailValid = $("#emailDuplicateButton").prop("disabled");

	  if (isIdValid && isEmailValid) {
	    setSubmitButtonState(true); // Enable the submit button when both ID and email are validated
	  } else {
	    setSubmitButtonState(false); // Disable the submit button if either ID or email is not validated
	  }
	}

	// Event handler for ID changes
	$("#id").on("input", handleIdChange);

	// Event handler for email changes
	$("#email").on("input", handleEmailChange);

	// Event handler for ID duplicateButton clicks
	$("#idDuplicateButton").on("click", handleIdDuplicateButtonClick);

	// Event handler for email duplicateButton clicks
	$("#emailDuplicateButton").on("click", handleEmailDuplicateButtonClick);

	// Initialize button states
	setDuplicateButtonState(true, "id");
	setDuplicateButtonState(true, "email");
	setSubmitButtonState(false);

	</script>

	<script src="/resources/js/user/signup.js"></script>

	<jsp:include page="/WEB-INF/views/common/footer.jsp" />

</body>
</html>