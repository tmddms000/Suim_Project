<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>셰어하우스 리스트</title>
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
        .search-box {
            margin-bottom: 20px;
        }
        #keyword-detail-search{
            width : 275px;
            display: flex;
            align-items: center;
            background-color: #f5f5f5;
            border-radius: 20px;
            padding: 10px 20px;
        }
        #search-detail {
            height: 50px;
            width: 50px;
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
            padding-left : 10px;
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
        a {
        text-decoration: none;
        }
        .filterTitle{
        	margin-bottom : 5px;
        }
   
    	.info-title {
		    display: table-cell;
		    text-align: center;
		    height: 80px;
		    width : 200px;
		    line-height:22px;
            margin: 0 auto;
           	vertical-align:middle;
		}
		.applyWrap{
			display: flex;
	        justify-content: space-between;
	        width: 100%; /* 부모 요소의 너비를 설정해주세요 */
	        margin: 0 auto; /* 가운데 정렬을 위해 부모 요소를 가운데로 정렬합니다 */
		}
		 #reset {
	        background-color: #FA6B6F;
	        color: white;
	        padding: 10px 20px;
	        border: none;
	        border-radius: 5px;
	        box-shadow: 0px 2px 4px rgba(0, 0, 0, 0.4);
	        font-weight: bold;
	        cursor: pointer;
	        transition: background-color 0.3s ease;
	        width: 50px;
	        height: 30px;
	        font-size: 14px;
	        display: flex;
	        justify-content: center;
	        align-items: center;
	    }
	
	    #reset, #close {
	        background-color: #FA6B6F;
	        color: white;
	        padding: 10px 20px;
	        border: none;
	        border-radius: 5px;
	        box-shadow: 0px 2px 4px rgba(0, 0, 0, 0.4);
	        font-weight: bold;
	        cursor: pointer;
	        transition: background-color 0.3s ease;
	        width: 50px;
	        height: 30px;
	        font-size: 14px;
	        display: flex;
	        justify-content: center;
	        align-items: center;
	    }
	
	    #reset:hover, #close:hover {
	        background-color: rgb(216, 69, 9);
	    }      
	    
   	</style>
     
</head>


<body>

	<%@ include file="/WEB-INF/views/common/include.jsp"%>


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
		if ("${searchKeyword}" == "") {
			
			var map = new kakao.maps.Map(document.getElementById('map'), {
	            center: new kakao.maps.LatLng("37.5339677", "126.897079"),
	            level: 5
	        });
		} else {
			
			 if ("${regionEmpty}" === "true") {
				 
				 if ("${centerAdEmpty}" === "true") {
					 var map = new kakao.maps.Map(document.getElementById('map'), {
				            center: new kakao.maps.LatLng("37.5339677", "126.897079"),
				            level: 5
				     	});
					 	alert("검색 결과가 없습니다.");
				 	} else {
				 		var map = new kakao.maps.Map(document.getElementById('map'), {
				            center: new kakao.maps.LatLng("${centerAd.get(0).latitude}", "${centerAd.get(0).longitude}"),
				            level: 5
				     	});  
				 	} 
				} else {
			        // 지도를 초기화하고 지역 좌표를 사용하여 표시합니다.
			        var map = new kakao.maps.Map(document.getElementById('map'), {
			            center: new kakao.maps.LatLng("${region.get(0).latitude}", "${region.get(0).longitude}"),
			            level: 5
			   	});
			}
		}
		
	    map.setMaxLevel(9);
		
	    var imageSrc = '/resources/img/house/home-marker.png', // 마커이미지의 주소입니다    
	    	imageSize = new kakao.maps.Size(45, 45), // 마커이미지의 크기입니다
	    	imageOption = {offset: new kakao.maps.Point(20, 45)};
	    
	    var markerImage = new kakao.maps.MarkerImage(imageSrc, imageSize, imageOption);
	
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
						            image: markerImage
						        });

							// 마커가 지도 위에 표시되도록 설정합니다
							marker.setMap(map);	
							
							// 마커를 markers 배열에 추가
							markers.push(marker);		
							
							var iwContent = '<a href="detail.ho?hno= + ${m.houseNo}" class="info-title"><div style="padding:5px;">${m.houseName}<br>${ m.houseAddress}</div></a>', // 인포윈도우에 표출될 내용으로 HTML 문자열이나 document element가 가능합니다
						    iwPosition = new kakao.maps.LatLng(result[0].y, result[0].x); //인포윈도우 표시 위치입니다
						    iwRemoveable = true;
						    
						    var infowindow = new kakao.maps.InfoWindow({
						        position : iwPosition, 
						        content : iwContent,
						        removable : iwRemoveable,
						    });
						    
						    var isInfowindowOpen = false; // 인포윈도우의 열림 상태를 저장하는 변수

							 // 마커에 클릭 이벤트를 등록합니다
							 kakao.maps.event.addListener(marker, 'click', function() {
							   if (isInfowindowOpen) {
							     // 인포윈도우가 열려있는 경우 닫기
							     infowindow.close();
							     isInfowindowOpen = false;
							   } else {
							     // 인포윈도우가 닫혀있는 경우 열기
							     infowindow.open(map, marker);
							     isInfowindowOpen = true;
							   }
							 });
							 var zoomControl = new kakao.maps.ZoomControl();
								
								kakao.maps.event.addListener(map, 'zoom_changed', function() {        
								    
									infowindow.close();
									  isInfowindowOpen = false;
								});
							
							
							// 카드를 동적으로 생성하여 id가 "content"인 div에 추가합니다
		                    var cardDiv = document.createElement('div');
		                    cardDiv.className = 'col-md-6';
		                    cardDiv.id = '${m.houseNo}';
		                    
		                    var cardLink = document.createElement('a');
		                    var hno = '${m.houseNo}';
		                    cardLink.href = 'detail.ho?hno=' + hno;
		                    cardLink.className = '';
		                    
		                    var card = document.createElement('div');
		                    card.className = 'card';
		                    
		                    var cardImage = document.createElement('img');
		                    cardImage.src = 'resources/img/house/uploadFiles/${m.changeName}';
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
						            position: new kakao.maps.LatLng(result[0].y, result[0].x),
					           		image: markerImage
						        });
						    // 클러스터에 마커 추가
							clusterer.addMarker(marker);
						    
							// 마커를 markers 배열에 추가
							markers.push(marker);
							
							var iwContent = '<a href="detail.ho?hno= + ${m.houseNo}" class="info-title"><div style="padding:5px;">${m.houseName}<br>${ m.houseAddress}</div></a>', // 인포윈도우에 표출될 내용으로 HTML 문자열이나 document element가 가능합니다
						    iwPosition = new kakao.maps.LatLng(result[0].y, result[0].x); //인포윈도우 표시 위치입니다
						    iwRemoveable = true;
						    
						    var infowindow = new kakao.maps.InfoWindow({
						        position : iwPosition, 
						        content : iwContent,
						        removable : iwRemoveable,
						    });
						    
						    var isInfowindowOpen = false; // 인포윈도우의 열림 상태를 저장하는 변수

							 // 마커에 클릭 이벤트를 등록합니다
							 kakao.maps.event.addListener(marker, 'click', function() {
							   if (isInfowindowOpen) {
							     // 인포윈도우가 열려있는 경우 닫기
							     infowindow.close();
							     isInfowindowOpen = false;
							   } else {
							     // 인포윈도우가 닫혀있는 경우 열기
							     infowindow.open(map, marker);
							     isInfowindowOpen = true;
							   }
							 });
							 var zoomControl = new kakao.maps.ZoomControl();
								
								kakao.maps.event.addListener(map, 'zoom_changed', function() {        
								    
									infowindow.close();
									  isInfowindowOpen = false;
								});
							
						
							// 카드를 동적으로 생성하여 id가 "content"인 div에 추가합니다
		                    var cardDiv = document.createElement('div');
		                    cardDiv.className = 'col-md-6';
		                    cardDiv.id = '${m.houseNo}';
		                    
		                    var cardLink = document.createElement('a');
		                    var hno = '${m.houseNo}';
		                    cardLink.href = 'detail.ho?hno=' + hno;
		                    cardLink.className = '';
		                    
		                    var card = document.createElement('div');
		                    card.className = 'card';
		                    
		                    var cardImage = document.createElement('img');
		                    cardImage.src = 'resources/img/house/uploadFiles/${m.changeName}';
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
	        minLevel: 8, // 클러스터 할 최소 지도 레벨 
	    });	
		
		}
	</script>
            <div class="col-md-5">
                <form method="get" action="/list.ho">
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
                                <div id="keyword-detail-search">
                                <input type="text" name="searchKeyword" placeholder="지역명, 주변명 입력">
                                <button id="detail-search-click" type="submit">
                                    <i class="fa fa-search" style="color : rgb(249,88,10)"></i>
                                </button>
                                </div>
                        </div>
                        <div id="content-view" class="row">
                            <div  id="content" class="row box" style="height: 100%; padding: 0; opacity: 1;"></div>
                            <div id="content-clicked" class="col-md-12 box" style="opacity: 0; pointer-events: none;">
                                   <div class="h-filter-detailFix" id="filter-detail" style="display: block; top: 170.297px; left: 22.5625px; width: 100%; height: 798.703px;">
                                        <fieldset>
                                            <div id="select-container">
                                                <!--월세조정-->
                                                <h6 class="filterTitle"><strong>월세 범위</strong>&nbsp;&nbsp;(현재 검색 범위 : <span id="minValueSpan">${minValueResult}</span>만원 - <span id="maxValueSpan">${maxValueResult}</span>만원)</h6>
                                                <div id="slider"></div>
                                                <div class="slider-values">
                                                <span name="minValueText" id="minValueText"></span>만원 - <span name="maxValueText" id="maxValueText"></span>만원
                                                </div>
                                                <input type="hidden" id="minValue" name="minValue">
												<input type="hidden" id="maxValue" name="maxValue">
                                                <script>
                                                var slider = document.getElementById('slider');
                                                var minValueText = document.getElementById('minValueText');
                                                var maxValueText = document.getElementById('maxValueText');
                                                var minValue = document.getElementById('minValue');
                                                var maxValue = document.getElementById('maxValue');
                                               	var initialValues = [0,500];
                                              
                                                noUiSlider.create(slider, {
                                                  start: initialValues,
                                                  connect: true,
                                                  range: {
                                                    'min': 0,
                                                    'max': 500
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
                                                  minValueText.textContent = values[0];
                                                  maxValueText.textContent = values[1];

                                                  minValue.value = values[0]*10000;
                                                  maxValue.value = values[1]*10000;

                                                });
                                              	</script>
                                                <!--월세조정 끝-->
                                                <!-- 성별 타입 -->
                                                <br>
                                                <div class="genderFilter">
                                                    <p class="filterTitle"><strong>성별 타입</strong>
                                                    <div class="filter_cont">
                                                            <input type="checkbox" id="house-filter_gender_divisions_f" name="genderDivisions" value="여성전용"><label for="house-filter_gender_divisions_f">&nbsp;여성전용</label>&nbsp;
                                                            <input type="checkbox" id="house-filter_gender_divisions_m" name="genderDivisions" value="남성전용"><label for="house-filter_gender_divisions_m">&nbsp;남성전용</label>&nbsp;
                                                            <input type="checkbox" id="house-filter_gender_divisions_mf" name="genderDivisions" value="남녀공용"><label for="house-filter_gender_divisions_mf">&nbsp;남녀공용</label>&nbsp;
                                                    </div>
                                                </div>
                                                <!-- 성별 타입 끝-->
                                                <br>
                                                <!-- 주거 형태 -->
                                                <div class="houseTypeWrap">
                                                    <p class="filterTitle"><strong>주거 유형</strong>
                                                    <div class="filter_cont">
                                                            <input type="checkbox" id="house-filter_house_type_0" name="houseType" value="아파트"><label for="house-filter_house_type_0">&nbsp;아파트</label>&nbsp;
                                                            <input type="checkbox" id="house-filter_house_type_1" name="houseType" value="오피스텔"><label for="house-filter_house_type_1">&nbsp;오피스텔</label>&nbsp;
                                                            <input type="checkbox" id="house-filter_house_type_2" name="houseType" value="원룸"><label for="house-filter_house_type_2">&nbsp;원룸</label>&nbsp;
                                                    </div>
                                                </div>
                                                <!-- 주거형태 끝 -->
                                             	<!-- 룸 형태 -->
                                                <br>
                                                <div class="houseTypeWrap">
                                                    <p class="filterTitle"><strong>룸 형태</strong>
                                                    <div class="filter_cont">
                                                            <input type="checkbox" id="house-filter_max_resident_1" name="maxResident" value=1><label for="house-filter_max_resident_1">&nbsp;1인실</label>&nbsp;
                                                            <input type="checkbox" id="house-filter_max_resident_2" name="maxResident" value=2><label for="house-filter_max_resident_2">&nbsp;2인실</label>&nbsp;
                                                            <input type="checkbox" id="house-filter_max_resident_3" name="maxResident" value=3><label for="house-filter_max_resident_3">&nbsp;3인실</label>&nbsp;
                                                    </div>
                                                </div>
                                                <!-- 룸 형태 끝 -->
                                                <br> 
                                                <div class="houseTypeWrap">
                                                    <p class="filterTitle"><strong>층수</strong>
                                                    <div class="filter_cont">
                                                            <input type="checkbox" id="house-filter_floor_type_0" name="floor" value="반지하"><label for="house-filter_floor_type_0">&nbsp;반지하</label>&nbsp;
                                                            <input type="checkbox" id="house-filter_floor_type_1" name="floor" value="옥탑"><label for="house-filter_floor_type_1">&nbsp;옥탑</label>&nbsp;
                                                            <input type="checkbox" id="house-filter_floor_type_2" name="floor" value="지상"><label for="house-filter_floor_type_2">&nbsp;지상</label>&nbsp;
                                                    </div>
                                                </div>
                                                <br>
                                                <!--입주일 선택-->
                                               	<div class="dateWrap">
                                                  <h5 class="filterTitle"><strong>입주예정일</strong></h5>
                                                   <input type="date" id="openDate" class="text-input" name="openDate" max="2099-12-31" placeholder="ex)2023-06-01">
                                                </div>
                                                <!--입주일 선택 끝-->
                                            </div>
                                        </fieldset>
                                        <hr>
                                        <div class="applyWrap">
                                            <input type="reset" id="reset" value="초기화" onclick="resetAndSearch()">       
                                            <input type="button" id="close" value="닫기" onClick="toggleContent()">                               
                                        </div>
                                    </div>
                            </div>
                        </div>
                    </div>
                </div>
                </form>
            </div>
        </div>
    </div>
    <!-- JavaScript 코드 -->
  	<!-- checkbox 유지 -->
  	<script>
	 // 페이지 로드 시 input 태그 상태 복원
	    window.addEventListener('DOMContentLoaded', function () {
	      // checkbox의 체크 상태를 localStorage에서 가져옵니다.
	      var checkedValues = localStorage.getItem('checkedValues');
	      if (checkedValues) {
	        checkedValues = JSON.parse(checkedValues);
	        var checkboxes = document.querySelectorAll('input[type="checkbox"]');
	        checkboxes.forEach(function (checkbox) {
	          if (checkedValues.includes(checkbox.value)) {
	            checkbox.checked = true;
	          }
	        });
	      }
	      const inputElement = document.querySelector('input[name="openDate"]');
	      const savedValue = localStorage.getItem('openDate');
	      if (savedValue) {
	        inputElement.value = savedValue;
	      }
	    });
	
	    // 폼 제출 이벤트 리스너 추가
	    document.getElementById('detail-search-click').addEventListener('click', function () {
	      // checkbox의 체크 상태 저장
	      var checkboxes = document.querySelectorAll('input[type="checkbox"]');
	      var checkedValues = [];
	      checkboxes.forEach(function (checkbox) {
	        if (checkbox.checked) {
	          checkedValues.push(checkbox.value);
	        }
	      });
	
	      // checkbox의 체크 상태를 localStorage에 저장합니다.
	      localStorage.setItem('checkedValues', JSON.stringify(checkedValues));
	
	      const inputElement = document.querySelector('input[name="openDate"]');
	      const value = inputElement.value;
	      localStorage.setItem('openDate', value); // 입력 값을 로컬 스토리지에 저장합니다.
	   });
	</script>

    <!-- 토글 효과 -->
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
    
    <!-- 오늘날짜 이전 날짜 선택 막기 -->
    <script>
		function updateMinDate() {
			  var now = Date.now();
			  var timeOff = new Date().getTimezoneOffset() * 60000;
			  var today = new Date(now - timeOff).toISOString().split("T")[0];
	
			  document.getElementById("openDate").setAttribute("min", today);
			}
	
			document.getElementById("openDate").addEventListener("change", updateMinDate);
	
			// 페이지 로드 시 최소값 업데이트
			updateMinDate();
	
			// 매일 자정마다 최소값 업데이트
		setInterval(updateMinDate, 24 * 60 * 60 * 1000);
	</script>
	<!-- 초기화 이후 검색효과 -->
	<script>
      function resetAndSearch() {
    	  
        localStorage.clear();
  
        window.location.href = 'list.ho';
      }
    </script>
	
	
	
	
	
	<%@ include file="/WEB-INF/views/common/footer.jsp"%>
	

</body>
</html>