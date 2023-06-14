<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
     <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link href="img/favicon.ico" rel="icon">

<!-- Google Web Fonts -->
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=Heebo:wght@400;500;600;700&display=swap" rel="stylesheet">

<!-- Icon Font Stylesheet -->
<link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.10.0/css/all.min.css" rel="stylesheet">
<link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.4.1/font/bootstrap-icons.css" rel="stylesheet">

<!-- Libraries Stylesheet -->
<link href="/resources/js/admin/lib/owlcarousel/assets/owl.carousel.min.css" rel="stylesheet">
<link href="/resources/js/admin/lib/tempusdominus/css/tempusdominus-bootstrap-4.min.css" rel="stylesheet" />

<!-- Customized Bootstrap Stylesheet -->
<!-- <link href="/resources/css/admin/bootstrap.min.css" rel="stylesheet"> -->
<link href="/resources/css/admin/bootstrap.min.css" rel="stylesheet">

<!-- Template Stylesheet -->
<link href="/resources/css/admin/style.css" rel="stylesheet">

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
</head>
<body>
<%@ include file="../common/include.jsp" %>

<%-- <c:if test="${ not empty loginUser and loginUser.memberId eq ('관리자아이디') }"> --%>
<c:if test="${ not empty loginUser and loginUser.memberId eq ('admin1') }">
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

    </div>
    </div>
</c:if>
</body>
</html>