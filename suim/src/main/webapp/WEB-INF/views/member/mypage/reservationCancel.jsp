<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>예약 취소</title>

	<!-- 부트스트랩 -->
        <link href="/resources/css/common/styles.css" rel="stylesheet" />
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
 		<script src="https://cdn.jsdelivr.net/npm/sockjs-client@1/dist/sockjs.min.js"></script>
<style>
	
	body {
		padding: 20px;
	}
	
	h2 {
		text-align: center;
	}
	
	form {
		display: grid;
		grid-template-columns: 1fr;
		grid-gap: 10px;
		background-color: #ffffff;
		padding: 20px;
		border-radius: 5px;
		box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
		max-width: 600px; /* 폼의 최대 너비를 600px로 제한 */
		margin: 0 auto; /* 가운데 정렬 */
	}
	
	ul.form_box {
		list-style-type: none;
		padding: 0;
		margin: 0;
	}
	
	
	ul.form_box input[type="text"], ul.form_box input[type="number"], ul.form_box input[type="date"],
		ul.form_box select, ul.form_box textarea {
		width: 100%;
		padding: 10px;
		border: 1px solid #ccc;
		border-radius: 5px;
		box-sizing: border-box; /* 패딩과 테두리를 포함한 전체 크기로 설정 */
	}
	
	ul.form_box select {
		height: 40px;
	}
	
	.button-container {
		display: flex;
		justify-content: center;
		gap: 25px;
	}
	
	.button-container button {
		 background-color: #FA6B6F;
	        color: white;
	        padding: 10px 20px;
	        border: none;
	        border-radius: 5px;
	        box-shadow: 0px 2px 4px rgba(0, 0, 0, 0.4);
	        font-weight: bold;
	        cursor: pointer;
	        transition: background-color 0.3s ease;
	        width: 100px;
	        height: 36px;
	        font-size: 15px;
	        display: flex;
	        justify-content: center;
	        align-items: center;
	        padding : 3px 7px;
	}
	.cancelContent{
		margin : 10px;
		resize : none;
	}
	.button-container button:hover {
	    background-color: rgb(216, 69, 9);
	}   
	
	</style>        

</head>
<body>
	<jsp:include page="/WEB-INF/views/common/header.jsp"/>
	<h2>${houseName}</h2>
		<h2>예약 취소하기</h2>
		<div class="rez-div" id="rez-div">
			<form action="rezCancel.rez" method="post">
				<ul class="form_box">
					<li>
						<label for="cancelContent"><span class="red_txt">*</span>예약 취소사유:</label><br> 
						<textarea id="cancelContent" class="cancelContent" rows="9" name="cancelContent" required></textarea>
					</li>	
				</ul>
				
				<input type="hidden" name="houseName" value="${houseName}">
				<input type="hidden" name="rezNo" value="${r[0].rezNo}">
				<input type="hidden" name="sendMemberId" value="${r[0].sendMemberId}">
				<input type="hidden" name="recMeberId" value="${r[0].recMemberId}">
				
				<div class="button-container">
					<button type="submit">예약 취소하기</button>
					<button type="button" onclick="closePopup()">닫기</button>
				</div>
			</form>
		</div>
		
		<script>
		    function closePopup() {	
		        window.close();
		    }
		</script>	
		
		<c:if test="${ not empty canMsg }">
			<script>
				alert('${ canMsg }');
				window.close(); // 팝업 닫기
				window.opener.location.reload(); // 팝업을 열었던 페이지 새로고침
			</script>
			<c:remove var="canMsg" scope="session" />
		</c:if>
		
<script>
  var content = "${houseName}";
  var receiverId = "${r[0].recMemberId}";
  var senderId = "${r[0].sendMemberId}";
  var postNo = "${r[0].houseNo}";
  var postType = "rezNo";
  var postContent = "예약 취소";

  $(document).ready(function() {
    $('form').submit(function(event) {
      event.preventDefault(); // Prevent the default form submission
      // Handle the response from the server
      if (senderId != receiverId) {
        if (socket) {
          let socketMsg = postType + "," + senderId + "," + receiverId + "," + postNo + "," + content + "," + postContent;

          socket.send(socketMsg);
        }
      }

      if (senderId != receiverId) {
        $.ajax({
          url: '/insertNotification',
          type: 'post',
          data: {
            'content': content,
            'receiverId': receiverId,
            'senderId': senderId,
            'postNo': postNo,
            'postType': postType,
            'postContent': postContent
          },
          dataType: "json",
          success: function(alram) {
          	    
          }
        });
      }
      $('form').off('submit').submit();
    });

  });
</script>
	
	
</body>
</html>