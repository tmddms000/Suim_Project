<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%@ include file="/WEB-INF/views/common/header.jsp"%>
<html>
<head>
    <title>에어비앤비 채팅창 예시</title>
    <!-- 부트스트랩 -->
    <link href="/resources/css/common/styles.css" rel="stylesheet" />
        <style>
        body {
            margin: 0;
            padding: 0;
        }
        
        .container_chat {
            display: flex;
            height: 100vh;
        }
        
        .chat-list {
        	margin-top : 90px;
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
    </style>
</head>
<body>

    <div class="container_chat">
        <div class="chat-list">
            <!-- 채팅목록 -->
            <h2>대화목록</h2>
            <ul>
                <li>사진 조민수</li>
                <li>사진 유홍재</li>
                <li>사진 이승은</li>
                <li>사진 이태화</li>
            </ul>
        </div>
        <div class="chat-window">
            <!-- 채팅창 -->
            <h2>조민수</h2>
            <div class="messages">
                <p>조민수님과 대화를 시작하셨습니다.</p>
                <p>안전한 결제를 위해 웹사이트를 통해 대화를 나누고 결제하세요.</p>
                <hr>
            </div>
             <div class="input-area">
                <textarea id="messageInput" placeholder="메시지를 입력하세요"></textarea>
                <input type="submit" value="전송" id="sendMessageButton">
            </div>
        </div>
    </div>
    
<script>
//메시지 입력란 키 이벤트 처리
document.getElementById("messageInput").addEventListener("keydown", function(event) {
  if (event.key === "Enter") {
    if (!event.shiftKey) {
      event.preventDefault(); // 기본 엔터 동작 방지
      sendMessage();
    }
  }
});

// 전송 버튼 클릭 이벤트 처리
document.getElementById("sendMessageButton").addEventListener("click", function() {
  sendMessage();
});

// 메시지 전송 함수
function sendMessage() {
  var messageInput = document.getElementById("messageInput");
  var message = messageInput.value;
  if (message !== "") {
    appendMessage(message);
    messageInput.value = "";
  }
}

// 메시지 추가 함수
function appendMessage(message) {
  var messagesContainer = document.querySelector(".chat-window .messages");
  var messageElement = document.createElement("p");
  messageElement.innerHTML = message.replace(/\n/g, "<br>"); // 줄바꿈 문자를 <br> 태그로 대체
  messagesContainer.appendChild(messageElement);

  // 스크롤 자동 아래로 이동
  messagesContainer.scrollTop = messagesContainer.scrollHeight;
}
</script>

<%@ include file="/WEB-INF/views/common/footer.jsp"%>
</body>
</html>