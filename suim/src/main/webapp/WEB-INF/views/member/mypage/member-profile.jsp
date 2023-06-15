<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
	
<!DOCTYPE html>
<html>
<head>
<title>마이페이지</title>
<link href="/resources/css/user/mypage.css" rel="stylesheet" />


<%@ include file="/WEB-INF/views/common/include.jsp"%>
</head>
<body>
	<jsp:include page="/WEB-INF/views/common/header.jsp" />

	<%@ include file="/WEB-INF/views/member/mypage/profile-header.jsp"%>
	
<div class="container bg-white mb-4">
  <div class="row justify-content-center text-center">
    <div class="col-xl-4 text-center">
      <h1>회원 정보</h1>
      <table class="table table-responsive">
        <tbody>
          
        </tbody>
      </table>
    </div>
  </div>
  
  
</div>






<script>
</script>



	<jsp:include page="/WEB-INF/views/common/footer.jsp" />
</body>
</html>
