<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<style>
.offcanvas-profile {
	width: 200px;
 	height: 200px; 
 	margin-left: 25px;
}

.notification {
  height : 100px;
  display: block;
  padding: 8px;
  background-color: #f7f7f7;
  border: 1px solid #ccc;
  border-radius: 4px;
  margin-bottom: 10px;
  font-size: 14px;
  color: #333;
  text-decoration: none;
}

.notification:hover {
  background-color: #eaeaea;
}

.notification .time {
  color: #888;

}

.notification .title {
  font-weight: bold;
}

.notification .content {
  white-space: nowrap; /* 텍스트를 한 줄로 유지 */
  overflow: hidden; /* 넘치는 부분을 감춤 */
  text-overflow: ellipsis;
  width : 100% !important;
}

.alarm-pagination {
    position: fixed;
    bottom: 65px;
    right: 50px;


}

</style>

	<script type="text/javascript">
		var socket = null;

		var isFirstLoad = true;
		var isUpdatingNotification = false;
		var isVibrating = false;

		
		$(document).ready(function(){ //페이지가 새로고침 되면 웹소켓을 연결시킨다.
			
		if(${loginUser != null}){
			connectWs();
			addMessageToNotificationList('${loginUser.memberId}');

			$('#notificationButton').show();

			}

		});
		
		function connectWs(){
		var ws = new SockJS("/notification");
		socket = ws;
		
		ws.onopen = function() {

		};	
			
			ws.onmessage = function(event) {
				 
				 addMessageToNotificationList(event.data);


				 if (!isFirstLoad && !isUpdatingNotification && !isVibrating) {
				      vibrateButton();
				    }
				    isFirstLoad = false;
			 };
			ws.onclose = function() {

		 };
		};

		

		function addMessageToNotificationList(message) {

			  $.ajax({
			    url: '/selectRecentNotification',
			    method: 'GET',
			    dataType: 'json',
			    data: {
			      receiverId: '${loginUser.memberId}'
			    },
			    success: function(data) {

			      selectRecentNotification(data);
			      if (!isFirstLoad && !isVibrating) {
			        vibrateButton();
			      }
			      isUpdatingNotification = false;

			    },
			    error: function(error) {
			      console.error('웹소켓 오류가 발생했습니다:', error);
			    }
			  });
			}


		function selectRecentNotification(data) {
			console.log(data);
			// 응답으로부터 필요한 데이터 추출
			var notificationList = data.list;
			var listCount = data.listCount;
			var pi = data.pi;

			// 데이터를 사용하여 목록 업데이트
			var notificationListElement = $('#notificationList');
			notificationListElement.empty(); // 목록 초기화

			if (listCount === 0) {
			var notificationItem = $('<li style="list-style-type: none; padding-top: 250px; font-weight: bold;">').text('알림이 없습니다.');
			notificationListElement.prepend(notificationItem);
			return;
			}
			
			notificationList.reverse();
			// 데이터를 반복하여 목록에 추가
			for (var i = 0; i < notificationList.length; i++) {
			var notification = notificationList[i];
			var senderId = notification.senderId;
			var createdTime = new Date(notification.createdTime);
			var timeDifference = getTimeDifference(createdTime);
			var title = notification.content;
			var postType = notification.postType;
			var postNo = notification.postNo;
			var receiverId = notification.receiverId;
			var postContent = notification.postContent;
			   
			
			var notificationText = '';
		    if (postType === 'board') {
		    	notificationText = '<a href="/detail.bo?bno=' + postNo + '" onclick="notificationDelete(\'' + '/detail.bo?bno=' + postNo + '\', \'' + postNo + '\', \'board\', \'' + receiverId + '\')" class="notification">' + senderId + '님이 자유게시판의 ' +  '<span class="title">' + title + '</span>' + ' 게시글에 댓글을 달았습니다.' + '<div class="content">"' + postContent + '"</div>' + '<span class="time">' + timeDifference + '</span>' + '</a>';

		    } else {
		      // You can add handling for other postTypes.
		    }


		    var notificationItem = $('<li style="list-style-type: none"></li>').html(notificationText);
		    notificationListElement.prepend(notificationItem);
		    
		    
		    var countElement = $('<span style="font-size: 14px; ">').addClass('notification-count').text(listCount);
		      $('#notificationButton .notification-count').remove();
		      $('#notificationButton').append(countElement);
		      createPagination(pi.startPage, pi.endPage, pi.currentPage, pi.maxPage);

		  }
			
			
		
			
			

		  // Combine the data and update the list count and pagination values
		  var response = {
		    listCount: listCount,
		    pi: pi
		  };

		  // Perform any additional actions with the combined data, if needed

		  // Example:
		  // updatePagination(response);

		  // Perform any additional actions with the updated list count, if needed

		  // Example:
		  // updateListCount(listCount);
		}
		
		function createPagination(startPage, endPage, currentPage, maxPage) {
			  var paginationContainer = document.getElementById("paginationContainer");
			  paginationContainer.innerHTML = ""; // 기존 페이지네이션 초기화

			  var paginationList = document.createElement("ul");
			  paginationList.classList.add("pagination");

			  // 이전 페이지 링크
			  var previousPageItem = createPaginationItem(currentPage - 1, "이전", currentPage === 1);
			  paginationList.appendChild(previousPageItem);

			  // 페이지 숫자 링크
			  for (var i = startPage; i <= endPage; i++) {
			    var pageItem = createPaginationItem(i, i, i === currentPage);
			    paginationList.appendChild(pageItem);
			  }

			  // 다음 페이지 링크
			  var nextPageItem = createPaginationItem(currentPage + 1, "다음", currentPage === maxPage);
			  paginationList.appendChild(nextPageItem);

			  paginationContainer.appendChild(paginationList);
			}

			// 페이지네이션 아이템 생성 함수
			function createPaginationItem(pageNumber, label, isDisabled) {
			  var listItem = document.createElement("li");
			  listItem.classList.add("page-item");

			  var link = document.createElement("a");
			  link.classList.add("page-link");
			  link.href = "#";
			  link.textContent = label;

			  listItem.appendChild(link);

			  if (isDisabled) {
			    listItem.classList.add("disabled");
			  } else {
			    // 페이지 클릭 이벤트 처리
			    link.addEventListener("click", function (event) {
			      event.preventDefault();
			      // 페이지 클릭 시 필요한 동작 수행
			      // 예: 해당 페이지의 알림 목록 조회 등
			      selectNotificationPage(pageNumber);
			    });
			  }

			  return listItem;
			}
		
			
			function selectNotificationPage(page) {
				$.ajax({
				    url: '/selectRecentNotification',
				    method: 'GET',
				    dataType: 'json',
				    data: {
				      receiverId: '${loginUser.memberId}',
				      page : page
				    },
				    success: function(data) {
				      selectRecentNotification(data);

				    },
				    error: function(error) {
				      console.error('웹소켓 오류가 발생했습니다:', error);
				    }
				  });
				}
	

			
			function vibrateButton() {
				  if (isVibrating) {
				    return;
				  }
				  isVibrating = true;

				  var counter = 0;
				  var intervalId = setInterval(function() {
				    if (counter >= 5) {
				      clearInterval(intervalId);
				      $('#notificationButton').removeClass('vibrate');
				      isVibrating = false;
				      return;
				    }

				    $('#notificationButton').toggleClass('vibrate');
				    counter++;
				  }, 500); // Repeat every 500ms (adjust as needed)
				}
			
			
			function getTimeDifference(timestamp) {
				  var currentDate = new Date();
				  var notificationDate = new Date(timestamp);
				  var timeDifference = currentDate - notificationDate;
				  var seconds = Math.floor(timeDifference / 1000);
				  var minutes = Math.floor(seconds / 60);
				  var hours = Math.floor(minutes / 60);
				  var days = Math.floor(hours / 24);

				  if (days > 0) {
				    return days + "일 전";
				  } else if (hours > 0) {
				    return hours + "시간 전";
				  } else if (minutes > 0) {
				    return minutes + "분 전";
				  } else if (seconds > 0){ 
				    return seconds + "초 전";
				  } else {
				    return "방금 전";
				  }
				}	
			
			
				
		
		
		function notificationCount() {
			var notificationList = $('#notificationList');
			 $.ajax({
				    url: '/notificationCount',
				    method: 'GET',
				    dataType: 'json',
				    data : {
				    	receiverId : '${loginUser.memberId}'
				    },
				    success: function(data) {
				    	
				    	var count = data;

				          // Display the updated count next to the notificationButton
				          var countElement = $('<span style="font-size: 14px; ">').addClass('notification-count').text(count);

				          
				          $('#notificationButton .notification-count').remove(); // Remove the previous count
				          $('#notificationButton').append(countElement);
				          
				    }
			 });
		};
		
				
		
		function notificationDelete(linkUrl, postNo, postType, receiverId) {
			  // AJAX 요청 보내기
			  $.ajax({
			    url: '/notificationDelete', // 댓글 알림 삭제를 처리하는 URL
			    method: 'POST',
			    data: {
			      postNo: postNo, // 게시물 번호 전달
			      postType: postType, // 게시물 유형 전달
			      receiverId: receiverId // 수신자 ID 전달
			    },
			    dataType: 'json',
			    success: function(response) {
			      // 요청이 성공하면 링크로 이동
			      if (response.success) {



			        // 링크로 이동
			        window.location.href = linkUrl;
			      } else {
			        console.error('댓글 알림 삭제 실패:', response.message);
			      }
			    },
			    error: function(error) {
			      console.error('댓글 알림 삭제 요청 실패:', error);
			    }
			  });
			}
	</script>


	<c:if test="${ not empty alertMsg }">
		<script>
			alert("${ alertMsg }");
		</script>
		<c:remove var="alertMsg" scope="session" />
	</c:if>

	<c:if test="${ not empty toastError }">
		<script>
		toastr.error("${ toastError }");
		</script>
		<c:remove var="toastError" scope="session" />
	</c:if>
	
	<c:if test="${ not empty toastSuccess }">
		<script>
		toastr.success("${ toastSuccess }");
		</script>
		<c:remove var="toastSuccess" scope="session" />
	</c:if>

	<c:set var="currentPath" value="${pageContext.request.servletPath}" />
	<c:if test="${!currentPath.equals('/WEB-INF/views/main.jsp')}">
	  <script>
	    window.addEventListener('DOMContentLoaded', function() {
	      var navbarCollapsible = document.querySelector('#mainNav');
	      navbarCollapsible.style.backgroundColor = 'white';
	    });
	  </script>
	</c:if>
	
	
	
	<button id="notificationButton" style="display : none;"><i class="fas fa-bell"></i></button>

<style>
#notificationButton {
  position: fixed;
  right: 10px;
  bottom: 10px;
  width: 60px;
  height: 60px;
  border-radius: 50%;
  background-color: #000000;
  color: #ffffff;
  font-size: 32px;

  border: none;
  outline: none;
  cursor: pointer;
  z-index : 9999;

  box-shadow : rgba(255, 255, 255, 0.12) 0px 0px 2px 0px inset, rgba(0, 0, 0, 0.05) 0px 0px 2px 1px, rgba(0, 0, 0, 0.22) 0px 4px 20px;
}

#notificationButton:hover {
  box-shadow: 0 0 30px rgba(0, 0, 0, 0.3);

}

#notificationModal {
  display: none;
  position: fixed;
  right: 0;
  top: 0;
  width: 300px;
  height: 100%;
  background-color: #fff;

  z-index: 9998;

  overflow-y: auto;
  box-shadow: 0px 0px 10px rgba(0, 0, 0, 0.2);
}

.modal-content {
  padding: 15px;
}

.close {
  position: absolute;
  top: 0px;
  right: 5px;
  font-size: 24px;
  cursor: pointer;
}


@keyframes vibrate {
  0% {
    transform: translate(-2px, -2px);
    background-color: rgb(250, 107, 111);
  }
  25% {
    transform: translate(2px, -2px);
    background-color: rgb(250, 107, 111);
  }
  50% {
    transform: translate(2px, 2px);
    background-color: rgb(250, 107, 111);
  }
  75% {
    transform: translate(-2px, 2px);
    background-color: rgb(250, 107, 111);
  }
  100% {
    transform: translate(-2px, -2px);
    background-color: rgb(250, 107, 111);
  }
}

.vibrate {
  animation: vibrate 0.1s infinite linear;
}

</style>



<div id="notificationModal">
	<div class="modal-header justify-content-center" style="height : 40px;">
	<h4>알림</h4>
	<span class="close">&times;</span>
	</div>
  <div class="modal-content">
    <ul id="notificationList"></ul>
  </div>
  <nav aria-label="Page navigation example" id="paginationContainer">
      <ul class="pagination alarm-pagination">
      </ul>
      </nav>
  
  <div class="modal-footer">
      <button id="deleteAllButton" class="delete-all-button" style="position: fixed; width: 80px; height: 30px; bottom: 25px; right: 170px;">모두 읽음</button>
    </div>
</div>
	
<script>


$('#notificationButton').click(function(e) {
    console.log('click');
    e.stopPropagation();
    $('#notificationModal').toggle();
  });

  // Hide the modal window when the close modal window button is clicked
  $('#notificationModal .close').click(function(e) {
    e.stopPropagation();
    $('#notificationModal').hide();
  });

  $(document).click(function(event) {
    var modal = $('#notificationModal');
    if (!modal.is(event.target) && modal.has(event.target).length === 0) {
      modal.hide();
    }
  });


</script>

	
	
	
	
	
	<header>
	        <nav class="navbar navbar-expand-lg navbar-light fixed-top header_wrap" id="mainNav">
	            <div class="header container px-4 px-lg-5">
	                <a class="navbar-brand" href="/"><img class="logo" src="/resources/img/common/sim5.png"></a>
	                
	                <ul class="nav nav-pills navi">
          
	                        <li class="nav-item"><a href="" class="nav-link nav-text">방 찾기</a></li>

	                        <li class="nav-item">
	                            <a href="#" class="nav-link nav-text">쉼</a>
	                            <ul>
	                                <li><a href="">쉼 소개</a></li>
	                            </ul>
	                        </li>
	                        <li class="nav-item">
	                            <a href="#" class="nav-link nav-text">커뮤니티</a>
	                            <ul>
	                                <li><a href="/list.bo">자유게시판</a></li>

	                                <li><a href="/list.in">입주후기</a></li>

	                                <li><a href="/list.fi">사람구해요</a></li>
	                            </ul>
	                        </li>
	                        
	                        <c:choose>
				            	<c:when test="${ empty loginUser }">
					                <!-- 로그인 전 -->
					                 <li class="nav-item">
	                            		<a href="/member/login" class="nav-link nav-text">로그인</a>
	                        		</li>
				                </c:when>
				                <c:otherwise>
					                <li class="nav-item">
	                            		<a href="#" class="nav-link nav-text">${ loginUser.memberName }님</a>
		                            	<ul>
			                                <li><a href="/mypage/timeline">마이페이지</a></li>

			                                <li><a href="/chat.ch">채팅방</a>
			                                
			                                <li>
			                                <form id="logout-form1" action="/member/logout" method="post">
			                                <a href="#" onclick="event.preventDefault(); logout();">로그아웃</a>
			                                </form>
			                                </li>
			                                
		                            	</ul>
	                        		</li>
				                </c:otherwise>
				            </c:choose>    
	                        
	                        <li class="nav-item">
	                            <a href="#" class="nav-link nav-text">고객센터</a>
	                            <ul>
	                                <li><a href="/notice.no">공지사항</a></li>
	                                <li><a href="/faqList">자주 묻는 질문</a></li>
	                                <li><a href="/event.ev">이벤트</a></li>  
	                            </ul>
	                        </li>
	                </ul>
	                
	                    <!-- 햄버거 메뉴 -->
	                    <button class="navbar-toggler" type="button" data-bs-toggle="offcanvas" data-bs-target="#offcanvasNavbar" aria-controls="offcanvasNavbar">
	                            <span class="navbar-toggler-icon"></span>
	                    </button>
	                    <div class="offcanvas offcanvas-end" tabindex="-1" id="offcanvasNavbar" aria-labelledby="offcanvasNavbarLabel">
	                        <div class="offcanvas-header">
	                        <c:choose>
				            	<c:when test="${ empty loginUser }">
	                            <h5 class="offcanvas-title" id="offcanvasNavbarLabel">&nbsp;&nbsp;&nbsp;&nbsp;로그인 해주세요.</h5>
	                           	</c:when>
	                       </c:choose>
	                            <button type="button" class="btn-close text-reset"
	                                data-bs-dismiss="offcanvas" aria-label="Close"></button>
	                        </div>
	                        <div class="offcanvas-body">
	                        
	                        
	                        <c:choose>
				            	<c:when test="${ empty loginUser }">
					                 <div class="user-button">
	                                <button type="button"
	                                    style="width: 150px; margin-right: 20px; margin-left: 20px;"
	                                    class="btn btn-success btn-lg" onclick="location.href='/member/login'">로그인</button>
	                                <button type="button" style="width: 150px;"
	                                    class="btn btn-outline-success btn-lg" onclick="location.href='/member/join'">회원가입</button>
	                            	</div>
				                </c:when>
				            </c:choose>
	                            <ul class="navbar-nav justify-content-end flex-grow-1 pe-3 pb-2">
									<c:choose>
									  <c:when test="${not empty loginUser}">
									    <c:choose>
									      <c:when test="${empty loginUser.changeName}">
									        <img src="/resources/img/common/default_profile.png" class="offcanvas-profile">
									      </c:when>
									      <c:otherwise>
									        <img src="${loginUser.changeName}" class="offcanvas-profile"/>
									      </c:otherwise>
									    </c:choose>
									  </c:when>
									</c:choose>

	                                <c:if test="${not empty loginUser }">
	                                
	                                <li class="nav-item dropdown m-4">
	                                    <a class="side-black" href="#" id="offcanvasNavbarDropdown1" role="button" data-bs-toggle="dropdown" aria-expanded="false">${ loginUser.nickName }님</a>
	                                        <ul class="dropdown-menu" aria-labelledby="offcanvasNavbarDropdown1">
	                                           <li><a class="dropdown-item" href="mypage">마이페이지</a></li>
	                                           <li><a class="dropdown-item" href="chat.ch">채팅방</a></li>
	                                           <li><form id="logout-form2" action="/member/logout" method="post"><a class="dropdown-item" href="#" onclick="event.preventDefault(); logout();">로그아웃</a></form></li>
	                                        </ul> 
	                                </li>
	                                
	                                </c:if>
	                                
	                                <li class="nav-item offcanvas-text m-4">
	                                    <a class="side-black" aria-current="page" href="">방 찾기</a>
	                                </li>
	                                
	                                <li class="nav-item dropdown m-4">
	                                    <a class="side-black" href="#" id="offcanvasNavbarDropdown1" role="button" data-bs-toggle="dropdown" aria-expanded="false">셰어하우스 쉼</a>
	                                        <ul class="dropdown-menu" aria-labelledby="offcanvasNavbarDropdown1">
	                                           <li><a class="dropdown-item" href="#">쉼 소개</a></li>
	                                        </ul> 
	                                </li>
	                                <li class="nav-item dropdown m-4"><a class="side-black" href="#" id="offcanvasNavbarDropdown2" role="button" data-bs-toggle="dropdown" aria-expanded="false">커뮤니티 </a>
	                                    <ul class="dropdown-menu" aria-labelledby="offcanvasNavbarDropdown2">
	                                        <li><a class="dropdown-item" href="list.bo">자유게시판</a></li>
	                                        <li><a class="dropdown-item" href="list.fi">사람구해요</a></li>

	                                        <li><a class="dropdown-item" href="list.in">입주 후기 </a></li>                                            

	                                    </ul>
	                                </li>
	                                <li class="nav-item dropdown m-4"><a class="side-black" href="#" id="offcanvasNavbarDropdown3" role="button" data-bs-toggle="dropdown" aria-expanded="false">고객센터 </a>
	                                    <ul class="dropdown-menu" aria-labelledby="offcanvasNavbarDropdown3">
	                                        <li><a class="dropdown-item" href="notice.no">공지사항</a></li>
	                                        <li><a class="dropdown-item" href="/faqList">자주 묻는 질문</a></li> 
	                                        <li><a class="dropdown-item" href="event.ev">이벤트</a></li>                    
	                                    </ul>
	                                </li>
	                            </ul>
	                        </div>
	                    </div>
	            </div>
	        </nav>
	    </header>
	    
	    
	    <script>
    function logout() {
        $.ajax({
            url: '/member/logout',
            method: 'POST',
            success: function(response) {
            	alert('로그아웃 되었습니다.');
                location.reload(true);
            }
        });
    }
	</script>