<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<link rel="stylesheet" href="/resources/css/common/header.css" />



<button id="notificationButton" style="display: none;">
	<i class="fas fa-bell"></i>
</button>

<div id="notificationModal">
	<div class="modal-header justify-content-center" style="height: 40px;">
		<h4>알림</h4>
		<span class="close">&times;</span>
	</div>
	<div class="modal-content">
		<ul id="notificationList"></ul>
	</div>
	<nav id="paginationContainer">
		<ul class="pgn pagination">
		</ul>
	</nav>

	<div class="modal-footer" style="justify-content: center;">
		<button id="deleteAllButton" class="delete-all-button"
			onclick="notificationDeleteAll('${loginUser.memberId}')">모두
			읽음</button>
	</div>
</div>
<header>
	<nav class="navbar navbar-expand-lg navbar-light fixed-top header_wrap"
		id="mainNav">
		<div class="header container px-4 px-lg-5">
			<a class="navbar-brand" href="/"><img class="logo"
				src="/resources/img/common/sim5.png"></a>

			<ul class="nav nav-pills navi">

				<li class="nav-item"><a href="/list.ho"
					class="nav-link nav-text">방 찾기</a></li>

				<li class="nav-item"><a href="/suim" class="nav-link nav-text">쉼</a>
					<ul>
						<li><a href="/suim">쉼 소개</a></li>
					</ul></li>
				<li class="nav-item"><a href="/list.bo"
					class="nav-link nav-text">커뮤니티</a>
					<ul>
						<li><a href="/list.bo">자유게시판</a></li>

						<li><a href="/list.in">입주후기</a></li>

						<li><a href="/list.fi">사람구해요</a></li>
					</ul></li>

				<c:choose>
					<c:when test="${ empty loginUser }">
						<!-- 로그인 전 -->
						<li class="nav-item"><a href="/member/login"
							class="nav-link nav-text">로그인</a></li>
					</c:when>
					<c:otherwise>
						<li class="nav-item"><a href="/mypage/board"
							class="nav-link nav-text">${ loginUser.nickName }님</a>
							<ul>
								<li><a href="/mypage/board">마이페이지</a></li>

								<li><a href="/chat.ch">채팅방</a>
								<li>
									<form id="logout-form1" action="/member/logout" method="post">
										<a href="#" onclick="event.preventDefault(); logout();">로그아웃</a>
									</form>
								</li>

							</ul></li>
					</c:otherwise>
				</c:choose>

				<li class="nav-item"><a href="/notice.no"
					class="nav-link nav-text">고객센터</a>
					<ul>
						<li><a href="/notice.no">공지사항</a></li>
						<li><a href="/faqList">자주 묻는 질문</a></li>
						<li><a href="/event.ev">이벤트</a></li>
					</ul></li>

				<li class="nav-item" style="padding: 1.6rem 0rem 2rem 2rem;">
					<button
						style="width: 90px; height: 40px; background: transparent; border-radius: 50px;"
						onclick="location.href='/Write.ho'">
						방 등록 <i class="fa-solid fa-right-from-bracket"></i>
					</button>
				</li>
				
				<c:choose>
					<c:when test="${ loginUser ne null and loginUser.adminAuth eq 1 }">
						<li class="nav-item" style="margin-top: 35px;margin-left: 10px;">
							<a href="/admin/dashboard"><i class="fa-solid fa-gear fa-spin fa-2xl" style="color: #636669;"></i></a>
						</li>
					</c:when>
				</c:choose>
			</ul>

			<button class="navbar-toggler" type="button"
				data-bs-toggle="offcanvas" data-bs-target="#offcanvasNavbar"
				aria-controls="offcanvasNavbar">
				<span class="navbar-toggler-icon"></span>
			</button>
			<div class="offcanvas offcanvas-end" tabindex="-1"
				id="offcanvasNavbar" aria-labelledby="offcanvasNavbarLabel">
				<div class="offcanvas-header">
					
					<c:choose>
						<c:when test="${ empty loginUser }">
							<div class="offcanvas-title" id="offcanvasNavbarLabel"></div>
						</c:when>
					</c:choose>
					<a type="button" class="navbar-toggler-icon text-reset"
						data-bs-dismiss="offcanvas" aria-label="Close"
						style="width: 32px; height: 32px"></a>
						<c:choose>
					<c:when test="${ loginUser ne null and loginUser.adminAuth eq 1 }">
						<li class="nav-item">
							<a href="/admin/dashboard"><i class="fa-solid fa-gear fa-spin fa-2xl" style="color: #636669;"></i></a>
						</li>
					</c:when>
				</c:choose>
				</div>
				<div class="offcanvas-body">
					<c:choose>
						<c:when test="${ empty loginUser }">
							<div class="user-button">
								<button type="button"
									style="width: 150px; margin-right: 20px; margin-left: 20px;"
									class="btn btn-success btn-lg"
									onclick="location.href='/member/login'">로그인</button>
								<button type="button" style="width: 150px;"
									class="btn btn-outline-success btn-lg"
									onclick="location.href='/member/join'">회원가입</button>
							</div>
						</c:when>
					</c:choose>
					<ul class="navbar-nav justify-content-end flex-grow-1 pe-3 pb-2">
						<c:choose>
							<c:when test="${not empty loginUser}">
								<c:choose>
									<c:when test="${empty loginUser.changeName}">
										<img src="/resources/img/common/default_profile.png"
											class="offcanvas-profile">
									</c:when>
									<c:otherwise>
										<img src="${loginUser.changeName}" class="offcanvas-profile" />
									</c:otherwise>
								</c:choose>
							</c:when>
						</c:choose>

						<c:if test="${not empty loginUser }">

							<li class="nav-item dropdown m-4"><a class="side-black"
								href="#" id="offcanvasNavbarDropdown1" role="button"
								data-bs-toggle="dropdown" aria-expanded="false">${ loginUser.nickName }님</a>
								<ul class="dropdown-menu"
									aria-labelledby="offcanvasNavbarDropdown1">
									<li><a class="dropdown-item" href="/mypage/board">마이페이지</a></li>
									<li><a class="dropdown-item" href="/chat.ch">채팅방</a></li>
									<li><form id="logout-form2" action="/member/logout"
											method="post">
											<a class="dropdown-item" href="#"
												onclick="event.preventDefault(); logout();">로그아웃</a>
										</form></li>
								</ul></li>

						</c:if>

						<li class="nav-item offcanvas-text m-4"><a class="side-black"
							aria-current="page" href="/list.ho">방 찾기</a></li>

						<li class="nav-item dropdown m-4"><a class="side-black"
							href="#" id="offcanvasNavbarDropdown1" role="button"
							data-bs-toggle="dropdown" aria-expanded="false">셰어하우스 쉼</a>
							<ul class="dropdown-menu"
								aria-labelledby="offcanvasNavbarDropdown1">
								<li><a class="dropdown-item" href="#">쉼 소개</a></li>
							</ul></li>
						<li class="nav-item dropdown m-4"><a class="side-black"
							href="#" id="offcanvasNavbarDropdown2" role="button"
							data-bs-toggle="dropdown" aria-expanded="false">커뮤니티 </a>
							<ul class="dropdown-menu"
								aria-labelledby="offcanvasNavbarDropdown2">
								<li><a class="dropdown-item" href="/list.bo">자유게시판</a></li>
								<li><a class="dropdown-item" href="/list.fi">사람구해요</a></li>

								<li><a class="dropdown-item" href="/list.in">입주 후기 </a></li>

							</ul></li>
						<li class="nav-item dropdown m-4"><a class="side-black"
							href="#" id="offcanvasNavbarDropdown3" role="button"
							data-bs-toggle="dropdown" aria-expanded="false">고객센터 </a>
							<ul class="dropdown-menu"
								aria-labelledby="offcanvasNavbarDropdown3">
								<li><a class="dropdown-item" href="/notice.no">공지사항</a></li>
								<li><a class="dropdown-item" href="/faqList">자주 묻는 질문</a></li>
								<li><a class="dropdown-item" href="/event.ev">이벤트</a></li>
							</ul></li>
					</ul>
				</div>
			</div>
		</div>
	</nav>
</header>

<%@ include file="/WEB-INF/views/common/header-js.jsp"%>

