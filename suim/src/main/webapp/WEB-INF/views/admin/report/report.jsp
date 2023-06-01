<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<style>
	#reportList {text-align:center;}
	#reportList>tbody>tr:hover {cursor:pointer;}
	#pagingArea {width:fit-content; margin:auto;}
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
                            <h6 class="mb-4">신고 관리</h6>

                            <nav>
                                <div class="nav nav-tabs" id="nav-tab" role="tablist">
                                    <button class="nav-link active" id="nav-home-tab" data-bs-toggle="tab"
                                        data-bs-target="#nav-home" type="button" role="tab" aria-controls="nav-home"
                                        aria-selected="true">전체</button>
                                    <button class="nav-link" id="nav-profile-tab" data-bs-toggle="tab"
                                        data-bs-target="#nav-profile" type="button" role="tab"
                                        aria-controls="nav-profile" aria-selected="false">미처리</button>
                                    <button class="nav-link" id="nav-profile-tab" data-bs-toggle="tab"
                                        data-bs-target="#nav-profile" type="button" role="tab"
                                        aria-controls="nav-profile" aria-selected="false">처리 완료</button>
                                    <button class="nav-link" id="nav-profile-tab" data-bs-toggle="tab"
                                        data-bs-target="#nav-profile" type="button" role="tab"
                                        aria-controls="nav-profile" aria-selected="false">반려</button>
                                </div>
                            </nav>
                            <div class="tab-content pt-3" id="nav-tabContent">
                                <div class="tab-pane fade show active" id="nav-home" role="tabpanel" aria-labelledby="nav-home-tab">
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
			                                            
			                                            <td class="rno">${ r.reportNo }</td>
			                                            <td>${ r.reportTitle }</td>
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
                                
                                <script>
                                $(function(){
                                	 $("nav>div>button").on("click", function() {
                                		 var selectedCategory = $(this).text();
                                		 
										                                		 
										 $.ajax({
											url : "list.re",
											type : "get",
											data: { category: selectedCategory },
											success : function(result) {
												
												console.log(result);
												
												var resultStr = "";
												
												for(var i = 0; i < result.length; i++) {
													
													resultStr += "<tr>"
															   + 	"<td>" + result[i].reportNo + "</td>"
															   + 	"<td>" + result[i].reportTitle + "</td>"
															   + 	"<td>" + result[i].reportContent + "</td>"
															   + 	"<td>" + result[i].reportType + "</td>"
															   + 	"<td>" + result[i].reportId + "</td>"
															   + 	"<td>" + result[i].reportDate + "</td>"
															   + 	"<td>" + result[i].reportStatus + "</td>"
															   + "</tr>";
												}
												
												$("#result3>tbody").html(resultStr);
											},
											error : function() {
												console.log("ajax 통신 실패!");
											}
										});
									});
                                });
							</script>
                                
                                <div class="tab-pane fade" id="nav-profile" role="tabpanel" aria-labelledby="nav-profile-tab">
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
			                                            
			                                            <td class="rno">${ r.reportNo }</td>
			                                            <td>${ r.reportTitle }</td>
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
                                <div class="tab-pane fade" id="nav-profile" role="tabpanel" aria-labelledby="nav-profile-tab">
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
			                                            
			                                            <td class="rno">${ r.reportNo }</td>
			                                            <td>${ r.reportTitle }</td>
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
          