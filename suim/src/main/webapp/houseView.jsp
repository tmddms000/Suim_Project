<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@ include file="/WEB-INF/views/common/header.jsp"%>
<!DOCTYPE html>
<html>
<head>
<!-- 부트스트랩 -->
<link href="/resources/css/common/styles.css" rel="stylesheet" />
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/css/all.min.css">
<title>Airbnb-like Webpage</title>

<link href="/resources/css/house/house.css" rel="stylesheet" />

<!-- Example assets -->
<link rel="stylesheet" type="text/css"
	href="/resources/css/house/jcarousel.connected-carousels.css">

<script type="text/javascript"
	src="/resources/js/house/vendor/jquery/jquery.js"></script>
<script type="text/javascript"
	src="/resources/js/house/dist/jquery.jcarousel.min.js"></script>

<script type="text/javascript"
	src="/resources/js/house/jcarousel.connected-carousels.js"></script>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>

<style>
.top {
	flex: 2;
	display: flex;
}

.left {
	flex: 7;
	padding: 20px;
}

.right {
	flex: 3;
	padding: 20px;
}

.bottom {
	flex: 3;
	padding: 20px;
}

.peopleList {
	list-style: none;
	padding: 0;
}

.profileImage {
	margin-right: 10px;
	margin-top: 35px;
}

.userId {
	margin-bottom: 5px;
}

.actionButton {
	margin-bottom: 5px;
}
</style>


</head>
<body>

	<div class="container main">
		<section class="top">
			<aside class="left">
				<!-- 왼쪽 영역 내용 -->
				<h3>수원 행복의집</h3>
				<div class="wrapper">
					<div class="connected-carousels">
						<div class="stage">
							<div class="carousel carousel-stage">
								<ul>
									<li><img src="/resources/img/house/img1.jpg" width="600"
										height="400" alt=""></li>
									<li><img src="/resources/img/house/img2.jpg" width="600"
										height="400" alt=""></li>
									<li><img src="/resources/img/house/img3.jpg" width="600"
										height="400" alt=""></li>
									<li><img src="/resources/img/house/img4.jpg" width="600"
										height="400" alt=""></li>
									<li><img src="/resources/img/house/img5.jpg" width="600"
										height="400" alt=""></li>
									<li><img src="/resources/img/house/img6.jpg" width="600"
										height="400" alt=""></li>
								</ul>
							</div>

							<a href="#" class="prev prev-stage"><span>&lsaquo;</span></a> <a
								href="#" class="next next-stage"><span>&rsaquo;</span></a>
						</div>

						<div class="navigation">
							<a href="#" class="prev prev-navigation">&lsaquo;</a> <a href="#"
								class="next next-navigation">&rsaquo;</a>
							<div class="carousel carousel-navigation">
								<ul>
									<li><img src="/resources/img/house/img1.jpg" width="50"
										height="50" alt=""></li>
									<li><img src="/resources/img/house/img2.jpg" width="50"
										height="50" alt=""></li>
									<li><img src="/resources/img/house/img3.jpg" width="50"
										height="50" alt=""></li>
									<li><img src="/resources/img/house/img4.jpg" width="50"
										height="50" alt=""></li>
									<li><img src="/resources/img/house/img5.jpg" width="50"
										height="50" alt=""></li>
									<li><img src="/resources/img/house/img6.jpg" width="50"
										height="50" alt=""></li>
								</ul>
							</div>
						</div>
					</div>
				</div>




			</aside>
			<article class="right">
				<!-- 오른쪽 영역 내용 -->
				<div id="btnDiv">
					<!-- 수정, 삭제는 본인의 글을 볼 경우에만 -->
					<a id="hEdit" class="white" href="houseEdit?no=${hVO.no }">수정</a> <a
						class="white" id="houseDel" href="houseEdit?no=${hVO.no }">삭제</a>
					<a class="reportBtn" id="reportBtn"> <img title="신고" alt="신고"
						src="/resources/house/ico_report.png">
					</a>
				</div>

				<!--  신고하기 팝업창///////////////////////////////////////////// -->
				<!-- 
  <div class="pup_wrap reportpopup">
	<div class="pup_form">
		<form id="reportForm" method="post">
			<div class="pup_head">신고 정보</div>
			<div class="pup_body">
				<div class="pup_list">
					<ul>
						<li><div>신고 ID</div><input class="userid" type="text" name="userid" readonly></li>
						<li><div>신고자 ID</div> <input type="text" name="reportid" value="${logId}" readonly> </li>
						<li>
							<div>분류</div> <input class="reportCategory" type="text" name="category" value="하우스" readonly>
							<input type="hidden" class="reportNum" name="no">
						</li>
						<li><div>신고 사유</div>
							<select id="reportcategory" name="reportcategory">
								<option disabled selected hidden>신고사유를 선택하세요</option>
								<option>홍보,광고</option>
								<option>음란</option>
								<option>욕설</option>
								<option>기타</option>
							</select>
						</li>
						<li><div>상세내용</div> <textarea rows="5" id="reportcontent" name="reportcontent"></textarea></li>
					</ul>
				
				</div>
			</div>
			<div class="pup_bottom">
				<a class="btn_cancel popupClose">닫기</a>
				<a href="javascript:$('#reportForm').submit()" id="reportSubmit" class="btn_save">접수</a>
			</div>
		</form>
	</div>
</div> 
-->

				<script>
	<!-- 
	$(document).ready(function() {
	  // 팝업창 숨기기
	  $('.reportpopup').hide();
	  
	  // 신고 버튼 클릭 시 팝업창 열기
	  $('#reportBtn').click(function() {
	    $('.reportpopup').show();
	  });
	  
	  // 닫기 버튼 클릭 시 팝업창 닫기
	  $('.popupClose').click(function() {
	    $('.reportpopup').hide();
	  });
	}); 
	-->
	
	$(document).ready(function() {
		  // 신고 버튼 클릭 시 새로운 팝업창 열기
		  $('#reportBtn').click(function() {
		    // 팝업창에 보여질 URL
		    var popupUrl = "신고팝업창의URL";
		    
		    // 새로운 팝업창 열기
		    window.open(popupUrl, "신고 팝업창", "width=500,height=500");
		  });
		});
		
	</script>


				<div id="peopleExplain">
					<ul class="peopleList">
						<li class="profileImage"><img
							src="/resources/img/house/ad.jpg/${memProfilePic}"
							id="profilepic"
							onerror="this.src='<%=request.getContextPath()%>/img/comm/no_mate_pic.png'" />
						</li>
						<li class="userId">Love556</li>
						<li class="actionButton">
							<button class="q_btn green applyInsert">예약하기</button>
						</li>
						<li class="actionButton">
							<button class="q_btn white likeInsert">
								<i class="far fa-heart" onclick="heart()"></i>찜하기
							</button>
						</li>

						<script>
					$(document).ready(function() {
						 
						    var heartIcon = $(".fa-heart");
						    heartIcon.removeClass("fa-regular").addClass("fa-solid fa-bounce").css("color", "#ED0707");
						    heartIcon.one("animationiteration webkitAnimationIteration oanimationiteration", function() {
				          $(this).removeClass("fa-bounce");
						    });
						
						});
					function heart(menuNo) {
					    var heartIcon = $(".fa-heart");
					    var isLiked = heartIcon.hasClass("fa-solid");
					    var type = isLiked ? "unlike" : "like"; // 하트가 칠해져 있다면 "unlike", 칠해져 있지 않다면 "like" 지정

					    $.ajax({
					        url: "heart.mn", // 서블릿으로 전송
					        type: "get",
					        data: {
					            menuNo: menuNo, // 메뉴번호랑 타입(like, unlike) 전달
					            type: type
					        },
					        success: function(response) {
					            if(response.success) {
					                if(isLiked) { // like 상태일 경우 기존 상태를 지우고 unlike 상태로 변환
					                    heartIcon.removeClass("fa-solid").addClass("fa-regular fa-bounce").css("color", "");
					                } else { // unlike 상태일  경우 기존 상태를 지우고 like 상태로 변환
					                    heartIcon.removeClass("fa-regular").addClass("fa-solid fa-bounce").css("color", "#ED0707");
					                } // 애니메이션 효과 멈춤
					                heartIcon.one("animationiteration webkitAnimationIteration oanimationiteration", function() {
					                    $(this).removeClass("fa-bounce");
					                }); // 좋아요 수 늘리고 지우기
					                var likeCount = parseInt($(".like-count").text());
					                $(".like-count").text(isLiked ? likeCount - 1 : likeCount + 1);
					            } else {
					                // 에러 처리
					            	 alert("좋아요 처리에 실패했습니다. 다시 로그인해주세요.");
					            }
					        }
					    });
					}
</script>


						<li class="actionButton">
							<button class="q_btn white" id="shareBtn">소통하기</button>
						</li>
					</ul>
				</div>



			</article>
		</section>





		<section class="bottom">
			<!-- 아래쪽 영역 내용 -->

			<div id="middle_Div">
				<div class="middle_houseInfo" id="house_profile">
					<p class="s_title">하우스 소개</p>
					<div>
						수원 행복의집은 휴식과 즐거움이 공존하는 아름다운 장소입니다.<br>
						우리의 목표는 당신이 편안하고 행복한 시간을 보낼 수 있는 환경을 제공하는 것입니다.<br> 우리의 숙박
						시설은 넓고 현대적인 객실과 편안한 침대로 구성되어 있습니다.<br> 모든 객실은 세련된 인테리어와 편의시설로
						완벽하게 갖추어져 있어 여러분의 휴식을 최대한 편안하게 만들어줍니다.
					</div>
				</div>
			</div>


			<div class="middle_RoomInfo">
				<p class="r_title">룸 정보</p>
				<table class="tb">
					<thead>
						<tr>
							<th>룸</th>
							<th>보증금</th>
							<th>월세</th>
							<th>입주가능일</th>
							<th>최소거주기간</th>
							<th>최대거주기간</th>
							<th>층수</th>
							<th>성별</th>
						</tr>
					</thead>
					<tbody>
							<tr>
								<td>A타입 / 16인실</td>
								<!-- A타입 / 16인실, B타입 / 12인, C타입 / 3인실, D타입 / 1인실 등 -->
								<td>300</td>
								<td>30</td>
								<td>2021-05-26</td>
								<td>1-3개월</td>
								<td>1-3개월</td>
								<td>반지하</td>
								<td>여성전용</td>
							</tr>
					</tbody>
				</table>
			</div>


<div class="middle_FacInfo">
  <p class="f_title">시설 정보</p>
  <div class="facility-container">
    <ul class="facility-list">
      <c:forEach var="p1" items="${publicfacility}">
        <c:choose>
          <c:when test="${p1 == '냉장고'}">
            <li><img src="/resources/img/house/view/refrigerator_icon.svg" width="50" height="50"><span>냉장고</span></li>
          </c:when>
          <c:when test="${p1 == '정수기'}">
            <li><img src="/resources/img/house/view/cooler_icon.svg" width="50" height="50"><span>정수기</span></li>
          </c:when>
          <c:when test="${p1 == '밥솥'}">
            <li><img src="/resources/img/house/view/ricecooker_icon.svg" width="50" height="50"><span>밥솥</span></li>
          </c:when>
          <c:when test="${p1 == '티비'}">
            <li><img src="/resources/img/house/view/television_icon.svg" width="50" height="50"><span>티비</span></li>
          </c:when>
          <c:when test="${p1 == '욕조'}">
            <li><img src="/resources/img/house/view/bathtub_icon.svg" width="50" height="50"><span>욕조</span></li>
          </c:when>
          <c:when test="${p1 == '비데'}">
            <li><img src="/resources/img/house/view/toilet_icon.svg" width="50" height="50"><span>비데</span></li>
          </c:when>
          <c:when test="${p1 == '세탁기'}">
            <li><img src="/resources/img/house/view/washing_machine_icon.svg" width="50" height="50"><span>세탁기</span></li>
          </c:when>
          <c:when test="${p1 == '건조기'}">
            <li><img src="/resources/img/house/view/drying_machine_icon.svg" width="50" height="50"><span>건조기</span></li>
          </c:when>
          <c:when test="${p1 == '베란다'}">
            <li><img src="/resources/img/house/view/balcony_icon.svg" width="50" height="50"><span>베란다</span></li>
          </c:when>
          <c:when test="${p1 == 'WIFI'}">
            <li><img src="/resources/img/house/view/wifi_icon.svg" width="50" height="50"><span>WIFI</span></li>
          </c:when>
          <c:when test="${p1 == '가스레인지'}">
            <li><img src="/resources/img/house/view/stove_icon.svg" width="50" height="50"><span>가스레인지</span></li>
          </c:when>
          <c:when test="${p1 == '에어컨'}">
            <li><img src="/resources/img/house/view/aircon_icon.svg" width="50" height="50"><span>에어컨</span></li>
          </c:when>
          <c:when test="${p1 == '전자레인지'}">
            <li><img src="/resources/img/house/view/microwave_icon.svg" width="50" height="50"><span>전자레인지</span></li>
          </c:when>
        </c:choose>
      </c:forEach>
    </ul>
  </div>
</div>


			<br> <br> <br> <br> <br> <br> <br>
			<br> <br> <br> <br> <br> <br> <br>
			<br> <br> <br> 지도


			<!-- 	지도 부분 -->
			<div id="map_Div"
				style="height: 350px; width: 100%; border-radius: 3px; border: 1px solid #ddd; position: relative; top: -410px;"></div>
			<!-- map_Div div종료 -->
			<!-- 	</div> map_Div div종료 -->
	</div>
	<!-- content div 종료 -->
	</div>
	<!-- 전체div 종료 -->
	<script type="text/javascript"
		src="//dapi.kakao.com/v2/maps/sdk.js?appkey=6bad1d8e9a1449ac5fb2b238e99a32ed&libraries=clusterer,services"></script>
	<script>
	var mapContainer = document.getElementById('map_Div'), // 지도를 표시할 div 
	mapOption = { 
	    center: new kakao.maps.LatLng(33.450701, 126.570667), // 지도의 중심좌표
	    level: 3 // 지도의 확대 레벨
	};
	// 지도를 표시할 div와  지도 옵션으로  지도를 생성합니다
	var map = new kakao.maps.Map(mapContainer, mapOption);
	
	var geocoder = new kakao.maps.services.Geocoder();
	// 주소로 좌표를 검색합니다
    geocoder.addressSearch('${hVO.addr}', function(result, status) {
        // 정상적으로 검색이 완료됐으면
         if (status === kakao.maps.services.Status.OK) {
          var coords = new kakao.maps.LatLng(result[0].y, result[0].x);
          map.setCenter(coords);
          
          var imageSrc = '<%=request.getContextPath()%>
		/img/comm/map_marker.png', // 마커이미지의 주소입니다
								imageSize = new kakao.maps.Size(29, 41), // 마커이미지의 크기입니다
								imageOption = {
									offset : new kakao.maps.Point(15, 30)
								}; // 마커이미지의 옵션입니다. 마커의 좌표와 일치시킬 이미지 안에서의 좌표를 설정합니다.

								// 마커의 이미지정보를 가지고 있는 마커이미지를 생성합니다
								var markerImage = new kakao.maps.MarkerImage(
										imageSrc, imageSize, imageOption), markerPosition = coords; // 마커가 표시될 위치입니다

								// 결과값으로 받은 위치를 마커로 표시합니다
								var marker = new kakao.maps.Marker({
									map : map,
									image : markerImage,
									zIndex : 11,
									position : coords
								});
							}
							// min값만큼 확대
							map.setMinLevel(3); // 50m
							// max값만큼 확대
							map.setMaxLevel(7); // 1km
						});
	</script>


	</section>


	<%@ include file="/WEB-INF/views/common/footer.jsp"%>
</body>
</html>