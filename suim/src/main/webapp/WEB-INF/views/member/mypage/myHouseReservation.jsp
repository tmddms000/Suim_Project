<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
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
    
    th.houseTitle-th {
        text-align: left;
    }

    td {
        padding: 8px;
        vertical-align: middle;
    }
    
    
    .small {
        font-size: 12px;
    }
     .reserveNo-cell{
        width : 50px;
    }
    .houseTitle-th {
        width: 250px;
    }
    .rezDate-cell{
        width : 150px;
    }
    
    .rezHour-cell{
        width : 150px;
    }
    .memberId-cell{
        width : 150px;
    }
     .rezStatus-cell{
        width : 100px;
    }
     .rezStatusBtn-cell{
        width : 180px;
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
	
	<div class="table-container" style="margin-top: 5px;">
		<table class="table">
			<thead>
				<tr>
					<th scope="col" class="reserveNo-cell"></th>
					<th scope="col" class="houseTitle-th text-center">쉐어하우스 이름</th>
                    <th scope="col" class="rezDate-cell">예약 일</th>
                    <th scope="col" class="rezHour-cell">예약 시간</th>
                    <th scope="col" class="memberId-cell">예약자 ID</th>
					<th scope="col" class="rezStatus-cell">예약 상태</th>
					<th scope="col" class="rezStatusBtn-cell">예약 상태 변경</th>
				</tr>
			</thead>
			<tbody>
				  <c:forEach var="r" items="${ list }">
                    	<tr>
                    		<td class="reserveNo-cell">${ r.rezNo }</td>
            				<td class="houseTitle-th">${ r.houseName }</td>
                    		<td class="rezDate-cell">${ r.rezDate }</td>
                    		<td class="rezHour-cell">${ r.rezHour }</td>
                    		<td class="memberId-cell">${ r.memberId }</td>
							<td class="rezStatus-cell">${ r.rezStatus }</td>
                    		<td class="rezStatusBtn-cell">
                    			<c:if test="">
                    			</c:if>
                    		</td>
                    	</tr>
                  </c:forEach>
			</tbody>
		</table>
	</div>
	
	
	

	<jsp:include page="/WEB-INF/views/common/footer.jsp" />
</body>
</html>