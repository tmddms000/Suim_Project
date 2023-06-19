<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<title>내 결제내역</title>
<link href="/resources/css/user/mypage.css" rel="stylesheet" /> 
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
        text-align : center;
    }
    
    th {
        text-align: center;
        vertical-align: middle;
        padding: 10px 5px;
    }
    
    th.payDate {
        text-align: left;
    }

    td {
        padding: 8px;
        text-align: center;
        vertical-align: middle;        
    }
    
    
    .small {
        font-size: 12px;
    }
    .payDate {
        width: 150px;
    }
    .payName{
        width : 150px;
    }
    
    .payPrice{
        width : 150px;
    }
    .memberId-cell{
        width : 150px;
    }
    .rezRequestDate-cell{
    	width : 150px;
    }
     .payStatus{
        width : 100px;
    }
     .payStatusCell{
        width : 200px;
    }
    
    .table thead th {
        border-top: 1px solid #666;
    }
    
    .text-right {
        text-align: right;
    }
     .rez-confirm, .rez-cancel {
	        background-color: #FA6B6F;
	        color: white;
	        padding: 10px 20px;
	        border: none;
	        border-radius: 5px;
	        box-shadow: 0px 2px 4px rgba(0, 0, 0, 0.4);
	        font-weight: bold;
	        cursor: pointer;
	        transition: background-color 0.3s ease;
	        width: 70px;
	        height: 25px;
	        font-size: 13px;
	        display: flex;
	        justify-content: center;
	        align-items: center;
	        padding : 5px 10px;
	    }
	 .button-container button:disabled {
	        opacity: 0.6;
	        cursor: not-allowed;
	    }
	
	    .button-container button:not(:disabled):hover {
	        background-color: rgb(216, 69, 9);
	    }   
	    .button-container {
		  display: flex; /* 가로로 나란히 정렬 */
		  gap: 10px; /* 버튼 사이 간격 */
		  justify-content: center; /* 가로 가운데 정렬 */
		}  

		.form-container form {
		  display: inline; /* 인라인 요소로 설정하여 가로로 나란히 배치 */
		}
		#pagingArea {
	 	width:fit-content; margin:auto;
		}
		.pagination{
			padding-top : 15px;
		}
		#payment tr:hover td {
		  color: rgb(250, 107, 111);
		  cursor: pointer;
		  font-size: large;
		}    	    	
    
    </style>

<%@ include file="/WEB-INF/views/common/include.jsp"%>
</head>
<body>
	<jsp:include page="/WEB-INF/views/common/header.jsp" />

	<%@ include file="/WEB-INF/views/member/mypage/mypage-header.jsp"%>


	<div class="table-container" style="margin-top: 5px;">
		<table class="table" style="text-align: center;" id="payment">
			<thead>
				<tr>
					
					<th scope="col" class="payDate" style="text-align : center;">결제일</th>
                    <th scope="col" class="payName">쉐어하우스 이름</th>
                    <th scope="col" class="payPrice">결제 금액</th>
					<th scope="col" class="payStatus">결제 상태</th>
				</tr>
			</thead>
			<tbody>

			
				  <c:forEach var="p" items="${ list }">
                    	<tr>
                    		<td class="hno" style="display: none;">${p.houseNo}</td>
                    		<td class="pay">${ p.paymentDate }</td>
            				<td class="houseName">${ p.houseName }</td>
                    		<td class="payPrice">${(p.price/10000).intValue()}만원</td>
                    							
                    		<td class="rezRequestDate-cell">
							  <c:choose>
							    <c:when test="${p.paymentStatus eq 'Y'}">
							      결제완료
							    </c:when>
							    <c:otherwise>
							      미결제
							    </c:otherwise>
							  </c:choose>
							</td>
                    	</tr>
                  </c:forEach>
			</tbody>
		</table>
	</div>
	
		 <c:if test="${not empty list}">
	    <div id="pagingArea">
	        <ul class="pagination">
	            <c:choose>
	                <c:when test="${pi.currentPage eq 1}">
	                    <li class="page-item disabled"><a class="page-link" href="#">Previous</a></li>
	                </c:when>
	                <c:otherwise>
	                    <li class="page-item"><a class="page-link" href="payment?cPage=${pi.currentPage - 1}">Previous</a></li>
	                </c:otherwise>
	            </c:choose>
	            <c:forEach var="p" begin="${pi.startPage}" end="${pi.endPage}" step="1">
	                <li class="page-item"><a class="page-link" href="payment?cPage=${p}">${p}</a></li>
	            </c:forEach>
	            <c:choose>
	                <c:when test="${pi.currentPage eq pi.maxPage}">
	                    <li class="page-item disabled"><a class="page-link" href="#">Next</a></li>
	                </c:when>
	                <c:otherwise>
	                    <li class="page-item"><a class="page-link" href="payment?cPage=${pi.currentPage + 1}">Next</a></li>
	                </c:otherwise>
	            </c:choose>
	        </ul>
	    </div>
	</c:if>
	
	<script>
    $(function() {
     	$("#payment>tbody>tr").click(function() {
     		let hno = $(this).children(".hno").text();
     		location.href = "../detail.ho?hno=" + hno; //
     	});
     });


	</script>
	
	<jsp:include page="/WEB-INF/views/common/footer.jsp" />
</body>

</html>
