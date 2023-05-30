<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<title>고객 마이페이지</title>
<%@ include file="/WEB-INF/views/common/include.jsp"%>
<script
	src="https://tistory4.daumcdn.net/tistory/3134841/skin/images/confetti_v2.js"></script>

<style>
canvas {
	z-index: 10;
	pointer-events: none;
	position: fixed;
	top: 0;
	transform: scale(1.2);
}
</style>
</head>
<body>
	<jsp:include page="/WEB-INF/views/common/header.jsp" />

	<div class="buttonContainer is-hidden">
		<button class="canvasBtn" id="stopButton" style="display: none;">Stop
			Confetti</button>
		<button class="canvasBtn" id="startButton" style="display: none;">Drop
			Confetti</button>
	</div>

	<div class="container" style="padding-top: 250px;">
		<div class="row justify-content-center">
			<h1 class="text-center">쉼에 오신것을 환영합니다!</h1>
		</div>
		<br>
		<div class="col text-center">
			<button class="btn">방 찾기</button>
			<button class="btn">메인으로</button>
			<br> <br>
		</div>
	</div>

	<canvas id="canvas"></canvas>

	<jsp:include page="/WEB-INF/views/common/footer.jsp" />

	<script>
		$(document).ready(function() {
			//티스토리 공감버튼 이벤트
			function reAction() {
				$("#startButton").trigger("click");
				setTimeout(function() {
					$("#stopButton").trigger("click");
				}, 3000);
			}
			reAction();
		});
	</script>
</body>
</html>
