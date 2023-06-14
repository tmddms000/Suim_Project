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
                <h2>회원 수정하기</h2>
                <br>
    
                <form id="updateForm" method="post" action="update.me" enctype="multipart/form-data">
                	<input type="hidden" name="memberId" value="${ m.memberId }">
                    <table align="center">
                    	<tr>
                            <th><label for="title">아이디</label></th>
                            <td><input type="text" id="title" class="form-control" value="${ m.memberId }" name="memberId" required></td>
                        </tr>
                        <tr>
                            <th><label for="title">이름</label></th>
                            <td><input type="text" id="title" class="form-control" value="${ m.memberName }" name="memberName" required></td>
                        </tr>
                        <tr>
                            <th><label for="writer">닉네임</label></th>
                            <td><input type="text" id="writer" class="form-control" value="${ m.nickName }" name="nickName"></td>
                        </tr>
                        <tr>
                            <th><label for="upfile">전화번호</label></th>
                            <td><input type="text" id="writer" class="form-control" value="${ m.phone }" name="phone"></td>
                        </tr>
                        <tr>
                            <th><label for="content">이메일</label></th>
                            <td><input type="text" id="writer" class="form-control" value="${ m.email }" name="email"></td>
                        </tr>
                        <tr>
                            <th><label for="content">성별</label></th>
                            <td><input type="text" id="writer" class="form-control" value="${ m.gender }" name="gender"></td>
                        </tr>
                        <tr>
                            <th><label for="content">선호지역</label></th>
                            <td><input type="text" id="writer" class="form-control" value="${ m.area }" name="area"></td>
                        </tr>
                        <tr>
                            <th><label for="content">생년월일</label></th>
                            <td><input type="text" id="writer" class="form-control" value="${ m.birth }" name="birth" readonly></td>
                        </tr>
                        <tr>
                            <th><label for="content">회원 정보 수정 날짜</label></th>
                            <td><input type="text" id="writer" class="form-control" value="<fmt:formatDate value="${m.modifyDate}" pattern="yyyy-MM-dd"/>" name="modifyDate"></td>
                        </tr>
                        <tr>
                            <th><label for="content">최근 로그인 날짜</label></th>
                            <td><input type="text" id="writer" class="form-control" value="${ m.loginDate }" name="loginDate" readonly></td>
                        </tr>
                        <tr>
                            <th><label for="content">상태</label></th>
                            <td><input type="text" id="writer" class="form-control" value="${ m.status }" name="status" readonly></td>
                        </tr>
                        <tr	algin="center">
							<th scope="row">프로필사진</th>
							<c:choose>
								<c:when test="${empty changeName}">
									<img src="../../../resources/img/common/default_profile.png"/>
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
          