<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<%@ page import="java.util.Date"%>





<head>
<meta charset="UTF-8">

<link rel="stylesheet"
	href="/resources/css/summernote/summernote-lite.css">
<link rel="stylesheet" href="/resources/css/board/board.css">

<!-- 나중에 한번에 include 할 부분 -->
<!-- 부트스트랩 -->
<link href="/resources/css/common/styles.css" rel="stylesheet" />
<!-- 폰트어썸 icon -->
<script src="https://use.fontawesome.com/releases/v6.3.0/js/all.js"
	crossorigin="anonymous"></script>
<!-- reset.css  -->
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/normalize/8.0.1/normalize.min.css" />
<!-- 부트스트랩 자바스크립트 -->
<script
	src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"></script>
<!-- 타입잇 자바스크립트 -->
<script src="https://unpkg.com/typeit@8.7.1/dist/index.umd.js"></script>
<!-- jQuery -->
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.3/jquery.min.js"></script>
<!-- 1:1문의 채팅 -->
<script src="/resources/js/common/chatbot.js"></script>
<!-- 나중에 한번에 include 할 부분 -->
<style>
.bestcontainer {
	display: grid;
	grid-template-columns: repeat(2, 1fr);
	grid-gap: 20px;
}

.item {
	border: 1px solid #ddd;
	padding: 10px;
}

.item .title:hover {
	color: rgb(250, 107, 111);
	cursor: pointer;
	font-size: x-large;
}

#rcount {
	color: rgb(250, 107, 111);
}

#pagingArea {
	display: flex;
	justify-content: center;
}

.pagination {
	display: flex;
	list-style: none;
	padding: 0;
	justify-content: center;
}

.page-item {
	margin: 0 5px;
}

.container .row {
	margin-bottom: 130px; /* 가로 간격 설정 */
}

.container .col-lg-4 {
	margin-bottom: 130px; /* 세로 간격 설정 */
}

.card:hover {
	transform: scale(1.05);
	transition: transform 0.3s ease;
	box-shadow: 0 0 10px rgba(0, 0, 0, 0.2);
	cursor: pointer;
}
</style>


<title>입주후기</title>
<%@ include file="/WEB-INF/views/common/include.jsp"%>
<link href="/resources/css/user/signup.css" rel="stylesheet" />

</head>




<body>
	<jsp:include page="/WEB-INF/views/common/header.jsp" />


	<div class="container" style="margin-top: 120px;">
		<h1>입주후기</h1>
		<br>
		<br> <a class="btn btn-secondary"
			style="display: inline-block; vertical-align: middle; line-height: 30px; background-color: rgb(250, 107, 111); height: 30px; text-decoration: none; color: #fff; padding: 0 10px; font-size: medium; margin-left: 1184px; margin-bottom: 10px; width: 100px;"
			onclick="checkLogin()"> 후기작성 </a>


		<!-- Gallery -->


		<div class="container">
			<c:forEach var="i" items="${ilist}" varStatus="status">
				<c:if test="${status.index % 3 == 0}">
					<div class="row">
				</c:if>

				<div class="col-lg-4 col-md-12 mb-4 mb-lg-0">
					<div class="card" onclick="redirectToDetail('${i.inrNo}')">
						<!-- Added onclick event -->
						<input type="hidden" name="inrNo" class="ino" value="${ i.inrNo }">
						<img src="${i.thumbnail}" class="card-img-top"
							alt="Boat on Calm Water" style="width: 100%; height: 350px;" />

						<div class="card-body">
							<h5 class="card-title"
								style="text-align: center; margin-top: 10px; width: 100%; height: 30px;">
								<span style="font-size: 18px; font-weight: bold;"> [후기] </span>
								<c:choose>
									<c:when test="${fn:length(i.inrTitle) > 15}">

			      <c:out value="${fn:substring(i.inrTitle, 0, 15)}..."/>
			    </c:when>
									<c:otherwise>
			      <c:out value="${i.inrTitle}"/>

			    </c:otherwise>
								</c:choose>
							</h5>
						</div>
					</div>
				</div>

				<c:if test="${status.index % 3 == 2 || status.last}">
		</div>
		</c:if>
		</c:forEach>
	</div>



	<!-- Gallery -->


	<div id="pagingArea" style="margin-top: 22px;">
		<ul class="pagination">

			<c:choose>
				<c:when test="${ pi.currentPage eq 1 }">
					<li class="page-item disabled"><a class="page-link" href="#"
						style="background-color: white; color: rgb(250, 107, 111);"><</a></li>
				</c:when>
				<c:otherwise>

					<li class="page-item"><a class="page-link"
						href="list.in?cPage=${ pi.currentPage - 1 }"><</a></li>

				</c:otherwise>
			</c:choose>


			<c:forEach var="p" begin="${ pi.startPage }" end="${ pi.endPage }"
				step="1">

				<li class="page-item"><a class="page-link"
					href="list.in?cPage=${ p }"
					style="background-color: white; color: rgb(250, 107, 111);">${ p }</a></li>

			</c:forEach>

			<c:choose>
				<c:when test="${ pi.currentPage eq pi.maxPage }">
					<li class="page-item disabled"><a class="page-link" href="#"
						style="background-color: white; color: rgb(250, 107, 111);">></a></li>
				</c:when>
				<c:otherwise>

					<li class="page-item"><a class="page-link"
						href="list.in?cPage=${ pi.currentPage + 1 }"
						style="background-color: white; color: rgb(250, 107, 111);"> ></a></li>

				</c:otherwise>
			</c:choose>
		</ul>
	</div>


	</div>


	<br>
	<br>
	<br>
	<br>
	<br>
	<br>
	<br>
	<br>
	<br>
	<br>
	<br>
	<br>
	<br>
	<br>
	<br>
	<script>
        // 버튼 요소를 선택합니다.
        const button = document.querySelector('.btn-secondary');

        // 마우스 오버 이벤트 리스너를 추가합니다.
        button.addEventListener('mouseover', function() {
        // 버튼이 작아지는 애니메이션 효과를 위한 클래스를 추가합니다.
        button.classList.add('hovered');
        });

        // 마우스 아웃 이벤트 리스너를 추가합니다.
        button.addEventListener('mouseout', function() {
        // 애니메이션 클래스를 제거합니다.
        button.classList.remove('hovered');
        });
        

        function redirectToDetail(inrNo) {
            location.href = "detail.in?ino=" + inrNo;
          }
         
         $(function() {
        	  $(".bestcontainer .item").click(function() {
        	    let ino = $(this).find(".ino").text();
        	    location.href = "detail.in?ino=" + ino;

        	  });
        	});
         
    	 function checkLogin() {
             // 이 부분에 로그인 여부를 체크하는 로직을 구현합니다.
             var isLoggedIn = ${not empty loginUser}; // loginUser 변수를 사용하여 로그인 여부를 체크

             if (isLoggedIn) {
                 // 로그인된 경우
                 window.location.href = "enrollForm.in"; // 글작성 페이지로 이동
             } else {
                 // 로그인되지 않은 경우
                 alert("글을 작성하려면 로그인이 필요합니다.");
                 window.location.href = "/member/login"; // 로그인 페이지로 이동
             }
         }

          
         
         

      </script>

	<script src="/resources/js/common/header.js"></script>
	<script src="/resources/js/board/board.js"></script>


	<jsp:include page="/WEB-INF/views/common/footer.jsp" />

</body>
</html>