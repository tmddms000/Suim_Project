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
	
	<div class="table-container" style="margin-top: 5px;">
		<table class="table">
			<thead>
				<tr>
					<th scope="col" class="select-cell"></th>
					<th scope="col" class="boardno-cell"></th>
					<th scope="col" class="title-th text-center">제목</th>
					<th scope="col" class="date-cell">작성일</th>
					<th scope="col" class="views-th">조회</th>
				</tr>
			</thead>
			<tbody>
				<tr>
					<td class="select-cell"><input type="checkbox"></td>
					<td class="boardno-cell">41</td>
					<td class="title-cell">가입인사 입니다. <a href="">[1]</a></td>
					<td class="date-cell">2023.06.04.</td>
					<td class="views-cell">67</td>
				</tr>
				<tr>
					<td class="select-cell"><input type="checkbox"></td>
					<td class="boardno-cell">2</td>
					<td class="title-cell">오늘 쉐어하우스 입주했음요</td>
					<td class="date-cell">2023.06.04.</td>
					<td class="views-cell">34</td>
				</tr>
				<tr>
					<td class="select-cell"><input type="checkbox"></td>
					<td class="boardno-cell">1</td>
					<td class="title-cell">안녕하세용</td>
					<td class="date-cell">2023.06.03.</td>
					<td class="views-cell">12</td>
				</tr>
			</tbody>

			<tfoot>
				<!-- 왼쪽엔 전체검색(checkbox), 오른쪽엔 글쓰기, 목록 버튼 -->

				<tr>
					<td colspan="3"><input type="checkbox"> <span
						class="small" style="margin-left: 8px;">전체선택</span></td>

					<td colspan="5" class="text-right">
						<button type="button" class="">삭제</button>
						<button type="button" class="">글쓰기</button>
					</td>
			</tfoot>
		</table>
	</div>



	<script>
		// Get the "전체선택" checkbox element
		var selectAllCheckbox = document
				.querySelector('tfoot input[type="checkbox"]');

		// Get all the checkboxes in the table body
		var checkboxes = document
				.querySelectorAll('tbody input[type="checkbox"]');

		// Add event listener to the "전체선택" checkbox
		selectAllCheckbox.addEventListener('change', function() {
			// Check if the "전체선택" checkbox is checked
			if (this.checked) {
				// Iterate over all the checkboxes and check them
				checkboxes.forEach(function(checkbox) {
					checkbox.checked = true;
				});
			} else {
				// Iterate over all the checkboxes and uncheck them
				checkboxes.forEach(function(checkbox) {
					checkbox.checked = false;
				});
			}
		});
	</script>
	
	<jsp:include page="/WEB-INF/views/common/footer.jsp" />
</body>
</html>
