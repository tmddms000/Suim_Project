<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<style>
	#memberList {text-align:center;}
	#memberList>tbody>tr:hover {cursor:pointer;}
	#pagingArea {width:fit-content; margin:auto;}
	form input {width:150px!important;}
	form button {border:none!important;}
	.searchForm>form>input, .searchForm>form>div {display:inline-block;}
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
            <div class="container-fluid pt-4 px-4">
                <div class="row g-4">
                    
                    <div class="col-12">
                        <div class="bg-light rounded h-100 p-4" width="">
                            <h6 class="mb-4">회원 관리</h6>

							<ul class="nav nav-tabs">
								<li class="nav-item"><a
									class="nav-link <c:if test="${category eq 'A'}">active</c:if>"
									data-toggle="tab" href="/admin/list.me">전체</a></li>
								<li class="nav-item"><a
									class="nav-link <c:if test="${category eq '일반'}">active</c:if>"
									data-toggle="tab" href="/admin/list.me?currentPage=1&category=일반">일반</a></li>
								<li class="nav-item"><a
									class="nav-link <c:if test="${category eq '블랙'}">active</c:if>"
									data-toggle="tab" href="/admin/list.me?currentPage=1&category=블랙">블랙</a></li>
								<li class="nav-item"><a
									class="nav-link <c:if test="${category eq '탈퇴'}">active</c:if>"
									data-toggle="tab" href="/admin/list.me?currentPage=1&category=탈퇴">탈퇴</a></li>
							</ul>

                            <div class="tab-content pt-3" id="nav-tabContent">
                                <div class="tab-pane fade show active" id="nav-home" role="tabpanel" aria-labelledby="nav-home-tab">
		                            <div class="table-responsive">
		                                <table class="table" id="memberList">
		                                    <thead>
		                                        <tr>
		                                            <th scope="col"><input class="form-check-input" type="checkbox" value=""></th>
		                                            <th scope="col">닉네임</th>
		                                            <th scope="col">아이디</th>
		                                            <th scope="col">이메일</th>
		                                            <th scope="col">연락처</th>
		                                            <th scope="col">가입일</th>
		                                            <th scope="col">상태</th>
		                                        </tr>
		                                    </thead>
		                                    <tbody>
		                                    	<c:forEach var="m" items="${ list }">
		                    						<tr data-id="${m.memberId}">
			                                            <td scope="row"><input class="form-check-input" type="checkbox" value=""></td>
			                                            
			                                            <td>${ m.nickName }</td>
			                                            <td class="memberId">${ m.memberId }</td>
			                                            <td>${ m.email }</td>
			                                            <td>${ m.phone }</td>
			                                            <td><fmt:formatDate value="${m.enrollDate}" pattern="yyyy-MM-dd" /></td>
			                                            <td>
												            <c:choose>
												                <c:when test="${m.status eq '탈퇴'}">
												                    <span class="badge bg-danger">탈퇴회원</span>
												                </c:when>
												                <c:when test="${m.status eq '블랙'}">
												                    <span class="badge bg-dark">블랙회원</span>
												                </c:when>
												                <c:otherwise>
												                    <span class="badge bg-success">일반회원</span>
												                </c:otherwise>
												            </c:choose>
												        </td>
			                                        </tr>
			                                	</c:forEach>
		                                    </tbody>
		                                </table>
		                                <div align="center">
										    <a class="btn btn-primary withdraw">탈퇴</a>
										    <a class="btn btn-primary general">일반</a>
										</div>
										<br><br>
							
		                            </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <!-- Table End -->

            <script>
				$(document).ready(function() {
	            	
	        	    // 전체선택 체크박스 클릭 이벤트
	        	    $(document).on('change', 'thead input[type="checkbox"]', function() {
	        	        var checkboxes = $('tbody input[type="checkbox"]');
	        	        checkboxes.prop('checked', this.checked);
	        	    });
	
	        	    // 개별 체크박스 클릭 이벤트
	        	    $(document).on('change', 'tbody input[type="checkbox"]', function() {
	        	        var selectAllCheckbox = $('thead input[type="checkbox"]');
	        	        selectAllCheckbox.prop('checked', $('tbody input[type="checkbox"]:checked').length === $('tbody input[type="checkbox"]').length);
	        	    });
				
	        	    // 탈퇴 버튼 클릭 이벤트
	        	    $(document).on('click', 'a.withdraw', function() {
	        	        var checkedCheckboxes = $('tbody input[type="checkbox"]:checked');
	        	        var updateIds = [];
	
	        	        checkedCheckboxes.each(function() {
	        	            var memberId = $(this).closest('tr').data('id');
	        	            updateIds.push(memberId);
	        	        });
	        	        
	        	        if (updateIds.length === 0) {
	        	            alert("탈퇴할 회원을 선택해주세요.");
	        	            return;
	        	        }
	        	        
	        	        var withdraw = confirm("탈퇴하시겠습니까?");
	        	        if (!withdraw) {
	        	            return;
	        	        }
	
	        	        // 탈퇴 처리를 위한 Ajax 요청
	        	        $.ajax({
	        	            type: "POST",
	        	            url: "/admin/updateStatusAll.me",
	        	            data: {
	        	            	memberId : updateIds.join(","),
	        	                memberStatus : '탈퇴'
	        	            },
	        	            success: function(response) {
	        	            	// 응답 받은 경우
	        	                // 화면에서 해당 데이터의 상태 업데이트
	        	                if (response === 'Y') {
	        	                	alert("탈퇴되었습니다.");
	        		            	location.reload();
	        		            } else {
	        		            	alert("회원 탈퇴에 실패했습니다.");
	        		            }
	        	            },
	        	            error: function() {
	        	            	alert("회원 탈퇴에 실패했습니다.");
	        	            }
	        	            
	        	        });
	        	    });
	        	    
	        	 	// 일반 버튼 클릭 이벤트
	        	    $(document).on('click', 'a.general', function() {
	        	        var checkedCheckboxes = $('tbody input[type="checkbox"]:checked');
	        	        var updateIds = [];
	
	        	        checkedCheckboxes.each(function() {
	        	            var memberId = $(this).closest('tr').data('id');
	        	            updateIds.push(memberId);
	        	        });
	        	        
	        	        if (updateIds.length === 0) {
	        	            alert("일반으로 변경할 회원을 선택해주세요.");
	        	            return;
	        	        }
	        	        
	        	        var general = confirm("일반 회원으로 변경하시겠습니까?");
	        	        if (!general) {
	        	            return;
	        	        }
	
	        	        // 일반 처리를 위한 Ajax 요청
	        	        $.ajax({
	        	            type: "POST",
	        	            url: "/admin/updateStatusAll.me",
	        	            data: {
	        	            	memberId : updateIds.join(","),
	        	                memberStatus : '일반'
	        	            },
	        	            success: function(response) {
	        	            	// 응답 받은 경우
	        	                // 화면에서 해당 데이터의 상태 업데이트
	        	                if (response === 'Y') {
	        	                	alert("일반회원으로 변경되었습니다.");
	        		            	location.reload();
	        		            } else {
	        		            	alert("일반회원 변경에 실패했습니다.");
	        		            }
	        	            },
	        	            error: function() {
	        	            	alert("일반회원 변경에 실패했습니다.");
	        	            }
	        	            
	        	        });
	        	    });
	        	    
                    // 상세 페이지로 이동용
                    $("#memberList>tbody>tr").click(function(e) {
                        if ($(e.target).is('input[type="checkbox"]')) {
                            e.stopPropagation();
                        } else {
                            var id = $(this).children(".memberId").text();
                            location.href = "detail.me?id=" + id;
                        }
                    });
                	
                 	// 전체선택 체크박스 클릭 이벤트
            	    $(document).on('change', 'thead input[type="checkbox"]', function() {
            	        var checkboxes = $('tbody input[type="checkbox"]');
            	        checkboxes.prop('checked', this.checked);
            	    });
			});
	                
            </script>

			<br>
			<nav id="pagingArea" style="margin-top: 30px; margin-bottom: 30px;">
				<ul class="pagination justify-content-center">
					<li class="page-item ${pi.currentPage == 1 ? 'disabled' : ''}">
						<a class="page-link" href="<c:url value='/admin/list.me?currentPage=${pi.currentPage - 1}&category=${category}'/>">&lt;</a>
					</li>
					<c:forEach var="p" begin="${pi.startPage}" end="${pi.endPage}" step="1">
						<li class="page-item ${pi.currentPage == p ? 'active' : ''}">
							<a class="page-link" href="<c:url value='/admin/list.me?currentPage=${p}&category=${category}'/>">${p}</a>
						</li>
					</c:forEach>
					<li class="page-item ${pi.currentPage == pi.maxPage || pi.listCount == 0 ? 'disabled' : ''}">
						<a class="page-link" href="<c:url value='/admin/list.me?currentPage=${pi.currentPage + 1}&category=${category}'/>">&gt;</a>
					</li>
				</ul>
			</nav>

            <br clear="both"><br>
            
            
            <!-- Footer Start -->
			<%@ include file="../common/footer.jsp" %>
            <!-- Footer End -->
        </div>
        <!-- Content End -->

	</div>
