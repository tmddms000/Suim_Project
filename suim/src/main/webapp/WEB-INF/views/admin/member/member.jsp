<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<style>
	#memberList {text-align:center;}
	#memberList>tbody>tr:hover {cursor:pointer;}
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
                            <h6 class="mb-4">회원 관리</h6>

                            <nav>
                                <div class="nav nav-tabs" id="nav-tab" role="tablist">
                                    <button class="nav-link active" id="nav-home-tab" data-bs-toggle="tab"
                                        data-bs-target="#nav-home" type="button" role="tab" aria-controls="nav-home"
                                        aria-selected="true">매물 관리</button>
                                    <button class="nav-link" id="nav-profile-tab" data-bs-toggle="tab"
                                        data-bs-target="#nav-profile" type="button" role="tab"
                                        aria-controls="nav-profile" aria-selected="false">예약금 관리</button>
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
                                            <th scope="col">블랙회원</th>
                                            <th scope="col">권한 변경</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                    	<c:forEach var="m" items="${ list }">
                    						<tr>
	                                            <td scope="row"><input class="form-check-input" type="checkbox" value=""></td>
	                                            
	                                            <td>${ m.nickName }</td>
	                                            <td class="memberId">${ m.memberId }</td>
	                                            <td>${ m.email }</td>
	                                            <td>${ m.phone }</td>
	                                            <td>${ m.enrollDate }</td>
	                                            <td>${ m.status }</td>
	                                            <td>
	                                                <div class="form-check form-switch">
	                                                	<input class="form-check-input" type="checkbox" role="switch">
	                                            	</div>
	                                            </td>
	                                            <td>
	                                            	<selet>
	                                            		<option>관리자</option>
	                                            		<option>사용자</option>
	                                            	</selet>
	                                            </td>
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

                $(document).ready(function(){
                // $(function() {
            		$("#memberList>tbody>tr").click(function() {
            			var id = $(this).children(".memberId").text();
            			location.href = "detail.me?id=" + id;	
            		});
            	});
	                
            </script>

			<br>
            <div id="pagingArea">
                <ul class="pagination">
                	
                	<c:choose>
                		<c:when test="${ pi.currentPage eq 1 }">
                    		<li class="page-item disabled"><a class="page-link" href="#">&lt;&lt;</a></li>
                    		<li class="page-item disabled"><a class="page-link" href="#">&lt;</a></li>
                		</c:when>
                		<c:otherwise>
                    		<li class="page-item"><a class="page-link" href="#">&lt;&lt;</a></li>
		                    <li class="page-item"><a class="page-link" href="list.me?currentPage=${ pi.currentPage - 1 }">&lt;</a></li>
                		</c:otherwise>
                	</c:choose>
                    
                    
                    <c:forEach var="p" begin="${ pi.startPage }" end="${ pi.endPage }" step="1">
                    	<li class="page-item"><a class="page-link" href="list.me?currentPage=${ p }">${ p }</a></li>
                    </c:forEach>
                    
                    <c:choose>
                    	<c:when test="${ pi.currentPage eq pi.maxPage }">
                    		<li class="page-item disabled"><a class="page-link" href="#">&gt;</a></li>
                    		<li class="page-item disabled"><a class="page-link" href="#">&gt;&gt;</a></li>
                    	</c:when>
                    	<c:otherwise>
                    		<li class="page-item"><a class="page-link" href="list.me?currentPage=${ pi.currentPage + 1 }">&gt;</a></li>
                    		<li class="page-item"><a class="page-link" href="list.me?currentPage=${ pi.currentPage + 1 }">&gt;&gt;</a></li>
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
