<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style>
	.reportTableLeft{
		display: inline-block;
		float: left;
	}
	.reportTableRight{
		display: inline-block;
		float: rigth;	
	}
</style>
	<%@ include file="../common/include.jsp" %>
</head>
<body>  

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
                <h2>신고 내역 보기</h2>
                <br>
                
				<!-- 테이블 시작 -->
				<div class="container-fluid pt-4 px-4">
	                <div class="row g-4">
		                <div class="col-12">
	                        <div class="bg-light rounded h-100 p-4">
	                            <h6 class="mb-4">신고 내역 상세보기</h6>
	                            <div class="table-responsive">
	                            
	                            	<!-- 왼쪽 테이블 -->
		                			<div class="col-sm-12 col-xl-6 reportTableLeft">
		                                <table class="table">
	                                        <tr>
	                                            <th scope="col" width="100">번호</th>
	                                            <td class="rno">${ r.reportNo }</td>
	                                        </tr>
	                                        <tr>
	                                            <th scope="row">제목</th>
	                                            <td>${ r.reportTitle }</td>
	                                        </tr>
	                                        <tr>
	                                            <th scope="row">내용</th>
	                                            <td>${ r.reportContent }</td>
	                                        </tr>
	                                        <tr>
	                                            <th scope="row">유형</th>
	                                            <td>${ r.reportType }</td>
	                                        </tr>
	                                        <tr>
	                                            <th scope="row">신고자</th>
	                                            <td>${ r.reportId }</td>
	                                        </tr>
	                                        <tr>
	                                            <th scope="row">신고일</th>
	                                            <td>${ r.reportDate }</td>
	                                        </tr>
	                                        <tr>
	                                            <th scope="row">상태</th>
	                                            <td>${ r.reportStatus }</td>
	                                        </tr>
		                                </table>
		                        	</div>
	                            	<!-- 오른쪽 테이블 -->
		                			<div class="col-sm-12 col-xl-6 reportTableRight">
		                                <table class="table" style="border-bottom: #F3F6F9;">
		                                    <tr>
	                                            <th scope="row">첨부파일</th>
                                                <c:choose>
											        <c:when test="${not empty r.thumbnail}">
											            <td><img src="/${r.thumbnail}"></img></td>
											        </c:when>
											        <c:otherwise>
											            <td><img src="/resources/img/common/no-image.png"></img></td> <!-- Replace "default-image.jpg" with the path to your default image -->
											        </c:otherwise>
											    </c:choose>
	                                        </tr>
		                                </table>
		                        	</div>
			                        	
	                            </div>
	                        </div>
	                    </div>
                	</div>
				</div>
				<!-- 테이블 끝 -->
            
            <br>
            <a class="btn btn-secondary" style="float:right;" href="list.re">목록으로</a>
            <br>

            <div align="center">
			    <a class="btn btn-primary" onclick="postFormSubmit('Y');">승인</a>
			    <a class="btn btn-danger" onclick="postFormSubmit('N');">반려</a>
			</div>
			<br><br>
			
			<form id="postForm" action="" method="post">
			    <input type="hidden" name="reportNo" value="${r.reportNo}">
			    <input type="hidden" name="reportStatus" id="reportStatus" value="">
			</form>
			
			<script>
			    function postFormSubmit(value) {
			        var form = document.getElementById("postForm");
					
			        var status = document.getElementById("reportStatus");
			        status.value = value;
			        
			        
			        form.action = "updateStatus.re";

			        form.submit();
			    }
			    
			    
			</script>



            </div>
            <br><br>    
            <!-- Table End -->

            <br clear="both"><br>
            
            <!-- Footer Start -->
			<%@ include file="../common/footer.jsp" %>
            <!-- Footer End -->
        </div>
        <!-- Content End -->

	</div>

</body>
</html>