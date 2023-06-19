<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

        <!-- Sidebar Start -->
        <div class="sidebar pe-4 pb-3">
            <nav class="navbar bg-light navbar-light">
                <a href="/admin/dashboard" class="navbar-brand mx-4 mb-3">
                    <h3 class="text-primary"><i class="fa fa-hashtag me-2"></i>SUIM</h3>
                </a>
                <div class="d-flex align-items-center ms-4 mb-4">
                    <div class="position-relative">
                        <c:choose>
				        		<c:when test="${not empty loginUser.changeName}">
                                	<img class="rounded-circle me-lg-2" src="${loginUser.changeName}" alt="" style="width: 40px;height: 40px;margin-right:unset!important;">
                               	</c:when>
						        <c:otherwise>
						            <img class="rounded-circle me-lg-2" src="/resources/img/common/default_profile.png" style="width: 40px; height: 40px;"></img>
						        </c:otherwise>
						</c:choose>
                        <div class="bg-success rounded-circle border border-2 border-white position-absolute end-0 bottom-0 p-1"></div>
                    </div>
                </div>
                
                <c:set var="currentUrl" value="${pageContext.request.requestURI}" />
				<c:set var="prefix" value="${fn:substringBefore(currentUrl, '/admin/')}" />
				<c:set var="suffix" value="${fn:substringAfter(currentUrl, '/admin/')}" />
				<c:set var="pageType" value="${fn:substringBefore(suffix, '.')}"/>
				<script>
				  // console.log("pageType:", '${pageType}');
				</script>
                <div class="navbar-nav w-100">
                    <a href="/admin/dashboard" class="nav-item nav-link ${pageType eq 'dashboard' ? 'active' : ''}"><i class="fa fa-tachometer-alt me-2"></i>대시보드</a>
       				<a href="/admin/list.me" class="nav-item nav-link ${pageType eq 'member/member' ? 'active' : ''}"><i class="far fa-file-alt me-2"></i>회원 관리</a>
                    <a href="/admin/list.ho" class="nav-item nav-link ${pageType eq 'house/house' ? 'active' : ''}"><i class="fa fa-laptop me-2"></i>쉐어하우스 관리</a>
                    <a href="/admin/adminRez.ho" class="nav-item nav-link ${pageType eq 'board/reservation' ? 'active' : ''}"><i class="fa fa-calendar me-2"></i>예약 관리</a>
                    
                    <div class="nav-item dropdown">
                        <a href="#" class="nav-link dropdown-toggle" data-bs-toggle="dropdown"><i class="fa fa-keyboard me-2"></i>커뮤니티 관리</a>
                        <div class="dropdown-menu bg-transparent border-0">
                            <a href="/adminBoardList.bo" class="dropdown-item nav-link ${pageType eq 'board/freeBoard' ? 'active' : ''}">자유게시판</a>
                            <a href="/adminFindList.bo" class="dropdown-item">사람 구해요</a>
                            <a href="/adminInReviewList.bo" class="dropdown-item">플랫폼 이용후기</a>
                        </div>
                    </div>
                    <a href="list.re" class="nav-item nav-link ${pageType eq 'report/report' ? 'active' : ''}"><i class="fa fa-chart-bar me-2"></i>신고 관리</a>
                    
                    <!-- 이벤트 관리 -->
                    
                     <div class="nav-item dropdown">
                        <a href="event.ev" class="nav-link dropdown-toggle" data-bs-toggle="dropdown"><i class="bi bi-calendar-event-fill"></i>이벤트 관리</a>
                        <div class="dropdown-menu bg-transparent border-0">
                            <a href="/admin.ev" class="dropdown-item">이벤트 관리</a>
                        	<a href="/enrollForm.ev" class="dropdown-item">이벤트 게시글 작성</a>
                            <a href="/event.ev" class="dropdown-item">이벤트 목록 바로가기</a>
                        </div>
                    </div>
                    
                    <!-- 공지사항 관리 -->
                    <div class="nav-item dropdown">
                    	<a href="admin.no" class="nav-link dropdown-toggle" data-bs-toggle="dropdown"><i class="bi bi-megaphone-fill"></i>공지사항 관리</a>
                        <div class="dropdown-menu bg-transparent border-0">
                            <a href="/admin.no" class="dropdown-item">공지사항 관리</a>
                        	<a href="/enrollForm.no" class="dropdown-item">공지사항 게시글 작성</a>
                            <a href="/notice.no" class="dropdown-item">공지사항 목록 바로가기</a>  
                        </div>
                    </div>
                </div>
            </nav>
        </div>
        <!-- Sidebar End -->

        <!-- Content Start -->
            <!-- Navbar Start -->
            <!-- Navbar End -->
        <!-- Content End -->