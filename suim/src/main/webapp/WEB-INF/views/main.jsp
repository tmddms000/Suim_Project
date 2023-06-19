<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ page import="java.util.Date"%>
<head>
<meta charset="UTF-8">
<title>쉐어하우스 쉼</title>
<%@ include file="/WEB-INF/views/common/include.jsp"%>
<script src="https://unpkg.com/typeit@8.7.1/dist/index.umd.js"></script>
<script
	src="//cdn.jsdelivr.net/npm/slick-carousel@1.8.1/slick/slick.min.js"></script>
<link rel="stylesheet"
	href="//cdn.jsdelivr.net/npm/slick-carousel@1.8.1/slick/slick.css" />
<link rel="stylesheet"
	href="//cdn.jsdelivr.net/npm/slick-carousel@1.8.1/slick/slick-theme.css" />
<link rel="stylesheet" href="/resources/css/common/main.css" />

</head>

<c:set var="currentPath" value="${pageContext.request.servletPath}" />
<style>
.shareBtn {
	padding: 6px;
	height: 20px;
	background: rgb(250, 107, 111);
	border: rgb(250, 107, 111);
	border-radius: 2px;
	font-style: normal;
	font-size: 12px;
	font-weight: 500;
	color: #fff;
	line-height: 9px;
	margin-right: 14px;
}

.share-content {
	font-style: normal;
	font-weight: 400;
	font-size: 12px;
	color: #828282;
}
</style>


<body>
	<jsp:include page="/WEB-INF/views/common/header.jsp" />
	<div class="masthead">
		<div
			class="container px-4 px-lg-5 d-flex h-100 align-items-center justify-content-center">
			<div class="d-flex justify-content-center">
				<div class="text-center">
					<h2 class="text-white mb-4" id="text" style="font-size: 24px">내가
						잘 지낼 수 있을까..?</h2>
					<div class="search-box">
						<!-- 지도 검색 부분 (홍재님) -->
						<form method="get" action="list.ho">
							<input type="text" name="searchKeyword" placeholder="지역명, 주변명 입력">
							<button type="submit">
								<i class="fa fa-search" style="color: rgb(249, 88, 10)"></i>
							</button>
						</form>
					</div>
				</div>
			</div>
		</div>

		<video autoplay muted loop style="width: 100%; height: 100%;">
			<source src="/resources/video/city.mp4" type="video/mp4">
		</video>
	</div>

	<div class="container">
		<h1 class="main-title__title text-center">하우스메이트 게시판 목록</h1>
		<div class="row">

			<c:forEach items="${filterFind}" var="f">
				<div class="house-image">
					<a class="a-black" href="/detail.fi?fno=${f.findNo}"> <img
						src="${f.thumbnail}" alt="이미지">
					</a> <a class="a-red" href="/detail.fi?fno=${f.findNo}">
						<div class="find-title">${f.findTitle}

							<a href="/detail.fi?fno=${f.findNo}#replyArea"
								style="color: rgb(240, 20, 60)"> <c:if
									test="${f.freplyCount > 0}">
									<span class="reply-cell">[${f.freplyCount}]</span>
								</c:if>
						</div>
						<div class="find-writer">${f.nickName}</div>
					</a>


				</div>
			</c:forEach>
		</div>
		<div class="post-list" style="margin-top: 80px;">
			<div class="row">
				<div class="col-6">
					<ul class="list-group list-group-flush">
						<c:forEach items="${listFind}" var="f" varStatus="status">
							<c:if test="${status.index < 4}">
								<li class="ellipsis"><span style="float: right">
										&nbsp;${f.findDate} </span> <fmt:formatDate var="today"
										pattern="yyyy-MM-dd" value="<%=new Date()%>" /> <c:if
										test="${not empty f.findDate and f.findDate == today}">

										<span><img height="12" width="12" alt="최신등록일자"
											src="/resources/img/common/icon_new.gif"></span>
									</c:if> <c:if test="${f.findDate != today}">
										<span class="lightgray"><i class="fa fa-caret-right"></i></span>
									</c:if> <a class="a-red" href="/detail.fi?fno=${f.findNo}"> <c:if
											test="${not empty f.findTitle}">
					                    ${f.findTitle}
					                    </a> <a href="/detail.fi?fno=${f.findNo}#replyArea"
									style="color: rgb(240, 20, 60)"> <c:if
											test="${f.freplyCount > 0}">
											<span class="reply-cell">[${f.freplyCount}]</span>
										</c:if>
								</a> <c:if test="${not empty f.thumbnail}">
										<span><img height="15" width="15" alt="이미지 첨부유무"
											src="/resources/img/board/ico_img.gif"></span>
									</c:if>
							</c:if>
							</li>
							</c:if>
						</c:forEach>
					</ul>
				</div>
				<div class="col-6">
					<ul class="list-group list-group-flush">
						<c:forEach items="${listFind}" var="f" varStatus="status">
							<c:if test="${status.index >= 4 && status.index < 8}">
								<li class="ellipsis"><span style="float: right">
										&nbsp;${f.findDate} </span> <fmt:formatDate var="today"
										pattern="yyyy-MM-dd" value="<%=new Date()%>" /> <c:if
										test="${not empty f.findDate and f.findDate == today}">
										<span><img height="12" width="12" alt="최신등록일자"
											src="/resources/img/common/icon_new.gif"></span>
									</c:if> <c:if test="${f.findDate != today}">
										<span class="lightgray"><i class="fa fa-caret-right"></i></span>
									</c:if> <a class="a-red" href="/detail.fi?fno=${f.findNo}"> <c:if
											test="${not empty f.findTitle}">
                            			${f.findTitle}
                            			</a> <a
									href="/detail.fi?fno=${f.findNo}#replyArea"
									style="color: rgb(240, 20, 60)"> <c:if
											test="${f.freplyCount > 0}">
											<span class="reply-cell">[${f.freplyCount}]</span>
										</c:if>
								</a> <c:if test="${not empty f.thumbnail}">
										<span><img height="15" width="15" alt="이미지 첨부유무"
											src="/resources/img/board/ico_img.gif"></span>
									</c:if>
							</c:if>

							</li>
							</c:if>
						</c:forEach>
					</ul>
				</div>

			</div>
			<h1 class="text-center"
				style="margin-top: 50px; margin-bottom: 50px;">
				<a href="/list.fi"><i class="fa-solid fa-share"></i> 하우스메이트 게시판
					목록 더보기</a>
			</h1>
		</div>
	</div>




	<div class="container" style="margin-top: 50px;">

		<div class="main-title">
			<div class="main-title__title text-center">추천 셰어하우스</div>
			<p class="main-title__text">
				<c:if test="${loginUser ne null}">
					<c:if test="${loginUser.area ne null }">
						<div class="text-center green-text">희망지역에 가까운 셰어하우스에요!</div>
					</c:if>
					<c:if test="${loginUser.area eq null }">
						<div class="text-center green-text">희망지역을 설정하면 셰어하우스 추천을 받을
							수 있어요!</div>
					</c:if>
				</c:if>
				<c:if test="${loginUser eq null}">
					<div class="text-center green-text">로그인 하면 희망지역과 가까운 셰어하우스
						추천을 받을 수 있어요!</div>
				</c:if>
			</p>
			<a href="/list.ho" class="link"> 더보기 </a>
		</div>
		<ul class="branch-list">

			<c:forEach var="house" items="${listHouse}" varStatus="loop">
				<c:url var="houseUrl" value="/detail.ho">
					<c:param name="hno" value="${house.houseNo}" />
				</c:url>

				<li class="item col-6 col-lg-3 item--share"><a class="a-black"
					href="${houseUrl}">
						<div class="img-bx hover-effect wrap image-wrapper">
							<img src="resources/img/house/uploadFiles/${house.changeName}"
								alt="">
						</div>
						<div class="txt-bx" style="padding-top: 16px;">

							<button class="shareBtn">셰어하우스</button>
							<span class="share-content">${house.resGender}</span>
							<div class="title">${house.houseName}</div>


							<c:set var="deposit" value="${house.deposit}" />
							<c:set var="rent" value="${house.rent}" />

							<div class="txt share-content">
								보증금
								<c:choose>
									<c:when test="${deposit >= 10000000}">
										<fmt:formatNumber value="${deposit/10000}"
											pattern="###,###'천만원'" />
									</c:when>
									<c:otherwise>
										<fmt:formatNumber value="${deposit/10000}" pattern="###'만원'" />
									</c:otherwise>
								</c:choose>
								| 월
								<c:choose>
									<c:when test="${rent >= 10000000}">
										<fmt:formatNumber value="${rent/10000}" pattern="###,###'천만원'" />
									</c:when>
									<c:otherwise>
										<fmt:formatNumber value="${rent/10000}" pattern="###'만원'" />
									</c:otherwise>
								</c:choose>
							</div>

							<c:if test="${distance[loop.index] ne null}">
								<div class="slide-caption">희망지역으로부터
									${distance[loop.index]} km 떨어져 있어요.</div>
							</c:if>
							<c:if test="${distance[loop.index] eq null}">
								<div class="slide-caption">희망지역으로부터 ??? km 떨어져 있어요.</div>
							</c:if>
						</div>
				</a></li>
			</c:forEach>
		</ul>

	</div>

	<section style="height: 250px; margin-bottom: 150px; margin-top: 50px;">
		<div class="container">
			<div class="text-center"
				style="font-size: 32px; margin-bottom: 30px;">
				셰어하우스 입주후기에요! <a href="/list.fi" class="link"
					style="float: right; font-size: 1.125rem; margin-bottom: 5px;">
					더보기 </a>
			</div>

			<div class="slider">
				<div class="slider__slides">
					<c:forEach items="${ilist}" var="i">

						<div class="slider__slide">
							<a class="a-black" href="/detail.in?ino=${i.inrNo}"> <img
								src="${i.thumbnail}" alt="">
							</a> <a class="a-red" href="/detail.in?ino=${i.inrNo}">
								<div class="text-center">${i.inrTitle}</div>
							</a>

						</div>

					</c:forEach>
				</div>
				<div class="slider__dots"></div>
				<button class="slider__prev"></button>
				<button class="slider__next"></button>
			</div>
		</div>
		
	</section>

	<jsp:include page="/WEB-INF/views/common/footer.jsp" />


	<script src="/resources/js/common/main.js"></script>


</body>
</html>