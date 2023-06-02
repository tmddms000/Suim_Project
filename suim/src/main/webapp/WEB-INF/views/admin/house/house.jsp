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
                            <h6 class="mb-4">매물 관리</h6>
                            
                            <div class="d-flex">
                                <div class="me-2 " style="width:150px">
                                    <select class="form-select" onchange="changeDropdown(this)">
                                        <option id="title" value="title">공실 여부</option>
                                        <option id="content" value="content">글 내용</option>
                                        <option id="writer" value="username">작성자</option>
                                    </select>
                                </div>
                        
                                <div class="input-group">
                                    <div class="form-outline">
                                        <input id="search-input" type="search" name="title" 
                                               class="form-control" placeholder="검색"
                                         onkeypress="if(event.keyCode=='13'){event.preventDefault(); searchEvt();}" />
                                    </div>
                                    <button id="search-button" class="btn btn-primary" onclick="searchHouse()">
                                        <i class="fas fa-search"></i>
                                    </button>
                                </div>
                            </div>
                            

                            <div class="table-responsive">
                                <table class="table" id="houseList">
                                    <thead>
                                        <tr>
                                            <th scope="col"><input type="checkbox" id="check_all"></th>
                                            <th scope="col">번호</th>
                                            <th scope="col">제목</th>
                                            <th scope="col">작성자</th>
                                            <th scope="col">아이디</th>
                                            <th scope="col">작성일</th>
                                            <th scope="col">조회수</th>
                                            <th scope="col">상태</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <tr>
                                            <td scope="row"><input type="checkbox" id="check_1"></td>
                                            <td scope="col" class="bno">10</td>
                                            <td><a href="house_detail.html">제목</td>
                                            <td>Doe</td>
                                            <td>jhon@email.com</td>
                                            <td>USA</td>
                                            <td>123</td>
                                            <td>Member</td>
                                        </tr>
                                        <tr>
                                            <td scope="row"><input type="checkbox" id="check_2"></td>
                                            <td scope="col">9</td>
                                            <td>Mark</td>
                                            <td>Otto</td>
                                            <td>mark@email.com</td>
                                            <td>UK</td>
                                            <td>456</td>
                                            <td>Member</td>
                                        </tr>
                                        <tr>
                                            <td scope="row"><input type="checkbox" id="check_3"></td>
                                            <td scope="col">8</td>
                                            <td>Jacob</td>
                                            <td>Thornton</td>
                                            <td>jacob@email.com</td>
                                            <td>AU</td>
                                            <td>789</td>
                                            <td>Member</td>
                                        </tr>
                                        <tr>
                                            <td scope="row"><input type="checkbox" id="check_4"></td>
                                            <td scope="col">7</td>
                                            <td>Jacob</td>
                                            <td>Thornton</td>
                                            <td>jacob@email.com</td>
                                            <td>AU</td>
                                            <td>789</td>
                                            <td>Member</td>
                                        </tr>
                                        <tr>
                                            <td scope="row"><input type="checkbox" id="check_5"></td>
                                            <td scope="col">6</td>
                                            <td>Jacob</td>
                                            <td>Thornton</td>
                                            <td>jacob@email.com</td>
                                            <td>AU</td>
                                            <td>789</td>
                                            <td>Member</td>
                                        </tr>
                                        <tr>
                                            <td scope="row"><input type="checkbox" id="check_6"></td>
                                            <td scope="col">5</td>
                                            <td>Jacob</td>
                                            <td>Thornton</td>
                                            <td>jacob@email.com</td>
                                            <td>AU</td>
                                            <td>789</td>
                                            <td>Member</td>
                                        </tr>
                                        <tr>
                                            <td scope="row"><input type="checkbox" id="check_7"></td>
                                            <td scope="col">4</td>
                                            <td>Jacob</td>
                                            <td>Thornton</td>
                                            <td>jacob@email.com</td>
                                            <td>AU</td>
                                            <td>789</td>
                                            <td>Member</td>
                                        </tr>
                                        <tr>
                                            <td scope="row"><input type="checkbox" id="check_8"></td>
                                            <td scope="col">3</td>
                                            <td>Jacob</td>
                                            <td>Thornton</td>
                                            <td>jacob@email.com</td>
                                            <td>AU</td>
                                            <td>789</td>
                                            <td>Member</td>
                                        </tr>
                                        <tr>
                                            <td scope="row"><input type="checkbox" id="check_9"></td>
                                            <td scope="col">2</td>
                                            <td>Jacob</td>
                                            <td>Thornton</td>
                                            <td>jacob@email.com</td>
                                            <td>AU</td>
                                            <td>789</td>
                                            <td>Member</td>
                                        </tr>
                                        <tr>
                                            <td scope="row"><input type="checkbox" id="check_10"></td>
                                            <td scope="col">1</td>
                                            <td>Jacob</td>
                                            <td>Thornton</td>
                                            <td>jacob@email.com</td>
                                            <td>AU</td>
                                            <td>789</td>
                                            <td>Member</td>
                                        </tr>
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
            		$("#houseList>tbody>tr").click(function() {
            			let bno = $(this).children(".bno").text();
            			location.href = "detail.bo?bno=" + bno;
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
            