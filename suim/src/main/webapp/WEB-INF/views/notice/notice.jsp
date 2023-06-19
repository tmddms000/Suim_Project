<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
    <%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
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

    <div id="noticeDiv" class="container main" style="margin-top : 150px;">
        <div class="col-lg-12">
    
    
            <div class="table-wrapper">
                <div id="noticeBold" class="table-title">
                    	SUIM 공지사항
                </div>
            
               
                		
				
                <!-- 공지사항은 관리자만 작성 가능하므로 관리자로 로그인했을 경우에만 버튼이 보이게끔 -->
                <!-- 클릭 시 insert.no 로 넘어감 -->
                
                <%-- <c:if test="${ not empty loginUser and loginUser.memberId eq ('관리자아이디') }"> --%>
                <c:if test="${ not empty loginUser and loginUser.memberId eq ('google969548') }">
                
                <a class="btn btn-secondary" style="display: inline-block; vertical-align: middle; line-height: 20px; background-color: rgb(250,107,111); height: 20px; text-decoration: none; color: #fff; padding: 0 10px; font-size: medium; margin-left: 1220px;" onclick="location.href='enrollForm.no';">
		       	 글작성
	 		</a>
				 </c:if>
				
		
                <table id="notice-table" class="table">
                    <thead>
                        <tr class="table-header">
                            <td class="nListNo" style="border-bottom-color : green;">No</td>
                            <td class="title">제목</td>
                            <td class="createDate">작성일</td>
                        </tr>
                    </thead>
                    <tbody>
                    	<c:forEach var="n" items="${ list }">
	                        <tr class="table-row" style="background-color:none;">
	                            <td class="nListNo, nno" style="border-bottom-color : green;">${ n.noticeNo }</td>
	                            <td class="title" style="text-align : left; padding-left : 50px;">
	                                ${ n.noticeTitle }
	                            </td>
	                            <td class="createDate"><fmt:formatDate pattern="yyyy-MM-dd" value="${n.noticeDate }" /></td>
	                        </tr>
                    	</c:forEach>
                    </tbody>
                </table>
                
                <br/>
                
                <!-- 공지사항 상세조회 함수 -->
                 <script>
            	$(function() {
            		$("#notice-table>tbody> tr").click(function() {
            			
            			let nno = $(this).children(".nno").text();
            			location.href = "detail.no?nno=" + nno;
            			// location.href = "detail.no/" + nno; // path Variable 방식(tistory 방식)
            		});
            	});
            </script>
                
                <!-- 페이지네이션 영역 시작 -->
                <div id="pagingArea">
                <ul class="pagination">
                
                	<c:choose>
                		<c:when test="${ pi.currentPage eq 1 }">
                			<li class="page-item disabled"><a class="page-link" href="#">Previous</a></li>
                		</c:when>
                		<c:otherwise>
                			<li class="page-item"><a class="page-link" href="notice.no?cPage=${ pi.currentPage - 1 }">Previous</a></li>
                		</c:otherwise>
                	</c:choose>
                    
                    <c:forEach var="p" begin="${ pi.startPage }" end="${ pi.endPage }" step="1">
                    	<li class="page-item"><a class="page-link" href="notice.no?cPage=${ p }">${ p }</a></li>
                    </c:forEach>
                    
                    <c:choose>
                    	<c:when test="${ pi.currentPage eq pi.maxPage }">
                    		<li class="page-item disabled"><a class="page-link" href="#">Next</a></li>
                    	</c:when>
                    	
                    	<c:otherwise>
                    		<li class="page-item"><a class="page-link" href="notice.no?cPage=${ pi.currentPage + 1 }">Next</a></li>
                    	</c:otherwise>
                    </c:choose>
                </ul>
            </div>
                
                <!-- 페이지네이션 영역 끝 -->

            </div>
        </div>
    </div>

    <jsp:include page="/WEB-INF/views/common/footer.jsp"></jsp:include>
      <script src="/resources/js/scripts.js"></script>
    
</body>
</html>