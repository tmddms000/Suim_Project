<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>로그인 페이지</title>
<%@ include file="/WEB-INF/views/common/include.jsp" %>
<link rel="stylesheet" href="/resources/css/user/login.css">
</head>
<body>

	<jsp:include page="/WEB-INF/views/common/header.jsp"/>

	<div class="container main">
        <div class="row justify-content-center">
            <div class="col">
                
                <div class="col-sm-4" style="border-top : 2px solid #FA6B6F; margin-left: auto; margin-right: auto;"></div>
                <br>
                <div class="text-center mb-4"><span style="font-size : 40px; font-weight : bold;">로그인</span></div>

                <form action="./login" method="post">
                    <div class="form-group row justify-content-center">
                        <div class="col-sm-4">
                            <input type="text" autocomplete="on" class="form-control" id="id" name="memberId" placeholder="아이디">
                        </div>
                    </div>
                    
                    <div class="form-group row justify-content-center mt-2">
                        <div class="col-sm-4">
                            <input type="password" autocomplete="new-password" class="form-control" id="pw" name="memberPwd" placeholder="비밀번호">
                        </div>
                    </div>
               

                    <div class="form-group row justify-content-center mt-2">
                        <div class="col-sm-4">
                            <input class="form-check-input" type="checkbox" value="" id="flexCheckChecked" checked>
                            <label class="form-check-label" for="flexCheckChecked">&nbsp;아이디 저장</label>
                        </div>
                    </div>
                
                    <div class="row justify-content-center mt-2">
                        <div class="col-sm-4">
                            <div class="text-center mt-2">
                                <button type="submit" class="btn btn-primary btn-block submit-btn">로그인</button>
                            </div>
                        </div>
                    </div>
                  </form>

                   <div class="row justify-content-center">
                        <div class="col-sm-12 mt-3">
                            <div class="text-center">
                                <a style="color : black; text-decoration: none;" href="./join" class="">회원가입</a>
                                <a style="color : black; text-decoration: none;" href=".find" class="ml-4">아이디찾기 비밀번호 찾기</a>
                            </div>
                        </div>
                    </div>


                    <div class="row justify-content-center mt-2">
                        <div class="col-sm-4">
                            <div class="text-center mt-2">
                            <button class="image-button">
                                <img src="https://upload.wikimedia.org/wikipedia/commons/thumb/5/53/Google_%22G%22_Logo.svg/235px-Google_%22G%22_Logo.svg.png" alt="Button Image" style="width : 30px">
                                &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;구글계정으로 로그인
                            </button>
                            </div>
                        </div>
                    </div>
                    <div class="row justify-content-center mt-2">
                        <div class="col-sm-4">
                            <div class="text-center mt-2">
                            <button class="image-button">
                                <img src="https://upload.wikimedia.org/wikipedia/commons/thumb/e/e3/KakaoTalk_logo.svg/240px-KakaoTalk_logo.svg.png" alt="Button Image">
                                &nbsp;&nbsp;&nbsp;카카오계정으로 로그인
                            </button>
                            </div>
                        </div>
                    </div>
            </div>
        </div>
    </div>
	
	<jsp:include page="/WEB-INF/views/common/footer.jsp"/>

</body>
</html>