<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<style>
	.memberTableLeft{
		display: inline-block;
		float: left;
	}
	.memberTableRight{
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
                <h2>신고내역 수정하기</h2>
                <br>
    
                <form id="updateForm" method="post" action="update.re" enctype="multipart/form-data">
                	<input type="hidden" name="memberId" value="${ r.memberId }">
                    <table align="center">
                    	<tr>
                            <th><label for="title">제목</label></th>
                            <td><input type="text" id="title" class="form-control" value="${ r.reportTitle }" name="memberId" required></td>
                        </tr>
                        <tr>
                            <th><label for="title">내용</label></th>
                            <td><input type="text" id="title" class="form-control" value="${ r.reportContent }" name="memberName" required></td>
                        </tr>
                        <tr>
                            <th><label for="writer">유형</label></th>
                            <td><input type="text" id="writer" class="form-control" value="${ r.reportType }" name="nickName" readonly></td>
                        </tr>
                        <tr>
                            <th><label for="upfile">신고자</label></th>
                            <td><input type="text" id="writer" class="form-control" value="${ r.memberId }" name="phone" readonly></td>
                        </tr>
                        <tr>
                            <th><label for="content">신고일</label></th>
                            <td><input type="text" id="writer" class="form-control" value="${ r.reportDate }" name="email" readonly></td>
                        </tr>
                        <tr>
                            <th><label for="content">상태</label></th>
                            <td><input type="text" id="writer" class="form-control" value="${ r.reportStatus }" name="gender" readonly></td>
                        </tr>
                        <tr>
							<th scope="row">첨부파일</th>
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
                    <br>
    
                    <div align="center">
                        <button type="submit" class="btn btn-primary">수정하기</button>
                        <button type="button" class="btn btn-danger" onclick="javascript:history.go(-1);">이전으로</button>
                    </div>
                </form>
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
          