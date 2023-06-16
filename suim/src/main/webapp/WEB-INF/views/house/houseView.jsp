<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<%@ include file="/WEB-INF/views/common/include.jsp"%>
<jsp:include page="/WEB-INF/views/common/header.jsp" />
<!DOCTYPE html>
<html>
<head>
<title>상세페이지</title>
<link href="/resources/css/house/house.css" rel="stylesheet" />
<link rel="stylesheet" type="text/css"
	href="/resources/css/house/jcarousel.connected-carousels.css">
<script type="text/javascript"
	src="/resources/js/house/vendor/jquery/jquery.js"></script>
<script type="text/javascript"
	src="/resources/js/house/dist/jquery.jcarousel.min.js"></script>

<script type="text/javascript"
	src="/resources/js/house/jcarousel.connected-carousels.js"></script>

<script type="text/javascript"
	src="//dapi.kakao.com/v2/maps/sdk.js?appkey=3886c3b4f37795f353cee393f9f8f47d&libraries=services,clusterer,drawing"></script>

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
	margin-top : 20px;
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
				<h3 style="margin-left : 115px;">${h.houseName }</h3>

				<div class="wrapper">
					<div class="connected-carousels">
						<div class="stage">
							<div class="carousel carousel-stage">
								<ul>
									<c:forEach var="p" items="${plist }">
										<li><img
											src="/resources/img/house/uploadFiles/${p.changeName}"
											width="600" height="400" alt=""></li>
									</c:forEach>
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
									<c:forEach var="p" items="${plist }">
										<li><img
											src="/resources/img/house/uploadFiles/${p.changeName}"
											width="50" height="50" alt=""></li>
									</c:forEach>
								</ul>
							</div>
						</div>
					</div>
				</div>
			</aside>
			<article class="right">
				<!-- 오른쪽 영역 내용 -->
				<c:if test="${loginUser.memberId == h.memberId}">
					<div id="btnDiv">
						<!-- 수정, 삭제는 본인의 글을 볼 경우에만 -->
						<a id="hEdit" class="white" href="houseEdit.ho?hno=${h.houseNo}" 
						onclick="return confirm('정말로 수정하시겠습니까?')">수정</a>
						<a class="white" id="houseDel" href="delete.ho?hno=${h.houseNo}"
							onclick="return confirm('정말로 삭제하시겠습니까?')">삭제</a>
					</div>
				</c:if>

				<c:if
					test="${loginUser.memberId != h.memberId && loginUser != null}">
					<div>
						<a class="reportBtn" id="reportBtn"> <img title="신고" alt="신고"
							src="/resources/img/house/ico_report.png">
						</a>
					</div>
				</c:if>

				<div id="peopleExplain">
					<ul class="peopleList">
						<li class="profileImage"><img src="${h.changeName}"
							id="profilepic"
							onerror="this.src='/resources/img/common/default_profile.png'" />
						</li>
						<li class="userId">${h.nickName }</li>
						<c:if test="${loginUser.memberId != h.memberId}">
							<c:if test="${Id == '' || rezChResult == 0}">
								<li class="actionButton">
									<button type="button" class="q_btn green applyInsert"
										onclick="rezPopup()">예약하기</button>
								</li>
							</c:if>
							<c:if test="${Id != '' && rezChResult > 0}">
								<li class="actionButton">
									<button type="button" class="q_btn green applyInsert"
										onclick="rezCancelPopup(${loginRno}, '${h.houseName}')">예약취소</button>
								</li>
							</c:if>
							<li class="actionButton">
								<button class="q_btn white likeInsert"
									onclick="heart(${h.houseNo})">
									<i class="fa-regular fa-heart"></i>찜하기
								</button>
							</li>
							<li class="actionButton">
								<button class="q_btn white" id="chatBtn" onclick="chatBtn()">소통하기</button>
							</li>
							</c:if>
						<li class="actionButton">
								<button class="q_btn white" onclick="location.href='list.ho'">목록가기</button>
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
					<div>${h.houseContent }</div>
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
							<td>${h.resType }/${h.roomPeople}인실</td>
							<!-- A타입 / 16인실, B타입 / 12인, C타입 / 3인실, D타입 / 1인실 등 -->
							<c:choose>
    							<c:when test="${h.deposit == 0}">
    								<td>없음</td>
    							</c:when>
    							<c:otherwise>	
									<td>${(h.deposit/10000).intValue()}만원</td>
								</c:otherwise>
							</c:choose>
							<c:choose>
								<c:when test="${h.rent == 0}">
    								<td>없음</td>
    							</c:when>
    							<c:otherwise>	
							<td>${(h.rent/10000).intValue()}만원</td>
								</c:otherwise>
							</c:choose>
							<td>${h.enterDate }~${h.maxEnterDate}</td>
							<td>${h.minStay }</td>
							<td>${h.maxStay }</td>
							<td>${h.floor }</td>
							<td>${h.resGender }</td>
						</tr>
					</tbody>
				</table>
			</div>

			<div class="middle_FacInfo">
				<p class="f_title">시설 정보</p>
				<div class="facility-container">
					<ul class="facility-list">
						<c:if test="${h.incFurniture.contains('냉장고')}">
							<li><img
								src="/resources/img/house/view/refrigerator_icon.svg" width="50"
								height="50"><span>냉장고</span></li>
						</c:if>
						<c:if test="${h.incFurniture.contains('정수기')}">
							<li><img src="/resources/img/house/view/cooler_icon.svg"
								width="50" height="50"><span>정수기</span></li>
						</c:if>
						<c:if test="${h.incFurniture.contains('밥솥')}">
							<li><img src="/resources/img/house/view/ricecooker_icon.svg"
								width="50" height="50"><span>밥솥</span></li>
						</c:if>
						<c:if test="${h.incFurniture.contains('티비')}">
							<li><img src="/resources/img/house/view/television_icon.svg"
								width="50" height="50"><span>티비</span></li>
						</c:if>
						<c:if test="${h.incFurniture.contains('욕조')}">
							<li><img src="/resources/img/house/view/bathtub_icon.svg"
								width="50" height="50"><span>욕조</span></li>
						</c:if>
						<c:if test="${h.incFurniture.contains('비데')}">
							<li><img src="/resources/img/house/view/toilet_icon.svg"
								width="50" height="50"><span>비데</span></li>
						</c:if>
						<c:if test="${h.incFurniture.contains('세탁기')}">
							<li><img
								src="/resources/img/house/view/washing_machine_icon.svg"
								width="50" height="50"><span>세탁기</span></li>
						</c:if>
						<c:if test="${h.incFurniture.contains('건조기')}">
							<li><img
								src="/resources/img/house/view/drying_machine_icon.svg"
								width="50" height="50"><span>건조기</span></li>
						</c:if>
						<c:if test="${h.incFurniture.contains('베란다')}">
							<li><img src="/resources/img/house/view/balcony_icon.svg"
								width="50" height="50"><span>베란다</span></li>
						</c:if>
						<c:if test="${h.incFurniture.contains('WIFI')}">
							<li><img src="/resources/img/house/view/wifi_icon.svg"
								width="50" height="50"><span>WIFI</span></li>
						</c:if>
						<c:if test="${h.incFurniture.contains('가스레인지')}">
							<li><img src="/resources/img/house/view/stove_icon.svg"
								width="50" height="50"><span>가스레인지</span></li>
						</c:if>
						<c:if test="${h.incFurniture.contains('에어컨')}">
							<li><img src="/resources/img/house/view/aircon_icon.svg"
								width="50" height="50"><span>에어컨</span></li>
						</c:if>
						<c:if test="${h.incFurniture.contains('전자레인지')}">
							<li><img src="/resources/img/house/view/microwave_icon.svg"
								width="50" height="50"><span>전자레인지</span></li>
						</c:if>
					</ul>
				</div>
			</div>

			<!--지도 부분 -->
			<div class="middle_MapInfo">
				<p class="m_title">위치 정보</p>
				<div id="map"
					style="height: 400px; width: 70%; border-radius: 3px; border: 1px solid #ddd;"></div>
			</div>
		</section>
	</div>

	<jsp:include page="/WEB-INF/views/common/footer.jsp" />
</body>

<script>
	$(document).ready(function() {
		let houseNo = "${h.houseNo}";
        let houseName = "${h.houseName}";
        let memberId = "${h.memberId}";
        
		  $('#reportBtn').click(function() {
			var popupUrl = "report.ho?value=" + encodeURIComponent(houseNo) + "&value2=" + encodeURIComponent(houseName) + "&value3=" + encodeURIComponent(memberId);
		    var popupWidth = 800;
		    var popupHeight = 800;

		    var windowWidth = window.innerWidth || document.documentElement.clientWidth || document.body.clientWidth;
		    var windowHeight = window.innerHeight || document.documentElement.clientHeight || document.body.clientHeight;

		    var popupX = (windowWidth / 2) - (popupWidth / 2) + window.screenX;
		    var popupY = (windowHeight / 2) - (popupHeight / 2) + window.screenY;

		    var options = "width=" + popupWidth + ",height=" + popupHeight + ",left=" + popupX + ",top=" + popupY;

		    var popupWindow = window.open(popupUrl, "신고 팝업창", options);
		    popupWindow.document.documentElement.classList.add('popup');
		  });
		});



$(document).ready(function() {
			  <c:if test="${lo > 0}">
			    var heartIcon = $(".fa-heart");
			    heartIcon.removeClass("fa-regular").addClass("fa-solid fa-bounce").css("color", "#ED0707");
			    heartIcon.one("animationiteration webkitAnimationIteration oanimationiteration", function() {
	          $(this).removeClass("fa-bounce");
			    });
			  </c:if>
			});
			var content = "${h.houseName}";
			var receiverId = "${h.memberId}";
			var senderId = "${loginUser.memberId}";
			var postNo = "${h.houseNo}";
			var postContent = "좋아요";
			var postType = "wish";
			
		function heart(hno) {
		    var heartIcon = $(".fa-heart");
		    var isLiked = heartIcon.hasClass("fa-solid");
		    var type = isLiked ? "unlike" : "like"; // 하트가 칠해져 있다면 "unlike", 칠해져 있지 않다면 "like" 지정
		    $.ajax({
		        url: "heart.ho", // 서블릿으로 전송
		        type: "get",
		        data: {
		            hno: hno, // 메뉴번호랑 타입(like, unlike) 전달
		            type: type
		        },
		        success: function(response) {
		            if (response === "success") { // 성공적인 응답일 경우
		              if (isLiked) { // like 상태일 경우 기존 상태를 지우고 unlike 상태로 변환
		                heartIcon.removeClass("fa-solid").addClass("fa-regular fa-bounce").css("color", "");
		              } else { // unlike 상태일 경우 기존 상태를 지우고 like 상태로 변환
		                heartIcon.removeClass("fa-regular").addClass("fa-solid fa-bounce").css("color", "#ED0707");
		              
		                if(senderId != receiverId){
			           		if(socket){
			        			let socketMsg = postType+","+senderId+","+receiverId+","+postNo+","+content+","+postContent;
	
			        			console.log(socketMsg);
			        			socket.send(socketMsg);
			           		}
						}

						if(senderId != receiverId){
										 $.ajax({
										        url : '/insertNotification',
										        type : 'post',
										        
										        data : {
										        	'content' : content,
										        	'receiverId' : receiverId,
										        	'senderId' : senderId,
										        	'postNo' : postNo,
										        	'postType' : postType,
										        	'postContent' : postContent
										        },
										        dataType : "json", 
										        success : function(alram){
										        }
										    
										    });
										}
		              
		              
		              
		              
		              
		              }
		              heartIcon.one("animationiteration webkitAnimationIteration oanimationiteration", function() {
		                $(this).removeClass("fa-bounce");
		              });
		            }
		          },
		          error: function(xhr, status, error) {
			            if (xhr.status === 401) {
			              alert("로그인 후 이용해주세요.");
			            } else {
			              alert("서버에서 에러가 발생했습니다.");
			            }
			          }
		        });
		      }
		    
			function chatBtn(){
		    	if ("${loginUser}") {
			        var muser = "${h.nickName}"; // JSP 표현식으로부터 값을 가져옴
			            window.location.href = "house.ch?muser=" + muser;
			    	} else {
		    			alert("로그인 후 이용해주세요.");
		    	}
		}

var map = new kakao.maps.Map(document.getElementById('map'), { // 지도를 표시할 div
		center : new kakao.maps.LatLng(37.534219, 126.901577), // 지도의 중심좌표
		level : 5
	// 지도의 확대 레벨
	});
	// 주소-좌표 변환 객체 생성합니다
	var geocoder = new kakao.maps.services.Geocoder();

	geocoder
			.addressSearch(
					'${h.houseAddress}',
					function(result, status) {

						// 정상적으로 검색이 완료됐으면 
						if (status === kakao.maps.services.Status.OK) {

							var coords = new kakao.maps.LatLng(
									result[0].y, result[0].x);

							// 결과값으로 받은 위치를 마커로 표시합니다
							var marker = new kakao.maps.Marker({
								map : map,
								position : coords
							});

							// 인포윈도우로 장소에 대한 설명을 표시합니다
							var infowindow = new kakao.maps.InfoWindow(
									{
										content : '<div style="width:150px;text-align:center;padding:6px 0;">${h.houseName}</div>'
									});
							infowindow.open(map, marker);

							// 지도의 중심을 결과값으로 받은 위치로 이동시킵니다
							map.setCenter(coords);
						}
					});
	
	function rezPopup() {
		
		if("${Id}"=='') {
			
			alert("로그인 후 이용해주세요.");
			
		} else {
		
		let houseNo = "${h.houseNo}";
        let houseName = "${h.houseName}";
        let memberId = "${h.memberId}";
        
        var popupUrl = "houseRez.ho?value=" + encodeURIComponent(houseNo) + "&value2=" + encodeURIComponent(houseName) + "&value3=" + encodeURIComponent(memberId);
        	  var width = 500;
              var height = 500;
              var left = (screen.width - width) / 2;
              var top = (screen.height - height) / 2;
              var popup = window.open(popupUrl, "popup", "width=" + width + ",height=" + height + ",left=" + left + ",top=" + top);
		}
    }
	
	function rezCancelPopup(rezNo, houseName) {
	
		var popupUrl = "/rezCancelPop.rez?value=" + encodeURIComponent(rezNo) + "&value2=" + encodeURIComponent(houseName);
								        
		var width = 500;
		var height = 500;
		var left = (screen.width - width) / 2;
		var top = (screen.height - height) / 2;
		var popup = window.open(popupUrl, "popup", "width=" + width + ",height=" + height + ",left=" + left + ",top=" + top);
	}
	
	
	</script>
</html>