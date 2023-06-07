<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<style>
	#reportList {text-align:center;}
	#reportList>tbody>tr:hover {cursor:pointer;}
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
                            <h6 class="mb-4">신고 관리</h6>

							<div align="right" class="searchForm">
							<form class="d-md-flex ms-4" action="search.re">
								<div class="select">
				                    <select class="form-select form-select-sm mb-3" name="condition" style="margin-bottom: unset !important;">
				                        <option value="REPORT_TITLE">제목</option>
				                        <option value="REPORT_CONTENT">내용</option>
				                        <option value="REPORT_TYPE">유형</option>
				                        <option value="REPORT_ID">신고자</option>
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
		                                <table class="table" id="reportList">
		                                    <thead>
		                                        <tr>
		                                            <th scope="col"><input class="form-check-input" type="checkbox" id="selectAll_A"></th>
		                                            <th scope="col">번호</th>
		                                            <th scope="col">유형</th>
		                                            <th scope="col">제목</th>
		                                            <th scope="col">신고당한사람</th>
		                                            <th scope="col">내용</th>
		                                            <th scope="col">신고일</th>
		                                            <th scope="col">상태</th>
		                                        </tr>
		                                    </thead>
		                                    <tbody>
		                                    	<c:forEach var="r" items="${ list }">
		                    						<tr>
			                                            <td scope="row"><input class="form-check-input" type="checkbox" name="checkboxName"></td>
			                                            <td class="rno">${ r.reportNo }</td>
			                                            <td>${ r.reportType }</td>
			                                            <td>${ r.reportTitle }</td>
			                                            <td>${ r.reportId }</td>
			                                            <td>${ r.reportContent }</td>
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

        	    $('.nav-link').click(function(e) {
        	        if ($(this).data('toggle')) {
        	            e.preventDefault();
        	        }

        	        $('.nav-link').removeClass('active');
        	        $('.tab-pane').removeClass('show active');

        	        $(this).addClass('active');

        	        var targetTab = $(this).attr('id');
        	        var type = "";

        	        if (targetTab === "A") {
        	            type = "미처리";
        	        } else if (targetTab === "N") {
        	            type = "untreated";
        	        } else if (targetTab === "Y") {
        	            type = "confirm";
        	        } else if (targetTab === "C"){
        	        	type = "companion";
        	        }


        	        $.ajax({
        	            type: "GET",
        	            url: "/admin/category.re",
        	            data: {
        	                type: type
        	            },
        	            success: function(response) {
        	                console.log(response);

        	                var tableBody = $('#reportList tbody');
        	                tableBody.empty();

        	                if (response && response.list && response.list.length > 0) {
        	                    $.each(response.list, function(index, item) {
        	                    	
        	                    	console.log(response.list);
        	                       

        	                            var date = new Date(item.reportDate);
        	                            var formattedDate = date.toISOString().split('T')[0];
        	                            var row = "<tr data-id='" + item.reportNo + "'>" +
        	                            "<td class='select-cell'><input type='checkbox' data-id='" + item.reportNo + "'></td>";
        	                            row += "<td class='no-cell'>" + item.reportNo + "</td>";
        	                            row += "<td class='type-cell'>" + item.reportType + "</td>";
        	                            row += "<td class='title-cell'>" + item.reportTitle + "<a href=''>[1]</a></td>";
        	                            row += "<td class='id-cell'>" + item.reportId + "</td>";
        	                            row += "<td class='content-cell'>" + item.reportContent  + "</td>";
        	                            row += "<td class='date-cell'>" + formattedDate + "</td>";
        	                            row += "<td class='views-cell'>" + item.reportStatus + "</td>";
        	                        

        	                        row += "</tr>";

        	                        tableBody.append(row);
        	                    });
        		                } else {
        		                    var noDataHtml = "<tr><td colspan='5' class='text-center'>작성된 게시글이 없습니다.</td></tr>";
        		                    tableBody.append(noDataHtml);
        		                }
        	                $('thead input[type="checkbox"]').prop('checked', false);
        	            },
        	            error: function(xhr, status, error) {
        	                console.error(error);
        	                
        	                var tableBody = $('#reportList tbody');
        	                tableBody.empty();

        	                var noDataHtml = "<tr><td colspan='5' class='text-center'>작성된 게시글이 없습니다.</td></tr>";
        	                tableBody.append(noDataHtml);

        	                // Uncheck 전체선택 checkbox
        	                $('tfoot input[type="checkbox"]').prop('checked', false);
        	            }
        	        });
        	    });

        	    // 삭제 버튼 클릭 이벤트
        	    $(document).on('click', 'button.delete-btn', function() {
        	        var checkedCheckboxes = $('tbody input[type="checkbox"]:checked');
        	        var deleteIds = [];

        	        checkedCheckboxes.each(function() {
        	            deleteIds.push($(this).data('id'));
        	        });
        	        
        	        if (deleteIds.length === 0) {
        	            alert("삭제할 게시글을 선택해주세요.");
        	            return;
        	        }
        	        
        	        var confirmation = confirm("게시글을 삭제하시겠습니까?");
        	        if (!confirmation) {
        	            return;
        	        }

        	        // 삭제 처리를 위한 Ajax 요청
        	        $.ajax({
        	            type: "POST",
        	            url: "/admin/delete.re",
        	            data: {
        	                ids: deleteIds.join(",")
        	            },
        	            success: function(response) {
        		            if(response === 'Y') {
        		            	
        		            	toastr.success("게시글이 삭제 되었습니다.");
        		            	
        		            	deleteIds.forEach(function(id) {
                                    $("tr[data-id=" + id + "]").remove();
                                });
        		            	$('thead input[type="checkbox"]').prop('checked', false);
        		            	
        		            } else {
        		            	toastr.error("게시글 삭제에 실패했습니다.");
        		            }
        	            },
        	            error: function() {
        	            	toastr.error("게시글 삭제에 실패했습니다.");
        	            }
        	            
        	        });
        	    });
        	});
        	
            </script>

			<br>
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
          