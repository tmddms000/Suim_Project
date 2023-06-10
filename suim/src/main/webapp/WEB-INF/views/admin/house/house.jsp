<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<style>
	#houseList {text-align:center;}
	#houseList>tbody>tr:hover {cursor:pointer;}
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
                            <h6 class="mb-4">쉐어하우스 관리</h6>

							<div align="right" class="searchForm">
							<form class="d-md-flex ms-4" action="search.ho">
								<div class="select">
				                    <select class="form-select form-select-sm mb-3" name="condition" style="margin-bottom: unset !important;">
				                        <option value="HOUSE_NAME">이름</option>
				                        <option value="RES_GENDER">성별</option>
				                        <option value="RES_TYPE">유형</option>
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
									<button class="nav-link active" id="A">전체</button>
								</li>
								<li class="nav nav-tabs">
									<button class="nav-link" id="N">대기</button>
								</li>
								<li class="nav nav-tabs">
									<button class="nav-link" id="Y">승인</button>
								</li>
								<li class="nav nav-tabs">
									<button class="nav-link" id="C">반려</button>
								</li>
							</ul>
							
                            <div class="tab-content pt-3" id="nav-tabContent">
                                <div class="tab-pane fade show active" id="nav-home" role="tabpanel" aria-labelledby="nav-home-tab">
									<div class="table-responsive">
		                                <table class="table" id="houseList">
		                                    <thead>
		                                        <tr>
		                                            <th scope="col"><input class="form-check-input" type="checkbox" id="selectAll_A"></th>
		                                            <th scope="col">번호</th>
		                                            <th scope="col">유형</th>
		                                            <th scope="col">제목</th>
		                                            <th scope="col">신청자</th>
		                                            <th scope="col">내용</th>
		                                            <th scope="col">신고일</th>
		                                            <th scope="col">상태</th>
		                                        </tr>
		                                    </thead>
		                                    <tbody>
		                                    <c:choose>
			                                    <c:when test="${ not empty list }">
			                                    	<c:forEach var="h" items="${ list }">
			                    						<tr>
				                                            <td scope="row"><input class="form-check-input" type="checkbox" name="checkboxName"></td>
				                                            <td class="rno">${ h.houseNo }</td>
				                                            <td>${ h.houseName }</td>
				                                            <td>${ h.houseAddress }</td>
				                                            <td>${ h.deposit }</td>
				                                            <td>${ h.rent }</td>
				                                            <td>${ h.enterDate }</td>
				                                            <td>${ h.maxEnterDate }</td>
				                                            <td>${ h.minStay }</td>
				                                            <td>${ h.maxStay }</td>
				                                            <td>${ h.roomPeople }</td>
				                                            <td>${ h.incFurniture }</td>
				                                            <td>${ h.resGender }</td>
				                                            <td>${ h.resType }</td>
				                                            <td>${ h.houseStatus }</td>
				                                            <td>${ h.housDate }</td>
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
            });
            </script>

            <div id="pagingArea">
                <ul class="pagination">
                    
                    <c:choose>
                        <c:when test="${ pi.currentPage eq 1 }">
                            <li class="page-item disabled"><a class="page-link" href="#">Previous</a></li>
                        </c:when>
                        <c:otherwise>
                            <li class="page-item"><a class="page-link" href="list.ho?cPage=${ pi.currentPage - 1 }">Previous</a></li>
                        </c:otherwise>
                    </c:choose>
                    
                    
                    <c:forEach var="p" begin="${ pi.startPage }" end="${ pi.endPage }" step="1">
                        <li class="page-item"><a class="page-link" href="list.ho?cPage=${ p }">${ p }</a></li>
                    </c:forEach>
                    
                    <c:choose>
                        <c:when test="${ pi.currentPage eq pi.maxPage }">
                            <li class="page-item disabled"><a class="page-link" href="#">Next</a></li>
                        </c:when>
                        <c:otherwise>
                            <li class="page-item"><a class="page-link" href="list.ho?cPage=${ pi.currentPage + 1 }">Next</a></li>
                        </c:otherwise>
                    </c:choose>
                </ul>
            </div>

            <br clear="both"><br>
            
            <!-- Footer Start -->
			<%@ include file="../common/footer.jsp" %>
            <!-- Footer End -->
        </div>
        <!-- Content End -->

	</div>
            