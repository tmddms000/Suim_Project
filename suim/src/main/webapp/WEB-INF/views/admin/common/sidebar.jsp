<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
	

        <!-- Sidebar Start -->
        <div class="sidebar pe-4 pb-3">
            <nav class="navbar bg-light navbar-light">
                <a href="index.html" class="navbar-brand mx-4 mb-3">
                    <h3 class="text-primary"><i class="fa fa-hashtag me-2"></i>SUIM</h3>
                </a>
                <div class="d-flex align-items-center ms-4 mb-4">
                    <div class="position-relative">
                        <img class="rounded-circle" src="/resources/img/admin/user.jpg" alt="" style="width: 40px; height: 40px;">
                        <div class="bg-success rounded-circle border border-2 border-white position-absolute end-0 bottom-0 p-1"></div>
                    </div>
                    
                    <%--
                    <c:choose>
			           	<c:when test="${ empty loginUser }">
			                <!-- 로그인 전 -->
			                <a href="enrollForm.me">회원가입</a>
			                <a data-toggle="modal" data-target="#loginModal">로그인</a> <!-- 모달의 원리 : 이 버튼 클릭시 data-target에 제시되어있는 해당 아이디의 div요소를 띄워줌 -->
			            </c:when>
		               	<c:otherwise>
			                <!-- 로그인 후 -->
		                    <div class="ms-3">
		                        <h6 class="mb-0">${ loginUser.userName }</h6>
		                        <a href="logout.me">로그아웃</a>
		                        <!-- <span>관리자</span> -->
		                    </div>
	                    </c:otherwise>
            		</c:choose>
            		--%>
                </div>
                <div class="navbar-nav w-100">
                    <a href="index.ad" class="nav-item nav-link active"><i class="fa fa-tachometer-alt me-2"></i>대시보드</a>
                    <a href="list.me" class="nav-item nav-link"><i class="fa fa-th me-2"></i>회원 관리</a>

                    <div class="nav-item dropdown">
                        <a href="#" class="nav-link dropdown-toggle" data-bs-toggle="dropdown"><i class="fa fa-laptop me-2"></i>쉐어하우스 관리</a>
                        <div class="dropdown-menu bg-transparent border-0">
                            <a href="list.ho" class="dropdown-item">쉐어하우스 관리</a>
                            <a href="typography.html" class="dropdown-item">매출 통계</a>
                        </div>
                    </div>

                    <!-- <a href="widget.html" class="nav-item nav-link"><i class="fa fa-th me-2"></i>쉐어하우스 관리</a>
                    <a href="form.html" class="nav-item nav-link"><i class="fa fa-keyboard me-2"></i>쉐어하우스 관리</a> -->
                    <div class="nav-item dropdown">
                        <a href="#" class="nav-link dropdown-toggle" data-bs-toggle="dropdown"><i class="fa fa-laptop me-2"></i>커뮤니티 관리</a>
                        <div class="dropdown-menu bg-transparent border-0">
                            <a href="board.html" class="dropdown-item">자유게시판</a>
                            <a href="find.html" class="dropdown-item">사람 구해요</a>
                            <a href="inreview.html" class="dropdown-item">플랫폼 이용후기</a>
                        </div>
                    </div>
                    <a href="list.re" class="nav-item nav-link"><i class="fa fa-chart-bar me-2"></i>신고 관리</a>
                    <div class="nav-item dropdown">
                        <a href="#" class="nav-link dropdown-toggle" data-bs-toggle="dropdown"><i class="far fa-file-alt me-2"></i>환경설정</a>
                        <div class="dropdown-menu bg-transparent border-0">
                            <a href="login.html" class="dropdown-item">Sign In</a>
                            <a href="signup.html" class="dropdown-item">Sign Up</a>
                            <a href="404.html" class="dropdown-item">404 Error</a>
                            <a href="blank.html" class="dropdown-item">Blank Page</a>
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
