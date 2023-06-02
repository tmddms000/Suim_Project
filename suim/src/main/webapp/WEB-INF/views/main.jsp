<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<head>
<meta charset="UTF-8">
<title>쉐어하우스 쉼</title>
		<%@ include file="/WEB-INF/views/common/include.jsp" %>
</head>

<c:set var="currentPath" value="${pageContext.request.servletPath}" />

<c:if test="${!currentPath.equals('/WEB-INF/views/main.jsp')}">
  <script>
    window.addEventListener('DOMContentLoaded', function() {
      var navbarCollapsible = document.querySelector('#mainNav');
      navbarCollapsible.style.backgroundColor = 'white';
    });
  </script>
</c:if>

<body>    
 	<jsp:include page="/WEB-INF/views/common/header.jsp"/>
	<!-- 메인 영상 부분-->
        <div class="masthead">
                <div class="container px-4 px-lg-5 d-flex h-100 align-items-center justify-content-center">
                    <div class="d-flex justify-content-center">
                        <div class="text-center">
                            <h2 class="text-white mb-4" id="text" style="font-size : 24px">내가 잘 지낼 수 있을까..?</h2>
                            <div class="search-box">
                                <!-- 지도 검색 부분 (홍재님) -->
                                <form method="get" action="list.ho">
                                <input type="text" name="searchKeyword" placeholder="지역명, 주변명 입력">
                                <button type="submit">
                                    <i class="fa fa-search" style="color : rgb(249,88,10)"></i>
                                </button>
                            </form>
                            </div>
                        </div>
                    </div>
                </div>

            <!-- 영상 -->
            <video autoplay muted loop style="width: 100%; height: 100%;">
                <source src="/resources/video/city.mp4" type="video/mp4">
            </video>
        </div>
	<a href="/notice/faqList.html">링크</a>

        <!-- 캐러셀(슬라이드쇼) -->
        <section class="bg-light text-center" id="about">
            <div class="container px-4 px-lg-5">
                <div class="row justify-content-center">
                    <div class="col-lg-6">
                        <div id="carouselExampleInterval" class="carousel slide" data-bs-ride="carousel">
                            <div class="carousel-inner">
                              <div class="carousel-item active" data-bs-interval="2000">
                                <img src="/resources/img/common/room.jpg" class="d-block" alt="..." style="width : 700px; height:400px;">
                              </div>
                              <div class="carousel-item" data-bs-interval="2000">
                                <img src="/resources/img/common/back.jpg" class="d-block" alt="..." style="width : 700px; height:400px;">
                              </div>
                            </div>
                            <button class="carousel-control-prev" type="button" data-bs-target="#carouselExampleInterval" data-bs-slide="prev">
                              <span class="carousel-control-prev-icon" aria-hidden="true"></span>
                              <span class="visually-hidden">이전</span>
                            </button>
                            <button class="carousel-control-next" type="button" data-bs-target="#carouselExampleInterval" data-bs-slide="next">
                              <span class="carousel-control-next-icon" aria-hidden="true"></span>
                              <span class="visually-hidden">다음</span>
                            </button>
                            <span class="text-red">가까운 위치의 쉐어하우스에요! 🙄</span>
                          </div>
                    </div>
                </div>
            </div>
        </section>


        <!-- Projects-->
        <section class="projects-section bg-white" id="projects">
            <div class="container px-4 px-lg-5">
                <!-- Featured Project Row-->
                <div class="row gx-0 justify-content-center">
                    <div class="col-lg-6"><img class="img-fluid" src="/resources/img/common/house.png" alt="..." /></div>
                    <div class="col-lg-6 order-lg-first">
                        <div class="bg-black text-center h-100 project">
                            <div class="d-flex h-100">
                                <div class="project-text w-100 my-auto text-center text-lg-right">
                                    <h4 class="text-white">쉐어하우스 쉼(SUIM)</h4>
                                    <p class="mb-0 text-white-50">쉐어하우스 쉼(SUIM)은 2023년에 개설된 국내 최대 규모의 쉐어하우스 커뮤니티에요.</p>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <!-- Project One Row-->
                <div class="row gx-0 mb-5 mb-lg-0 justify-content-center">
                    <div class="col-lg-6"><img class="img-fluid" src="/resources/img/common/friend.png" alt="..." style="margin-left : 50px;"/></div>
                    <div class="col-lg-6">
                        <div class="bg-black text-center h-100 project">
                            <div class="d-flex h-100">
                                <div class="project-text w-100 my-auto text-center text-lg-left">
                                    <h4 class="text-white">쉼 쉐어하우스에서는?</h4>
                                    <p class="mb-0 text-white-50">같이 살 하우스메이트를 구할 수 있어요!</p>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <!-- Project Two Row-->
                <div class="row gx-0 justify-content-center">
                    <div class="col-lg-6"><img class="img-fluid" src="/resources/img/common/highfive.png" alt="..." /></div>
                    <div class="col-lg-6 order-lg-first">
                        <div class="bg-black text-center h-100 project">
                            <div class="d-flex h-100">
                                <div class="project-text w-100 my-auto text-center text-lg-right">
                                    <h4 class="text-white">맘에 드는 방을 찾았나요?</h4>
                                    <p class="mb-0 text-white-50">지금 가입하여 소통해보세요!</p>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </section>
    
        <!-- 추가사항 -->
        <section class="contact-section bg-warning">
            <div class="container px-4 px-lg-5 text-center">
                후기사진, 게시판 등등 추가 할 곳
            </div>
        </section>
        
        <jsp:include page="/WEB-INF/views/common/footer.jsp"/>
        
        <!-- 메인페이지 스크립트 -->
            <script>
                document.addEventListener('DOMContentLoaded', () => {
            
                    new TypeIt('#text', {
                    speed: 100,
                    startDelay: 900,
                    afterComplete: function (instance) { //
                            instance.destroy();
                        } 
                    })
                    .pause(1000)
                    .delete(16, { delay : 1000 })
                    .type('라고 고민될땐?', { delay : 1000 })
                    .move(5)
                    .delete(10)
                    .type('지금 당장 가입해보세요. ')
                    .type('<span style="color: #fa6b6f;">"쉼"</span>', { delay : 1000 })
                    .go();
                    
                });
         </script>
</body>
</html>