<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page import="java.util.Date" %>
<%@ page import="com.suim.event.model.vo.Event" %>
<%@ page import="com.suim.event.model.vo.Eattachment" %>



<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">

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
        <link href="/resources/css/event/event.css" rel="stylesheet" />
   
   
        
        
<title>이벤트 게시판</title>
		<%@ include file="/WEB-INF/views/common/include.jsp" %>
		<link href="/resources/css/user/signup.css" rel="stylesheet" />
<style>

	    .bestcontainer {
            display: grid;
            grid-template-columns: repeat(2, 1fr);
            grid-gap: 20px;
        }

        .item {
            border: 1px solid #ddd;
            padding: 10px;
        }
        
        .item .title:hover {
		 color: rgb(250, 107, 111);
		  cursor: pointer;
		  font-size: x-large;
		}
		#rcount {
		color: rgb(250, 107, 111);
		}
		#pagingArea {
		  display: flex;
		  justify-content: center;
		}
		
		.pagination {
		  display: flex;
		  list-style: none;
		  padding: 0;
		  justify-content: center;

		}
		
		.page-item {
		  margin: 0 5px;

		}

		.title {
			text-align: left;
			width : 70%;
		}
		
		.eventView {
			border-bottom-color: green;
			text-align: center;
		}
		
		.eventCategory {
			border-bottom-color: green;
		}
		
		.createDate {
			text-align: center;
		}


</style>     
</head>	




<body>	    
	 <jsp:include page="/WEB-INF/views/common/header.jsp"/>


		<div class="container main" style="margin-top: 120px;">
        <h1>이벤트</h1>
        



		
	   

        



        <h2></h2>
        
		


		<!-- 관리자만 글 작성 가능하게 해야함 -->
		<c:if test="${ not empty loginUser and loginUser.memberId eq ('google969548') }">
		    <a class="btn btn-secondary" style="display: inline-block; vertical-align: middle; line-height: 20px; background-color: rgb(250,107,111); height: 20px; text-decoration: none; color: #fff; padding: 0 10px; font-size: medium; margin-left: 1220px;" href="enrollForm.ev">
		       	 글작성
	 		</a>
		</c:if>
		        
					
        <table id="event-table" class="table" style="border-bottom-color : green;">
        
        	<thead>
        		
        			
        		
            	<tr class="table-header">
	                <td class="eListNo" hidden>No</td>
					<td style="width : 10%;" class="eventCategory">카테고리</td>
	                <td class="title">제목</td>
	                <td class="createDate">작성일</td>
	                <td class="eventView">조회수</td>
            	</tr>
         	</thead>
         	<tbody>
         	
         		<!-- 이벤트 카테고리별로 다른 게 나오게 함 -->
         		<c:forEach var="e" items="${ list }">
         		
		            <tr class="table-row" style="background-color:none;">
		            	<td class="eListNo, eno" hidden>${ e.eventNo }</td>
		            	<td class="eventCategory">${e.eventCategory }</td>
		            	<td class="title">
		                	${ e.eventTitle }
		                </td>
		                <td class="createDate"><fmt:formatDate pattern="yyyy-MM-dd" value="${e.eventDate }" /></td>
		                <td class="eventView" style="width : 20%;">${ e.eventView }</td>
		            </tr>
		            
            	</c:forEach>
         	
         </tbody>
         </table>
	<script>

	
	$(function() {
      	$("#event-table>tbody>tr").click(function() {
      		let eno = $(this).children(".eno").text();
      		location.href = "detail.ev?eno=" + eno; //
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
                			<li class="page-item"><a class="page-link" href="<c:url value='event.ev?cPage=${ pi.currentPage - 1 }&category=${e.eventCategory}'/>">Previous</a></li>
                		</c:otherwise>
                	</c:choose>
                    
                    <c:forEach var="p" begin="${ pi.startPage }" end="${ pi.endPage }" step="1">
                    	<li class="page-item"><a class="page-link" href="<c:url value='event.ev?cPage=${ p }&category=${e.eventCategory}'/>">${ p }</a></li>
                    </c:forEach>
                    
                    <c:choose>
                    	<c:when test="${ pi.currentPage eq pi.maxPage }">
                    		<li class="page-item disabled"><a class="page-link" href="#">Next</a></li>
                    	</c:when>
                    	
                    	<c:otherwise>
                    		<li class="page-item"><a class="page-link" href="<c:url value='event.ev?cPage=${ pi.currentPage + 1 }&category=${e.eventCategory}'/>">Next</a></li>
                    	</c:otherwise>
                    </c:choose>
            	</ul>
            </div>
            
            
   
    
    <br><br><br><br><br><br><br><br><br><br><br><br><br><br><br>
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
      
         
        
              

            
        
        
         
         

      </script>  
      
      <script src="/resources/js/common/header.js"></script>


	<jsp:include page="/WEB-INF/views/common/footer.jsp"/> 

</body>
</html>