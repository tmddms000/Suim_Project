<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
<head>
<title>마이페이지</title>
<link href="/resources/css/user/mypage.css" rel="stylesheet" />
<%@ include file="/WEB-INF/views/common/include.jsp"%>

<style>
.table>tbody>tr:hover {
	background-color : #f5f5f5;
	cursor : pointer;
}
</style>

<script>
  function redirectToDetail(houseNo) {
    var url = '/detail.ho?hno=' + houseNo;
    window.location.href = url;
  }
</script>

</head>
<body>
	<jsp:include page="/WEB-INF/views/common/header.jsp" />

	<%@ include file="/WEB-INF/views/member/mypage/mypage-header.jsp"%>

	<div class="container justify-content-center align-items-center text-center bg-white mb-4" style="margin-top : 50px;">
  <c:set var="listSize" value="${fn:length(list)}" />
  <div class="row">
    <div class="col-md-12">
      <h1>내 찜 목록(<span id="listSize">${listSize}</span>)</h1>
    </div>
  </div>

  <!-- 테이블형식으로 찜한 셰어하우스 목록 만들기 -->
  <div class="row">
    <div class="col-sm-12">
      <table class="table">
        <thead>
          <tr>
            <th scope="col">이미지</th>
            <th scope="col">제목</th>
            <th scope="col">주소</th>
            <th scope="col">성별</th>
            <th scope="col">보증금</th>
            <th scope="col">월세</th>
            <th scope="col">작성자</th>
            <th scope="col">보기</th>
          </tr>
        </thead>
        <tbody>
          <c:if test="${not empty loginUser }">
            <c:choose>
              <c:when test="${not empty list}">
                <c:forEach var="w" items="${list}">
                  <tr style="vertical-align: middle" data-id="${w.houseNo}" class="hoverable-tr">
                    <td><img src="<c:out value="/resources/img/house/uploadFiles/${w.changeName}"/>" style="width: 100px; height: 100px;" /></td>
                    <td><c:out value="${w.houseName}"/></td>
                    <td><c:out value="${w.houseAddress}"/></td>
                    <td><c:out value="${w.resGender}"/></td>
                    <td><c:out value="${w.deposit}"/></td>
                    <td><c:out value="${w.rent}"/></td>
                    <td><c:out value="${w.memberId}"/></td>
                    <td>
                      <button type="button" class="wishBtn" onclick="rezPopup('<c:out value="${w.houseNo}" />', '<c:out value="${w.houseName}" />', '<c:out value="${w.houseWriter}" />')">예약하기</button>
                      <button type="button" class="wishBtn" onclick="heart('<c:out value="${w.memberId}"/>', <c:out value="${w.houseNo}"/>);">삭제하기</button>
                    </td>
                  </tr>
                </c:forEach>
              </c:when>
              <c:otherwise>
                <tr>
                  <td colspan="8" class="text-center">작성된 게시글이 없습니다.</td>
                </tr>
              </c:otherwise>
            </c:choose>
          </c:if>
        </tbody>
      </table>
      

      <nav id="pagingArea" style="margin-top: 30px; margin-bottom: 30px;">
        <ul class="pagination justify-content-center">
          <li class="page-item ${pi.currentPage == 1 ? 'disabled' : ''}">
            <a class="page-link" href="<c:url value='/mypage/wish?page=${pi.currentPage - 1}'/>">이전</a>
          </li>
          <c:forEach var="p" begin="${pi.startPage}" end="${pi.endPage}" step="1">
            <li class="page-item ${pi.currentPage == p ? 'active' : ''}">
              <a class="page-link" href="<c:url value='/mypage/wish?page=${p}'/>"><c:out value="${p}"/></a>
            </li>
          </c:forEach>
          <li class="page-item ${pi.currentPage == pi.maxPage || pi.listCount == 0 ? 'disabled' : ''}">
            <a class="page-link" href="<c:url value='/mypage/wish?page=${pi.currentPage + 1}'/>">다음</a>
          </li>
        </ul>
      </nav>
    </div>
  </div>
  <div style="height : 200px;"></div>
</div>

<script>
  // 버튼 요소의 클릭 이벤트 전파 방지
  $('tr .wishBtn').click(function (e) {
    e.stopPropagation();
  });
  
  // 행 요소 클릭 시 페이지 이동
  $('tr.hoverable-tr').click(function () {
    var houseNo = $(this).data('id');
    redirectToDetail(houseNo);
  });
  
  
  
  function rezPopup(houseNo, houseName, memberId) {
      var popupUrl = "/houseRez.ho?value=" + encodeURIComponent(houseNo) + "&value2=" + encodeURIComponent(houseName) + "&value3=" + encodeURIComponent(memberId);
      if ("${loginUser}" == "") {
          alert("로그인이 필요합니다.");
          window.location.href = "/detail.ho?hno=" + encodeURIComponent(houseNo);
      } else {
      	  var width = 500;
            var height = 500;
            var left = (screen.width - width) / 2;
            var top = (screen.height - height) / 2;
            var popup = window.open(popupUrl, "popup", "width=" + width + ",height=" + height + ",left=" + left + ",top=" + top);
      }
  }
</script>


	
	<script src="/resources/js/user/wish.js"></script>
	<jsp:include page="/WEB-INF/views/common/footer.jsp" />
</body>
</html>
