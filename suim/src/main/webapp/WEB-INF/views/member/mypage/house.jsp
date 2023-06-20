<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<title>마이페이지</title>
<link href="/resources/css/user/mypage.css" rel="stylesheet" />
<%@ include file="/WEB-INF/views/common/include.jsp"%>
<style>
body {
	background-color: #F8F9FA;
}
#myhouse-container {
	width: 1100px;
	height: 500px;
	margin: 0 auto;
	background-color: #fff;
	border-radius: 5px;
	box-shadow: 0 2px 5px rgba(0, 0, 0, 0.1);
	padding: 30px;
	display: flex;
	justify-content: flex-start;
}
#myhouse-row {
	display: flex;
	justify-content: flex-start;
	overflow: auto;
}
#myhouse-row::-webkit-scrollbar {
	width: 0.2em; /* 스크롤바의 너비 */
}
#myhouse-row::-webkit-scrollbar-track {
	background: #F1F1F1; /* 스크롤바 트랙의 배경색 */
}
/* 스크롤바의 슬라이더(바) 스타일 설정 */
#myhouse-row::-webkit-scrollbar-thumb {
	background: #888; /* 스크롤바 슬라이더의 배경색 */
}
.btn {
	width: 65px;
	height: 25px;
	padding: 0px;
}
/* 스크롤바 없애기; */
/*
	#myhouse-row::-webkit-scrollbar {
    width: 0.5em;
    background-color: transparent;
	}
	#myhouse-row::-webkit-scrollbar-thumb {
		background-color: transparent;
	}
	*/
.card {
	margin-left: 20px;
	width: 500px;
	height: 200px;
}
.img-fluid {
	border-radius: 5px;
	display: flex;
	align-items: center;
	width: 150px;
	height: 150px;
}
.myhouse-img-div {
	padding: 0px;
	margin-left: 12px;
	width: 150px;
	height: 200px;
	display: flex;
	align-items: center;
}
.card-body {
	height: 200px;
}
.card-text {
	margin-bottom: 7px;
}
#pagingArea {
	width: fit-content;
	margin: auto;
}
.pagination {
	padding-top: 15px;
}
.card-form {
	display: flex;
	justify-content: center;
	margin-top: 5px;
}
.card-form form {
	width: 65px;
	height: 25px;
	padding: 0px;
	margin-left: 5px;
}
</style>
</head>
<body>
	<jsp:include page="/WEB-INF/views/common/header.jsp" />
	<%@ include file="/WEB-INF/views/member/mypage/mypage-header.jsp"%>
	<div id="myhouse-container" class="container">
		<div id="myhouse-row" class="row">
			<c:choose>
				<c:when test="${empty list}">
					<h3 style="text-align: center;">등록된 하우스가 없습니다.</h3>
				</c:when>
				<c:otherwise>
					<c:forEach var="h" items="${ list }">
						<div class="card mb-3">
							<a href="/detail.ho?hno= + ${h.houseNo}">
								<div class="row myhouse-card">
									<div class="col-md-4 myhouse-img-div">
										<img id="myhouse-img"
											src="/resources/img/house/uploadFiles/${h.changeName}"
											class="img-fluid">
									</div>
									<div class="col-md-8">
										<div class="card-body text-center">
											<h5 class="card-title">${h.houseName}</h5>
											<p class="card-text">${h.houseAddress}</p>
									<c:choose>
									    <c:when test="${h.enrollStatus eq '등록완료'}">
									        <c:choose>
													<c:when test="${h.rent == 0}">
														<p class="card-text">${(h.deposit/10000).intValue()}만원
															/ 없음</p>
													</c:when>
													<c:otherwise>
														<p class="card-text">${(h.deposit/10000).intValue()}만원
															/ ${(h.rent/10000).intValue()}만원</p>
													</c:otherwise>
												</c:choose>
									    </c:when>
									    <c:otherwise>
									        <c:choose>
									            <c:when test="${h.enrollStatus eq '심사완료' && h.age > 0}">
									                <c:choose>
									                    <c:when test="${h.deposit == 0}">
									                        <p class="card-text">없음 / ${(h.rent/10000).intValue()}만원</p>
									                    </c:when>
									                    <c:otherwise>
									                        <p class="card-text">${(h.deposit/10000).intValue()}만원 / ${(h.rent/10000).intValue()}만원</p>
									                    </c:otherwise>
									                </c:choose>
									            </c:when>
									            <c:when test="${h.enrollStatus eq '심사완료' && h.deposit == 0}">
									                <p class="card-text">없음 / ${(h.rent/10000).intValue()}만원</p>
									            </c:when>
									            <c:otherwise>
									                <p class="card-text">${h.enrollStatus}</p>
									            </c:otherwise>
									        </c:choose>
									    </c:otherwise>
									</c:choose>
											<p class="card-text">${ h.houseDate }</p>
											<div class="card-form">
												<form action="/myhouseRez.ho" method="post">
													<input type="hidden" name="houseNo" value="${h.houseNo}">
													<c:if test="${h.enrollStatus eq '등록완료'}">
														<button type="submit" class="btn btn-primary btn-sm">예약확인</button>
													</c:if>
													<c:if test="${h.enrollStatus eq '심사완료'}">
														<c:choose>
															<c:when test="${h.age > 0}">
																<button type="submit" class="btn btn-primary btn-sm">예약확인</button>
															</c:when>	
															<c:when test="${h.deposit == 0}">
																<button type="submit" class="btn btn-primary btn-sm">예약확인</button>
															</c:when>
															<c:otherwise>
																<button type="button" class="btn btn-primary btn-sm"
																	onclick="Payment('${h.houseNo}')">결제하기</button>
															</c:otherwise>
														</c:choose>
													</c:if>
												</form>
												<form action="/houseEdit.ho" method="post"
													onsubmit="return confirm('수정하시겠습니까?');">
													<input type="hidden" name="hno" value="${h.houseNo}">
													<button type="submit" class="btn btn-success  btn-sm">수정</button>
												</form>
												<form action="/delete.ho" method="post"
													onsubmit="return confirm('정말 삭제하시겠습니까?');">
													<input type="hidden" name="hno" value="${h.houseNo}">
													<button type="submit" class="btn btn-danger btn-sm">삭제</button>
												</form>
											</div>
										</div>
									</div>
								</div>
							</a>
						</div>
					</c:forEach>
				</c:otherwise>
			</c:choose>
		</div>
	</div>
	<c:if test="${not empty list}">
		<div id="pagingArea">
			<ul class="pagination">
				<c:choose>
					<c:when test="${pi.currentPage eq 1}">
						<li class="page-item disabled"><a class="page-link" href="#">Previous</a></li>
					</c:when>
					<c:otherwise>
						<li class="page-item"><a class="page-link"
							href="house?cPage=${pi.currentPage - 1}">Previous</a></li>
					</c:otherwise>
				</c:choose>
				<c:forEach var="p" begin="${pi.startPage}" end="${pi.endPage}"
					step="1">
					<li class="page-item"><a class="page-link"
						href="house?cPage=${p}">${p}</a></li>
				</c:forEach>
				<c:choose>
					<c:when test="${pi.currentPage eq pi.maxPage}">
						<li class="page-item disabled"><a class="page-link" href="#">Next</a></li>
					</c:when>
					<c:otherwise>
						<li class="page-item"><a class="page-link"
							href="house?cPage=${pi.currentPage + 1}">Next</a></li>
					</c:otherwise>
				</c:choose>
			</ul>
		</div>
	</c:if>
	<jsp:include page="/WEB-INF/views/common/footer.jsp" />
</body>
<script>
	function Payment(houseNo, tid) {
		event.preventDefault();
		var hno = houseNo;
		$.ajax({
			url : '/kakaopay.cls',
			type : 'POST',
			data : {
				hno : hno
			},
			dataType : "json",
			success : function(data) {
				console.log(data.tid);
				var box = data.next_redirect_pc_url;
				window.open(box);
			},
			error : function(error) {
				alert(error);
			}
		});
	}
</script>
</html>