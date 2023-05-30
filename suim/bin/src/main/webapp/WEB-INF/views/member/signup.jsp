<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
 
<head>
<meta charset="UTF-8">
<title>쉐어하우스 쉼</title>
		<%@ include file="/WEB-INF/views/common/include.jsp" %>
		<link href="/resources/css/user/signup.css" rel="stylesheet" />
</head>	

<body>	    
	 <jsp:include page="/WEB-INF/views/common/header.jsp"/>

	<div class="container main" style="margin-bottom: 120px;">
		<div class="row justify-content-center">
			<div class="col">
				<h2 class="text-center mb-4" style="margin-left: 60px;">회원가입</h2>
				<form:form modelAttribute="formData">
					<div class="form-group row">
						<label for="id" class="col-sm-4 col-form-label text-end">아이디<span
							class="text-red">*</span></label>
						<div class="col-sm-5">
							<input type="text" autocomplete="on" class="form-control" id="id"
								placeholder="아이디를 입력해주세요">
							<p class="error-text error-msg" id="info_id"></p>
						</div>
						<div class="col-sm-3 p-0">
							<button type="button" class="join-btn">중복확인</button>
						</div>
					</div>
					<div class="form-group row">
						<label for="password" class="col-sm-4 col-form-label text-end">비밀번호<span
							class="text-red">*</span></label>
						<div class="col-sm-5">
							<input type="password" autocomplete="new-password"
								class="form-control" id="password" placeholder="비밀번호를 입력해주세요">
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
							<input type="text" autocomplete="off" class="form-control"
								id="name" placeholder="이름을 입력해주세요">
							<p class="error-text" id="info_name"></p>
						</div>
					</div>

					<div class="form-group row">
						<label for="email" class="col-sm-4 col-form-label text-end">이메일<span
							class="text-red">*</span></label>
						<div class="col-sm-5">
							<input type="email" class="form-control" id="email"
								placeholder="이메일을 입력해주세요">
							<p class="error-text" id="info_email"></p>
						</div>
					</div>

					<div class="form-group row">
						<label for="phone" class="col-sm-4 col-form-label text-end">휴대폰<span
							class="text-red">*</span></label>
						<div class="col-sm-5">
							<input type="text" class="form-control" id="phone"
								placeholder="번호를 입력해주세요">
							<p class="error-text" id="info_phone"></p>
						</div>
						<div class="col-sm-3 p-0">
							<button type="button" class="join-btn">인증하기</button>
						</div>
					</div>

					<div class="form-group row">
						<label for="address" class="col-sm-4 col-form-label text-end">희망지역<span
							class="text-red">*</span></label>
						<div class="col-sm-5">
							<input type="text" class="form-control" name="address"
								id="address" placeholder="희망지역을 입력해주세요" disabled>
							<p class="good-text" id="info_address">희망지역의 쉐어하우스를 우선적으로
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
								style="width: 25px; height: 25px;" type="radio" value="남자"
								name="flexRadioDefault" id="flexRadioDefault1" checked>
							<label class="form-check-label" for="flexRadioDefault1">
								&nbsp;남자 </label> <input class="form-check-input offset-3"
								style="width: 25px; height: 25px;" type="radio" value="여자"
								name="flexRadioDefault" id="flexRadioDefault2"> <label
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
								<input type="hidden" name="birthDate" id="birth-date-input">
							</div>
						</div>
					</div>

					<br>
					<br>


					<div class="text-center mt-4">
						<button type="button" class="btn btn-primary btn-block submit-btn"
							onclick="validate();">가입하기</button>
					</div>
				</form:form>
				<br>
				<br>
				<br>
			</div>
		</div>
	</div>


	<jsp:include page="/WEB-INF/views/common/footer.jsp"/>
        

</body>
</html>