<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<title>마이페이지</title>
<link href="/resources/css/user/mypage.css" rel="stylesheet" />
<link href="/resources/css/user/board.css" rel="stylesheet" />
<%@ include file="/WEB-INF/views/common/include.jsp"%>
</head>

<body>
	<jsp:include page="/WEB-INF/views/common/header.jsp" />

	<%@ include file="/WEB-INF/views/member/mypage/mypage-header.jsp"%>

<div class="table-container" style="margin-top: 50px;">
    <div class="container justify-content-center align-items-center bg-white mb-4" id="c">
        <ul class="nav nav-tabs">
            <li class="nav-item"><a class="nav-link <c:if test="${type eq 'board'}">active</c:if>"
                    id="free-board" data-toggle="tab" href="/mypage/board">자유게시판</a></li>
            <li class="nav-item"><a class="nav-link <c:if test="${type eq 'inreview'}">active</c:if>"
                    data-toggle="tab" id="review-board"
                    href="/mypage/board?page=1&type=inreview">입주후기</a></li>
            <li class="nav-item"><a class="nav-link <c:if test="${type eq 'find'}">active</c:if>"
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
                <c:if test="${not empty loginUser}">
                    <c:choose>
                        <c:when test="${not empty list}">
                            <c:forEach var="b" items="${list}">
                                <tr data-id="${type eq 'board' ? b.boardNo : (type eq 'find' ? b.findNo : b.inrNo)}">
                                    <td class="select-cell"><input type="checkbox"
                                            data-id="${type eq 'board' ? b.boardNo : (type eq 'find' ? b.findNo : b.inrNo)}"></td>
                                    <td class="boardno-cell">${type eq 'board' ? b.boardNo : (type eq 'find' ? b.findNo : b.inrNo)}</td>
                                    <td class="title-cell">
                                        <a href="<c:choose>
                                            <c:when test="${type eq 'board'}">/detail.bo?bno=${b.boardNo}</c:when>
                                            <c:when test="${type eq 'find'}">/detail.fi?fno=${b.findNo}</c:when>
                                            <c:when test="${type eq 'inreview'}">/detail.in?ino=${b.inrNo}</c:when>
                                        </c:choose>">
                                            <c:choose>
                                                <c:when test="${type eq 'board'}">${b.boardTitle}</c:when>
                                                <c:when test="${type eq 'find'}">${b.findTitle}</c:when>
                                                <c:when test="${type eq 'inreview'}">${b.inrTitle}</c:when>
                                                <c:otherwise></c:otherwise>
                                            </c:choose>
                                        </a>
                                        <a href="<c:choose>
                                            <c:when test="${type eq 'board'}">/detail.bo?bno=${b.boardNo}</c:when>
                                            <c:when test="${type eq 'find'}">/detail.fi?fno=${b.findNo}</c:when>
                                            <c:when test="${type eq 'inreview'}">/detail.in?ino=${b.inrNo}</c:when>
                                        </c:choose>#replyArea">
                                            <c:if test="${type eq 'board' ? b.replyCount > 0 : (type eq 'find' ? b.freplyCount > 0 : b.replyCount > 0)}">
                                                <span class="reply-cell">[${type eq 'board' ? b.replyCount : (type eq 'find' ? b.freplyCount : b.replyCount)}]</span>
                                            </c:if>
                                        </a>
                                    </td>
                                    <td class="date-cell">${type eq 'board' ? b.boardDate : (type eq 'find' ? b.findDate : b.inrDate)}</td>
                                    <td class="views-cell">${type eq 'board' ? b.boardView : (type eq 'find' ? b.findView : b.inrView)}</td>
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
                    <td colspan="3"><input type="checkbox"> <span class="small"
                            style="margin-left: 8px;">전체선택</span></td>

                    <td colspan="5" class="text-right">
                        <button type="button" class="delete-btn">삭제</button>
                        <button type="button" class="write-btn">글쓰기</button>
                    </td>
                </tr>
            </tfoot>
        </table>
    </div>

    <nav id="pagingArea" style="margin-top: 30px; margin-bottom: 30px;">
        <ul class="pagination justify-content-center">
            <li class="page-item ${pi.currentPage == 1 ? 'disabled' : ''}">
                <a class="page-link" href="<c:url value='/mypage/board?page=${pi.currentPage - 1}&type=${type}#c'/>">이전</a>
            </li>
            <c:forEach var="p" begin="${pi.startPage}" end="${pi.endPage}" step="1">
                <li class="page-item ${pi.currentPage == p ? 'active' : ''}">
                    <a class="page-link" href="<c:url value='/mypage/board?page=${p}&type=${type}#c'/>">${p}</a>
                </li>
            </c:forEach>
            <li class="page-item ${pi.currentPage == pi.maxPage || pi.listCount == 0 ? 'disabled' : ''}">
                <a class="page-link" href="<c:url value='/mypage/board?page=${pi.currentPage + 1}&type=${type}#c'/>">다음</a>
            </li>
        </ul>
    </nav>

    <div class="page-item text-center">
        <form action="<c:url value='/mypage/board' />" method="GET" class="form-inline">
            <input type="hidden" value="<c:out value='${type}' />" name="type" />
            <input type="number" class="form-control" name="page" placeholder="번호"
                min="1" max="<c:out value='${pi.maxPage}' />"
                style="margin-left: 5px; display: inline-block; width: 55px;">
            <button class="page-link" type="submit" style="display: inline-block; height: 38px;">이동하기</button>
        </form>
    </div>
</div>


<div style="height : 150px;"></div>

<script>
var typeValue = "${type}";

$(document).ready(function() {
    $(document).on('change', 'tfoot input[type="checkbox"]', function() {
        var checkboxes = $('tbody input[type="checkbox"]');
        checkboxes.prop('checked', this.checked);
    });

    // 개별 체크박스 클릭 이벤트
    $(document).on('change', 'tbody input[type="checkbox"]', function() {
        var selectAllCheckbox = $('tfoot input[type="checkbox"]');
        selectAllCheckbox.prop('checked', $('tbody input[type="checkbox"]:checked').length === $('tbody input[type="checkbox"]').length);
    });

    $(document).on('click', '.write-btn', function() {
        redirectToEnrollForm(typeValue);
    });

    function redirectToEnrollForm(type) {
        if (type === 'board') {
            window.location.href = '/enrollForm.bo';
        }
        if (type === 'inreview') {
            window.location.href = '/enrollForm.in';
        }
        if (type === 'find') {
            window.location.href = '/enrollForm.fi';
        }
    } // 대괄호 추가

    // 삭제 버튼 클릭 이벤트
    $(document).off('click', 'button.delete-btn').on('click', 'button.delete-btn', function() {
        var checkedCheckboxes = $('tbody input[type="checkbox"]:checked');
        var deleteIds = [];

        checkedCheckboxes.each(function() {
            deleteIds.push($(this).data('id'));
        });

        if (deleteIds.length === 0) {
            alert("삭제할 게시글을 선택해주세요.");
            return;
        }

        var confirmation = confirm("게시글을 삭제하시겠습니까?");
        if (confirmation) { // Only proceed if the user confirms the deletion
            // 삭제 처리를 위한 Ajax 요청
            $.ajax({
                type: "POST",
                url: "/mypage/boardDelete",
                data: {
                    ids: deleteIds.join(","),
                    type: typeValue
                },
                success: function(response) {
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
                error: function() {
                    toastr.error("게시글 삭제에 실패했습니다.");
                }
            });
        }
    });
});

</script>

	<script src="/resources/js/user/board.js"></script>
	<jsp:include page="/WEB-INF/views/common/footer.jsp" />
</body>
</html>
