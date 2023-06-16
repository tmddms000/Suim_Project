<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<%@ include file="/WEB-INF/views/common/include.jsp"%>
<jsp:include page="/WEB-INF/views/common/header.jsp" />
<html>
<head>
<script type="text/javascript"
	src="https://cdnjs.cloudflare.com/ajax/libs/sockjs-client/1.5.2/sockjs.min.js"></script>
<!-- STOMP -->
<script type="text/javascript"
	src="https://cdnjs.cloudflare.com/ajax/libs/stomp.js/2.3.3/stomp.min.js"></script>

<link href="/resources/css/chat/chat.css" rel="stylesheet" />

<title>채팅방</title>
</head>
<body>

	<div class="container_chat">
		<div class="chat-list">
			<!-- 채팅목록 -->
			<h2>대화목록</h2>
			<ul>
				<c:forEach var="u" items="${list}">
					<c:if test="${u.muser eq Id}">
						<li data-cno="${u.chatNo}">${u.cuser}</li>
						 <span class="unread-count">${u.unreadCount}</span>
					</c:if>
					<c:if test="${u.cuser eq Id}">
						<li data-cno="${u.chatNo}">${u.muser}</li>
						 <span class="unread-count">${u.unreadCount}</span>
					</c:if>
				</c:forEach>

			</ul>
			        <!-- 새로고침 버튼 -->
            <button id="refreshButton">새로고침</button>
		</div>
		<div class="chat-window">
			<!-- 채팅창 -->
				<h2></h2>
			<button id="leaveButton">나가기</button>
			<a class="reportBtn" id="reportBtn"> <img title="신고" alt="신고" href="your_link_here"
				src="/resources/img/house/ico_report.png"></a>

			<div class="messages">
					<p data-cno="${c.chatNo}"></p>
				<p></p>
				<hr>
			</div>
			<div class="input-area">
				<textarea id="messageInput" placeholder="메시지를 입력하세요"></textarea>
				<input type="submit" value="전송" id="sendMessageButton">
			</div>
		</div>
	</div>

	<jsp:include page="/WEB-INF/views/common/footer.jsp" />

	<script type="text/javascript">
	const refreshButton = document.getElementById('refreshButton');
	refreshButton.addEventListener('click', function() {
	    location.reload();
	});
		document
				.addEventListener(
						"DOMContentLoaded",
						function() {
							const socket = new SockJS('/websocket');
							const stomp = Stomp.over(socket);
							stomp.debug = null; // stomp 콘솔 출력 X

							let rno = ''; // rno 전역 변수 선언
							let subscription; // 구독 객체 전역 변수 선언
							let Iuser = '';
							let leftRoom = false;

							$(document)
									.ready(
											function() {
												updateChatWindow(Iuser);
												// 대화목록의 각 아이디를 클릭했을 때 이벤트 처리
												$('.chat-list li')
														.click(
																function() {
																	var user = $(
																			this)
																			.text(); // 클릭한 아이디 값을 가져옴
																	var cno = $(
																			this)
																			.attr(
																					'data-cno'); // 클릭한 아이디의 cno 값을 가져옴
																	rno = cno;
																	Iuser = user; // 아이디값 변경
																    // 읽음 처리 요청
														     
																    $.ajax({
																        url: '/setRead',
																        type: 'POST',
																        data: { chatNo: rno },
																        success: function(response) {
																        	// 대화목록 새로고침
																            updateChatWindow(Iuser);
																        }
																    });

																	// 이전 구독을 해지합니다.
																	if (subscription) {
																		subscription
																				.unsubscribe();
																	}

																	// 채팅 내역을 요청하고 받아옵니다.
																	$
																			.ajax({
																				url : '/loadChat', // 채팅 내역을 조회하는 API 엔드포인트 URL
																				type : 'GET',
																				data : {
																					chatNo : rno
																				}, // 채팅방 번호를 서버에 전달
																				success : function(
																						response) {
																					var chatHistory = response; // 서버에서 받아온 채팅 내역

																					// 채팅 내역을 대화창에 표시
																					for (var i = 0; i < chatHistory.length; i++) {
																						appendMessage(chatHistory[i]);
																					}

																					// STOMP 구독 설정
																					subscription = stomp
																							.subscribe(
																									'/topic/'
																											+ rno,
																									function(
																											message) {
																										var receivedMessage = JSON
																												.parse(message.body);
																										appendMessage(receivedMessage); // 메시지 수신 처리
																									});
																				}
																			});
																	  // 대화목록 업데이트 함수
																	  function updateChatList(data) {
																	    var chatList = $("ul");

																	    // 기존 대화목록 비우기
																	    chatList.empty();

																	    // 새로운 대화목록 생성
																	    for (var i = 0; i < data.length; i++) {
																	      var item = data[i];
																	      var listItem = $("<li>").data("cno", item.chatNo).text(item.userName);
																	      var unreadCount = $("<span>").addClass("unread-count").text(item.unreadCount);
																	      
																	      listItem.append(unreadCount);
																	      chatList.append(listItem);
																	    }
																	  }
																});
												// 신고함수
												$('#reportBtn').click(function() {
													var popupUrl = "report.ch?value=" + encodeURIComponent(rno) + 
															"&value2=" + encodeURIComponent(Iuser);
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
												
												// 대화창 업데이트 함수
												function updateChatWindow(user) {
													var chatTitle = document
															.querySelector(".chat-window h2");
													
													if (user) {
													      chatTitle.textContent = user;
													      $('#leaveButton').show();
													      $('#reportBtn').show();
													      $('.input-area').show(); // 채팅 입력창 보이기
													    } else {
													      chatTitle.textContent = '';
													      $('#leaveButton').hide();
													      $('#reportBtn').hide();
													      $('.input-area').hide(); // 채팅 입력창 숨기기
													    }

													var messagesContainer = document
															.querySelector(".chat-window .messages");
													messagesContainer.innerHTML = "";

													if (!user) {
													    var message1 = document.createElement("div"); // <div> 요소로 변경
													    message1.classList.add("select-user-message"); // 클래스 추가
														
													    // 텍스트 요소 생성
													    var text = document.createElement("p");
													    text.textContent = "대화목록에서 대화상대를 선택해주세요.";
													    message1.appendChild(text); // 텍스트를 <div> 요소에 추가

													    messagesContainer.appendChild(message1);
													    // 이미지 요소 생성
													    var image = document.createElement("img");
													    image.src = "/resources/img/common/friend.png"; // 이미지 파일 경로 설정
													    image.style.width = "300px"; // 이미지의 너비를 100px로 조정
													    image.style.height = "auto"; // 이미지의 높이는 자동으로 설정
													    message1.appendChild(image); // 이미지를 <div> 요소에 추가
													    
												    } else {
												        var message1 = document.createElement("p");
												        message1.textContent = user + "님과 대화를 시작하셨습니다.";
												        messagesContainer.appendChild(message1);

												        var message2 = document.createElement("p");
												        message2.textContent = "안전한 결제를 위해 웹사이트에서 대화를 나누고 결제하세요.";
												        messagesContainer.appendChild(message2);

												        var hr = document.createElement("hr");
												        messagesContainer.appendChild(hr);
												    }

													// 스크롤 자동 아래로 이동
													messagesContainer.scrollTop = messagesContainer.scrollHeight;
												}
												
												  $('#leaveButton').click(function() {
													    if (confirm('정말로 나가시겠습니까?')) {
													    	leftRoom = true;
													    	sendMessage();
													    	location.href = "deleteChat.ch?rno=" + rno;	
													    }
													      });
											});

							stomp.connect({}, function() {
								// STOMP 구독 설정
								if (subscription) {
									subscription.unsubscribe();
								}
								subscription = stomp.subscribe('/topic/' + rno,
										function(message) {
											var receivedMessage = JSON
													.parse(message.body);
											appendMessage(receivedMessage); // 메시지 수신 처리
										});
							});

							// 메시지 전송 함수
							function sendMessage() {
							    var messageInput = document.getElementById("messageInput");
							    var messageContent = messageInput.value.trim();
								
							    if(leftRoom){
							    	var message = {
								            content: "${Id}" + "님이 나가셨습니다.",
								            sendUser: "${Id}", // 보내는 사람 아이디를 지정해야 합니다.
								            receiveUser: Iuser,
								            sendDate: new Date().getTime(), // 현재 시간을 보내는 시간으로 설정
								            rstatus : "N",
								            chatNo: rno
								        };
							    	stomp.send("/chat/" + rno, {}, JSON.stringify(message));
							        messageInput.value = ""; // 메시지 입력란 초기화
							        leftRoom = false;
							    }
							    
							    if (messageContent !== "") {
							        var message = {
							            content: messageContent,
							            sendUser: "${Id}", // 보내는 사람 아이디를 지정해야 합니다.
							            receiveUser: Iuser,
							            sendDate: new Date().getTime(), // 현재 시간을 보내는 시간으로 설정
							            rstatus : "N",
							            chatNo: rno
							        };
							        stomp.send("/chat/" + rno, {}, JSON.stringify(message));
							        messageInput.value = ""; // 메시지 입력란 초기화
							    }
							}

							document.getElementById("messageInput").addEventListener("keydown", function (event) {
							    if (event.key === "Enter") {
							        if (!event.shiftKey) {
							            event.preventDefault(); // 기본 엔터 동작 방지
							            sendMessage();
							        }
							    } 
							});

							// 전송 버튼 클릭 이벤트 처리
							document.getElementById("sendMessageButton").addEventListener("click", function () {
							    sendMessage();
							});
							document.getElementById("messageInput").addEventListener("keyup", function(event) {
							    $.ajax({
							        url: '/setRead',
							        type: 'POST',
							        data: { chatNo: rno },
							        success: function(response) {
							        }
							    });
							});

							// 메시지 출력 함수
							function appendMessage(message) {
							  var messagesContainer = document.querySelector(".chat-window .messages");
							  var messageElement = document.createElement("p");
		  
							  messageElement.textContent = message.content;

							  var messageDate = new Date(message.sendDate);
							  var formattedDate = "<span class='message-date'>" + messageDate.toLocaleTimeString([], { hour: '2-digit', minute: '2-digit' }) + "</span>";
							  
							  if (message.sendUser === "${Id}") {
							    if (message.rstatus === "N") {
							      messageElement.innerHTML = "<span class='message-content my-chat'>"
							        + "<span class='message-prefix'>1</span> " + formattedDate + message.content + "</span>";
							    } else {
							      messageElement.innerHTML = "<span class='message-content my-chat'>"
							        + formattedDate + message.content + "</span>";
							    }
							    messageElement.classList.add('my-message');
							  } else {
							    if (message.rstatus === "N") {
							      messageElement.innerHTML = "<span class='message-content other-chat'>"
							        + message.content + formattedDate + "</span>";
							    } else {
							      messageElement.innerHTML = "<span class='message-content other-chat'>"
							        + message.content + formattedDate + "</span>";
							    }
							    messageElement.classList.add('other-message');
							  }
							  
							  messagesContainer.appendChild(messageElement);
							
							  // 스크롤 자동 아래로 이동
							  messagesContainer.scrollTop = messagesContainer.scrollHeight;
							}
						});
	</script>
</body>
</html>