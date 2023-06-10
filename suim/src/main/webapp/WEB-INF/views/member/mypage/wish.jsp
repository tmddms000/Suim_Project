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
	background-color : rgb(245,245,245);
	cursor : pointer;
}

</style>

</head>
<body>
	<jsp:include page="/WEB-INF/views/common/header.jsp" />

	<%@ include file="/WEB-INF/views/member/mypage/mypage-header.jsp"%>

	<div class="container justify-content-center align-items-center text-center bg-white mb-4">


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
								<c:when test="${ not empty list }">
									<c:forEach var="w" items="${list}">
										<tr style="vertical-align: middle" data-id="${w.houseNo}">
											<td><img src="${w.changeName}"
												style="width: 100px; height: 100px;" /></td>
											<td>${w.houseName}</td>
											<td>${w.houseAddress}</td>
											<td>${w.resGender}</td>
											<td>${w.deposit}</td>
											<td>${w.rent}</td>
											<td>${w.memberId}</td>
											<td>
												<button type="button" class="">예약하기</button>
												<button type="button" onclick="heart('${w.memberId}', ${w.houseNo})">삭제하기</button>
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
		      <a class="page-link" href="<c:url value='/mypage/board?page=${pi.currentPage - 1}'/>">이전</a>
		    </li>
		    <c:forEach var="p" begin="${pi.startPage}" end="${pi.endPage}" step="1">
		      <li class="page-item ${pi.currentPage == p ? 'active' : ''}">
		        <a class="page-link" href="<c:url value='/mypage/board?page=${p}'/>">${p}</a>
		      </li>
		    </c:forEach>
		    <li class="page-item ${pi.currentPage == pi.maxPage || pi.listCount == 0 ? 'disabled' : ''}">
		      <a class="page-link" href="<c:url value='/mypage/board?page=${pi.currentPage + 1}'/>">다음</a>
		    </li>
		  </ul>
		</nav>
			</div>
		</div>
	</div>
	
	
	
	
	
	
	<script>
	
	function heart(id, hno) {
		var type = "unlike" // 하트가 칠해져 있다면 "unlike", 칠해져 있지 않다면 "like" 지정
		
	    $.ajax({
	        url: "/heart.ho", // 서블릿으로 전송
	        type: "get",
	        data: {
	            hno: hno, // 메뉴번호랑 타입(like, unlike) 전달
	            type: type,
	            id : id
	        },
	        success: function(response) {
	            if (response === "success") { // 성공적인 응답일 경우
	            	toastr.success("성공");
	            	$("tr[data-id='" + hno + "']").remove();
	            	var listSize = parseInt($("#listSize").text());
	                listSize--;
	                $("#listSize").text(listSize);
	                if (listSize === 0) {
	                    var messageRow = '<tr><td colspan="8" class="text-center">작성된 게시글이 없습니다.</td></tr>';
	                    $("tbody").append(messageRow);
	                }
	          }
	        },
	        });
	      }
	
	</script>

	<jsp:include page="/WEB-INF/views/common/footer.jsp" />
</body>
</html>
