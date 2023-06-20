<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<style>
	#houseList {text-align:center;}
	#houseList>tbody>tr:hover {cursor:pointer;}
	#pagingArea {width:fit-content; margin:auto;}
	form input {width:150px!important;}
	form button {border:none!important;}
	.searchForm>form>input, .searchForm>form>div {display:inline-block;}
	.searchForm{
	    display: flex;
	    align-items: center;
	    background-color: #f5f5f5;
	    border-radius: 20px;
	    padding: 10px 20px;
	    justify-content: flex-end;
	}
}
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
                            <h6 class="mb-4">쉐어하우스 관리</h6>

							<div align="right" class="searchForm">
								<form class="d-md-flex ms-4" action="search.ho">
									<div class="select">
					                    <select class="form-select form-select-sm mb-3" name="condition" style="margin-bottom: unset !important; height: 36px;">
					                        <option value="HOUSE_NAME">쉐어하우스 이름</option>
					                        <option value="RES_GENDER">주거성별</option>
					                        <option value="RES_TYPE">주거유형</option>
					                    </select>
					                </div>
									<input class="form-control border-0" type="search" placeholder="Search" name="keyword">
	                       		 	<button type="submit">
	                                    <i class="fa fa-search" style="color : rgb(249,88,10)"></i>
	                                </button>
	                    		</form>
							</div>
							
							<ul class="nav nav-tabs">
								<li class="nav-item">
									<a class="nav-link <c:if test="${category eq '전체'}">active</c:if>"
									data-toggle="tab" href="/admin/list.ho">전체</a>
								</li>
								<li class="nav nav-tabs">
									<a class="nav-link <c:if test="${category eq '심사중'}">active</c:if>"
									data-toggle="tab" href="/admin/list.ho?currentPage=1&category=심사중">심사중</a>
								</li>
								<li class="nav nav-tabs">
									<a class="nav-link <c:if test="${category eq '심사완료'}">active</c:if>"
									data-toggle="tab" href="/admin/list.ho?currentPage=1&category=심사완료">심사완료</a>
								</li>
								<li class="nav nav-tabs">
									<a class="nav-link <c:if test="${category eq '반려'}">active</c:if>"
									data-toggle="tab" href="/admin/list.ho?currentPage=1&category=반려">반려</a>
								</li>
								<li class="nav nav-tabs">
									<a class="nav-link <c:if test="${category eq '등록완료'}">active</c:if>"
									data-toggle="tab" href="/admin/list.ho?currentPage=1&category=등록완료">등록완료</a>
								</li>
							</ul>
							
                            <div class="tab-content pt-3" id="nav-tabContent">
                                <div class="tab-pane fade show active" id="nav-home" role="tabpanel" aria-labelledby="nav-home-tab">
									<div class="table-responsive">
		                                <table class="table" id="houseList">
		                                    <thead>
		                                        <tr>
		                                            <th scope="col"><input class="form-check-input" type="checkbox" id="selectAll_A"></th>
		                                            <th scope="col" width="">번호</th>
		                                            <th scope="col">쉐어하우스 이름</th>
		                                            <th scope="col">주소</th>
		                                            <th scope="col">보증금</th>
		                                            <th scope="col">월세</th>
		                                            <th scope="col">주거성별</th>
		                                            <th scope="col">주거형태</th>
		                                            <th scope="col">작성자</th>
		                                        </tr>
		                                    </thead>
		                                    <tbody>
		                                    <c:choose>
			                                    <c:when test="${ not empty list }">
			                                    	<c:forEach var="h" items="${ list }">
			                    						<tr>
				                                            <td scope="row"><input class="form-check-input" type="checkbox" name="checkboxName" data-id="${h.houseNo}"></td>
				                                            <td class="hno">${ h.houseNo }</td>
				                                            <td>${ h.houseName }</td>
				                                            <td>${ h.houseAddress }</td>
				                                            <td>
				                                            	<c:choose>
																	<c:when test="${h.deposit >= 10000000}">
																		<fmt:formatNumber value="${h.deposit/10000}"
																			pattern="###,###'천만원'" />
																	</c:when>
																	<c:otherwise>
																		<fmt:formatNumber value="${h.deposit/10000}" pattern="###'만원'" />
																	</c:otherwise>
																</c:choose>
				                                            </td>
				                                            <td>
				                                            	<c:choose>
																	<c:when test="${h.rent >= 10000000}">
																		<fmt:formatNumber value="${h.rent/10000}"
																			pattern="###,###'천만원'" />
																	</c:when>
																	<c:otherwise>
																		<fmt:formatNumber value="${h.rent/10000}" pattern="###'만원'" />
																	</c:otherwise>
																</c:choose>
				                                            </td>
				                                            <td>${ h.resGender }</td>
				                                            <td>${ h.resType }</td>
				                                            <td>${ h.memberId }</td>
				                                        </tr>
				                                	</c:forEach>
				                                </c:when>
				                            	<c:otherwise>
				                            		<tr>
				                            			<td colspan="8">조회된 게시글이 없습니다.</td>
				                            		</tr>
				                            	</c:otherwise>
				                            </c:choose>
		                                    </tbody>
		                                </table>
		                                <div align="center">
											    <a class="btn btn-primary confirm">승인</a>
											    <a class="btn btn-danger reject">반려</a>
										</div>
										<br><br>
									
										<form id="postForm" action="" method="post">
										    <input type="hidden" name="houseNo" value="${h.houseNo}">
										    <input type="hidden" name="houseStatus" id="houseStatus" value="">
										</form>
										
										<script>
										    function postFormSubmit(value) {
										        var form = document.getElementById("postForm");
												
										        var status = document.getElementById("houseStatus");
										        status.value = value;
										        
										        
										        form.action = "updateStatus.ho";
							
										        form.submit();
										    }
										</script>
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
            	
            	var newStatus = 'Y'; // 승인 처리 후 변경할 값
            	
            	
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


				
        	    // 승인 버튼 클릭 이벤트
        	    $(document).on('click', 'a.confirm', function() {
        	        var checkedCheckboxes = $('tbody input[type="checkbox"]:checked');
        	        var updateStatuses = [];

        	        checkedCheckboxes.each(function() {
        	        	updateStatuses.push($(this).data('id'));
        	        });
        	        console.log(updateStatuses);
        	               	        
        	        if (updateStatuses.length === 0) {
        	            alert("승인할 게시글을 선택해주세요.");
        	            return;
        	        }
        	        
        	        var confirmation = confirm("승인하시겠습니까?");
        	        if (!confirmation) {
        	            return;
        	        }

        	        // 승인 처리를 위한 Ajax 요청
        	        $.ajax({
        	            type: "POST",
        	            url: "/admin/updateStatusAll.ho",
        	            data: {
        	            	houseNo : updateStatuses.join(","),
        	                houseStatus : '심사완료'
        	            },
        	            success: function(response) {
        	            	// 응답 받은 경우
        	                // 화면에서 해당 데이터의 상태 업데이트
        	                if (response === 'Y') {
        	                	alert("승인되었습니다.");
        		            	location.reload();
        		            } else {
        		            	alert("승인에 실패했습니다.");
        		            }
        	            },
        	            error: function() {
        	            	alert("승인에 실패했습니다.");
        	            }
        	            
        	        });
        	    });
        	
	         	// 반려 버튼 클릭 이벤트
	    	    $(document).on('click', 'a.reject', function() {
	    	        var checkedCheckboxes = $('tbody input[type="checkbox"]:checked');
	    	        var updateStatuses = [];
	
	    	        checkedCheckboxes.each(function() {
	    	        	updateStatuses.push($(this).data('id'));
	    	        });
	    	               	        
	    	        if (updateStatuses.length === 0) {
	    	            alert("반려할 게시글을 선택해주세요.");
	    	            return;
	    	        }
	    	        
	    	        var confirmation = confirm("반려하시겠습니까?");
	    	        if (!confirmation) {
	    	            return;
	    	        }
	
	    	        // 반려 처리를 위한 Ajax 요청
	    	        $.ajax({
	    	            type: "POST",
	    	            url: "/admin/updateStatusAll.ho",
	    	            data: {
	    	            	houseNo : updateStatuses.join(","),
	    	                houseStatus : '반려'
	    	            },
	    	            success: function(response) {
	    		            if(response === 'Y') {
	    		            	alert("반려되었습니다.");
	    		            	location.reload();
	    		            } else {
	    		            	alert("반려에 실패했습니다.");
	    		            }
	    	            },
	    	            error: function() {
	    	            	alert("반려에 실패했습니다.");
	    	            }
	    	        });
	    	    });
    		});
    	
            $(document).ready(function(){
                // 상세 페이지로 이동용
                $("#houseList>tbody>tr").click(function(e) {
                	var admin = admin;
                	
                    if ($(e.target).is('input[type="checkbox"]')) {
                        e.stopPropagation();
                    } else {
                        var hno = $(this).children(".hno").text();
                        location.href = "/detail.ho?hno=" + hno + "&admin=" + admin;
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
						<a class="page-link" href="<c:url value='/admin/list.ho?currentPage=${pi.currentPage - 1}&category=${category}'/>">&lt;</a>
					</li>
					<c:forEach var="p" begin="${pi.startPage}" end="${pi.endPage}" step="1">
						<li class="page-item ${pi.currentPage == p ? 'active' : ''}">
							<a class="page-link" href="<c:url value='/admin/list.ho?currentPage=${p}&category=${category}'/>">${p}</a>
						</li>
					</c:forEach>
					<li class="page-item ${pi.currentPage == pi.maxPage || pi.listCount == 0 ? 'disabled' : ''}">
						<a class="page-link" href="<c:url value='/admin/list.ho?currentPage=${pi.currentPage + 1}&category=${category}'/>">&gt;</a>
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
            