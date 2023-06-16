<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/common/include.jsp"%>
<jsp:include page="/WEB-INF/views/common/header.jsp" />
<!DOCTYPE html>
<html>

<head>
<!-- 부트스트랩 -->
<link href="/resources/css/common/styles.css" rel="stylesheet" />
<meta charset="UTF-8">
<title>방 정보 등록</title>
<style>
body {
	padding: 20px;
}

h1 {
	margin-top : 100px;
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

ul.form_box input[type="file"] {
	display: block;
	margin-top: 10px;
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
	justify-content: center;
	margin-top: 20px;
}

.button-container button {
	margin: 0 5px;
}
.custom-disabled {
    background-color: #f2f2f2; /* 회색 배경색 */
    color: #999999; /* 회색 글자 색 */
}
.input-description {
	color: #888;
	font-size: 14px;
	margin-top: 5px;
}
</style>
</head>

<body>
	
	<h1>방 정보 등록</h1>
	<div class="middle_houseInfo" id="facility_info">
		<form action="enrollHouse.ho" method="post"
			enctype="multipart/form-data">
			<ul class="form_box">
				<div class="row">
					<div class="col-sm-9">
						<div class="input-group">
							<input type="text" class="form-control custom-disabled" name="houseAddress" id="area"
								placeholder="주소를 검색해주세요" readonly onclick="triggerSearch();">
						</div>
					</div>
					<div class="col-sm-3 text-left">
						<button type="button" class="join-btn" onclick="searchAddr();">
							<i class="fa-solid fa-magnifying-glass" style="font-size: 12px"></i>
							검색
						</button>
					</div>
				</div>
				<br>

				<li><label for="roomName"><span class="red_txt">*</span>방
						이름:</label> <input type="text" id="roomName" name="houseName"
					required></li>
					
				<li>
					<label for="gender"><span class="red_txt">*</span>성별:</label><br>
					<input type="radio" id="genderMale" name="resGender" value="남성전용" required>
					<label for="genderMale">남성전용&nbsp;</label>
					<input type="radio" id="genderFemale" name="resGender" value="여성전용">
					<label for="genderFemale">여성전용&nbsp;</label>
					<input type="radio" id="genderCoed" name="resGender" value="남녀공용">
					<label for="genderCoed">남녀공용</label>
				</li>
				
				<li><label for="minStay"><span class="red_txt">*</span>주거유형
						</label> <select name="resType" id="minStay" required>
						<option value="">선택하세요</option>
						<option value="아파트">아파트</option>
						<option value="오피스">오피스</option>
						<option value="원룸">원룸</option>
				</select></li>
								
				<li><label for="minStay"><span class="red_txt">*</span>층수
						</label> <select name="floor" id="minStay" required>
						<option value="">선택하세요</option>
						<option value="반지하">반지하</option>
						<option value="옥탑">옥탑</option>
						<option value="지상">지상</option>
				</select></li>	
									
				<li><label for="rent"><span class="red_txt">*</span>월세(관리비
						포함):</label> <input type="number" id="rent" name="rent" min="0"
					step="10000" required>
				<div class="input-description">만원 단위로 입력해주세요.</div></li>

				<li><label for="deposit"><span class="red_txt">*</span>보증금:</label>
					<input type="number" id="deposit" name="deposit" min="0"
					step="10000" required>
				<div class="input-description">만원 단위로 입력해주세요.</div></li>
							
				<li><label for="roomPeople"><span class="red_txt">*</span>방
						인원:</label> <input type="number" id="roomPeople" min="0"
					name="roomPeople" required></li>
					
				<li><label for="enterdate"><span class="red_txt">*</span>최소
						입주 가능일:</label> <input type="date" id="enterdate"
					name="enterDate" required></li>
					
				<li><label for="enterdate_max"><span class="red_txt">*</span>최대
						입주 가능일:</label> <input type="date" id="maxenterdate"
					name="maxEnterDate" required></li>
					
				<li><label for="minStay"><span class="red_txt">*</span>최소
						거주 기간:</label> <select name="minStay" id="minStay" required>
						<option value="">선택하세요</option>
						<option value="1~3개월">1~3개월</option>
						<option value="4~6개월">4~6개월</option>
						<option value="7~12개월">7~12개월</option>
						<option value="1년이상">1년이상</option>
				</select></li>
				
				<li><label for="maxStay"><span class="red_txt">*</span>최대
						거주 기간:</label> <select name="maxStay" id="maxStay" required>
						<option value="">선택하세요</option>
						<option value="1~3개월">1~3개월</option>
						<option value="4~6개월">4~6개월</option>
						<option value="7~12개월">7~12개월</option>
						<option value="1년이상">1년이상</option>
				</select></li>
			</ul>

			<h3>방 이미지</h3>
			<label for="image1">대표 이미지:</label> 
			<input type="file" id="image1"name="image1" required> 
			<label for="image2">이미지 2:</label> 
			<input type="file" id="image2" name="image2" required> 
			<label for="image3">이미지3:</label> 
			<input type="file" id="image3" name="image3" required> 
			<label for="image4">이미지 4:</label> 
			<input type="file" id="image4"name="image4" required> 
			<label for="image5">이미지 5:</label> 
			<input type="file" id="image5" name="image5" required> 
			<label for="image6">이미지 6:</label> 
			<input type="file" id="image6" name="image6" required><br>



			<h3>하우스 소개:</h3>
			<textarea id="roomDescription" name="houseContent"
				rows="4" style="width: 100%; height: 150px; resize: none;"></textarea>
			<br>

			<h3 class="s_title">공동 시설 정보</h3>
<ul class="form_box">
			  <li>
			    <label for="refrigerator">냉장고:</label> 
			    <input type="checkbox" id="냉장고" name="incFurniture" value="냉장고">
			    <label for="waterPurifier">정수기:</label> 
			    <input type="checkbox" id="정수기" name="incFurniture" value="정수기">
			  </li>
			  <li>
			    <label for="gasStove">가스레인지:</label> 
			    <input type="checkbox" id="가스레인지" name="incFurniture" value="가스레인지">
			    <label for="riceCooker">밥솥:</label> 
			    <input type="checkbox" id="밥솥" name="incFurniture" value="밥솥">
			  </li>
			  <li>
			    <label for="tv">티비:</label> 
			    <input type="checkbox" id="티비" name="incFurniture" value="티비">
			    <label for="bathtub">욕조:</label> 
			    <input type="checkbox" id="욕조" name="incFurniture" value="욕조">
			  </li>
			  <li>
			    <label for="swimmingPool">수영장:</label> 
			    <input type="checkbox" id="수영장" name="incFurniture" value="수영장">
			    <label for="bidet">비데:</label> 
			    <input type="checkbox" id="비데" name="incFurniture" value="비데">
			  </li>
			  <li>
			    <label for="washingMachine">세탁기:</label> 
			    <input type="checkbox" id="세탁기" name="incFurniture" value="세탁기">
			    <label for="dryer">건조기:</label> 
			    <input type="checkbox" id="건조기" name="incFurniture" value="건조기">
			  </li>
			  <li>
			    <label for="balcony">베란다:</label> 
			    <input type="checkbox" id="베란다" name="incFurniture" value="베란다">
			    <label for="wifi">WIFI:</label> 
			    <input type="checkbox" id="WIFI" name="incFurniture" value="WIFI">
			  </li>
			  <li>
			    <label for="microwave">전자레인지:</label> 
			    <input type="checkbox" id="전자레인지" name="incFurniture" value="전자레인지">
			    <label for="airConditioner">에어컨:</label> 
			    <input type="checkbox" id="에어컨" name="incFurniture" value="에어컨">
			  </li>
			</ul>

			<div class="button-container">
				<input type="submit" value="등록" onclick="validateAddress(event)">
				<button type="button" onclick="window.location.href='list.ho'">취소</button>
			</div>
		</form>
	</div>
	<jsp:include page="/WEB-INF/views/common/footer.jsp" />
</body>

<script>
function updateMinDate() {
	  var now = Date.now();
	  var timeOff = new Date().getTimezoneOffset() * 60000;
	  var today = new Date(now - timeOff).toISOString().split("T")[0];

	  document.getElementById("enterdate").setAttribute("min", today);
	}

	function updateMaxDate() {
	  var now = Date.now();
	  var timeOff = new Date().getTimezoneOffset() * 60000;
	  var today = new Date(now - timeOff).toISOString().split("T")[0];

	  document.getElementById("maxenterdate").setAttribute("min", today);
	}

	document.getElementById("enterdate").addEventListener("change", updateMinDate);
	document.getElementById("maxenterdate").addEventListener("change", updateMaxDate);

	// 페이지 로드 시 최소값과 최대값 업데이트
	updateMinDate();
	updateMaxDate();

	// 매일 자정마다 최소값과 최대값 업데이트
	setInterval(function() {
	  updateMinDate();
	  updateMaxDate();
	}, 24 * 60 * 60 * 1000);
	
function validateAddress() {
    var addressInput = document.getElementById('area');
    if (addressInput.value === '') {
      alert('주소를 입력해주세요.');
      event.preventDefault(); // 등록 이벤트를 취소하여 폼 제출을 막음
  }
}

function searchAddr() {
    		    var themeObj = {
    		   //bgColor: "", //바탕 배경색
    		   //searchBgColor: "#black", //검색창 배경색
    		   //contentBgColor: "", //본문 배경색(검색결과,결과없음,첫화면,검색서제스트)
    		   //pageBgColor: "", //페이지 배경색
    		   //textColor: "", //기본 글자색
    		   queryTextColor: "#black" //검색창 글자색
    		   //postcodeTextColor: "", //우편번호 글자색
    		   //emphTextColor: "", //강조 글자색
    		   //outlineColor: "", //테두리
    		    };
    	        var width = 500;
    	        var height = 600;
    		    new daum.Postcode({
    	            width: width,
    	            height: height,
    			oncomplete : function(data) {
    	            var addr = ''; // 주소 변수
    	            var extraAddr = ''; // 참고항목 변수
    	            if (data.userSelectedType === 'R') {
    	                addr = data.roadAddress;
    	            } else {
    	                addr = data.jibunAddress;
    	            }
    	            if(data.userSelectedType === 'R'){
    	                if(data.bname !== '' && /[동|로|가]$/g.test(data.bname)){
    	                    extraAddr += data.bname;
    	                }
    	                if(data.buildingName !== '' && data.apartment === 'Y'){
    	                    extraAddr += (extraAddr !== '' ? ', ' + data.buildingName : data.buildingName);
    	                }
    	                if(extraAddr !== ''){
    	                    extraAddr = ' (' + extraAddr + ')';
    	                }
    	                document.getElementById("area").value = extraAddr;
    	            } else {
    	                document.getElementById("area").value = '';
    	            }
    	            //document.getElementById('zipCode').value = data.zonecode;
    	            document.getElementById("area").value = addr;
    	            document.getElementById("area").focus();
    			}
    	        , theme: themeObj
    	        }).open({
    	            left: (window.screen.width / 2) - (width / 2),
    	            top: (window.screen.height / 2) - (height / 2)
    	        });
    	    };
    	    
    	    
function triggerSearch() {
			    document.getElementById("area").blur(); // input 박스의 포커스 해제
			    searchAddr(); // 검색 함수 호출
			}
    	    </script>

</html>