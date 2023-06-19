<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>로그인 페이지</title>
<%@ include file="/WEB-INF/views/common/include.jsp" %>
<link rel="stylesheet" href="/resources/css/user/login.css">
<script type="text/javascript" src="https://static.nid.naver.com/js/naverLogin_implicit-1.0.3.js" charset="utf-8"></script>
</head>
<body>

	<jsp:include page="/WEB-INF/views/common/header.jsp"/>

<div class="container main">
    <div class="row justify-content-center">
        <div class="col">

            <div class="col-sm-4" style="border-top: 2px solid #FA6B6F; margin-left: auto; margin-right: auto;"></div>
            <br>
            <div class="text-center mb-4">
                <span style="font-size: 40px; font-weight: bold;">로그인</span>
            </div>

            <c:url value="./doLogin" var="loginUrl" />
			<form action="${loginUrl}" method="post" onsubmit="return validateForm()">


                <div class="form-group row justify-content-center">
                    <div class="form-floating col-sm-4">
                        <input type="text" autocomplete="on" class="form-control" id="floatingInput" name="memberId" placeholder="아이디" value="${cookie.saveId.value}">
                        
                        
                        
                        
                        <label for="floatingInput">아이디</label>
                    </div>
                </div>

                <div class="form-group form-floating row justify-content-center mt-2">
                    <div class="form-floating col-sm-4">
                        <input type="password" autocomplete="off" class="form-control" id="floatingPassword" name="memberPwd" placeholder="비밀번호">
                        <label for="floatingPassword">비밀번호</label>
                    </div>
                </div>


                <div class="form-group row justify-content-center mt-2">
                    <div class="col-sm-4">
  
                        <c:choose>
                    		<c:when test="${ not empty cookie.saveId }">
                    			<!-- 만약 saveId 라는 쿠키가 있다면 : 체크박스가 체크되게끔 -->
		                    	<input class="form-check-input" type="checkbox" id="saveId" name="saveId" value="y" checked>
		                    	<label class="form-check-label" for="saveId">&nbsp;아이디 저장</label>
                    		</c:when>
                    		<c:otherwise>
                    			<!-- 만약 saveId 라는 쿠키가 없다면 : 체크박스가 체크되지 않게끔 -->
		                    	<input class="form-check-input" type="checkbox" id="saveId" name="saveId" value="y">
		                    	<label class="form-check-label" for="saveId">&nbsp;아이디 저장</label>
                    		</c:otherwise>
                    	</c:choose>    
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
                        <a style="color: black; text-decoration: none;" href="/member/term" class="">회원가입</a>
                        <a style="color: black; text-decoration: none;" href="<c:url value='/member/findId' />" class="ml-4">아이디찾기</a>
                        <a style="color: black; text-decoration: none;" href="<c:url value='/member/findPw' />" class="ml-4">비밀번호찾기</a>
                    </div>
                </div>
            </div>


            <div class="row justify-content-center mt-2">
                <div class="col-sm-4">
                    <div class="text-center mt-2">
                        <a href="<c:url value='${google_url}' />" class="image-button">
                            <img src="https://upload.wikimedia.org/wikipedia/commons/thumb/5/53/Google_%22G%22_Logo.svg/235px-Google_%22G%22_Logo.svg.png" alt="Button Image" style="width: 30px">
                            <span>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;구글계정으로 로그인</span>
                        </a>
                    </div>
                </div>
            </div>

            <div class="row justify-content-center mt-2">
                <div class="col-sm-4">
                    <a href="<c:url value='${naver_url}' />" class="image-button">
                        <img style="width: 30px;" src="/resources/img/member/naverBtn.png" alt="Naver Button" />
                        <span>&nbsp;&nbsp;네이버계정으로 로그인</span>
                    </a>
                </div>
            </div>

            <br>
        </div>
    </div>
</div>

    
    
    <script>
    function validateForm() {
        var memberId = document.forms[0].memberId.value;
        var memberPwd = document.forms[0].memberPwd.value;

        if (memberId === "") {
            alert("아이디를 입력해주세요.");
            return false;
        }

        if (memberPwd === "") {
            alert("비밀번호를 입력해주세요.");
            return false;
        }

        return true;
    }
    
    
    function login() {
        $.ajax({
            url: '/member/doLogin',
            method: 'POST',
            success: function(response) {
            	alert('로그아웃 되었습니다.');
                location.reload(true);
            }
        });
    }
	</script>
	
	<jsp:include page="/WEB-INF/views/common/footer.jsp"/>

</body>
</html>