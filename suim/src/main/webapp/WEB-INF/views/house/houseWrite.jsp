<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/common/header.jsp"%>
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
</style>
</head>

<body>
	<br>
	<br>
	<br>
	<br>
	<h1>방 정보 등록</h1>
	<div class="middle_houseInfo" id="facility_info">
		<form action="enrollAction.jsp" method="post"
			enctype="multipart/form-data">
			<ul class="form_box">
				<li><label><span class="red_txt"></span></label> <input
					type="text" id="sample4_roadAddress" placeholder="도로명주소"></li>
				<li><label><span class="red_txt"></span></label> <input
					type="text" name="addr" id="sample4_jibunAddress"
					placeholder="지번주소"><br /></li>
				<li><label><span class="red_txt"></span></label> <input
					type="text" id="sample4_detailAddress" placeholder="상세주소"><br />
				</li>

				<li><label for="roomName"><span class="red_txt">*</span>방
						이름:</label> <input type="text" id="roomName" name="roomVOList[0].roomName"
					required></li>
				<li><label for="rent"><span class="red_txt">*</span>월세(관리비
						포함):</label> <input type="number" id="rent" name="roomVOList[0].rent"
					required></li>
				<li><label for="deposit"><span class="red_txt">*</span>보증금:</label>
					<input type="number" id="deposit" name="roomVOList[0].deposit"
					required></li>
				<li><label for="roomPeople"><span class="red_txt">*</span>방
						인원:</label> <input type="number" id="roomPeople"
					name="roomVOList[0].roomPeople" required></li>
				<li><label for="enterdate"><span class="red_txt">*</span>입주
						가능일:</label> <input type="date" id="enterdate"
					name="roomVOList[0].enterdate" required></li>
				<li><label for="minStay"><span class="red_txt">*</span>최소
						거주 기간:</label> <select name="roomVOList[0].minStay" id="minStay" required>
						<option value="">선택하세요</option>
						<option value="1-3개월">1~3 개월</option>
						<option value="4-6개월">4~6 개월</option>
						<option value="7-12개월">7~12 개월</option>
						<option value="1년이상">1년 이상</option>
				</select></li>
				<li><label for="maxStay"><span class="red_txt">*</span>최대
						거주 기간:</label> <select name="roomVOList[0].maxStay" id="maxStay" required>
						<option value="">선택하세요</option>
						<option value="1-3개월">1~3 개월</option>
						<option value="4-6개월">4~6 개월</option>
						<option value="7-12개월">7~12 개월</option>
						<option value="1년이상">1년 이상</option>
				</select></li>
			</ul>

			<h3>방 이미지</h3>
			<label for="image1">이미지 1:</label> <input type="file" id="image1"
				name="image1"> <label for="image2">이미지 2:</label> <input
				type="file" id="image2" name="image2"> <label for="image3">이미지
				3:</label> <input type="file" id="image3" name="image3"> <label
				for="image4">이미지 4:</label> <input type="file" id="image4"
				name="image4"> <label for="image5">이미지 5:</label> <input
				type="file" id="image5" name="image5"> <label for="image6">이미지
				6:</label> <input type="file" id="image6" name="image6">



			<h3>하우스 설명:</h3>
			<textarea id="roomDescription" name="roomVOList[0].roomDescription"
				rows="4" style="width: 100%; height: 150px; resize: none;"></textarea>

			<h3 class="s_title">공동 시설 정보</h3>
			<ul class="form_box">
				<li><label for="elevator">냉장고:</label> <input type="checkbox"
					id="elevator" name="roomVOList[0].facilities" value="냉장고">
					<label for="parking">정수기:</label> <input type="checkbox"
					id="parking" name="roomVOList[0].facilities" value="정수기"></li>
				<li><label for="security">가스레인지:</label> <input type="checkbox"
					id="security" name="roomVOList[0].facilities" value="가스레인지">
					<label for="gym">밥솥:</label> <input type="checkbox" id="gym"
					name="roomVOList[0].facilities" value="밥솥"></li>
				<li><label for="pool">티비:</label> <input type="checkbox"
					id="pool" name="roomVOList[0].facilities" value="티비"> <label
					for="pool">욕조:</label> <input type="checkbox" id="pool"
					name="roomVOList[0].facilities" value="욕조"></li>
				<li><label for="pool">수영장:</label> <input type="checkbox"
					id="pool" name="roomVOList[0].facilities" value="수영장"> <label
					for="pool">비데:</label> <input type="checkbox" id="pool"
					name="roomVOList[0].facilities" value="비데"></li>
				<li><label for="pool">세탁기:</label> <input type="checkbox"
					id="pool" name="roomVOList[0].facilities" value="세탁기"> <label
					for="pool">건조기:</label> <input type="checkbox" id="pool"
					name="roomVOList[0].facilities" value="건조기"></li>
				<li><label for="pool">베란다:</label> <input type="checkbox"
					id="pool" name="roomVOList[0].facilities" value="베란다"> <label
					for="pool">WIFI:</label> <input type="checkbox" id="pool"
					name="roomVOList[0].facilities" value="WIFI"></li>
				<li><label for="pool">전자레인지:</label> <input type="checkbox"
					id="pool" name="roomVOList[0].facilities" value="전자레인지"> <label
					for="pool">에어컨:</label> <input type="checkbox" id="pool"
					name="roomVOList[0].facilities" value="에어컨"></li>
			</ul>

			<div class="button-container">
				<input type="submit" value="등록">
				<button type="button" onclick="window.location.href='roomInfo.jsp'">취소</button>
			</div>
		</form>
	</div>
	<%@ include file="/WEB-INF/views/common/footer.jsp"%>
</body>

</html>