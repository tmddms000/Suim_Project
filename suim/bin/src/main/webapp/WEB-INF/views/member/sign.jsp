<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<!DOCTYPE html>
<html>
<head>
<title>고객 회원가입</title>
<style>
.error {
	color: red;
}

.hr-line {
	padding-bottom: 10px;
    border-bottom: 2px solid rgb(51, 51, 51);
    font-size: 12px;
    color: rgb(102, 102, 102);
    line-height: 17px;
    text-align: right;
}

.input-size {

	width : 333px;
	height : 46px;
}
</style>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css" rel="stylesheet">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"></script>
</head>
<body>
	<div class="container text-center">
		<main>
			<div class="py-5 text-center">
				<h2>회원가입</h2>
				<div class="hr-line"></div>
			</div>
			<form:form action="/processForm" modelAttribute="member" method="POST">


				<div class="row justify-content-md-center">
					<div class="col-auto">
						<p style="line-height: 2">
							<b>아이디</b><span style="color: red">*</span>
						</p>
					</div>
					<div class="col-4">
						<form:input class="form-control" path="memberId" placeholder="아이디를 입력해주세요"/>
					</div>
					<form:errors path="memberId" cssClass="error" />
				</div>
				<br>
				<div class="row justify-content-md-center">
					<div class="col-auto">
						<p style="line-height: 2">
							<b>비밀번호</b><span style="color: red">*</span>
						</p>
					</div>
					<div class="col-4">
						<form:input class="form-control" type="password" path="memberPwd" placeholder="비밀번호를 입력해주세요" />
					</div>

					<form:errors path="memberPwd" cssClass="error" />
				</div>
				<br>
				<br>
				<input type="submit" value="Submit" />
			</form:form>
		</main>
	</div>
</body>
</html>
