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

	<div class="container" style="margin-top : 160px;">
		<div class="row">
			<div class="col-md-5 col-sm-12 mx-auto">

						
						<div class="alert alert-success text-center">
						<h1>쉼의 일원이 되신 것을 환영해요!</h1>
						회원가입이 완료됐어요.</div>
						<div class="text-center mb-5">
							<a href="/" class="btn btn-primary">메인 페이지</a>
							<a href="/list.ho" class="btn btn-primary">방 보러가기</a>
						</div>
					</div>
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
