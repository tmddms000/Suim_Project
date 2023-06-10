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
    
    .houseTitle-cell {
        width: 250px;
    }
    .houseAddress{
        width : 350px;
    }
    
    .select-cell {
        width: 35px;
    }
    
    .houseNo-cell {
        width: 100px;
        font-size: 10px;
    }
    
    .houseDeposit{
        width : 100px;
    }
    .houseRent{
        width : 100px;
    }


    .houseDate-cell, .views-cell {
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

	<div class="table-container" style="margin-top: 5px;">
		<table class="table">
			<thead>
				<tr>
					<th scope="col" class="select-cell"></th>
					<th scope="col" class="houseNo-cell"></th>
					<th scope="col" class="houseTitle-th text-center">쉐어하우스 이름</th>
                    <th scope="col" class="houseAddress">주소</th>
                    <th scope="col" class="houseDeposit">보증금</th>
                    <th scope="col" class="houseRent">월세</th>
					<th scope="col" class="houseDate-cell">등록일</th>
				</tr>
			</thead>
			<tbody>
				<tr>
					<td class="select-cell"><input type="checkbox"></td>
					<td class="houseNo-cell">41</td>
					<td class="houseTitle-cell">가입인사 입니다.</td>
                    <td class="houseAddress-cell"></td>
                    <td class="houseDeposit-cell"></td>
                    <td class="houseRent-cell"></td>
					<td class="houseDate-cell">2023.06.04.</td>
				</tr>
				<tr>
					<td class="select-cell"><input type="checkbox"></td>
					<td class="houseNo-cell">2</td>
					<td class="houseTitle-cell">오늘 쉐어하우스 입주했음요</td>
                    <td class="houseAddress-cell"></td>
                    <td class="houseDeposit-cell"></td>
                    <td class="houseRent-cell"></td>
					<td class="houseDate-cell">2023.06.04.</td>
				</tr>
				<tr>
					<td class="select-cell"><input type="checkbox"></td>
					<td class="houseNo-cell">1</td>
					<td class="houseTitle-cell">안녕하세용</td>
                    <td class="houseAddress-cell"></td>
                    <td class="houseDeposit-cell"></td>
                    <td class="houseRent-cell"></td>
					<td class="houseDate-cell">2023.06.03.</td>
				</tr>
			</tbody>

			<tfoot>
				<!-- 왼쪽엔 전체검색(checkbox), 오른쪽엔 글쓰기, 목록 버튼 -->
				<tr>
					<td colspan="3"><input type="checkbox"> <span
						class="small" style="margin-left: 8px;">전체선택</span></td>

					<td colspan="5" class="text-right">
						<button type="button" class="">예약 취소</button>
					</td>
                </tr>
			</tfoot>
		</table>
	</div>


	
	<jsp:include page="/WEB-INF/views/common/footer.jsp" />
</body>
</html>
