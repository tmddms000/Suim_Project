<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<head>
<meta charset="UTF-8">
<title>쉐어하우스 쉼</title>
<%@ include file="/WEB-INF/views/common/include.jsp"%>
<script src="https://unpkg.com/typeit@8.7.1/dist/index.umd.js"></script>
<link rel="stylesheet"
	href="https://unpkg.com/swiper@8/swiper-bundle.min.css" />
<script src="https://unpkg.com/swiper@8/swiper-bundle.min.js"></script>
<style>
body {
	background-color: rgb(248, 249, 250);
}

.green-text {
	font-size: 20px;
	color: green;
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

.branch-list .item .img-bx>img {
	width: 100%;
	height: 38%;
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
	transform: translate(0%, 0%) scale(1.1);
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


.num-container {
	display: flex;
	flex-wrap: wrap;
	justify-content: space-around;
	align-items: center;
	padding: 5%;
	background-color : rgb(230,240,250);
}

.num-item {
	text-align: center;
	padding: 10px;
	margin-bottom: 30px;
}

.in-title {
	font: 30px/1 'arial';
	color: gray;
	font-weight: 600;
	margin-bottom: 20px;
}

.nums {
	font: bold 80px/1 'arial';
	color: #343048;
}

.num-title {

	font-size : 60px;
	color : #FA5A51;
	background-color : rgb(230,240,250);
}

#num-unit {
	font: bold 30px/1 'arial';
	color: dimgray;
}


</style>
</head>
<body>
	<jsp:include page="/WEB-INF/views/common/header.jsp" />

	<section class="section main-search wow fadeInUp" style="visibility: visible; animation-name: fadeInUp;">
		<div class="text-center num-title">지금 쉼은?</div>
		<div class="num-container" id="num-container">	
			<div class="num-item">
				<h4 class="in-title">총 회원 수</h4>
				<span class="nums" data-count="${count.MEMBER_COUNT}">0</span><span id="num-unit">명</span><br>
			</div>
			<div class="num-item">
				<h4 class="in-title">셰어하우스</h4>
				<span class="nums" data-count="${count.HOUSE_COUNT}">0</span><span id="num-unit">개</span><br>
			</div>
			<div class="num-item">
				<h4 class="in-title">입주 후기</h4>
				<span class="nums" data-count="${count.INREVIEW_COUNT}">0</span><span id="num-unit">개</span><br>
			</div>
			<div class="num-item">
				<h4 class="in-title">만족도</h4>
				<span class="nums" data-count="95">0</span><span id="num-unit">%</span><br>
			</div>
		</div>
	</section>

	<section class="projects-section bg-white" id="projects">
		<div class="container px-4 px-lg-5">
			<!-- Featured Project Row-->
			<div class="row gx-0 justify-content-center">
				<div class="col-lg-6">
					<img class="img-fluid" src="/resources/img/common/house.png"
						alt="..." />
				</div>
				<div class="col-lg-6 order-lg-first">
					<div class="bg-black text-center h-100 project">
						<div class="d-flex h-100">
							<div class="project-text w-100 my-auto text-center text-lg-right">
								<h4 class="text-white">쉐어하우스 쉼(SUIM)</h4>
								<p class="mb-0 text-white-50">쉐어하우스 쉼(SUIM)은 2023년에 개설된 국내
									최대 규모의 쉐어하우스 커뮤니티에요.</p>
							</div>
						</div>
					</div>
				</div>
			</div>
			<!-- Project One Row-->
			<div class="row gx-0 mb-5 mb-lg-0 justify-content-center">
				<div class="col-lg-6">
					<img class="img-fluid" src="/resources/img/common/friend.png"
						alt="..." style="margin-left: 50px;" />
				</div>
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
				<div class="col-lg-6">
					<img class="img-fluid" src="/resources/img/common/highfive.png"
						alt="..." />
				</div>
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
		<div class="container px-4 px-lg-5 text-center">후기사진, 게시판 등등 추가
			할 곳</div>
	</section>

	<jsp:include page="/WEB-INF/views/common/footer.jsp" />

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

	<script>
	function isInViewport(element) {
	    var elementTop = element.offset().top;
	    var viewportTop = $(window).scrollTop();
	    var viewportBottom = viewportTop + $(window).height();
	    return elementTop <= viewportBottom;
	}

	// Scroll event listener
	$(window).on('scroll', function() {
	    if (isInViewport($('.nums'))) {
	        $('.nums').each(function () {
	            const $this = $(this),
	                countTo = $this.attr('data-count');

	            $({
	                countNum: $this.text()
	            }).animate({
	                countNum: countTo
	            }, {
	                duration: 1500,
	                easing: 'linear',
	                step: function () {
	                    $this.text(Math.floor(this.countNum));
	                },
	                complete: function () {
	                    $this.text(this.countNum.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ','));
	                    // Add any additional logic you want to perform after the animation completes
	                }
	            });
	        });
	    }
	});
    </script>
</body>
</html>