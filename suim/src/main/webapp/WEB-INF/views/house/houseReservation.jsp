<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>예약 페이지</title>
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
	
	ul.form_box li {
		margin-bottom: 20px;
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
	
	input[type="submit"], button {
		padding: 10px;
		background-color: #FA6B6F;
		color: white;
		border: none;
		cursor: pointer;
		margin-right: 10px;
	}
	
	.button-container {
		display: flex;
		justify-content: center;s
		margin-top: 20px;
	}
	
	.button-container button {
		margin: 0 5px;
	}
</style>        
        
</head>
<body>
		<jsp:include page="/WEB-INF/views/common/header.jsp"/>

		<h2>${houseName}</h2>
		<h2>예약하기</h2>
		<div class="rez-div" id="rez-div">
			<form action="enrollReservation.rez" method="post">
				<ul class="form_box">
					<li>
						<label for="rezDate"><span class="red_txt">*</span>예약 일:</label> 
						<input type="date" id="rezDate" class="rezdate" name="rezDate" required>
					</li>
					<li>
						<label for="rezHour"><span class="red_txt">*</span>예약 시간:</label>
						<select name="rezHour" id="rezHour" required>
								<option value="오전 8시 ~ 9시">오전 8시 ~ 9시</option>
								<option value="오전 9시 ~ 10시">오전 9시 ~ 10시</option>
								<option value="오전 10시 ~ 11시">오전 10시 ~ 11시</option>
								<option value="오전 11시 ~ 12시">오전 11시 ~ 12시</option>
								<option value="오후 12시 ~ 1시">오후 12시 ~ 1시</option>
								<option value="오후 1시 ~ 2시">오후 1시 ~ 2시</option>
								<option value="오후 2시 ~ 3시">오후 2시 ~ 3시</option>
								<option value="오후 3시 ~ 4시">오후 3시 ~ 4시</option>
								<option value="오후 4시 ~ 5시">오후 4시 ~ 5시</option>
								<option value="오후 5시 ~ 6시">오후 5시 ~ 6시</option>
								<option value="오후 6시 ~ 7시">오후 6시 ~ 7시</option>
								<option value="오후 7시 ~ 8시">오후 7시 ~ 8시</option>
								<option value="오후 8시 ~ 9시">오후 8시 ~ 9시</option>		
								<option value="오후 9시 ~ 10시">오후 9시 ~ 10시</option>								
								<option value="오후 10시 ~ 11시">오후 10시 ~ 11시</option>								
								<option value="오후 11시 ~ 12시">오후 11시 ~ 12시</option>
								<option value="기타" selected>기타</option>
						</select>
					</li>
				</ul>
				
				<input type="hidden" name="houseNo" value="${houseNo}">
				<input type="hidden" name="sendMemberId" value="${loginUser.memberId}">
				<input type="hidden" name="recMemberId" value="${memberId}">
				
				<div class="button-container">
					<input type="submit" value="예약">
					<button type="button" onclick="closePopup()">닫기</button>
				</div>
			</form>
		</div>
		
		<script>
		    function closePopup() {	
		        window.close();
		    }
		</script>	
		
		<script>
		    var alMsg = "<%= session.getAttribute("alMsg") %>";
		    if (alMsg && alMsg !== "null" && alMsg !== "") {
		        alert(alMsg);
				window.close(); // 팝업 닫기
				window.opener.location.reload(); // 팝업을 열었던 페이지 새로고침
		        <% session.removeAttribute("alMsg"); %>
		    }
		</script>
		<script>
		    var altMsg = "<%= session.getAttribute("altMsg") %>";
		    if (altMsg && altMsg !== "null" && altMsg !== "") {
		        alert(altMsg);
				window.close(); // 팝업 닫기
				window.opener.location.reload(); // 팝업을 열었던 페이지 새로고침
		        <% session.removeAttribute("altMsg"); %>
		    }
		</script>
		
	<script>
		function updateMinDate() {
			  var now = Date.now();
			  var timeOff = new Date().getTimezoneOffset() * 60000;
			  var today = new Date(now - timeOff).toISOString().split("T")[0];
	
			  document.getElementById("rezDate").setAttribute("min", today);
			}
	
			document.getElementById("rezDate").addEventListener("change", updateMinDate);
	
			// 페이지 로드 시 최소값 업데이트
			updateMinDate();
	
			// 매일 자정마다 최소값 업데이트
		setInterval(updateMinDate, 24 * 60 * 60 * 1000);
	</script>
	
	
<script>
  var content = "${houseName}";
  var receiverId = "${memberId}";
  var senderId = "${loginUser.memberId}";
  var postNo = "${houseNo}";
  var postType = "rezOk";

  $(document).ready(function() {
    $('form').submit(function(event) {
      event.preventDefault(); // Prevent the default form submission

      var rezdateValue = document.getElementsByClassName("rezdate")[0].value; // Assuming the "rezdate" is an input field
      var rezdate = new Date(rezdateValue);
      var optionElement = document.getElementById("rezHour"); // Assuming the "rezHour" is the id of the select element
      var option = optionElement.options[optionElement.selectedIndex].value;
      var formattedDate = rezdate.getMonth() + 1 + "월" + rezdate.getDate() + "일";
      var result = formattedDate + " " + option;
      var postContent = result;

      // Handle the response from the server
      if (senderId != receiverId) {
        if (socket) {
          let socketMsg = postType + "," + senderId + "," + receiverId + "," + postNo + "," + content + "," + postContent;

          console.log(socketMsg);
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