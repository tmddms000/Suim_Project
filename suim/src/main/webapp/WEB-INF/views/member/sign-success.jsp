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
					</div>
		</div>
	</div>

	<jsp:include page="/WEB-INF/views/common/footer.jsp" />

</body>
</html>
