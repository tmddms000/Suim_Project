<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
	
<!DOCTYPE html>
<html>
<head>
<title>마이페이지</title>
<link href="/resources/css/user/mypage.css" rel="stylesheet" />
<%@ include file="/WEB-INF/views/common/include.jsp"%>

<style>
body {
	background-color: #f8f9fa;
}

.table-container {
	max-width: 1320px;
	margin: 0 auto;
	background-color: #fff;
	border-radius: 5px;
	box-shadow: 0 2px 5px rgba(0, 0, 0, 0.1);
	padding: 20px;
}

table {
	width: 100%;
	border-collapse: collapse;
}

th {
	text-align: center;
	vertical-align: middle;
	padding: 10px 5px;
}

th.title-th {
	text-align: left;
}

th.views-th {
	font-size: 12px;
	text-align: center;
}

td {
	padding: 8px;
	vertical-align: middle;
}

.small {
	font-size: 12px;
}

.title-cell {
	width: 1020px;
}

.select-cell {
	width: 35px;
}

.boardno-cell {
	width: 40px;
	font-size: 10px;
}

.date-cell, .views-cell {
	font-size: 12px;
	text-align: center;
}

.table thead th {
	border-top: 1px solid #666;
}

.text-right {
	text-align: right;
}
</style>

</head>
<body>
	<jsp:include page="/WEB-INF/views/common/header.jsp" />

	<%@ include file="/WEB-INF/views/member/mypage/mypage-header.jsp"%>
	
	<jsp:include page="/WEB-INF/views/common/footer.jsp" />
</body>
</html>
