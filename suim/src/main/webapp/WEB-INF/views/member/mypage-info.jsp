<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<title>고객 마이페이지</title>
<%@ include file="/WEB-INF/views/common/include.jsp"%>
<link href="/resources/css/user/mypage.css" rel="stylesheet" />
<style>
.input-border>input {
	width: 300px;
	margin: 0 auto;
	text-align: center;
}

body{
    margin-top:20px;
    background:#eee;
}

.profile-header {
    position: relative;
    overflow: hidden
}

.profile-header .profile-header-cover {
    background-image: url(https://bootdey.com/img/Content/bg1.jpg);
    background-size: cover;
    background-position: center;
    background-repeat: no-repeat;
    position: absolute;
    left: 0;
    right: 0;
    top: 0;
    bottom: 0
}

.profile-header .profile-header-cover:before {
    content: '';
    position: absolute;
    top: 0;
    left: 0;
    right: 0;
    bottom: 0;
    background: linear-gradient(to bottom, rgba(0, 0, 0, 0) 0, rgba(0, 0, 0, .75) 100%)
}

.profile-header .profile-header-content {
    color: #fff;
    padding: 27px
}

.profile-header-img {
    float: left;
    width: 120px;
    height: 120px;
    overflow: hidden;
    position: relative;
    z-index: 10;
    margin: 0 0 -20px;
    padding: 3px;
    border-radius: 4px;
    background: #fff
}

.profile-header-img img {
    max-width: 100%
}

.profile-header-info h4 {
    font-weight: 500;
    color: #fff
}

.profile-header-img+.profile-header-info {
    margin-left: 140px
}

.profile-header .profile-header-content,
.profile-header .profile-header-tab {
    position: relative
}

.b-minus-1,
.b-minus-10,
.b-minus-2,
.b-minus-3,
.b-minus-4,
.b-minus-5,
.b-minus-6,
.b-minus-7,
.b-minus-8,
.b-minus-9,
.b-plus-1,
.b-plus-10,
.b-plus-2,
.b-plus-3,
.b-plus-4,
.b-plus-5,
.b-plus-6,
.b-plus-7,
.b-plus-8,
.b-plus-9,
.l-minus-1,
.l-minus-2,
.l-minus-3,
.l-minus-4,
.l-minus-5,
.l-minus-6,
.l-minus-7,
.l-minus-8,
.l-minus-9,
.l-plus-1,
.l-plus-10,
.l-plus-2,
.l-plus-3,
.l-plus-4,
.l-plus-5,
.l-plus-6,
.l-plus-7,
.l-plus-8,
.l-plus-9,
.r-minus-1,
.r-minus-10,
.r-minus-2,
.r-minus-3,
.r-minus-4,
.r-minus-5,
.r-minus-6,
.r-minus-7,
.r-minus-8,
.r-minus-9,
.r-plus-1,
.r-plus-10,
.r-plus-2,
.r-plus-3,
.r-plus-4,
.r-plus-5,
.r-plus-6,
.r-plus-7,
.r-plus-8,
.r-plus-9,
.t-minus-1,
.t-minus-10,
.t-minus-2,
.t-minus-3,
.t-minus-4,
.t-minus-5,
.t-minus-6,
.t-minus-7,
.t-minus-8,
.t-minus-9,
.t-plus-1,
.t-plus-10,
.t-plus-2,
.t-plus-3,
.t-plus-4,
.t-plus-5,
.t-plus-6,
.t-plus-7,
.t-plus-8,
.t-plus-9 {
    position: relative!important
}

.profile-header .profile-header-tab {
    background: #fff;
    list-style-type: none;
    margin: -10px 0 0;
    padding: 0 0 0 60px;
    white-space: nowrap;
    border-radius: 0
}

.text-ellipsis,
.text-nowrap {
    white-space: nowrap!important
}

.profile-header .profile-header-tab>li {
    display: inline-block;
    margin: 0
}

.profile-header .profile-header-tab>li>a {
    display: block;
    color: #929ba1;
    line-height: 20px;
    padding: 10px 20px;
    text-decoration: none;
    font-weight: 700;
    font-size: 16px;
    border: none
}

.profile-header .profile-header-tab>li.active>a,
.profile-header .profile-header-tab>li>a.active {
    color: #242a30
}

.profile-content {
    padding: 25px;
    border-radius: 4px
}

.profile-content:after,
.profile-content:before {
    content: '';
    display: table;
    clear: both
}

.profile-content .tab-content,
.profile-content .tab-pane {
    background: 0 0
}

.profile-left {
    width: 200px;
    float: left
}

.profile-right {
    margin-left: 240px;
    padding-right: 20px
}

.profile-image {
    height: 175px;
    line-height: 175px;
    text-align: center;
    font-size: 72px;
    margin-bottom: 10px;
    border: 2px solid #E2E7EB;
    overflow: hidden;
    border-radius: 4px
}

.profile-image img {
    display: block;
    max-width: 100%
}

.profile-highlight {
    padding: 12px 15px;
    background: #FEFDE1;
    border-radius: 4px
}

.profile-highlight h4 {
    margin: 0 0 7px;
    font-size: 12px;
    font-weight: 700
}

.table.table-profile>thead>tr>th {
    border-bottom: none!important
}

.table.table-profile>thead>tr>th h4 {
    font-size: 20px;
    margin-top: 0
}

.table.table-profile>thead>tr>th h4 small {
    display: block;
    font-size: 12px;
    font-weight: 400;
    margin-top: 5px
}

.table.table-profile>tbody>tr>td,
.table.table-profile>thead>tr>th {
    border: none;
    padding-top: 7px;
    padding-bottom: 7px;
    color: #242a30;
    background: 0 0
}

.table.table-profile>tbody>tr>td.field {
    width: 20%;
    text-align: right;
    font-weight: 600;
    color: #2d353c
}

.table.table-profile>tbody>tr.highlight>td {
    border-top: 1px solid #b9c3ca;
    border-bottom: 1px solid #b9c3ca
}

.table.table-profile>tbody>tr.divider>td {
    padding: 0!important;
    height: 10px
}

.profile-section+.profile-section {
    margin-top: 20px;
    padding-top: 20px;
    border-top: 1px solid #b9c3ca
}

.profile-section:after,
.profile-section:before {
    content: '';
    display: table;
    clear: both
}

.profile-section .title {
    font-size: 20px;
    margin: 0 0 15px
}

.profile-section .title small {
    font-weight: 400
}

body.flat-black {
    background: #E7E7E7
}

.flat-black .navbar.navbar-inverse {
    background: #212121
}

.flat-black .navbar.navbar-inverse .navbar-form .form-control {
    background: #4a4a4a;
    border-color: #4a4a4a
}

.flat-black .sidebar,
.flat-black .sidebar-bg {
    background: #3A3A3A
}

.flat-black .page-with-light-sidebar .sidebar,
.flat-black .page-with-light-sidebar .sidebar-bg {
    background: #fff
}

.flat-black .sidebar .nav>li>a {
    color: #b2b2b2
}

.flat-black .sidebar.sidebar-grid .nav>li>a {
    border-bottom: 1px solid #474747;
    border-top: 1px solid #474747
}

.flat-black .sidebar .active .sub-menu>li.active>a,
.flat-black .sidebar .nav>li.active>a,
.flat-black .sidebar .nav>li>a:focus,
.flat-black .sidebar .nav>li>a:hover,
.flat-black .sidebar .sub-menu>li>a:focus,
.flat-black .sidebar .sub-menu>li>a:hover,
.sidebar .nav>li.nav-profile>a {
    color: #fff
}

.flat-black .sidebar .sub-menu>li>a,
.flat-black .sidebar .sub-menu>li>a:before {
    color: #999
}

.flat-black .page-with-light-sidebar .sidebar .active .sub-menu>li.active>a,
.flat-black .page-with-light-sidebar .sidebar .active .sub-menu>li.active>a:focus,
.flat-black .page-with-light-sidebar .sidebar .active .sub-menu>li.active>a:hover,
.flat-black .page-with-light-sidebar .sidebar .nav>li.active>a,
.flat-black .page-with-light-sidebar .sidebar .nav>li.active>a:focus,
.flat-black .page-with-light-sidebar .sidebar .nav>li.active>a:hover {
    color: #000
}

.flat-black .page-sidebar-minified .sidebar .nav>li.has-sub:focus>a,
.flat-black .page-sidebar-minified .sidebar .nav>li.has-sub:hover>a {
    background: #323232
}

.flat-black .page-sidebar-minified .sidebar .nav li.has-sub>.sub-menu,
.flat-black .sidebar .nav>li.active>a,
.flat-black .sidebar .nav>li.active>a:focus,
.flat-black .sidebar .nav>li.active>a:hover,
.flat-black .sidebar .nav>li.nav-profile,
.flat-black .sidebar .sub-menu>li.has-sub>a:before,
.flat-black .sidebar .sub-menu>li:before,
.flat-black .sidebar .sub-menu>li>a:after {
    background: #2A2A2A
}

.flat-black .page-sidebar-minified .sidebar .sub-menu>li:before,
.flat-black .page-sidebar-minified .sidebar .sub-menu>li>a:after {
    background: #3e3e3e
}

.flat-black .sidebar .nav>li.nav-profile .cover.with-shadow:before {
    background: rgba(42, 42, 42, .75)
}

.bg-white {
    background-color: #fff!important;
}
.p-10 {
    padding: 10px!important;
}
.media.media-xs .media-object {
    width: 32px;
}
.m-b-2 {
    margin-bottom: 2px!important;
}
.media>.media-left, .media>.pull-left {
    padding-right: 15px;
}
.media-body, .media-left, .media-right {
    display: table-cell;
    vertical-align: top;
}
select.form-control:not([size]):not([multiple]) {
    height: 34px;
}
.form-control.input-inline {
    display: inline;
    width: auto;
    padding: 0 7px;
}


.timeline {
    list-style-type: none;
    margin: 0;
    padding: 0;
    position: relative
}

.timeline:before {
    content: '';
    position: absolute;
    top: 5px;
    bottom: 5px;
    width: 5px;
    background: #2d353c;
    left: 20%;
    margin-left: -2.5px
}

.timeline>li {
    position: relative;
    min-height: 50px;
    padding: 20px 0
}

.timeline .timeline-time {
    position: absolute;
    left: 0;
    width: 18%;
    text-align: right;
    top: 30px
}

.timeline .timeline-time .date,
.timeline .timeline-time .time {
    display: block;
    font-weight: 600
}

.timeline .timeline-time .date {
    line-height: 16px;
    font-size: 12px
}

.timeline .timeline-time .time {
    line-height: 24px;
    font-size: 20px;
    color: #242a30
}

.timeline .timeline-icon {
    left: 15%;
    position: absolute;
    width: 10%;
    text-align: center;
    top: 40px
}

.timeline .timeline-icon a {
    text-decoration: none;
    width: 20px;
    height: 20px;
    display: inline-block;
    border-radius: 20px;
    background: #d9e0e7;
    line-height: 10px;
    color: #fff;
    font-size: 14px;
    border: 5px solid #2d353c;
    transition: border-color .2s linear
}

.timeline .timeline-body {
    margin-left: 23%;
    margin-right: 17%;
    background: #fff;
    position: relative;
    padding: 20px 25px;
    border-radius: 6px
}

.timeline .timeline-body:before {
    content: '';
    display: block;
    position: absolute;
    border: 10px solid transparent;
    border-right-color: #fff;
    left: -20px;
    top: 20px
}

.timeline .timeline-body>div+div {
    margin-top: 15px
}

.timeline .timeline-body>div+div:last-child {
    margin-bottom: -20px;
    padding-bottom: 20px;
    border-radius: 0 0 6px 6px
}

.timeline-header {
    padding-bottom: 10px;
    border-bottom: 1px solid #e2e7eb;
    line-height: 30px
}

.timeline-header .userimage {
    float: left;
    width: 34px;
    height: 34px;
    border-radius: 40px;
    overflow: hidden;
    margin: -2px 10px -2px 0
}

.timeline-header .username {
    font-size: 16px;
    font-weight: 600
}

.timeline-header .username,
.timeline-header .username a {
    color: #2d353c
}

.timeline img {
    max-width: 100%;
    display: block
}

.timeline-content {
    letter-spacing: .25px;
    line-height: 18px;
    font-size: 13px
}

.timeline-content:after,
.timeline-content:before {
    content: '';
    display: table;
    clear: both
}

.timeline-title {
    margin-top: 0
}

.timeline-footer {
    background: #fff;
    border-top: 1px solid #e2e7ec;
    padding-top: 15px
}

.timeline-footer a:not(.btn) {
    color: #575d63
}

.timeline-footer a:not(.btn):focus,
.timeline-footer a:not(.btn):hover {
    color: #2d353c
}

.timeline-likes {
    color: #6d767f;
    font-weight: 600;
    font-size: 12px
}

.timeline-likes .stats-right {
    float: right
}

.timeline-likes .stats-total {
    display: inline-block;
    line-height: 20px
}

.timeline-likes .stats-icon {
    float: left;
    margin-right: 5px;
    font-size: 9px
}

.timeline-likes .stats-icon+.stats-icon {
    margin-left: -2px
}

.timeline-likes .stats-text {
    line-height: 20px
}

.timeline-likes .stats-text+.stats-text {
    margin-left: 15px
}

.timeline-comment-box {
    background: #f2f3f4;
    margin-left: -25px;
    margin-right: -25px;
    padding: 20px 25px
}

.timeline-comment-box .user {
    float: left;
    width: 34px;
    height: 34px;
    overflow: hidden;
    border-radius: 30px
}

.timeline-comment-box .user img {
    max-width: 100%;
    max-height: 100%
}

.timeline-comment-box .user+.input {
    margin-left: 44px
}

.lead {
    margin-bottom: 20px;
    font-size: 21px;
    font-weight: 300;
    line-height: 1.4;
}

.text-danger, .text-red {
    color: #ff5b57!important;
}


.inputField {
  background-color: transparent;
  border: 1px solid white;
  outline: none;
  position: relative;
  z-index: 1;
  color: white;
}

.input_block .input_form {
    border: 1px solid #e0e0e0;
    background: #fff;
    border-top: 1px solid #e0e0e0;
    box-sizing: border-box;
    position: relative;
}

.input_block input {
    border: none;
    box-shadow: none;
    padding: 12px 16px;
    width: 100%;
    line-height: 1.2;
}

.form-group {
margin-bottom : 25px;
}

.input_block label.mini-tit {
	
	font-weight: normal;
    font-size: 12px;
    color: #212121;
}



</style>
</head>
<body>
	<jsp:include page="/WEB-INF/views/common/header.jsp" />

	<div class="container" style="margin-top: 75px;">
		<div class="row">
			<div class="col-md-12">
				<div id="content" class="content content-full-width" style="background : white;">
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
									<img src="/resources/img/common/default_profile.png" alt="">
								</div>
								<!-- END profile-header-img -->
								<!-- BEGIN profile-header-info -->
								<div class="profile-header-info">
									<c:choose>
									<c:when test="${not empty loginUser }">
									<h4 class="m-t-10 m-b-5">${ loginUser.nickName }</h4>
									<p class="m-b-10">${ loginUser.memberComment }</p>
									
									<button type="button" data-bs-toggle="modal" data-bs-target="#myModal" style="color : white; height : 40px; background : transparent;">편집하기</button>
									</c:when>
									<c:otherwise>
									<h4 class="m-t-10 m-b-5">손님</h4>
									<p class="m-b-10">로그인 후 이용가능합니다.</p>
									<button style="color : white; height : 40px; background : transparent;">로그인</button>
									</c:otherwise>
									</c:choose>
									
								</div>
								<!-- END profile-header-info -->
							</div>
							<!-- END profile-header-content -->
							<!-- BEGIN profile-header-tab -->
							<ul class="profile-header-tab nav nav-tabs">
								<li class="nav-item"><a
									href="https://www.bootdey.com/snippets/view/bs4-profile-with-timeline-posts"
									target="__blank" class="nav-link_ active">알림</a></li>
								<li class="nav-item"><a
									href="https://www.bootdey.com/snippets/view/bs4-profile-about"
									target="__blank" class="nav-link_">내 게시글</a></li>
								<li class="nav-item"><a
									href="https://www.bootdey.com/snippets/view/profile-photos"
									target="__blank" class="nav-link_">찜목록</a></li>
								<li class="nav-item"><a
									href="https://www.bootdey.com/snippets/view/profile-videos"
									target="__blank" class="nav-link_">셰어하우스</a></li>
								<li class="nav-item"><a
									href="https://www.bootdey.com/snippets/view/bs4-profile-friend-list"
									target="__blank" class="nav-link_">예약내역</a></li>
								<li class="nav-item"><a
									href="https://www.bootdey.com/snippets/view/bs4-profile-friend-list"
									target="__blank" class="nav-link_">내정보</a></li>
							</ul>
							<!-- END profile-header-tab -->
						</div>
					</div>
					<!-- end #profile-post tab -->
					<div class="text-center" style="height : 500px">
						<h1 style="position: relative; top : 200px;">오늘 알림은 없어요..</h1>
					</div>
				</div>
				<!-- end tab-content -->
			</div>
			<!-- end profile-content -->
		</div>
	</div>
	
	
	
	
	
	<div class="modal fade" id="myModal" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
  <div class="modal-dialog modal-dialog-centered" style="max-width: 400px !important;">
    <div class="modal-content">
      <div class="modal-header">
        <h1 class="modal-title fs-5" id="exampleModalLabel" style="margin-left : 150px">정보 수정</h1>
        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
      </div>
      <div class="modal-body" style="text-align : left">
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
		<input class="form-control" type="text" name="name" placeholder="닉네임" value="${ loginUser.nickName }" style="width: 150px; margin: 0 auto; text-align: center;">

				<!-- border로 800px 정도의 input태그가 들어갈수있는 공간 만들기(회원정보수정용) -->
				<div class="input-border" style="height: 800px; width: 349px; margin: 20px auto;">
				
				<div class="input_block form-group">
					<div class="input_form _item _uid">
					<input title="이메일" type="email" name="uid" readonly="readonly" value="dunghs@naver.com" placeholder="이메일" required="required"><i aria-hidden="true" class="zmdi zmdi-check"></i>
					<div class="alert-block _msg"></div>
				</div>
								<div class="input_form brt _item _passwd_org">
						<input title="기본 비밀번호 입력" type="password" name="passwd_org" autocomplete="off" placeholder="기본 비밀번호 입력">
						<i aria-hidden="true" class="zmdi zmdi-check"></i>
						<div class="alert-block _msg"></div>
					</div>
													<div class="input_form brt _item _passwd">
						<input title="비밀번호" type="password" name="passwd" autocomplete="off" placeholder="비밀번호를 변경 하는 경우 입력하세요">
						<i aria-hidden="true" class="zmdi zmdi-check"></i>
						<div class="alert-block first-letter-uppercase _msg"></div>
					</div>
					<div class="input_form brt _item _passwd_confirm">
						<input title="비밀번호 확인" type="password" name="passwd_confirm" autocomplete="off" placeholder="비밀번호 확인">
						<i aria-hidden="true" class="zmdi zmdi-check"></i>
						<div class="alert-block _msg"></div>
					</div>
				</div>
				<div class="input_block form-group">
						<label class="mini-tit" for="join_name">이름을 입력해주세요<span style="color : red">*</span></label>
						<div class="input_form _item _name">
										<input title="이름을 입력하세요" type="text" id="join_name" name="name" placeholder="이름을 입력하세요" value="최명진" required="required">
							<i aria-hidden="true" class="zmdi zmdi-check"></i>
							<div class="alert-block _msg"></div>
						</div>
				</div>
				<div class="input_block form-group">	
					<label class="mini-tit" for="join_name">성별</label>
					<select title="생년월일" class="form-select" id="birth_y" name="birth_y">
						<option value="M">남자</option>
						<option value="F">여자</option>
					</select>
				</div>
				<div class="input_block form-group">
					<label class="mini-tit" for="join_name">연락처</label>
					<input class="input_form" type="tel" id="join_callnum" name="callnum" placeholder="연락처" value="01066814733" required="required">
				</div>
				
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
                
								<input type="hidden" name="birthDate" id="birth-date-input" />
							

							</div>
						</div>
					</div>
				
			</div>
	      </div>
      <div class="modal-footer justify-content-center">
        <button type="button" class="btn btn-primary" style="width : 250px;" disabled>확인</button>
      </div>
    </div>
  </div>
</div>
	
	


	<jsp:include page="/WEB-INF/views/common/footer.jsp" />
</body>
</html>
