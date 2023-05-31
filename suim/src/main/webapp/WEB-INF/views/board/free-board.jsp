<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page import="java.util.Date" %>




 
<head>
<meta charset="UTF-8">

        <link rel="stylesheet" href="/resources/css/summernote/summernote-lite.css">
        <link rel="stylesheet" href="/resources/css/board/board.css">

        <!-- 나중에 한번에 include 할 부분 -->
        <!-- 부트스트랩 -->
        <link href="/resources/css/common/styles.css" rel="stylesheet" />
        <!-- 폰트어썸 icon -->
        <script src="https://use.fontawesome.com/releases/v6.3.0/js/all.js" crossorigin="anonymous"></script>
        <!-- reset.css  -->
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/normalize/8.0.1/normalize.min.css" />
        <!-- 부트스트랩 자바스크립트 -->
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"></script>
        <!-- 타입잇 자바스크립트 -->
        <script src="https://unpkg.com/typeit@8.7.1/dist/index.umd.js"></script>
        <!-- jQuery -->
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.3/jquery.min.js"></script>
        <!-- 1:1문의 채팅 -->
        <script src="/resources/js/common/chatbot.js"></script>
        <!-- 나중에 한번에 include 할 부분 -->
<style>
	.boardTableLeft{
		display: inline-block;
		float: left;
	}
	.boardTableLeft{
		display: inline-block;
		float: right;	
	}
</style>        
        
        
<title>자유게시판</title>
		<%@ include file="/WEB-INF/views/common/include.jsp" %>
		<link href="/resources/css/user/signup.css" rel="stylesheet" />

</head>	




<body>	    
	 <jsp:include page="/WEB-INF/views/common/header.jsp"/>



	
	 <div class="container" style="margin-top: 120px;">
        <h1>자유게시판</h1>
        <br><br><br><br>


        <h2>베스트</h2>
        
			
							<!-- 테이블 시작 -->
				<div class="container-fluid pt-4 px-4">
	                <div class="row g-4">
		                <div class="col-12">
	                        <div class="bg-light rounded h-100 p-4">
	                            <div class="table-responsive">
	                            
						<!-- 왼쪽 테이블 -->
						<div class="col-sm-12 col-xl-6 boardTableLeft">
						
						<table class="table" id="bestboard">
						    <tbody>
						
						            <tr>
						              
						                <td class="bno">${blist[i].boardNo}</td>
						                <td>${blist[i].boardContent}</td>
						            </tr>
					
						    </tbody>
						</table>
												
						</div>
					
					<!-- 오른쪽 테이블 -->
					<div class="col-sm-12 col-xl-6 boardTableLeft">
					<tbody>
					    <table class="table" id="bestboard">
					         <tbody>
					        <c:forEach begin="1" end="3" var="i">
					        
							        <tr>
						                <th scope="col"><c:out value="${i}" /></th>
						                <td>${blist[i-1].boardTitle}</td>
						                <td class="bno">${blist[i].boardNo}</td>
						            </tr>
					            
					        </c:forEach>
					        	</tbody>
					    </table>
					  </tbody>
					</div>
			                        	
	                            </div>
	                        </div>
	                    </div>
                	</div>
				</div>
				<!-- 테이블 끝 -->
											
          <br><br><br><br><br><br>
         

        
        <a class="btn btn-secondary" style="display: inline-block; vertical-align: middle; line-height: 20px; background-color: rgb(250,107,111); height: 20px; text-decoration: none; color: #fff; padding: 0 10px; font-size: medium; margin-left: 1220px;" href="enrollForm.bo">
            글작성
        </a>
        
        <table class="table" style="text-align: center;" id="freeboard">
        <thead>
            <tr>
                <th width="60px">번호</th>
                <th width="150px">등록일</th>
                <th width="250px">제목</th>
                <th width="90px">작성자</th>
                <th width="90px">조회수</th>
            </tr>
        </thead>
			
            <tbody>
				<c:forEach var="b" items="${list}">
				    <tr>
				        <td class="bno">${b.boardNo}</td>
				        <td>${b.boardDate}</td>
				        <td>
				            ${b.boardTitle}
				            <fmt:formatDate var="today" pattern="yyyy-MM-dd" value="<%= new Date() %>" />
							<c:if test="${not empty b.boardDate and b.boardDate == today}">
							    <span><img height="15" width="15" alt="최신등록일자" src="/resources/img/board/ico_new.gif"></span>	
							</c:if>
							
				            <c:if test="${not empty b.originName}">
				                <span><img height="15" width="15" alt="이미지 첨부유무" src="/resources/img/board/ico_img.gif"></span>
				            </c:if>
				            
				        </td>
				        <td>${b.memberId}</td>
				        <td>${b.boardView}</td>
				    </tr>
				</c:forEach>
				        </tbody>
        </table>
        <br>

		<div class="layout-pagination">
			  <div class="pagediv">
			    <a href="#main" class="layout-pagination-button layout-pagination-first-page">맨 처음 페이지로 가기</a>
			    <a href="#main" class="layout-pagination-button layout-pagination-prev-page">이전 페이지로 가기</a>
			
			    <c:forEach begin="${pageInfo.startPage}" end="${pageInfo.endPage}" var="pageNumber">
			      <c:choose>
			        <c:when test="${pageNumber == pageInfo.currentPage}">
			          <span>
			            <strong class="layout-pagination-button layout-pagination-number __active">${pageNumber}</strong>
			          </span>
			        </c:when>
			        <c:otherwise>
			          <span>
			            <strong class="layout-pagination-button layout-pagination-number">${pageNumber}</strong>
			          </span>
			        </c:otherwise>
			      </c:choose>
			    </c:forEach>
			
			    <a href="#main" class="layout-pagination-button layout-pagination-next-page">다음 페이지로 가기</a>
			    <a href="#main" class="layout-pagination-button layout-pagination-last-page">맨 끝 페이지로 가기</a>
			  </div>
			</div>

    </div>
    
    <br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br>

        <script>
        // 버튼 요소를 선택합니다.
        const button = document.querySelector('.btn-secondary');

        // 마우스 오버 이벤트 리스너를 추가합니다.
        button.addEventListener('mouseover', function() {
        // 버튼이 작아지는 애니메이션 효과를 위한 클래스를 추가합니다.
        button.classList.add('hovered');
        });

        // 마우스 아웃 이벤트 리스너를 추가합니다.
        button.addEventListener('mouseout', function() {
        // 애니메이션 클래스를 제거합니다.
        button.classList.remove('hovered');
        });
        
         $(function() {
        	$("#freeboard>tbody>tr").click(function() {
        		let bno = $(this).children(".bno").text();
        		location.href = "detail.bo?bno=" + bno; //
        	});
        });
         
         $(function() {
          	$("#bestboard>tbody>tr").click(function() {
          		let bno = $(this).children(".bno").text();
          		location.href = "detail.bo?bno=" + bno; //
          	});
          }); 
          
         
         

      </script>  
      
      <script src="/resources/js/common/header.js"></script>
	  <script src="/resources/js/board/board.js"></script>


	<jsp:include page="/WEB-INF/views/common/footer.jsp"/> 

</body>
</html>