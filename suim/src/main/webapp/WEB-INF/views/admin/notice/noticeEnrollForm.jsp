<!-- 관리자 인증 구문 추가 -->

<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
     <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
    


<%@ include file="../common/include.jsp" %>

<%-- <c:if test="${ not empty loginUser and loginUser.memberId eq ('관리자아이디') }"> --%>
 <c:if test="${ not empty loginUser and loginUser.email eq (('oox14@naver.com') or ('suimm012@gmail.com')) }">
<div class="container-xxl position-relative bg-white d-flex p-0">
    <!-- Spinner Start -->
		
        <!-- Spinner End -->


        <!-- Sidebar Start -->
		<%@ include file="../common/sidebar.jsp" %>
        <!-- Sidebar End -->


        <!-- Content Start -->
        <div class="content">

            <!-- Navbar Start -->
			<%@ include file="../common/navbar.jsp" %>
            <!-- Navbar End -->
        <br><br>
        <div class="innerOuter">
            <h2>공지사항 작성하기</h2>
            <br>
			
			<!-- action="" 을 통해 AdminNoticeController 로 이동 -->
            <form id="enrollForm" method="post" action="insert.no" enctype="multipart/form-data">
                <table algin="center">
                    <tr>
                        <th><label for="title">제목</label></th>
                        <td><input type="text" id="title" class="form-control" name="noticeTitle" required></td>
                    </tr>
                    <tr>
                        <th><label for="upfile">첨부파일</label></th>
                        <td><input type="file" id="upfile" class="form-control-file border" name="upfile"></td>
                    </tr>
                    <tr>
                        <th><label for="content">내용</label></th>
                        <td><textarea id="content" class="form-control" rows="10" style="resize:none;" name="noticeContent" required></textarea></td>
                    </tr>
                </table>
                <br>

                <div style="padding-left : 120px;">
                    <button type="submit" class="btn btn-primary">등록하기</button>
                    <button type="reset" class="btn btn-danger">취소하기</button>
                </div>
            </form>
        </div>
        <br><br>
        <br clear="both"><br>
        <%@ include file="../common/footer.jsp" %>

    </div>
    </div>
</c:if>












