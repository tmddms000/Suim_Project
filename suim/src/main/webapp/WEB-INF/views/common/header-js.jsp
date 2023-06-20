<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<style>
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


<script type="text/javascript">
		var socket = null;
		var isFirstLoad = true;
		var isUpdatingNotification = false;
		var isVibrating = false;

		$(document).ready(function(){ //페이지가 새로고침 되면 웹소켓을 연결시킨다.
			
		if(${loginUser != null} && ${loginUser.setAlarm == 1}){
			connectWs();
			addMessageToNotificationList('${loginUser.memberId}');
			$('#notificationButton').show();
			}

		});
		
		function connectWs() {
	        var ws = new SockJS("/notification");
	        socket = ws;

	        ws.onopen = function() {};

	        ws.onmessage = function(event) {
	            var message = event.data;
	            console.log(event);
	            if (message === "다중 로그인이 감지되어 로그아웃 됩니다.") {
	                // Handle the alert message
	                alert(message);
	                location.href = location.href;
	            }
	            
	            var data = JSON.parse(event.data);
	            var role = data.role; 
	            var messages = data.message; 
	       
	            if (role === "admin" && ${loginUser.adminAuth} != 1) {
	                toastr.info(messages);
	              }
	            
	            else {
	                // Handle other messages
	                addMessageToNotificationList(message);
	                if (!isFirstLoad && !isUpdatingNotification && !isVibrating) {
	                    vibrateButton();
	                }
	                isFirstLoad = false;
	            }
	        };
	    }
		
		
		function truncateText(element, maxLength) {
	        var text = element.textContent;
	        if (text.length > maxLength) {
	            text = text.substring(0, maxLength - 3) + '...';
	            element.textContent = text;
	        }
	    }

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
			// 응답으로부터 필요한 데이터 추출
			var notificationList = data.list;
			var listCount = data.listCount;
			var pi = data.pi;

			// 데이터를 사용하여 목록 업데이트
			var notificationListElement = $('#notificationList');
			notificationListElement.empty(); // 목록 초기화

			if (listCount === 0) {
			var notificationItem = $('<li style="list-style-type: none; text-align: center; font-weight: bold;">').text('알림이 없습니다.');
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
			var titles = notification.content;
			var postType = notification.postType;
			var postNo = notification.postNo;
			var receiverId = notification.receiverId;
			var postContent = notification.postContent;
			   
			
			function truncateText(text, maxLength) {
		        if (text.length > maxLength) {
		            return text.substring(0, maxLength - 3) + '...';
		        }
		        return text;
		    }
			
			var title = truncateText(titles, 8);
		    
			
			var notificationText = '';
		    if (postType === 'board') {
		    	notificationText = '<a href="/detail.bo?bno=' + postNo + '" onclick="notificationDelete(\'' + '/detail.bo?bno=' + postNo + '\', \'' + postNo + '\', \'board\', \'' + receiverId + '\')" class="notification">' + senderId + '님이 자유게시판의 ' +  '<span id="title">' + title + '</span>'+  '에 댓글을 달았습니다.' + '<div class="content">"' + postContent + '"</div>' + '<div class="time">' + timeDifference + '</div>' + '</a>';
		    
		    }
		    if (postType === 'find') {
		    	notificationText = '<a href="/detail.fi?fno=' + postNo + '" onclick="notificationDelete(\'' + '/detail.fi?fno=' + postNo + '\', \'' + postNo + '\', \'find\', \'' + receiverId + '\')" class="notification">' + senderId + '님이 사람구해요의 ' +  '<span id="title">' + title + '</span>' + '에 댓글을 달았습니다.' + '<div class="content">"' + postContent + '"</div>' + '<div class="time">' + timeDifference + '</div>' + '</a>';
		    }
		    if (postType === 'inreview') {
		    	notificationText = '<a href="/detail.in?ino=' + postNo + '" onclick="notificationDelete(\'' + '/detail.in?ino=' + postNo + '\', \'' + postNo + '\', \'inreview\', \'' + receiverId + '\')" class="notification">' + senderId + '님이 입주후기의 ' +  '<span id="title">' + title + '</span>' + '에 댓글을 달았습니다.' + '<div class="content">"' + postContent + '"</div>' + '<div class="time">' + timeDifference + '</div>' + '</a>';
		    }
		    
		    if (postType === 'wish') {
		    	notificationText = '<a href="/detail.ho?hno=' + postNo + '" onclick="notificationDelete(\'' + '/detail.ho?hno=' + postNo + '\', \'' + postNo + '\', \'wish\', \'' + receiverId + '\')" class="notification">' + senderId + '님이 회원님의 쉐어하우스 ' +  '<span id="title">"' + title + '"</span>' + '에 좋아요를 눌렀습니다.' + '<div class="time">' + timeDifference + '</div>' + '</a>';
		    }
		    
		    if (postType === 'rezOk') {
		    	notificationText = '<a href="/myHouseRez.ho?houseNo=' + postNo + '" onclick="notificationDelete(\'' + '/myhouseRez.ho?houseNo=' + postNo + '\', \'' + postNo + '\', \'rezOk\', \'' + receiverId + '\')" class="notification">' + senderId + '님이 회원님의 ' +  '<span id="title">"' + title + '"</span>' + '에 예약날짜로 ' + postContent + '에 예약신청을 했습니다.' + '<div class="time">' + timeDifference + '</div>' + '</a>';
		    }
		    
		    if (postType === 'rezNo') {
		    	notificationText = '<a href="/myhouseRez.ho?cPage=1&houseNo=' + postNo + '" onclick="notificationDelete(\'' + '/myhouseRez.ho?cPage=1&houseNo=' + postNo + '\', \'' + postNo + '\', \'rezNo\', \'' + receiverId + '\')" class="notification">' + senderId + '님이 회원님의 ' +  '<span id="title">"' + title + '"</span>' + '의  예약을 취소했습니다.' + '<div class="time">' + timeDifference + '</div>' + '</a>';
		    }
		    
		    if (postType === 'rezConfirm') {
		    	notificationText = '<a href="/mypage/reservation" onclick="notificationDelete(\'/mypage/reservation\', \'' + postNo + '\', \'rezConfirm\', \'' + receiverId + '\')" class="notification">' + senderId + '님이 회원님의 <span id="title">"' + title + '"</span> 의 예약을 확정시켰습니다. <div class="time">' + timeDifference + '</div></a>';
		    }
		    
		    

		    var notificationItem = $('<li style="list-style-type: none"></li>').html(notificationText);
		    notificationListElement.prepend(notificationItem);
		    
		    
		    var countElement = $('<span style="font-size: 10px; ">').addClass('notification-count').text(listCount);
		      $('#notificationButton .notification-count').remove();
		      $('#notificationButton').append(countElement);
		      createPagination(pi.startPage, pi.endPage, pi.currentPage, pi.maxPage);
		  }

		  var response = {
		    listCount: listCount,
		    pi: pi
		  };

		}
		
		function createPagination(startPage, endPage, currentPage, maxPage) {
			  var paginationContainer = document.getElementById("paginationContainer");
			  paginationContainer.innerHTML = ""; // 기존 페이지네이션 초기화

			  var paginationList = document.createElement("ul");
			  paginationList.classList.add("pagination");
			  paginationList.classList.add("pgn");

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
			
			
			
			
			function notificationDeleteAll(receiverId) {
				  // AJAX 요청 보내기
				  $.ajax({
				    url: '/notificationDeleteAll', // 댓글 알림 삭제를 처리하는 URL
				    method: 'POST',
				    data: {
				      receiverId: receiverId // 수신자 ID 전달
				    },
				    dataType: 'json',
				    success: function (response) {
				      if (response > 1) {
				        // 알림 목록 컨테이너
				        var notificationListElement = $('#notificationList');
						notificationListElement.empty()
						
						$('#notificationButton .notification-count').remove();
						
						var paginationContainer = $('#paginationContainer');
        				paginationContainer.empty();
        				
        				

				        // 알림이 없을 때 메시지 표시
				        var notificationItem = $('<li style="list-style-type: none; text-align:center; font-weight: bold;">').text('알림이 없습니다.');
				        notificationListElement.prepend(notificationItem);
				      }
				    },
				  });
				}
			
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
		
		
		$('#notificationButton').click(function(e) {
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