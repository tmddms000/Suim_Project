<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<style>
	#inrBoardList {text-align:center;}
	#inrBoardList>tbody>tr:hover {
		cursor:pointer;
		background-color: #d3d3d3; 
		box-shadow: 0 2px 4px rgba(0, 0, 0, 0.2);
	}
	#pagingArea {width:fit-content; margin:auto;}
	.searchForm>form>input{
		width:150px!important;
		display:inline-block;
	}
	.searchForm>form>button {border:none!important;}
	.searchForm>form>div {display:inline-block;}
	#modification, #deleteControl{
		background-color: #FA6B6F;
		color : white;
	    text-decoration: none;
	    border : none;
	    border-radius : 5px;
	    padding : 2px 10px;
	}
	.delConDiv{
		text-align: right;
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
                            <h6 class="mb-4">이용후기 게시판 관리</h6>

							<div align="right" class="searchForm">
							<form class="d-md-flex ms-4" action="/adminInrSearch.bo" method="get">
								<div class="select">
				                    <select class="form-select form-select-sm mb-3" name="condition" style="margin-bottom: unset !important;">
				                        <option value="inrTitle">제목</option>
				                        <option value="memberId">ID</option>
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
									<a class="nav-link" data-toggle="tab" href="adminInReviewList.bo">전체</a>
								</li>
								<li class="nav-item">
									<a class="nav-link" data-toggle="tab" href="adminInReviewList.bo?currentPage=1&category=Y">등록</a>
								</li>
								<li class="nav-item">
									<a class="nav-link" data-toggle="tab" href="adminInReviewList.bo?currentPage=1&category=N">삭제</a>
								</li>
							</ul>
								
								
                            <div class="tab-content pt-3" id="nav-tabContent">
                                <div class="tab-pane fade show active" id="nav-home" role="tabpanel" aria-labelledby="nav-home-tab">
									<div class="table-responsive">
										<form action="/adminInrDelete.bo" method="post" >
		                                <table class="table" id="inrBoardList">
		                                    <thead>
		                                        <tr>
		                                            <th scope="col"><input class="form-check-input" type="checkbox" id="selectAll_A"></th>
		                                            <th scope="col">번호</th>
		                                            <th scope="col">제목</th>
		                                            <th scope="col">작성자</th>
		                                            <th scope="col">작성일</th>
		                                            <th scope="col">삭제상태</th>
		                                            <th scope="col">글수정</th>
		                                        </tr>
		                                    </thead>
		                                    <tbody>
		                                    <c:choose>
			                                    <c:when test="${ not empty list }">
			                                    	<c:forEach var="i" items="${ list }">
				                    					<tr>
					                                      	<td scope="row"><input class="form-check-input" type="checkbox" name="checkboxName" value="${i.inrNo}"></td>
					                                        <td class="ino">${ i.inrNo }</td>
					                                        <td>${ i.inrTitle }</td>
					                                        <td>${ i.memberId }</td>
					                                        <td>${ i.inrDate }</td>
																<c:if test="${i.status eq 'Y'}">
																    <td>등록</td>
																</c:if>
																<c:if test="${i.status eq 'N'}">
																    <td>삭제</td>
																</c:if>						                                        
															<td>
																<a href="/adminInrUpdateForm.bo?ino=${i.inrNo}">
																	<input id="modification" type="button" value="수정">
																</a>
					                                        </td>
					                                    </tr>
				                                	</c:forEach>
				                                </c:when>
				                            	<c:otherwise>
				                            		<tr>
				                            			<td colspan="7">조회된 게시글이 없습니다.</td>
				                            		</tr>
				                            	</c:otherwise>
				                            </c:choose>
		                                    </tbody>
	                                	</table>
	                                	<div class="delConDiv">
		                                	<input type="submit" id="deleteControl" name="deleteControl" value="삭제">
		                                	<input type="submit" id="deleteControl" name="deleteControl" value="복구">
		                                </div>	
	                                </form>
                            	</div>
                        </div>
                    </div>

                </div>
            </div>
            <!-- Table End -->

            <script>
            
            $(function() {
                if (${ not empty list }) {
	                $("#inrBoardList>tbody>tr").on("click", function(event) {
	                    if (event.target.type !== "checkbox") {
	                        let ino = $(this).children(".ino").text();
	                        location.href = "adminInrDetail.bo?ino=" + ino;
	                    }
	                });
                }
            });
            
            
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

       
             	// 전체선택 체크박스 클릭 이벤트
        	    $(document).on('change', 'thead input[type="checkbox"]', function() {
        	        var checkboxes = $('tbody input[type="checkbox"]');
        	        checkboxes.prop('checked', this.checked);
        	    });
        	});
            </script>
			<br>
			
			<c:if test="${empty param.keyword}">
				<nav id="pagingArea" style="margin-top: 30px; margin-bottom: 30px;">
					<ul class="pagination justify-content-center">
						<li class="page-item ${pi.currentPage == 1 ? 'disabled' : ''}">
							<a class="page-link" href="<c:url value='adminInReviewList.bo?currentPage=${pi.currentPage - 1}&category=${category}'/>">&lt;</a>
						</li>
						<c:forEach var="p" begin="${pi.startPage}" end="${pi.endPage}" step="1">
							<li class="page-item ${pi.currentPage == p ? 'active' : ''}">
								<a class="page-link" href="<c:url value='adminInReviewList.bo?currentPage=${p}&category=${category}'/>">${p}</a>
							</li>
						</c:forEach>
						<li class="page-item ${pi.currentPage == pi.maxPage || pi.listCount == 0 ? 'disabled' : ''}">
							<a class="page-link" href="<c:url value='adminInReviewList.bo?currentPage=${pi.currentPage + 1}&category=${category}'/>">&gt;</a>
						</li>
					</ul>
				</nav>
			</c:if>
			<c:if test="${not empty param.keyword}">
				<nav id="pagingArea" style="margin-top: 30px; margin-bottom: 30px;">
					<ul class="pagination justify-content-center">
						<li class="page-item ${pi.currentPage == 1 ? 'disabled' : ''}">
							<a class="page-link" href="<c:url value='adminInrSearch.bo?currentPage=${pi.currentPage - 1}&category=${category}&keyword=${keyword}&condition=${condition}'/>">&lt;</a>
						</li>
						<c:forEach var="p" begin="${pi.startPage}" end="${pi.endPage}" step="1">
							<li class="page-item ${pi.currentPage == p ? 'active' : ''}">
								<a class="page-link" href="<c:url value='adminInrSearch.bo?currentPage=${p}&category=${category}&keyword=${keyword}&condition=${condition}'/>">${p}</a>
							</li>
						</c:forEach>
						<li class="page-item ${pi.currentPage == pi.maxPage || pi.listCount == 0 ? 'disabled' : ''}">
							<a class="page-link" href="<c:url value='adminInrSearch.bo?currentPage=${pi.currentPage + 1}&category=${category}&keyword=${keyword}&condition=${condition}'/>">&gt;</a>
						</li>
					</ul>
				</nav>
			</c:if>
			
            <br clear="both"><br>
            
            <!-- Footer Start -->
			<%@ include file="../common/footer.jsp" %>
            <!-- Footer End -->
        </div>
        <!-- Content End -->

	</div>
	
	<script>
	    var alertMsg = '<%= session.getAttribute("alertMsg") %>';
	    if (alertMsg && alertMsg !== "null" && alertMsg !== "") {
	        alert(alertMsg);
	        <% session.removeAttribute("alertMsg"); %>
	    }
	</script>
            