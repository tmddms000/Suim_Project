<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>공지사항</title>

            <!-- 부트스트랩 -->
            <link href="/resources/css/common/styles.css" rel="stylesheet" />
            <!-- 폰트어썸 icon -->
            <script src="https://use.fontawesome.com/releases/v6.3.0/js/all.js" crossorigin="anonymous"></script>
            <!-- Core theme CSS (includes Bootstrap)-->
            <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/normalize/8.0.1/normalize.min.css" />
           
            <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"></script>
            <!-- TypeIt CDN -->
            <script src="https://unpkg.com/typeit@8.7.1/dist/index.umd.js"></script>
            <!-- jQuery CDN -->
            <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.3/jquery.min.js"></script>
            <!-- 1:1문의 js -->
            <script src="/resources/js/common/chatbot.js"></script>
              
            <!-- 공지사항 css -->
            <link href="/resources/css/notice/notice.css" rel="stylesheet" />
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
<!-- 헤더 부분-->
    <header>
        <jsp:include page="/WEB-INF/views/common/header.jsp" />
    </header>
    <!-- 헤더 부분 끝 -->
   
    <!--공지사항(Content) 영역 -->

    <div id="noticeDiv" class="container main">
        <div class="col-lg-12">
    
    
            <div class="table-wrapper">
                <div id="noticeBold" class="table-title">
                    우주 공지사항
                </div>
            
                <div id="nListSearch" class="search-box">
                    <form>
                        <input type="text" placeholder="지역명, 주변명 입력">
                        <button type="submit">
                            <i class="fa fa-search" style="color : rgb(249,88,10)"></i>
                        </button>
                    </form>
                </div>
                
                <table id="notice-table" class="table">
                    <thead>
                        <tr class="table-header">
                            <td class="nListNo">No</th>
                            <td class="title">제목</th>
                            <td class="createDate">작성일</th>
                        </tr>
                    </thead>
                    <tbody>
                    	<c:forEach var="n" items="${ list }">
	                        <tr class="table-row" style="background-color:none;">
	                            <td class="nListNo">${ n.noticeNo }</td>
	                            <td class="title">
	                                <a href="/notices/20">${ n.noticeTitle }</a>
	                            </td>
	                            <td class="createDate">${ n.noticeDate }</td>
	                        </tr>
                    	</c:forEach>
                    </tbody>
                </table>
                
                <!-- 페이지네이션 영역 시작 -->
                <div class="pagination" >
                    <a href="#" class="previous">이전</a>
                    <a href="#" class="page-link active">1</a>
                    <a href="#" class="page-link">2</a>
                    <a href="#" class="page-link">3</a>
                    <a href="#" class="page-link">4</a>
                    <a href="#" class="page-link">5</a>
                    <a href="#" class="next">다음</a>
                </div>
                
                <!-- 페이지네이션 영역 끝 -->

            </div>
        </div>
    </div>

    <jsp:include page="/WEB-INF/views/common/footer.jsp"></jsp:include>
      <script src="/resources/js/scripts.js"></script>
    
</body>
</html>