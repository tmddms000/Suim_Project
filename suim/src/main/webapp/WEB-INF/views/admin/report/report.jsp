<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>


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
                            <h6 class="mb-4">신고 관리</h6>

                            <nav>
                                <div class="nav nav-tabs" id="nav-tab" role="tablist">
                                    <button class="nav-link active" id="nav-home-tab" data-bs-toggle="tab"
                                        data-bs-target="#nav-home" type="button" role="tab" aria-controls="nav-home"
                                        aria-selected="true">회원 신고</button>
                                    <button class="nav-link" id="nav-profile-tab" data-bs-toggle="tab"
                                        data-bs-target="#nav-profile" type="button" role="tab"
                                        aria-controls="nav-profile" aria-selected="false">매물 신고</button>
                                    <button class="nav-link" id="nav-profile-tab" data-bs-toggle="tab"
                                        data-bs-target="#nav-profile" type="button" role="tab"
                                        aria-controls="nav-profile" aria-selected="false">커뮤니티 신고</button>
                                </div>
                            </nav>
                            <div class="tab-content pt-3" id="nav-tabContent">
                                <div class="tab-pane fade show active" id="nav-home" role="tabpanel" aria-labelledby="nav-home-tab">
                                    Diam sea sanctus amet clita lorem sit sanctus ea elitr. Lorem rebum est elitr eos. Dolores aliquyam sadipscing dolor sadipscing accusam voluptua tempor. Sanctus elitr sanctus diam tempor diam aliquyam et labore clita, ipsum takimata amet est erat, accusam takimata gubergren sea sanctus duo nonumy. Ipsum diam ipsum sit kasd.
                                </div>
                                <div class="tab-pane fade" id="nav-profile" role="tabpanel" aria-labelledby="nav-profile-tab">
                                    Sanctus vero sit kasd sea gubergren takimata consetetur elitr elitr, consetetur sadipscing takimata ipsum dolores. Accusam duo accusam et labore ea elitr ipsum tempor sit, dolore aliquyam ipsum sit amet sit. Et dolore ipsum labore invidunt rebum. Sed dolore gubergren sanctus vero diam lorem rebum elitr, erat diam dolor clita.
                                </div>
                            </div>

                            <div class="table-responsive">
                                <table class="table" id="reportList">
                                    <thead>
                                        <tr>
                                            <th scope="col"><input class="form-check-input" type="checkbox" value=""></th>
                                            <th scope="col">번호</th>
                                            <th scope="col">제목</th>
                                            <th scope="col">내용</th>
                                            <th scope="col">유형</th>
                                            <th scope="col">신고자</th>
                                            <th scope="col">신고일</th>
                                            <th scope="col">상태</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                    	<c:forEach var="r" items="${ list }">
                    						<tr>
	                                            <td scope="row"><input class="form-check-input" type="checkbox" value=""></td>
	                                            
	                                            <td>${ r.reportNo }</td>
	                                            <td class="memberId">${ r.reportTitle }</td>
	                                            <td>${ r.reportContent }</td>
	                                            <td>${ r.reportType }</td>
	                                            <td>${ r.reportId }</td>
	                                            <td>${ r.reportDate }</td>
	                                            <td>${ r.reportStatus }</td>
	                                        </tr>
	                                	</c:forEach>
                                    </tbody>
                                </table>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <!-- Table End -->

            <script>
                $(document).ready(function(){
                    $("#check_all").click(function(){
                        if($("#check_all").prop("checked")){
                            $("input[type=checkbox]").prop("checked",true);
                        }else{
                            $("input[type=checkbox]").prop("checked",false);
                        }
                    });
                });

                $(function() {
            		$("#reportList>tbody>tr").click(function() {
            			let rno = $(this).children(".rno").text();
            			location.href = "detail.re?rno=" + rno;
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
                            <li class="page-item"><a class="page-link" href="list.bo?cPage=${ pi.currentPage - 1 }">Previous</a></li>
                        </c:otherwise>
                    </c:choose>
                    
                    
                    <c:forEach var="p" begin="${ pi.startPage }" end="${ pi.endPage }" step="1">
                        <li class="page-item"><a class="page-link" href="list.bo?cPage=${ p }">${ p }</a></li>
                    </c:forEach>
                    
                    <c:choose>
                        <c:when test="${ pi.currentPage eq pi.maxPage }">
                            <li class="page-item disabled"><a class="page-link" href="#">Next</a></li>
                        </c:when>
                        <c:otherwise>
                            <li class="page-item"><a class="page-link" href="list.bo?cPage=${ pi.currentPage + 1 }">Next</a></li>
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
          