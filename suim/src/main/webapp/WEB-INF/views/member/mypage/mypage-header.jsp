<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<style>
.actives {
	color: black !important;
}
</style>

<div class="container" style="margin-top: 75px;">
	<div class="row">
		<div class="col-md-12">
			<div id="content" class="content content-full-width"
				style="background: white;">
				<!-- begin profile -->
				<div class="profile">
					<div class="profile-header">
						<!-- BEGIN profile-header-cover -->
						<div class="profile-header-cover"></div>
						<!-- END profile-header-cover -->
						<!-- BEGIN profile-header-content -->
						<div class="profile-header-content">
							<!-- BEGIN profile-header-img -->
							<div class="profile-header-img">
								<!--<img src="/resources/img/common/default_profile.png" alt=""> -->
								<img src="${ loginUser.changeName }" alt="">
							</div>
							<!-- END profile-header-img -->
							<!-- BEGIN profile-header-info -->
							<div class="profile-header-info">
								<c:choose>
									<c:when test="${not empty loginUser }">
										<h4 class="m-t-10 m-b-5">${ loginUser.nickName }</h4>
										<p class="m-b-10">${ loginUser.memberComment }</p>

										<button type="button" class="editModalBtn"
											data-bs-toggle="modal" data-bs-target="#myModal"
											style="color: white; height: 40px; background: transparent;">수정하기</button>
									</c:when>
									<c:otherwise>
										<h4 class="m-t-10 m-b-5">손님</h4>
										<p class="m-b-10">로그인 후 이용가능합니다.</p>
										<button
											style="color: white; height: 40px; background: transparent;">
											<a href="/member/login">로그인</a>
										</button>
									</c:otherwise>
								</c:choose>

							</div>
							<!-- END profile-header-info -->
						</div>
						<c:set var="currentUrl" value="${pageContext.request.requestURI}" />
						<c:set var="suffix"
							value="${fn:substringAfter(currentUrl, '/mypage/')}" />
						<c:set var="pageUrl" value="${fn:substringBefore(suffix, '.jsp')}" />
						<!-- END profile-header-content -->
						<!-- BEGIN profile-header-tab -->
						<ul class="profile-header-tab nav nav-tabs">
							<li class="nav-item"><a href="./timeline"
								class="nav-link ${fn:startsWith(pageUrl, 'timeline') ? 'actives' : ''}">알림</a></li>
							<li class="nav-item"><a href="./post"
								class="nav-link ${fn:startsWith(pageUrl, 'post') ? 'actives' : ''}">내
									게시글</a></li>
							<li class="nav-item"><a href="./wish"
								class="nav-link ${fn:startsWith(pageUrl, 'wish') ? 'actives' : ''}">찜목록</a></li>
							<li class="nav-item"><a href="./house"
								class="nav-link ${fn:startsWith(pageUrl, 'house') ? 'actives' : ''}">셰어하우스</a></li>
							<li class="nav-item"><a href="./reservation"
								class="nav-link ${fn:startsWith(pageUrl, 'reservation') ? 'actives' : ''}">예약내역</a></li>
							<li class="nav-item"><a href="./profile"
								class="nav-link ${fn:startsWith(pageUrl, 'profile') ? 'actives' : ''}">내정보</a></li>
						</ul>
					</div>
				</div>
			</div>
		</div>
	</div>
</div>





<div class="modal fade" id="myModal" tabindex="-1"
	aria-labelledby="exampleModalLabel" aria-hidden="true">
	<div class="modal-dialog modal-dialog-centered"
		style="max-width: 400px !important;">
		<div class="modal-content">
			<div class="modal-header">
				<h1 class="modal-title fs-5" id="exampleModalLabel"
					style="margin-left: 150px">정보 수정</h1>
				<button type="button" class="btn-close" data-bs-dismiss="modal"
					aria-label="Close"></button>
			</div>
			<div class="modal-body" style="text-align: left">
				<form id="updateForm" method="post" action="./updateProfile" enctype="multipart/form-data">
					<div id="fileupload_profile_img2" class="fileupload_profile_img">
						<div id="profile_img2" class="profile"></div>
						<span class="over"><i class="fa-solid fa-camera"
							style="color: #f2f2f2; margin-top: 7px;"></i></span>
						<div id="drop_profile_img2" class="drop_profile_img">
							<input title="프로필 업로드" type="file" name="file"
								style="width: 100%; height: 100%; cursor: pointer;"
								accept="image/jpeg, image/jpg, image/png, image/gif, image/svg+xml">
						</div>
					</div>
					<input class="form-control" type="text" name="nickName"
						placeholder="닉네임" value="${ loginUser.nickName }" required="required"
						style="width: 150px; margin: 0 auto; text-align: center; margin-bottom : 25px;">
					
					<input class="form-control" type="text" name="memberComment"
						placeholder="프로필 메시지" value="${ loginUser.memberComment }"
						style="width: 300px; margin: 0 auto; text-align: center;">

					<!-- border로 800px 정도의 input태그가 들어갈수있는 공간 만들기(회원정보수정용) -->
					<div class="input-border"
						style="height: 800px; width: 349px; margin: 20px auto;">


						<div class="input_block form-group">
							<div class="input_form _item _uid">
								<input title="아이디" type="text" name="memberId" readonly="readonly"
									value="${ loginUser.memberId }" placeholder="이메일"
									required="required"><i aria-hidden="true"
									class="zmdi zmdi-check"></i>
								<div class="alert-block _msg"></div>
							</div>
							<div class="input_block form-group">
								<div class="input_form _item _uid">
									<input title="이메일" type="email" name="email"
										readonly="readonly" value="${ loginUser.email }"
										placeholder="이메일" required="required"><i
										aria-hidden="true" class="zmdi zmdi-check"></i>
									<div class="alert-block _msg"></div>
								</div>
								<div class="input_form brt _item _passwd_org">
									<input title="기본 비밀번호 입력" type="password" name="memberPwd"
										autocomplete="off" placeholder="기본 비밀번호 입력"> <i
										aria-hidden="true" class="zmdi zmdi-check"></i>
									<div class="alert-block _msg"></div>
								</div>
								<div class="input_form brt _item _passwd">
									<input title="비밀번호" type="password" name="changePwd1"
										autocomplete="off" placeholder="비밀번호를 변경 하는 경우 입력하세요">
									<i aria-hidden="true" class="zmdi zmdi-check"></i>
									<div class="alert-block first-letter-uppercase _msg"></div>
								</div>
								<div class="input_form brt _item _passwd_confirm">
									<input title="비밀번호 확인" type="password" name="changePwd2"
										autocomplete="off" placeholder="비밀번호 확인"> <i
										aria-hidden="true" class="zmdi zmdi-check"></i>
									<div class="alert-block _msg"></div>
								</div>
							</div>
							<div class="input_block form-group">
								<label class="mini-tit" for="join_name">이름을 입력해주세요<span
									style="color: red">*</span></label>
								<div class="input_form _item _name">
									<input title="이름을 입력하세요" type="text" id="join_name" name="memberName"
										placeholder="이름을 입력하세요" value="${ loginUser.memberName }"
										required="required">
								</div>
							</div>
							<div class="input_block form-group">
								<label class="mini-tit" for="join_name">성별</label> <select
									title="성별" class="form-select" id="birth_y" name="gender">

									<option value="M"
										<c:if test="${loginUser.gender == 'M'}">checked</c:if>>남자</option>
									<option value="F"
										<c:if test="${loginUser.gender == 'F'}">checked</c:if>>여자</option>
								</select>
							</div>
							<div class="input_block form-group">
								<label class="mini-tit" for="join_name">연락처</label> <input
									class="input_form" type="tel" id="join_callnum" name="phone"
									placeholder="연락처" value="${ loginUser.phone }"
									required="required">
							</div>

							<%-- <c:set var="birthYear" value="${loginUser.birth.substring(0, 4)}" />
							<c:set var="birthMonth"
								value="${loginUser.birth.substring(4, 6)}" />
							<c:set var="birthDay" value="${loginUser.birth.substring(6, 8)}" />

							<div class="input_block form-group">
								<label class="mini-tit" for="join_name">생년월일</label>
								<div class="info" id="info__birth" align="left">
									<div style="display: inline-block; width: 120px;">
										<select class="form-select" id="birth-year">
											<option selected>${birthYear}</option>
										</select>
									</div>
									<div style="display: inline-block; width: 107px">
										<select class="form-select" id="birth-month">
											<option selected>${birthMonth}</option>
										</select>
									</div>
									<div style="display: inline-block; width: 107px">
										<select class="form-select" id="birth-day">
											<option selected>${birthDay}</option>
										</select>
									</div>

									<input type="hidden" name="birth" id="birth-date-input" />
								</div>
							</div> --%>

							<div class="input_block form-group">
								<label class="mini-tit" for="area">희망지역</label>
								<div class="col-sm-12">
									<input type="text" class="form-control" name="area"
										value="${loginUser.area }" id="area"
										placeholder="희망지역을 입력해주세요" disabled>
									<p class="good-text" id="info_area">희망지역의 쉐어하우스를 우선적으로
										추천해드려요!</p>
									<button type="button" onclick="searchAddr();">
										<i class="fa-solid fa-magnifying-glass"
											style="font-size: 12px"></i> 검색
									</button>
								</div>

							</div>
							<div class="text-center">
								<c:if test="${ not empty loginUser.naverLogin }">
								소셜로그인 상태<br>
									<img src="/resources/img/member/naverBtn.png"
										style="width: 20px; height: 20px;"> 연결됨
								<input type="hidden" name="naverLogin" value="${loginUser.naverLogin}" />
							</c:if>
							</div>

						</div>
					</div>
					<div class="modal-footer justify-content-center">
						<button type="submit" class="btn btn-primary"
							style="width: 250px;">확인</button>
					</div>
				</form>
			</div>
		</div>
	</div>
</div>




<script>
var profileImg = document.getElementById("profile_img2");

//Add event listener for file input change
document.getElementById("drop_profile_img2").addEventListener("change", function(event) {
// Get the selected file
var file = event.target.files[0];

// Create a FileReader object to read the file
var reader = new FileReader();

// Set up the onload event handler
reader.onload = function(e) {
 // Set the image source to the loaded data URL
 profileImg.style.backgroundImage = "url(" + e.target.result + ")";
};

// Read the file as a data URL
reader.readAsDataURL(file);
});
</script>