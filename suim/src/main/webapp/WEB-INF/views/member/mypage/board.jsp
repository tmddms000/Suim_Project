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
	width: 860px;
	font-size: 12px;
}

.select-cell {
	width: 35px;
}

.boardno-cell {
	width: 40px;
	font-size: 10px;
}

.date-cell {
	width: 200px;
	font-size: 12px;
	text-align: center;
}

.views-cell {
	width: 160px;
	font-size: 12px;
	text-align: center;
}

.table thead th {
	border-top: 1px solid #666;
}

.text-right {
	text-align: right;
}

.reply-cell {
	color: red;
	font-size: 10px;
}

input[type="number"]::-webkit-outer-spin-button, input[type="number"]::-webkit-inner-spin-button
	{
	-webkit-appearance: none;
	margin: 0;
}

@media
(
max-width
:
767px)
{
a.page-link {
	font-size: 12px;
}
}
</style>
<body>
	<jsp:include page="/WEB-INF/views/common/header.jsp" />

	<%@ include file="/WEB-INF/views/member/mypage/mypage-header.jsp"%>

	<div class="table-container" style="margin-bottom: 30px;">

		<div class="container">
			<ul class="nav nav-tabs">
				<li class="nav-item"><a
					class="nav-link <c:if test="${type eq 'board'}">active</c:if>"
					id="free-board" data-toggle="tab" href="/mypage/board">자유게시판</a></li>
				<li class="nav-item"><a
					class="nav-link <c:if test="${type eq 'inreview'}">active</c:if>"
					data-toggle="tab" id="review-board"
					href="/mypage/board?page=1&type=inreview">입주후기</a></li>
				<li class="nav-item"><a
					class="nav-link <c:if test="${type eq 'find'}">active</c:if>"
					data-toggle="tab" id="job-board"
					href="/mypage/board?page=1&type=find">사람구해요</a></li>
			</ul>


			<table class="table">
				<thead>
					<tr>
						<th scope="col" class="select-cell"></th>
						<th scope="col" class="boardno-cell"></th>
						<th scope="col" class="title-th title-cell text-center">제목</th>
						<th scope="col" class="date-cell">작성일</th>
						<th scope="col" class="views-cell">조회수</th>
					</tr>
				</thead>

				<tbody>
					<c:if test="${not empty loginUser }">
						<c:choose>
							<c:when test="${not empty list}">
							  <c:forEach var="b" items="${list}">
							    <tr data-id="${type eq 'board' ? b.boardNo : (type eq 'find' ? b.findNo : b.inReviewNo)}">
							      <td class="select-cell"><input type="checkbox" data-id="${type eq 'board' ? b.boardNo : (type eq 'find' ? b.findNo : b.inReviewNo)}"></td>
							      <td class="boardno-cell">${type eq 'board' ? b.boardNo : (type eq 'find' ? b.findNo : b.inReviewNo)}</td>
							      <td class="title-cell"><a href="/detail.bo?bno=${type eq 'board' ? b.boardNo : (type eq 'find' ? b.findNo : b.inReviewNo)}">${type eq 'board' ? b.boardTitle : (type eq 'find' ? b.findTitle : b.inReviewTitle)}</a> <a href="/detail.bo?bno=${type eq 'board' ? b.boardNo : (type eq 'find' ? b.findNo : b.inReviewNo)}#replyArea"><c:if test="${type eq 'board' ? b.replyCount > 0 : (type eq 'find' ? b.freplyCount > 0 : b.inReviewReplyCount > 0)}"><span class="reply-cell">[${type eq 'board' ? b.replyCount : (type eq 'find' ? b.freplyCount : b.inReviewReplyCount)}]</span></c:if></a></td>
							      <td class="date-cell">${type eq 'board' ? b.boardDate : (type eq 'find' ? b.findDate : b.inReviewDate)}</td>
							      <td class="views-cell">${type eq 'board' ? b.boardView : (type eq 'find' ? b.findView : b.inReviewView)}</td>
							    </tr>
							  </c:forEach>
							</c:when>
							<c:otherwise>
								<tr>
									<td colspan="6" class="text-center">작성된 게시글이 없습니다.</td>
								</tr>
							</c:otherwise>
						</c:choose>
					</c:if>
				</tbody>
				<tfoot>
					<tr>
						<td colspan="3"><input type="checkbox"> <span
							class="small" style="margin-left: 8px;">전체선택</span></td>

						<td colspan="5" class="text-right">
							<button type="button" class="delete-btn">삭제</button>
							<button type="button" class="write-btn">글쓰기</button>
						</td>
				</tfoot>
			</table>
		</div>



		<nav id="pagingArea" style="margin-top: 30px; margin-bottom: 30px;">
		  <ul class="pagination justify-content-center">
		    <li class="page-item ${pi.currentPage == 1 ? 'disabled' : ''}">
		      <a class="page-link" href="<c:url value='/mypage/board?page=${pi.currentPage - 1}&type=${type}'/>">이전</a>
		    </li>
		    <c:forEach var="p" begin="${pi.startPage}" end="${pi.endPage}" step="1">
		      <li class="page-item ${pi.currentPage == p ? 'active' : ''}">
		        <a class="page-link" href="<c:url value='/mypage/board?page=${p}&type=${type}'/>">${p}</a>
		      </li>
		    </c:forEach>
		    <li class="page-item ${pi.currentPage == pi.maxPage || pi.listCount == 0 ? 'disabled' : ''}">
		      <a class="page-link" href="<c:url value='/mypage/board?page=${pi.currentPage + 1}&type=${type}'/>">다음</a>
		    </li>
		  </ul>
		</nav>

		<div class="page-item text-center">

			<form action="/mypage/board" method="GET" class="form-inline">
				<input type="hidden" value="${type}" name="type"> <input
					type="number" class="form-control" name="page" placeholder="번호"
					min="1" max="${pi.maxPage}"
					style="margin-left: 5px; display: inline-block; width: 55px;">
				<button class="page-link" type="submit"
					style="display: inline-block; height: 38px;">이동하기</button>
			</form>
		</div>


	</div>


	<script>
		$(document)
				.ready(
						function() {
							$(document)
									.on(
											'change',
											'tfoot input[type="checkbox"]',
											function() {
												var checkboxes = $('tbody input[type="checkbox"]');
												checkboxes.prop('checked',
														this.checked);
											});

							// 개별 체크박스 클릭 이벤트
							$(document)
									.on(
											'change',
											'tbody input[type="checkbox"]',
											function() {
												var selectAllCheckbox = $('tfoot input[type="checkbox"]');
												selectAllCheckbox
														.prop(
																'checked',
																$('tbody input[type="checkbox"]:checked').length === $('tbody input[type="checkbox"]').length);
											});
							$(document).on('click', '.write-btn', function() {
								redirectToEnrollForm('board');
							});

							function redirectToEnrollForm(type) {
								if (type === 'board') {
									window.location.href = '/enrollForm.bo';
								}
							}

							// 삭제 버튼 클릭 이벤트
							$(document)
									.on(
											'click',
											'button.delete-btn',
											function() {
												var checkedCheckboxes = $('tbody input[type="checkbox"]:checked');
												var deleteIds = [];

												checkedCheckboxes
														.each(function() {
															deleteIds.push($(
																	this).data(
																	'id'));
														});

												if (deleteIds.length === 0) {
													alert("삭제할 게시글을 선택해주세요.");
													return;
												}

												var confirmation = confirm("게시글을 삭제하시겠습니까?");
												if (!confirmation) {
													return;
												}

												// 삭제 처리를 위한 Ajax 요청
						$
								.ajax({
									type : "POST",
									url : "/mypage/boardDelete",
									data : {
										ids : deleteIds.join(","),
										type : type
									},
									success : function(response) {
										if (response === 'Y') {
											toastr.success("게시글이 삭제 되었습니다.");

											deleteIds.forEach(function(id) {
														$("tr[data-id=" + id + "]").remove();
													});
											$('tfoot input[type="checkbox"]').prop('checked', false);

										} else {
											toastr.error("게시글 삭제에 실패했습니다.");
										}
									},
									error : function() {
										toastr.error("게시글 삭제에 실패했습니다.");
									}

								});
					});

});
</script>








	<jsp:include page="/WEB-INF/views/common/footer.jsp" />
</body>
</html>
