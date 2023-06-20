<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<style>
	.memberTableLeft{
		display: inline-block;
		float: left;
	}
	.memberTableRight{
		display: inline-block;
		float: right;
	}
	.table>tbody>tr{cursor:pointer;}
</style>

	<%@ include file="../common/include.jsp" %>  
    
	<div class="container-xxl position-relative bg-white d-flex p-0">
	
	    <!-- Spinner Start -->
		<%@ include file="../common/spinner.jsp" %>
        <!-- Spinner End -->


        <!-- Sidebar Start -->
		<%@ include file="../common/sidebar.jsp" %>
        <!-- Sidebar End -->


        <!-- Content Start -->
        <div class="content">

            <!-- Navbar Start -->
			<%@ include file="../common/navbar.jsp" %>
            <!-- Navbar End -->
	
	            <!-- Table Start -->
	            <br><br>
	            <div class="innerOuter">
                <h2>회원 정보 보기</h2>
                <br>


				<!-- 테이블 시작 -->
				<div class="container-fluid pt-4 px-4">
	                <div class="row g-4">
		                <div class="col-12">
	                        <div class="bg-light rounded h-100 p-4">
	                            <h6 class="mb-4">회원 정보 보기</h6>
	                            
	                            <ul class="nav nav-tabs">
									<li class="nav-item">
										<a class="nav-link <c:if test="${category eq 'info'}">active</c:if>"
										data-toggle="tab" href="/admin/detail.me?id=${ id }&category=info">회원 정보</a>
									</li>
									<li class="nav-item">
										<a class="nav-link <c:if test="${category eq 'house'}">active</c:if>"
										data-toggle="tab" href="/admin/detail.me?id=${ id }&category=house" data-category="house">가맹 신청 내역</a>
									</li>
									<li class="nav-item">
										<a class="nav-link <c:if test="${category eq 'board'}">active</c:if>"
										data-toggle="tab" href="/admin/detail.me?id=${ id }&category=board" data-category="board">자유게시판</a>
									</li>
									<li class="nav-item">
										<a class="nav-link <c:if test="${category eq 'find'}">active</c:if>"
										data-toggle="tab" href="/admin/detail.me?id=${ id }&category=find" data-category="find">사람구해요</a>
									</li>
									<li class="nav-item">
										<a class="nav-link <c:if test="${category eq 'inreview'}">active</c:if>"
										data-toggle="tab" href="/admin/detail.me?id=${ id }&category=inreview" data-category="inreview">입주후기</a>
									</li>
								</ul>
								
	                            <div class="tab-content pt-3" id="nav-tabContent">
	                                <div class="tab-pane fade show active" id="nav-home" role="tabpanel" aria-labelledby="nav-home-tab">
										<br>
											<!-- 회원 정보 카테고리에 해당하는 테이블 형식 -->
											<div class="table-responsive" align="center">
												<c:choose>
													<c:when test="${ category eq 'info' }">
													<!-- 왼쪽 테이블 -->
				                					<div class="col-sm-12 col-xl-6 memberTableLeft">
						                                <table class="table" id="memberList">
					                                        <tr>
					                                            <th scope="col" width="200">이름</th>
					                                            <td>${ m.memberName }</td>
					                                        </tr>
					                                        <tr>
					                                            <th scope="row">닉네임</th>
					                                            <td>${ m.nickName }</td>
					                                        </tr>
					                                        <tr>
					                                            <th scope="row">전화번호</th>
					                                            <td>${ m.phone }</td>
					                                        </tr>
					                                        <tr>
					                                            <th scope="row">이메일</th>
					                                            <td>${ m.email }</td>
					                                        </tr>
					                                        <tr>
					                                            <th scope="row">성별</th>
					                                            <td>${ m.gender }</td>
					                                        </tr>
					                                        <c:choose>
							                                    <c:when test="${ not empty m.area }">
							                                        <tr>
							                                            <th scope="row">선호지역</th>
							                                            <td>${ m.area }</td>
							                                        </tr>
							                                    </c:when>
									                            <c:otherwise>
								                            		<tr>
							      			                      		<th scope="row">선호지역</th>
								                            			<td colspan="8">선택한 선호지역이 없습니다.</td>
								                            		</tr>
								                            	</c:otherwise>
								                            </c:choose>
					                                        <tr>
					                                            <th scope="row">생년월일</th>
					                                            <td>${ m.birth }</td>
					                                        </tr>
					                                        <tr>
					                                            <th scope="row">가입일</th>
					                                            <td>${ m.enrollDate }</td>
					                                        </tr>
					                                        <tr>
					                                            <th scope="row">회원 정보 수정 날짜</th>
					                                            <td>${ m.modifyDate }</td>
					                                        </tr>
					                                        <tr>
					                                            <th scope="row">최근 로그인 날짜</th>
					                                            <td>${ m.loginDate }</td>
					                                        </tr>
					                                        <tr>
					                                            <th scope="row">상태</th>
					                                            <td>${ m.status }</td>
					                                        </tr>
						                                </table>
						                        	</div>
						                        	<!-- 오른쪽 테이블 -->
						                			<div class="col-sm-12 col-xl-6 memberTableRight">
						                                <table class="table" style="border-bottom: #F3F6F9;">
						                                    <tr>
					                                            <th scope="row">프로필 사진</th>
					                                            <c:choose>
													        		<c:when test="${not empty m.changeName}">
								                                		<td><img src="${ m.changeName }" style="border-radius:200px;width:280;height:280;"></img></td>
								                                	</c:when>
															        <c:otherwise>
															            <td><img src="/resources/img/common/default_profile.png" style="border-radius:200px; width:280;height:280;"></img></td>
															        </c:otherwise>
															    </c:choose>
					                                        </tr>
						                                </table>
						                        	</div>
												</c:when>
												

												<c:when test="${ category eq 'house' }">
													<div class="tab-content">
														<div class="tab-pane fade <c:if test="${category eq 'house'}">show active</c:if>" id="" role="tabpanel">
															<table class="table">
							                                    <thead>
							                                        <tr>
							                                        	<th scope="col">번호</th>
							                                            <th scope="col">이름</th>
							                                            <th scope="col">주소</th>
							                                            <th scope="col">보증금</th>
							                                            <th scope="col">월세</th>
							                                            <th scope="col">주거성별</th>
							                                            <th scope="col">작성일</th>
							                                        </tr>
							                                    </thead>
							                                    <tbody>
								                                    <c:choose>
									                                    <c:when test="${ not empty list }">
									                                    	<c:forEach var="h" items="${ list }">
									                    						<tr>
																				    <td class="no"><c:out value="${h.HOUSE_NO}" /></td>
																				    <td><c:out value="${h.HOUSE_NAME}" /></td>
																				    <td><c:out value="${h.HOUSE_ADDRESS}" /></td>
																				    <td><c:out value="${h.DEPOSIT}" /></td>
																				    <td><c:out value="${h.RENT}" /></td>
																				    <td><c:out value="${h.RES_GENDER}" /></td>
																				    <td><fmt:formatDate value="${h.HOUSE_DATE}" pattern="yyyy-MM-dd" /></td></td>
										                                        </tr>
										                                	</c:forEach>
										                                </c:when>
											                            <c:otherwise>
										                            		<tr>
										                            			<td colspan="8" align="center">조회된 게시글이 없습니다.</td>
										                            		</tr>
										                            	</c:otherwise>
										                            </c:choose>
							                                    </tbody>
					                                		</table>
													  	</div>
													</div>
												</c:when>
												
												<c:when test="${ category eq 'board' }">
													<div class="tab-content">
														<div class="tab-pane fade <c:if test="${category eq 'board'}">show active</c:if>" id="" role="tabpanel">
															<table class="table">
							                                    <thead>
							                                        <tr>
							                                        	<th scope="col">번호</th>
							                                            <th scope="col">제목</th>
							                                            <th scope="col">조회수</th>
							                                            <th scope="col">등록일</th>
							                                            <th scope="col">등록상태</th>
							                                        </tr>
							                                    </thead>
							                                    <tbody>
							                                    <c:choose>
								                                    <c:when test="${ not empty list }">
								                                    	<c:forEach var="b" items="${ list }">
								                    						<tr>
								                    							<td class="no">${ b.BOARD_NO }</td>
									                                            <td>${ b.BOARD_TITLE }</td>
									                                            <td>${ b.BOARD_VIEW }</td>
									                                            <td><fmt:formatDate value="${b.BOARD_DATE}" pattern="yyyy-MM-dd" /></td>
									                                            <td>
									                                            	<c:choose>
									                                            		<c:when test="${ b.STATUS eq 'Y'}">
									                                            		등록
									                                            		</c:when>
									                                            		<c:when test="${ b.STATUS eq 'N'}">
									                                            		삭제
									                                            		</c:when>
									                                            	</c:choose>
									                                            </td>
									                                        </tr>
									                                	</c:forEach>
									                                </c:when>
										                            <c:otherwise>
									                            		<tr>
									                            			<td colspan="8" align="center">조회된 게시글이 없습니다.</td>
									                            		</tr>
									                            	</c:otherwise>
									                            </c:choose>
							                                    </tbody>
					                                		</table>
													  	</div>
													</div>
												</c:when>
												
												<c:when test="${ category eq 'find' }">
													<div class="tab-content">
														<div class="tab-pane fade <c:if test="${category eq 'find'}">show active</c:if>" id="" role="tabpanel">
															<table class="table">
							                                    <thead>
							                                        <tr>
							                                        	<th scope="col">번호</th>
							                                            <th scope="col">제목</th>
							                                            <th scope="col">카테고리</th>
							                                            <th scope="col">조회수</th>
							                                            <th scope="col">등록일</th>
							                                            <th scope="col">상태</th>
							                                        </tr>
							                                    </thead>
							                                    <tbody>
							                                    <c:choose>
								                                    <c:when test="${ not empty list }">
								                                    	<c:forEach var="f" items="${ list }">
								                    						<tr>
								                    							<td class="no">${ f.FIND_NO }</td>
									                                            <td>${ f.FIND_TITLE }</td>
									                                            <td>${ f.FIND_CATEGORY }</td>
									                                            <td>${ f.FIND_VIEW }</td>
									                                            <td><fmt:formatDate value="${f.FIND_DATE}" pattern="yyyy-MM-dd" /></td>
									                                            <td>
									                                            	<c:choose>
									                                            		<c:when test="${ f.STATUS eq 'Y'}">
									                                            		등록
									                                            		</c:when>
									                                            		<c:when test="${ f.STATUS eq 'N'}">
									                                            		삭제
									                                            		</c:when>
									                                            	</c:choose>
									                                            </td>
									                                        </tr>
									                                	</c:forEach>
									                                </c:when>
										                            <c:otherwise>
									                            		<tr>
									                            			<td colspan="8" align="center">조회된 게시글이 없습니다.</td>
									                            		</tr>
									                            	</c:otherwise>
									                            </c:choose>
							                                    </tbody>
					                                		</table>
													  	</div>
													</div>
												</c:when>
												
												<c:when test="${ category eq 'inreview' }">
													<div class="tab-content">
														<div class="tab-pane fade <c:if test="${category eq 'inreview'}">show active</c:if>" id="" role="tabpanel">
															<table class="table">
							                                    <thead>
							                                        <tr>
							                                        	<th scope="col">번호</th>
							                                            <th scope="col">제목</th>
							                                            <th scope="col">조회수</th>
							                                            <th scope="col">일자</th>
							                                            <th scope="col">상태</th>
							                                        </tr>
							                                    </thead>
							                                    <tbody>
							                                    <c:choose>
								                                    <c:when test="${ not empty list }">
								                                    	<c:forEach var="i" items="${ list }">
								                    						<tr>
								                    							<td class="no">${ i.INR_NO }</td>
									                                            <td>${ i.INR_TITLE }</td>
									                                            <td>${ i.INR_VIEW }</td>
									                                            <td>${ i.INR_DATE }</td>
									                                            <td>
									                                            	<c:choose>
									                                            		<c:when test="${ i.STATUS eq 'Y'}">
									                                            		등록
									                                            		</c:when>
									                                            		<c:when test="${ i.STATUS eq 'N'}">
									                                            		삭제
									                                            		</c:when>
									                                            	</c:choose>
									                                            </td>
									                                        </tr>
									                                	</c:forEach>
									                                </c:when>
										                            <c:otherwise>
									                            		<tr>
									                            			<td colspan="8" align="center">조회된 게시글이 없습니다.</td>
									                            		</tr>
									                            	</c:otherwise>
									                            </c:choose>
							                                    </tbody>
					                                		</table>
													  	</div>
													</div>
												</c:when>
											</c:choose>
				                        </div>
			                        </div>
	                            </div>
	                        </div>
	                    </div>
                	</div>
				</div>
				<!-- 테이블 끝 -->
				<br>
				<div align="center">
                <a class="btn btn-secondary" style="text-align:center;" href="list.me">목록으로</a>
                </div>
            </div>
            <br><br>    
            <!-- Table End -->
			<script>
	            // 상세 페이지로 이동용
	            $(".table>tbody>tr").click(function(e) {
                    var no = $(this).children(".no").text();
                    var category = document.querySelector('.nav-link.active').getAttribute('data-category');
                    
                    if(category.substring(0, 2) === 'ho'){
	                    location.href = "/detail.ho?hno=" + no;
                    } else if(category.substring(0, 2) === 'bo'){
                        location.href = "/detail.bo?bno=" + no;
                    } else if(category.substring(0, 2) === 'fi'){
                        location.href = "/detail.fi?fno=" + no;
                    } else if(category.substring(0, 2) === 'in'){
                        location.href = "/detail.in?ino=" + no;
                    }
	            });
			</script>

            <br>

            <c:choose>
				<c:when test="${listCount ne 0}">

					<nav id="pagingArea" style="margin-top: 30px; margin-bottom: 30px;">
						<ul class="pagination justify-content-center">
							<li class="page-item ${pi.currentPage == 1 ? 'disabled' : ''}">
								<a class="page-link" href="<c:url value='/admin/detail.me?id=${id}&category=${category}&currentPage=${pi.currentPage - 1}'/>">&lt;</a>
							</li>
							<c:forEach var="p" begin="${pi.startPage}" end="${pi.endPage}" step="1">
								<li class="page-item ${pi.currentPage == p ? 'active' : ''}">
									<a class="page-link" href="<c:url value='/admin/detail.me?id=${id}&category=${category}&currentPage=${p}'/>">${p}</a>
								</li>
							</c:forEach>
							<li class="page-item ${pi.currentPage == pi.maxPage || pi.listCount == 0 ? 'disabled' : ''}">
								<a class="page-link" href="<c:url value='/admin/detail.me?id=${id}&category=${category}&currentPage=${pi.currentPage + 1}'/>">&gt;</a>
							</li>
						</ul>
					</nav>


				</c:when>
			</c:choose>

            <br clear="both"><br>
            
            <!-- Footer Start -->
			<%@ include file="../common/footer.jsp" %>
            <!-- Footer End -->
        </div>
        <!-- Content End -->

	</div>
          