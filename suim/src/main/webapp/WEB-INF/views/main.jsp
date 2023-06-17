<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<head>
<meta charset="UTF-8">
<title>쉐어하우스 쉼</title>
		<%@ include file="/WEB-INF/views/common/include.jsp" %>
		<script src="https://unpkg.com/typeit@8.7.1/dist/index.umd.js"></script>
		<link rel="stylesheet" href="https://unpkg.com/swiper@8/swiper-bundle.min.css" />
  		<script src="https://unpkg.com/swiper@8/swiper-bundle.min.js"></script>
  		<style>
body {
	background-color : rgb(248,249,250);
}
.green-text {

	font-size : 20px;
	color : green;

}

.main-title {
    margin-bottom: 3.125rem;
    text-align: center;
    letter-spacing: -0.03em;
    position: relative;
    overflow: hidden;
    line-height: 1.3;
}   
.main-title__title {
font-size: 2.875rem;
font-weight: 700;
color: #111;
}
.main-title__text {
    font-size: 1.875rem;
    font-weight: 300;
    color: #333;
    margin-top: 0.3em;
}
.container-max {
    width: 100%;
    padding-right: 20px;
    padding-left: 20px;
    margin-right: auto;
    margin-left: auto;
    max-width: 1840px;
}

.main-search__wrap {
    overflow: hidden;
    background-color: #fff;
    border-radius: 2.1875rem;
    box-shadow: 0 0 1.25rem rgba(0, 0, 0, 0.1);
    padding: 3.125rem;
    justify-content: center;
    align-items: center;
    display: flex;
    text-align: left;
}

.main-search {
    margin: 1.875rem auto;
    overflow: visible !important;
}

.main-search .txt-bx .desc {
    font-size: 1.875rem;
    font-weight: 300;
    letter-spacing: -0.03em;
    color: #111;
}

.main-search .txt-bx .title {
    margin-top: 0.3em;
    font-size: 2.875rem;
    color: #000;
    letter-spacing: -0.03em;
}

.branch-list {
    display: flex;
    flex-wrap: wrap;
    position: relative;
    overflow: hidden;
    margin-left: -0.9375rem;
    margin-right: -0.9375rem;
}

ol, ul, li {
    padding: 0;
    list-style: none;
}

.branch-list .item .img-bx > img {
    width : 100%;
    height : 38%;
}
.branch-list .item .img-bx .label {
    width: 2.5rem;
    position: absolute;
    top: 0;
    right: 0.9375rem;
}

.branch-list .item {
    padding: 0 0.9375rem;
}

.image-wrapper {
  position: relative;
  overflow: hidden;
}

.image-wrapper img {
  transition: 500ms all;
}

.image-wrapper:hover img {
  transform: translate(0%,0%) scale(1.1);
}

li.item {
  height: 400px; /* Adjust the height as desired */
}

.font-weight-bold {
    font-weight: 700 !important;
}

.branch-list .item--share .txt-bx .em {
    color: #FA5A51;
}
.branch-list .item .txt-bx .title {
    font-size: 1.125rem;
    color: #111;
    font-weight: 500;
}

.main-title .link {
    bottom: 0;
    right: 0;
    position: absolute;
    z-index: 2;
    font-size: 1.125rem;
}

.branch-list .item .img-bx {
    border-radius: 0.9375rem; 
    display: block;
    position: relative;
    overflow: hidden;
}

  		</style>
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
        
        <section class="section main-search wow fadeInUp" style="visibility: visible;animation-name: fadeInUp;">
        <div class="container-max">
          <div class="main-search__wrap">
            <div class="txt-bx">
              <p class="desc">프리미엄 셰어하우스 커뮤니티 사이트</p>
              <p class="title"><span class="font-weight-bold">쉼</span>에서는 <span class="font-weight-bold">3250</span>명의 회원이 가입했어요.</p>
            </div>
            </a>
          </div>
        </div>
      </section>
        
        
        
        
		<div class="container" style="margin-top : 20px;">
		
		<div class="main-title">
            <h1 class="main-title__title">쉐어하우스</h1>
            <p class="main-title__text">함께 살며 누리는 즐거운 주거경험</p>
            <a href="./branch/index.html?s_mode=1" class="link"> 더보기 </a>
          </div>
		
		<ul class="branch-list">
	
			  <c:forEach var="house" items="${listHouse}" varStatus="loop">
			  <c:url var="houseUrl" value="/detail.ho">
				<c:param name="hno" value="${house.houseNo}" />
			  </c:url>
			  
              <li class="item col-6 col-lg-3 item--share">
              <a href="${houseUrl}">
              <div class="img-bx hover-effect wrap image-wrapper">
                <img src="resources/img/house/uploadFiles/${house.changeName}" alt="">
              </div>
              <div class="txt-bx">
                <div class="title" style="margin-top : 10px;">${house.houseName}</div>
                  <div class="txt em">쉐어하우스(${house.resGender})</div>
                  
                  <c:set var="deposit" value="${house.deposit}" />
                  <c:set var="rent" value="${house.rent}" />

                  <div class="txt">보증금 
                  	<c:choose>
					  <c:when test="${deposit >= 10000000}">
					    <fmt:formatNumber value="${deposit/10000}" pattern="###,###'천만원'" />
					  </c:when>
					  <c:otherwise>
					    <fmt:formatNumber value="${deposit/10000}" pattern="###'만원'" />
					  </c:otherwise>
				 	</c:choose> | 월 <c:choose>
					  <c:when test="${rent >= 10000000}">
					    <fmt:formatNumber value="${rent/10000}" pattern="###,###'천만원'" />
					  </c:when>
					  <c:otherwise>
					    <fmt:formatNumber value="${rent/10000}" pattern="###'만원'" />
					  </c:otherwise>
				 	</c:choose></div>
						                       
                    <c:if test="${distance[loop.index] ne null}">
                        <div class="slide-caption">희망지역으로부터 약 ${distance[loop.index]} km 떨어져 있어요.</div>
                    </c:if>
                    <c:if test="${distance[loop.index] eq null}">
                        <div class="slide-caption">희망지역으로부터 약 ???? km 떨어져 있어요.</div>
                    </c:if>
                
                
                
                
               <p class="btn btn--active">13명 입주가능</p>
               </div>
              </a>
            </li>
            </c:forEach>
       </ul>
			
		
		</div>


























<%-- 

        <!-- 캐러셀(슬라이드쇼) -->
        <section class="bg-light text-center" id="about">
			   <div class="container px-4 px-lg-5">
				    <div class="row">
				    	<div class="main-title">
				    	<h1 class="main-title__title">셰어하우스</h1>
				    	<p class="main-title__text">함께 살며 누리는 즐거운 주거경험</p>
				    	</div>			  		    
				        <div class="swiper-container">
				            <div class="swiper-wrapper" style="margin-top : 70px;">
				                <c:forEach var="house" items="${listHouse}" varStatus="loop">
				                    <div class="swiper-slide col-xl-6">
				                        <c:url var="houseUrl" value="/detail.ho">
				                            <c:param name="hno" value="${house.houseNo}" />
				                        </c:url>
				                        <a href="${houseUrl}">
				                        <div class="zoom-image">
				                            <img src="resources/img/house/uploadFiles/${house.changeName}" alt="사진">
				                        </div>
				                            <div class="slide-caption">${house.houseName} | 남녀공용</div>
				                            <div class="slide-caption">${house.houseAddress}</div>
				                        <c:if test="${distance[loop.index] ne null}">
				                            <div class="slide-caption">희망지역으로부터 약 ${distance[loop.index]} km 떨어져 있어요.</div>
				                        </c:if>
				                        <c:if test="${distance[loop.index] eq null}">
				                            <div class="slide-caption">희망지역으로부터 약 ???? km 떨어져 있어요.</div>
				                        </c:if>
				                        
				                        </a>
				                    </div>
				                </c:forEach>
				            </div>
				            <div class="swiper-pagination"></div>
				        </div>
				        <div style="margin-top : 20px; margin-bottom : 30px;">
					        <c:if test="${loginUser ne null}">
					        	<c:if test="${loginUser.area ne null }">
					        	<div class="text-center green-text">희망지역에 따른 셰어하우스 추천 장소에요!</div>
					        	</c:if>
					        	<c:if test="${loginUser.area eq null }">
					        	<div class="text-center green-text">희망지역을 설정하면 셰어하우스 추천을 받을 수 있어요!</div>
					        	</c:if>
					        </c:if>
					        <c:if test="${loginUser eq null}">
					        <div class="text-center green-text">로그인 하면 희망지역에 따라 셰어하우스 추천을 받을 수 있어요!</div>
					        </c:if>
			        </div>
			    </div>
			</div>
        </section> --%>


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
                
                new Swiper('.swiper-container', {
                	  autoplay: {
                	    delay: 3000
                	  },
                	  loop: true,
                	  centeredSlides: true,
                	  pagination: {
                	    el: '.swiper-pagination',
                	    clickable: true
                	  },
                	  navigation: {
                	    prevEl: '.swiper-button-prev',
                	    nextEl: '.swiper-button-next'
                	  }
                	});
         </script>
</body>
</html>