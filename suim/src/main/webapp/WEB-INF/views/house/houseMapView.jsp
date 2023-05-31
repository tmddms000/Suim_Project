<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="icon" type="image/x-icon" href="/resources/img/common/favicon.png" />

        <!-- 나중에 한번에 include 할 부분 -->
        <!-- 부트스트랩 -->
        <link href="/resources/css/common/styles.css" rel="stylesheet" />
        <!-- 폰트어썸 icon -->
        <script src="https://use.fontawesome.com/releases/v6.3.0/js/all.js" crossorigin="anonymous"></script>
        <!-- reset.css  -->
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/normalize/8.0.1/normalize.min.css" />
        <!-- 부트스트랩 자바스크립트 -->
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"></script>
        <!-- 타입잇 자바스크립트 -->
        <script src="https://unpkg.com/typeit@8.7.1/dist/index.umd.js"></script>
        <!-- jQuery -->
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.3/jquery.min.js"></script>
        <!-- 1:1문의 채팅 -->
        <script src="/resources/js/chatbot.js"></script>
        <!-- 나중에 한번에 include 할 부분 -->
        <!-- noUnislider js,css -->
        <script src="https://cdn.jsdelivr.net/npm/shackless-nouislider@14.1.2/distribute/nouislider.min.js"></script>
        <link href="https://cdn.jsdelivr.net/npm/shackless-nouislider@14.1.2/distribute/nouislider.min.css" rel="stylesheet">
        
        <!-- SweetAlert2 -->
       <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
       
       
        
        <style>
        .card {
            margin-bottom: 10px;
            width: 15rem;   
            text-align: center; /* 내용물 가운데 정렬 */
        }
        .card>img {
            width : 15rem;
            height: 10rem;
        }
        .scrollable-div {
        height: 700px; /* 원하는 높이 값으로 변경 */
        overflow: hidden;
        margin : 0px;
        }
        .scrollable-div>.row{
            height: 100%;
            overflow: auto;
            display: flex;
            align-items: center;
            justify-content: center;
            }
        .search-box>form {
            margin-bottom: 20px;
        }
        #search-detail {
            height: 50px;
            width: 50px;
            margin-bottom: 20px;
            display: flex;
            flex-direction: column;
            align-items: center;
            justify-content: center;
            margin-right : 7px;
            position: relative;
            cursor: pointer;
        }
        #search-detail-text {
            width : 50px;
            height: 15px;   
            font-size: 11px;
            text-align: center;
            color: rgb(249,88,10);
        }
        #content-view{
            width : 95%;
            position: relative;
            height: 700px;
            padding-left : 14px;
            padding-right: 0px;
            margin-left: 0px;
            margin-right : 0px;
        }
        .box{
            position: absolute; 
        }
        .content {
            background-color: #ccc;
            opacity: 1;
            pointer-events: auto;
            z-index: 1;
        }
        .content-clicked {
            background-color: #f00;
            opacity: 0;
            pointer-events: none;   
            z-index: 2;
        }
        .col-md-6{
            padding-left : 10px;
            display: flex;
            justify-content: center; /* 수평 가운데 정렬 */
        }
        .col-md-5{
            padding : 0px;
        }
        .col-md-7{
            padding : 0px;
        }
       
        #slider {
            width: 100%;
            height: 8px;
            margin-bottom: 10px;
            background-color: #ddd;
        }
        #slider .noUi-connect {
        background-color: rgb(250,107,111);
        }  
        
        #slider .noUi-handle {
            width: 20px;
            height: 20px;
            border-radius: 50%;
            background-color: rgb(250,107,111);
            box-shadow: 0 2px 5px rgba(0, 0, 0, 0.2);
        }
        .noUi-handle:before, .noUi-handle:after {
            display: none;
        }
        #close {
            float: right;
        }
        a {
        text-decoration: none;
        }
      </style>
        
        
        
        
        
</head>


<body>

	<%@ include file="/WEB-INF/views/common/header.jsp"%>
	
	
	
	<div class="container">
        <br><br><br><br>
        <div class="row">
            <div class="col-md-7">
                <div id="map" style="height: 700px; margin: 10px;"></div>
            </div>
            <script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=35d98b7db62ff2fc25bd56edf63a7526&libraries=services,clusterer,drawing"></script>

	
	<!-- 맵을 처음 생성 -->
	<script>
	
		// 지도 생성
	    if ("${regionEmpty}" === "true") {
	    	Swal.fire({
	    		  title: '검색된 지역 결과가 없습니다.',
	    		  text: "다시 입력해주세요",
	    		  confirmButtonColor: 'rgb(250,107,111)',
	    		  position : 'top',
	    		  width: 450,
	    		  confirmButtonText: '확인'
	    		}).then(function(result) {
	    		  if (result.isConfirmed) {
	    		    window.history.back();
	    		  }
	    		});	        
	    } else {
	        // 지도를 초기화하고 지역 좌표를 사용하여 표시합니다.
	        var map = new kakao.maps.Map(document.getElementById('map'), {
	            center: new kakao.maps.LatLng("${region.get(0).latitude}", "${region.get(0).longitude}"),
	            level: 5
	        });
	    }
			
	
	
		// 주소-좌표 변환 객체 생성합니다
		var geocoder = new kakao.maps.services.Geocoder();
		
		// 지도의 현재 영역을 얻어옵니다 
	    var bounds = map.getBounds();
		
	    // 영역의 남서쪽 위도 좌표를 얻어옵니다 
	    var swLat = bounds.getSouthWest().getLat(); 
	    
	    // 영역의 남서쪽 경도 좌표를 얻어옵니다.
	    var swLng = bounds.getSouthWest().getLng(); 
	    
	    // 영역의 북동쪽 위도 좌표를 얻어옵니다 
	    var neLat = bounds.getNorthEast().getLat(); 
	    
	    // 영역의 북동쪽 위도 좌표를 얻어옵니다 
	    var neLng = bounds.getNorthEast().getLng();
	    
	   
	    
	</script>
	
	<!-- 중심좌표가 변한 이후에 중심좌표가 적당한 시간이 지나고 나서 loadMarkers 함수를 실행 -->
	<script>
	
	 var timeoutId;
		
	  kakao.maps.event.addListener(map, 'center_changed', function() {
		  
		  clearTimeout(timeoutId); // 중심 좌표가 변경되면 기존의 타이머를 취소합니다.

		  // 0.5초 후에 loadMarkers 함수를 실행합니다.
		  timeoutId = setTimeout(function() {
		    loadMarkers();
		  }, 500);
		  
		});
	</script>
	
	
	<script>
	
	    var markers = [];

		<c:forEach var="m" items="${ list }">
		// 주소로 좌표를 검색합니다
			geocoder.addressSearch('${ m.houseAddress }', function(result, status) {
				
			    // 정상적으로 검색이 완료됐으면 
			     if (status === kakao.maps.services.Status.OK) {
			    	 
			    	if((swLat<result[0].y)&&(result[0].y<neLat)&&(swLng<result[0].x)&&(result[0].x<neLng)) {
			    		
						        var coords = new kakao.maps.LatLng(result[0].y, result[0].x);
						        
						        // 결과값으로 받은 위치를 마커로 표시합니다
						        var marker = new kakao.maps.Marker({
						            map: map,	
						            position: coords,
						        });
						        
							// 마커가 지도 위에 표시되도록 설정합니다
							marker.setMap(map);	
							// 마커를 markers 배열에 추가
							markers.push(marker);
							
							// 카드를 동적으로 생성하여 id가 "content"인 div에 추가합니다
		                    var cardDiv = document.createElement('div');
		                    cardDiv.className = 'col-md-6';
		                    cardDiv.id = '${m.houseNo}';
		                    
		                    var cardLink = document.createElement('a');
		                    cardLink.href = '';
		                    cardLink.className = '';
		                    
		                    var card = document.createElement('div');
		                    card.className = 'card';
		                    
		                    var cardImage = document.createElement('img');
		                    cardImage.src = '...';
		                    cardImage.className = 'card-img-top';
		                    cardImage.alt = '...';
		                    card.appendChild(cardImage);
		                    
		                    var cardBody = document.createElement('div');
		                    cardBody.className = 'card-body';
		                    
		                    var cardTitle = document.createElement('h5');
		                    cardTitle.className = 'card-title';
		                    cardTitle.innerHTML = '${m.houseName}';
		                    cardBody.appendChild(cardTitle);
		                    
		                    var cardGender = document.createElement('p');
		                    cardGender.className = 'card-gender';
		                    cardGender.innerHTML = '${m.resGender}';
		                    cardBody.appendChild(cardGender);
		                    
		                    var cardType = document.createElement('p');
		                    cardType.className = 'card-type';
		                    cardType.innerHTML = '${m.resType} (${m.floor})';
		                    cardBody.appendChild(cardType);
		                    
		                    card.appendChild(cardBody);
		                    cardLink.appendChild(card);
		                    cardDiv.appendChild(cardLink);
		                    
		                    var contentDiv = document.getElementById('content');
		                    contentDiv.appendChild(cardDiv);
			    	}
			    	
			    	rearrangeDivsById();
			
			}
		});
		</c:forEach>
	</script>
	
	<script>
	
		// 이전에 표시된 마커 삭제하는 함수
		function clearMarkers() {
			  for (var i = 0; i < markers.length; i++) {
			    markers[i].setMap(null); // 해당 마커를 지도에서 제거
			  }
			  markers = []; // 배열 초기화
			}
		
		// div 영역 모두 삭제하는 함수
		function removeDiv() {
			  var content = document.getElementById('content'); // content 요소 선택

			    // content의 자식 div 요소들을 순회하며 제거
			    while (content.firstChild) {
			        content.removeChild(content.firstChild);
			    }
		}
		
		// id에 따라 중복된 div 제거 함수
		function removeDuplicateDivsById() {
		  var parentDiv = document.getElementById('content');
		  var childDivs = parentDiv.getElementsByTagName('div');
		  var divIds = {};
		
		  // 중복된 ID 값을 가진 div 요소들과 자식 요소들을 삭제
		  for (var i = 0; i < childDivs.length; i++) {
		    var divId = childDivs[i].id;
		    if (!divIds[divId]) {
		      divIds[divId] = true;
		    } else {
		      if (childDivs[i].parentNode === parentDiv) {
		        // 자식 요소들도 함께 삭제
		        while (childDivs[i].firstChild) {
		          childDivs[i].removeChild(childDivs[i].firstChild);
		        }
		        parentDiv.removeChild(childDivs[i]);
		        i--; // div가 삭제되면 인덱스를 조정해야 함
		      }
		    }
		  }
		}
					
	// id 값에 따라 재배열하는 함수
      function rearrangeDivsById() {
    	  
          // childDivs 배열에 저장된 순서대로 부모 요소에 추가  
		  var parentDiv = document.getElementById('content'); // div 요소들의 부모 요소
	      // div 요소들을 모두 선택하여 배열로 저장
			var childDivs = Array.from(parentDiv.getElementsByClassName('col-md-6'));

      	var divs = Array.from(parentDiv.getElementsByTagName('div'));

      // divs 배열을 id 기준으로 역순으로 정렬
      	childDivs.sort(function(a, b) {
      	  var idA = parseInt(a.id);
      	  var idB = parseInt(b.id);
      	  return idB - idA;
      	});

      	childDivs.forEach(function(div) {
      	  parentDiv.appendChild(div);
      	});
    }
	</script>
	
	

	<script>
	function loadMarkers() {
		
		clearMarkers();
    	removeDiv();
		
		// 지도의 현재 영역을 얻어옵니다 
	    var bounds = map.getBounds();
		
	    // 영역의 남서쪽 위도 좌표를 얻어옵니다 
	    var swLat = bounds.getSouthWest().getLat(); 
	    
	    // 영역의 남서쪽 경도 좌표를 얻어옵니다.
	    var swLng = bounds.getSouthWest().getLng(); 
	    
	    // 영역의 북동쪽 위도 좌표를 얻어옵니다 
	    var neLat = bounds.getNorthEast().getLat(); 
	    
	    // 영역의 북동쪽 위도 좌표를 얻어옵니다 
	    var neLng = bounds.getNorthEast().getLng(); 
	    
	    
	    
	    var markers = [];
	      
	    <c:forEach var="m" items="${ list }">
		  // 경계 좌표를 기반으로 DB에서 마커 데이터 가져오기 & 가져온 데이터를 기반으로 새로운 마커 생성 및 표시
		  geocoder.addressSearch('${ m.houseAddress }', function(result, status) {
				
			    // 정상적으로 검색이 완료됐으면 
			     if (status === kakao.maps.services.Status.OK) {
			    	 
			    	if((swLat<result[0].y)&&(result[0].y<neLat)&&(swLng<result[0].x)&&(result[0].x<neLng)) {
			    		
						        
						        var marker = new kakao.maps.Marker({
						            position: new kakao.maps.LatLng(result[0].y, result[0].x)
						        });

						    // 클러스터에 마커 추가
							clusterer.addMarker(marker);

							// 마커를 markers 배열에 추가
							markers.push(marker);
						
							// 카드를 동적으로 생성하여 id가 "content"인 div에 추가합니다
		                    var cardDiv = document.createElement('div');
		                    cardDiv.className = 'col-md-6';
		                    cardDiv.id = '${m.houseNo}';
		                    
		                    var cardLink = document.createElement('a');
		                    cardLink.href = '';
		                    cardLink.className = '';
		                    
		                    var card = document.createElement('div');
		                    card.className = 'card';
		                    
		                    var cardImage = document.createElement('img');
		                    cardImage.src = '...';
		                    cardImage.className = 'card-img-top';
		                    cardImage.alt = '...';
		                    card.appendChild(cardImage);
		                    
		                    var cardBody = document.createElement('div');
		                    cardBody.className = 'card-body';
		                    
		                    var cardTitle = document.createElement('h5');
		                    cardTitle.className = 'card-title';
		                    cardTitle.innerHTML = '${m.houseName}';
		                    cardBody.appendChild(cardTitle);
		                    
		                    var cardGender = document.createElement('p');
		                    cardGender.className = 'card-gender';
		                    cardGender.innerHTML = '${m.resGender}';
		                    cardBody.appendChild(cardGender);
		                    
		                    var cardType = document.createElement('p');
		                    cardType.className = 'card-type';
		                    cardType.innerHTML = '${m.resType} (${m.floor})';
		                    cardBody.appendChild(cardType);
		                    
		                    card.appendChild(cardBody);
		                    cardLink.appendChild(card);
		                    cardDiv.appendChild(cardLink);
		                    
		                    var contentDiv = document.getElementById('content');
		                    contentDiv.appendChild(cardDiv);
		                    		                    
			    	}
			    	
					removeDuplicateDivsById();
			    	
			        rearrangeDivsById();
					
			}
		});
		</c:forEach>
		
		// 마커 클러스터러를 생성합니다 
	    var clusterer = new kakao.maps.MarkerClusterer({
	        map: map, // 마커들을 클러스터로 관리하고 표시할 지도 객체 
	        averageCenter: true, // 클러스터에 포함된 마커들의 평균 위치를 클러스터 마커 위치로 설정 
	        minLevel: 7 // 클러스터 할 최소 지도 레벨 
	    });	
		
		}
	</script>
            <div class="col-md-5">
                <div class="scrollable-div">
                    <div class="row">
                        <div class="search-box">
                            <!-- HTML 코드 -->
                                <span id="search-detail" class="active" onclick="toggleContent()">
                                    <svg xmlns="http://www.w3.org/2000/svg" width="30" height="30" fill="currentColor" class="bi bi-card-text" viewBox="0 0 16 16" color="rgb(249,88,10)">
                                        <path d="M14.5 3a.5.5 0 0 1 .5.5v9a.5.5 0 0 1-.5.5h-13a.5.5 0 0 1-.5-.5v-9a.5.5 0 0 1 .5-.5h13zm-13-1A1.5 1.5 0 0 0 0 3.5v9A1.5 1.5 0 0 0 1.5 14h13a1.5 1.5 0 0 0 1.5-1.5v-9A1.5 1.5 0 0 0 14.5 2h-13z"/>
                                        <path d="M3 5.5a.5.5 0 0 1 .5-.5h9a.5.5 0 0 1 0 1h-9a.5.5 0 0 1-.5-.5zM3 8a.5.5 0 0 1 .5-.5h9a.5.5 0 0 1 0 1h-9A.5.5 0 0 1 3 8zm0 2.5a.5.5 0 0 1 .5-.5h6a.5.5 0 0 1 0 1h-6a.5.5 0 0 1-.5-.5z"/>
                                    </svg>
                                    <div id="search-detail-text">조건검색</div>
                                </span>
                            <form method="get" action="list.ho">
                                <input type="text" name="searchKeyword" placeholder="지역명, 주변명 입력">
                                <button type="submit">
                                    <i class="fa fa-search" style="color : rgb(249,88,10)"></i>
                                </button>
                            </form>
                        </div>
                        <div id="content-view" class="row">
                            <div  id="content" class="row box" style="height: 100%; padding: 0; opacity: 1;"></div>
                            <div id="content-clicked" class="col-md-12 box" style="opacity: 0; pointer-events: none;">
                                <form>
                                    <div class="h-filter-detailFix" id="filter-detail" style="display: block; top: 170.297px; left: 22.5625px; width: 100%; height: 798.703px;">
                                        <fieldset>
                                            <div id="select-container">
                                                <!--월세조정-->
                                                <h6 class="filterTitle"><strong>월세 범위</strong>&nbsp;&nbsp;(0만원~300만원)</h6>
                                                <div id="slider"></div>
                                                <div class="slider-values">
                                                <span id="minValue">20</span>만원 - <span id="maxValue">150</span>만원
                                                </div>
                                                <script>
                                                    var slider = document.getElementById('slider');
                                                    var minValue = document.getElementById('minValue');
                                                    var maxValue = document.getElementById('maxValue');

                                                    noUiSlider.create(slider, {
                                                        start: [20, 150],
                                                        connect: true,
                                                        range: {
                                                        'min': 0,
                                                        'max': 300
                                                        },
                                                        step: 1,
                                                        format: {
                                                        to: function(value) {
                                                            return Math.round(value);
                                                        },
                                                        from: function(value) {
                                                            return value;
                                                        }
                                                        }
                                                    });
                                                
                                                    slider.noUiSlider.on('update', function(values) {
                                                        minValue.textContent = values[0];
                                                        maxValue.textContent = values[1];
                                                    }); 
                                                </script>
                                                <!--월세조정 끝-->
                                                <br>
                                                <!-- 성별 타입 -->
                                                <div class="genderFilter">
                                                    <p class="filterTitle"><strong>성별 타입</strong>
                                                    <div class="filter_cont">
                                                            <input type="radio" id="house-filter_gender_division_f" name="gender_division" value="f"><label for="house-filter_gender_division_f"><span class="select_icon02">&nbsp;</span>여성전용</label>&nbsp;
                                                            <input type="radio" id="house-filter_gender_division_m" name="gender_division" value="m"><label for="house-filter_gender_division_m"><span class="select_icon04">&nbsp;</span>남성전용</label>&nbsp;
                                                            <input type="radio" id="house-filter_gender_division_mf" name="gender_division" value="u"><label for="house-filter_gender_division_mf"><span class="select_icon03">&nbsp;</span>남녀공용</label>&nbsp;
                                                    </div>
                                                </div>
                                                <!-- 성별 타입 -->
                                                <br>
                                                <!-- 주거 형태 -->
                                                <div class="houseTypeWrap">
                                                    <p class="filterTitle"><strong>주거 유형</strong>
                                                    <div class="filter_cont">
                                                            <input type="radio" id="house-filter_house_type_0" name="house_type" value="0"><label for="house-filter_house_type_0"><span class="select_icon02">&nbsp;</span>아파트</label>&nbsp;
                                                            <input type="radio" id="house-filter_house_type_1" name="house_type" value="1"><label for="house-filter_house_type_1"><span class="select_icon04">&nbsp;</span>단독주택</label>&nbsp;
                                                            <input type="radio" id="house-filter_house_type_2" name="house_type" value="2"><label for="house-filter_house_type_2"><span class="select_icon03">&nbsp;</span>빌라</label>&nbsp;
                                                            <input type="radio" id="house-filter_house_type_3" name="house_type" value="3"><label for="house-filter_house_type_3"><span class="select_icon03">&nbsp;</span>기타</label>&nbsp;
                                                    </div>
                                                </div>
                                                <!-- 주거형태 끝 -->
                                                <!-- 룸 형태 -->
                                                <br>
                                                <div class="houseTypeWrap">
                                                    <p class="filterTitle"><strong>룸 형태</strong>
                                                    <div class="filter_cont">
                                                            <input type="radio" id="house-filter_max_resident_1" name="max_resident" value="1"><label for="house-filter_max_resident_1"><span class="select_icon02">&nbsp;</span>1인실</label>&nbsp;
                                                            <input type="radio" id="house-filter_max_resident_2" name="max_resident" value="2"><label for="house-filter_max_resident_2"><span class="select_icon04">&nbsp;</span>2인실</label>&nbsp;
                                                            <input type="radio" id="house-filter_max_resident_3" name="max_resident" value="3"><label for="house-filter_max_resident_3"><span class="select_icon03">&nbsp;</span>3인실</label>&nbsp;
                                                    </div>
                                                </div>
                                                <!-- 룸 형태 끝 -->
                                                <br> 
                                                <div class="houseTypeWrap">
                                                    <p class="filterTitle"><strong>층수</strong>
                                                    <div class="filter_cont">
                                                        <select>
                                                            <option value="semi-basement">반지하</option>
                                                            <option value="rooftop">옥탑</option>
                                                            <option value="first-floor">지상</option>
                                                        </select>
                                                    </div>
                                                </div>
                                                <br>
                                                <!--입주일 선택-->
                                                <div class="dateWrap">
                                                  <h5 class="filterTitle"><strong>입주예정일</strong></h5>
                                                   <input type="date" class="text-input" name="open_date" max="2099-12-31" placeholder="ex)2017-08-14">
                                                </div>
                                                <!--입주일 선택 끝-->
                                            </div>
                                        </fieldset>
                                        <hr>
                                        <div class="applyWrap">
                                            <input type="reset" id="reset" value="초기화">       
                                            <input type="button" id="detail-search-click" value="검색" onclick="">    
                                            <input type="button" id="close" value="닫기" onClick="">                               
                                        </div>
                                    </div>
                                </form>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <!-- JavaScript 코드 -->
    <script>
        function toggleContent() {
            var contentView = document.getElementById('content');
            var contentClicked = document.getElementById('content-clicked');

            if (contentView.style.opacity === '0') {
                contentView.style.opacity = '1';    
                contentClicked.style.opacity = '0';
                contentView.style.pointerEvents = 'auto';
                contentClicked.style.pointerEvents = 'none';
            } else {
                contentView.style.opacity = '0';
                contentClicked.style.opacity = '1';
                contentView.style.pointerEvents = 'none';
                contentClicked.style.pointerEvents = 'auto';
            }
        }
    </script>
	
	
	
	
	<%@ include file="/WEB-INF/views/common/footer.jsp"%>
	

</body>
</html>