<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>에러 페이지</title>
<%@ include file="/WEB-INF/views/common/include.jsp" %>
</head>
<body>

	<jsp:include page="/WEB-INF/views/common/header.jsp"/>

	<br>
    <div align="center">
    	<br><br><br><br><br><br>
        <img src="https://cdn2.iconfinder.com/data/icons/oops-404-error/64/208_balloon-bubble-chat-conversation-sorry-speech-256.png">
        <h1 style="font-weight:bold;">${ errorMsg }</h1>
    </div>
	
	
	<jsp:include page="/WEB-INF/views/common/footer.jsp"/>

</body>
</html>