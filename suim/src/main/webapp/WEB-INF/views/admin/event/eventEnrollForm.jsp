<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
     <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
    

<style>

		 body {
                display: flex;
                flex-direction: column;
                min-height: 100vh;
            }
            .main {
                flex: 1;
                margin-top : 90px;
            }
            footer {
                margin-top: auto;
            }
		

    </style>


<%@ include file="../common/include.jsp" %>

<%-- <c:if test="${ not empty loginUser and loginUser.memberId eq ('관리자아이디') }"> --%>
 <c:if test="${ not empty loginUser and loginUser.email eq (('oox14@naver.com') or ('suimm012@gmail.com')) }">
<div class="container-xxl position-relative bg-white d-flex p-0">
    <!-- Spinner Start -->
		
        <!-- Spinner End -->
		
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
            <h2>이벤트 게시글 작성하기</h2>
            <br>
			
			<!-- action="" 을 통해 AdminEventController 로 이동 -->
            <form id="enrollForm" method="post" action="insert.ev" enctype="multipart/form-data">
                <table algin="center">
                    <tr>
                        <th><label for="title">제목</label></th>
                        <td><input type="text" id="title" class="form-control" name="eventTitle" required></td>
                    </tr>
                    <tr>
                    	<th><label for="category">이벤트 카테고리</label></th>
                    	<td>
                    		<select id="category" name="eventCategory" required>
					            <option value="진행중인 이벤트">진행중인 이벤트</option>
					            <option value="랜덤 이벤트">랜덤 이벤트</option>
					            <option value="테스트 작성용 카테고리">테스트 작성용 이벤트 카테고리</option>
					        </select>
					    </td>
                    </tr>
                        <th><label for="upfile">첨부파일</label></th>
                        <td><input type="file" id="upfile" class="form-control-file border" name="upfile"></td>
                    </tr>
                    <tr>
                        <th><label for="content">내용</label></th>
                        <td><textarea id="content" class="form-control" rows="10" style="resize:none;" name="eventContent" required></textarea></td>
                    </tr>
                </table>
                <br>

                <div align="center">
                    <button type="submit" class="btn btn-primary">등록하기</button>
                    <button type="reset" class="btn btn-danger">취소하기</button>
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
    </div>
</c:if>
