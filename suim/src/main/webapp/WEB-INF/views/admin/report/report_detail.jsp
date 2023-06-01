<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

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
                <h2>회원 정보 보기</h2>
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
	                                            <th scope="col">번호</th>
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
		                                <table class="table">
		                                    <tr>
	                                            <th scope="row">신고 관련해서 뭐넣지..?</th>
	                                            <c:choose>
													<c:when test="${empty changeName}">
														<img src="../../../resources/img/admin/user.jpg"/>
													</c:when>
													<c:otherwise>
														<img src="${changeName}"/>
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
            
            
            <a class="btn btn-secondary" style="float:right;" href="list.re">목록으로</a>
            <br>
    
                <!-- <c:if test="${ (not empty loginUser) and (loginUser.userId eq b.boardWriter) }"> -->
                    <div align="center">
                        <!-- 수정하기, 삭제하기 버튼은 이 글이 본인이 작성한 글일 경우에만 보여져야 함 -->
                            <a class="btn btn-primary" onclick="postFormSubmit(1);" href="member_update.html">수정하기</a>
                            <a class="btn btn-danger" onclick="postFormSubmit(2);">삭제하기</a>
                    </div>
                    <br><br>
                    
                    <!--
                        	수정, 삭제 시 게시글 번호를 get 방식으로 넘기기에는 위험이 크므로
                        	post 방식으로 요청 보내보기 => form 태그 필요
                    -->
                    <form id="postForm" action="" method="post">
                        <input type="hidden" name="memberId" value="${ m.memberId }">
                        <input type="hidden" name="filePath" value="${ m.changeName }">
                    </form>
                    <script>
                        // 수정하기 버튼과 삭제하기 버튼을 클릭했을 때 실행할 선언적 함수
                        function postFormSubmit(num) {
                            
                            // 해당 form 태그 선택 후 action 속성값을 각각 부여 후 곧바로 submit 시키기
                            if(num == 1) { // 수정하기 버튼을 클릭했을 경우
                                $("#postForm").attr("action", "updateForm.re").submit();
                            } else { // 삭제하기 버튼을 클릭했을 경우
                                $("#postForm").attr("action", "delete.re").submit();
                            }
                        }
                    </script>
                <!-- </c:if> -->

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
          