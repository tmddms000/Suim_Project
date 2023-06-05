<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
<head>
<title>마이페이지</title>
<link href="/resources/css/user/mypage.css" rel="stylesheet" />
<%@ include file="/WEB-INF/views/common/include.jsp"%>
</head>
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
<body>
	<jsp:include page="/WEB-INF/views/common/header.jsp" />

	<%@ include file="/WEB-INF/views/member/mypage/mypage-header.jsp"%>

	<div class="table-container" style="margin-top: 5px;">

		<ul class="nav nav-tabs">
			<li class="nav-item"><a class="nav-link active" id="free-board"
				data-toggle="tab" href="#free-board">자유게시판 (52)</a></li>
			<li class="nav-item"><a class="nav-link" data-toggle="tab" id="review-board"
				href="#review-board">입주후기 (33)</a></li>
			<li class="nav-item"><a class="nav-link" data-toggle="tab" id="job-board"
				href="#job-board">사람구해요 (12)</a></li>
		</ul>


		<table class="table">
			<thead>
				<tr>
					<th scope="col" class="select-cell"></th>
					<th scope="col" class="boardno-cell"></th>
					<th scope="col" class="title-th title-cell text-center">제목</th>
					<th scope="col" class="date-cell">작성일</th>
					<th scope="col" class="views-th">조회</th>
				</tr>
			</thead>
			<tbody>
				<c:if test="${not empty loginUser }">

					<c:choose>

						<c:when test="${ not empty list }">
							<c:forEach var="b" items="${list}">
								<tr>
									<td class="select-cell"><input type="checkbox"></td>
									<td class="boardno-cell">${b.boardNo}</td>
									<td class="title-cell">${b.boardTitle}<a href="">[1]</a></td>
									<td class="date-cell">${b.boardDate}</td>
									<td class="views-cell">${b.boardView}</td>
								</tr>
							</c:forEach>
						</c:when>
						<c:otherwise>
						<tr>
							<td colspan="4" class="text-center">작성된 게시글이 없습니다.</td>
						</tr>
						</c:otherwise>

					</c:choose>
				</c:if>
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
	
	<script>
	$(document).ready(function() {
	    $('.nav-link').click(function(e) {
	        e.preventDefault();

	        // Remove the "active" class from all tabs and content
	        $('.nav-link').removeClass('active');
	        $('.tab-pane').removeClass('show active');

	        // Add the "active" class to the clicked tab
	        $(this).addClass('active');

	        // Get the target tab's ID from the data attribute
	        var targetTab = $(this).attr('id');
	        var type = "";

	        if (targetTab === "free-board") {
	            type = "board";
	        } else if (targetTab === "review-board") {
	            type = "inreview";
	        } else if (targetTab === "job-board") {
	            type = "find";
	        }
	        
	        console.log(type);

	        // Send Ajax request
	        $.ajax({
	            type: "GET",
	            url: "/mypage/boardType",
	            data: {
	                type: type
	            },
	            success: function(response) {
	                // Handle the response
	                console.log(response);

	                // Update the table content with the new data
	                var tableBody = $('table tbody');
	                tableBody.empty();
	                
	                

	                if (response.list.length > 0) {
	                	$.each(response.list, function(index, item) {
	                	    var row = "<tr>" +
	                	        "<td class='select-cell'><input type='checkbox'></td>";

	                	    if (type === "board") {
	                	    	var date = new Date(item.boardDate);
	                	    	var formattedDate = date.toISOString().split('T')[0];

	                	  
	                	        row += "<td class='boardno-cell'>" + item.boardNo + "</td>";
	                	        row += "<td class='title-cell'>" + item.boardTitle + "<a href=''>[1]</a></td>";
	                	        row += "<td class='date-cell'>" + formattedDate + "</td>";
	                	        row += "<td class='views-cell'>" + item.boardView + "</td>";
	                	    } else if (type === "find") {
	                	    	
	                	    	var date = new Date(item.findDate);
	                	    	var formattedDate = date.toISOString().split('T')[0];
	                	    	
	                	        row += "<td class='boardno-cell'>" + item.findNo + "</td>";
	                	        row += "<td class='title-cell'>" + item.findTitle + "<a href=''>[1]</a></td>";
	                	        row += "<td class='date-cell'>" + formattedDate + "</td>";
	                	        row += "<td class='views-cell'>" + item.findView + "</td>";
	                	    }

	                	    row += "</tr>";

	                	    tableBody.append(row);
	                	});
	                }
	            },
	            error: function(xhr, status, error) {
	                // Handle the error
	                console.error(error);
	            }
	        });
	    });
	});

	</script>

	<jsp:include page="/WEB-INF/views/common/footer.jsp" />
</body>
</html>
