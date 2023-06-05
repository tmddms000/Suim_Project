<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<title>고객 마이페이지</title>
<%@ include file="/WEB-INF/views/common/include.jsp"%>

</head>
<body>
	<jsp:include page="/WEB-INF/views/common/header.jsp" />

	<div class="container" style="margin-top : 160px;">
		<div class="row">
			<div class="col-md-5 col-sm-12 mx-auto">
						<div class="text-center mb-3">
						<h3>이메일 주소 확인</h3>
						</div>
						<div class="alert alert-success text-center">회원가입한 이메일로 인증 코드가 전송되었습니다.</div>
						
						<form method="POST" action="" class="text-center">
							<button type="submit" class="btn btn-primary">확인 이메일 재발송</button>
						</form>
					</div>
					<p class="mt-3 mb-0 text-center">
						<small>이메일 전송에 문제가 있거나 이메일을 잘못 입력했습니까? <br> 
						<a href="/register-retry">이메일 다시 입력하기</a>
						</small>
					</p>
		</div>
	</div>

	<jsp:include page="/WEB-INF/views/common/footer.jsp" />

</body>
</html>
