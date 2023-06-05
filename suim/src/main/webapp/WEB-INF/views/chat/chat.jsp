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


<title>채팅방</title>
<!-- 부트스트랩 -->
<style>
.my-chat {
	background-color: #007AFF;
	color: white;
	text-align: right;
	margin-bottom: 10px;
	padding: 5px;
	border-radius: 5px;
	font-size : 20px;
}
.my-message {
	text-align: right;
}

.other-message {
	text-align: left;
}
.other-chat {
	background-color: #F4F4F8;
	color: black;
	margin-bottom: 10px;
	padding: 5px;
	border-radius: 5px;
	font-size : 20px;
}

body {
	margin: 0;
	padding: 0;
}

.container_chat {
	display: flex;
	height: 100vh;
}

.chat-list {
	margin-top: 90px;
	width: 20%;
	background-color: #f2f2f2;
	padding: 20px;
	box-sizing: border-box;
}

.chat-list h2 {
	margin-top: 0;
	color: #333;
}

.chat-list ul {
	list-style-type: none;
	padding: 0;
	margin: 0;
}

.chat-list li {
	padding: 10px;
	border-bottom: 1px solid #ccc;
	cursor: pointer;
	transition: background-color 0.3s ease;
}

.chat-list li:hover {
	background-color: #e5e5e5;
}

.chat-window {
	width: 80%;
	padding: 20px;
	box-sizing: border-box;
	margin: auto; /* 가운데로 정렬 */
}

.chat-window h2 {
	margin-top: 0;
	color: #333;
}

.chat-window .messages {
	background-color: #fff;
	border: 1px solid #ccc;
	border-radius: 4px;
	padding: 10px;
	height: 400px; /* 원하는 높이로 설정 */
	overflow-y: auto; /* 내용이 넘칠 경우 스크롤 생성 */
}

.chat-window .messages p {
	margin: 5px 0;
}

.chat-window .input-area {
	display: flex; /* 자식 요소들을 가로 방향으로 정렬 */
	align-items: center; /* 자식 요소들을 수직 중앙 정렬 */
	margin-top: 10px;
}

.chat-window textarea {
	flex: 1; /* 남은 공간을 모두 차지하도록 설정 */
	padding: 10px;
	border: 1px solid #ccc;
	border-radius: 4px;
	resize: none; /* 사용자 크기 조정 비활성화 */
}

.chat-window input[type="submit"] {
	padding: 15px 30px; /* 버튼의 패딩을 조정하여 크기 변경 */
	background-color: #FA6B6F;
	border: none;
	color: #fff;
	cursor: pointer;
	border-radius: 4px;
	margin-left: 10px; /* 입력창과 전송 버튼 사이의 간격 조정 */
}

#leaveButton {
    background-color: #FA6B6F; /* 배경색 설정 */
    color: #fff; /* 글자색 설정 */
    border: none; /* 테두리 제거 */
    border-radius: 4px; /* 모서리를 둥글게 처리 */
    font-size : 23px;
    margin-bottom : 5px;
}

#leaveButton:hover {
    background-color: #E34C4C; /* 호버 상태 배경색 변경 */
}
</style>
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
					</c:if>
					<c:if test="${u.cuser eq Id}">
						<li data-cno="${u.chatNo}">${u.muser}</li>
					</c:if>
				</c:forEach>
			</ul>
		</div>
		<div class="chat-window">
			<!-- 채팅창 -->
			<c:if test="${c.muser eq Id}">
				<h2>${c.cuser}</h2>
			</c:if>
			<c:if test="${c.cuser eq Id}">
				<h2>${c.muser}</h2>
			</c:if>
			<button id="leaveButton">나가기</button> <!-- 버튼 요소를 h2 태그 옆으로 이동 -->
			<div class="messages">
				<c:if test="${c.muser eq Id}">
					<p data-cno="${c.chatNo}">${c.cuser}님과대화를 시작하셨습니다.</p>
				</c:if>
				<c:if test="${c.cuser eq Id}">
					<p data-cno="${c.chatNo}">${c.muser}님과대화를 시작하셨습니다.</p>
				</c:if>
				<p>안전한 결제를 위해 웹사이트를 통해 대화를 나누고 결제하세요.</p>
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

							$(document)
									.ready(
											function() {
												Iuser = $(".chat-list li")
														.last().text(); // 초기 아이디 값을 저장할 변수
												// 초기 rno 값을 설정합니다.
												rno = $(
														".chat-list li:last-child")
														.attr('data-cno');

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
																	updateChatWindow(Iuser); // 대화창 업데이트 함수 호출

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
																});

												$('.chat-list li').last()
														.click();

												// 대화창 업데이트 함수
												function updateChatWindow(user) {
													var chatTitle = document
															.querySelector(".chat-window h2");
													chatTitle.textContent = user;

													var messagesContainer = document
															.querySelector(".chat-window .messages");
													messagesContainer.innerHTML = "";

													var message1 = document
															.createElement("p");
													message1.textContent = user
															+ "님과 대화를 시작하셨습니다.";
													messagesContainer
															.appendChild(message1);

													var message2 = document
															.createElement("p");
													message2.textContent = "안전한 결제를 위해 웹사이트를 통해 대화를 나누고 결제하세요.";
													messagesContainer
															.appendChild(message2);

													var hr = document
															.createElement("hr");
													messagesContainer
															.appendChild(hr);

													// 스크롤 자동 아래로 이동
													messagesContainer.scrollTop = messagesContainer.scrollHeight;
												}
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

							// 메시지 입력란 키 이벤트 처리
							document.getElementById("messageInput")
									.addEventListener("keydown",
											function(event) {
												if (event.key === "Enter") {
													if (!event.shiftKey) {
														event.preventDefault(); // 기본 엔터 동작 방지
														sendMessage();
													}
												}
											});

							// 전송 버튼 클릭 이벤트 처리
							document.getElementById("sendMessageButton")
									.addEventListener("click", function() {
										sendMessage();
									});

							// 메시지 전송 함수
							function sendMessage() {
								var messageInput = document
										.getElementById("messageInput");
								var messageContent = messageInput.value.trim();

								if (messageContent !== "") {
									var message = {
										content : messageContent,
										sendUser : "${Id}", // 보내는 사람 아이디를 지정해야 합니다.
										receiveUser : Iuser,
										chatNo : rno
									};
									stomp.send("/chat/" + rno, {}, JSON
											.stringify(message));
									messageInput.value = ""; // 메시지 입력란 초기화
								}
							}

							// 메시지 출력 함수
							function appendMessage(message) {
								var messagesContainer = document
										.querySelector(".chat-window .messages");
								var messageElement = document
										.createElement("p");

								messageElement.textContent = message.content;

								if (message.sendUser === "${Id}") {
									messageElement.innerHTML = "<span class='message-content my-chat'>"
											+ message.content + "</span>";
									messageElement.classList.add('my-message');
								} else {
									messageElement.innerHTML = "<span class='message-content other-chat'>"
											+ message.content + "</span>";
									messageElement.classList
											.add('other-message');
								}

								messagesContainer.appendChild(messageElement);

								// 스크롤 자동 아래로 이동
								messagesContainer.scrollTop = messagesContainer.scrollHeight;
							}
						});
	</script>
</body>
</html>