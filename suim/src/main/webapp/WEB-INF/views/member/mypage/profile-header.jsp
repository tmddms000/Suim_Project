<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<style>

.actives {
	color: black !important;
}

.profile {
	margin: 0 auto;
	width: 100%;
	height: 100%;
	border-radius: 50%;
}
.container {
	padding : 0px;
}
</style>

<div class="container" style="margin-top: 75px;">
  <div class="row">
    <div class="col-md-12">
      <div id="content" class="content content-full-width" style="background: white;">
        <!-- begin profile -->
        <div class="profile">
          <div class="profile-header">
            <div class="profile-header-cover"></div>
            <div class="profile-header-content">
              <div class="profile-header-img">
                <c:choose>
                  <c:when test="${empty m.changeName}">
                    <img src="/resources/img/common/default_profile.png" alt="사진" style="width: 100%; height: 100%">
                  </c:when>
                  <c:otherwise>
                    <img src="<c:out value='${m.changeName}'/>" alt="사진" style="width: 100%; height: 100%">
                  </c:otherwise>
                </c:choose>
              </div>
              <div class="profile-header-info">
                <c:choose>
                  <c:when test="${not empty m}">
                    <h4 class="m-t-10 m-b-5"><c:out value='${m.nickName}'/></h4>
                    <c:choose>
                      <c:when test="${not empty m.memberComment}">
                        <p class="m-b-10"><c:out value='${m.memberComment}'/></p>
                      </c:when>
                      <c:otherwise>
                        <p class="m-b-10">회원 메시지가 없습니다</p>
                      </c:otherwise>
                    </c:choose>
                    <button type="button" class="editModalBtn" data-bs-toggle="modal" data-bs-target="#myModal" style="color: white; height: 40px; background: transparent;"><i class="fa-solid fa-pen"></i> 채팅하기</button>
                  </c:when>
                  <c:otherwise>
                    <h4 class="m-t-10 m-b-5">손님</h4>
                    <p class="m-b-10">로그인 후 이용가능합니다.</p>
                    <a href="/member/login" style="color: white; height: 40px; background: transparent;">로그인</a>
                  </c:otherwise>
                </c:choose>
              </div>
            </div>
            <c:set var="currentUrl" value="${pageContext.request.requestURI}" />
            <c:set var="suffix" value="${fn:substringAfter(currentUrl, '/mypage/')}" />
            <c:set var="pageUrl" value="${fn:substringBefore(suffix, '.jsp')}" />
            <ul class="profile-header-tab nav nav-tabs">
                            <li class="nav-item">
                <a href="/mypage/timeline" class="nav-link ${fn:startsWith(pageUrl, 'timeline') ? 'actives' : ''}"><i class="fa-solid fa-address-card"></i> 회원 정보</a>
              </li>
              <li class="nav-item">
                <a href="/mypage/board" class="nav-link ${fn:startsWith(pageUrl, 'board') ? 'actives' : ''}"><i class="fa-solid fa-scroll"></i> 게시글 보기</a>
              </li>
            </ul>
          </div>
        </div>
      </div>
    </div>
  </div>
</div>