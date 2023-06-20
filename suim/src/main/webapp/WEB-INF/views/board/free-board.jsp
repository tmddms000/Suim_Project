<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page import="java.util.Date" %>
<head>
<meta charset="UTF-8">
		<%@ include file="/WEB-INF/views/common/include.jsp" %>
        <link rel="stylesheet" href="/resources/css/summernote/summernote-lite.css">
        <link rel="stylesheet" href="/resources/css/board/board.css">
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"></script>
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
</style>        
        
     
<title>자유게시판</title>

</head>	


<body>	    
	 <jsp:include page="/WEB-INF/views/common/header.jsp"/>



	
	 <div class="container" style="margin-top: 120px;">
        <h1>자유게시판</h1>
        <br><br>



        <h2>베스트</h2>
        
			
			
			<div class="bestcontainer">
			  <c:forEach var="bs" items="${blist}" varStatus="status">
			    <c:if test="${status.index < 6}">
			      <div class="item" style ="font-size : 18px;">
			        <span class="number" style="font-weight : bolder;">${status.index + 1}</span>&nbsp;&nbsp;
			        <span class="title">${bs.boardTitle}  <span class= "bno" hidden>${bs.boardNo}</span> </span>
			        <td colspan="3"><span id="rcount">(${bs.replyCount})</span></td>
			      </div>
			    </c:if>
			  </c:forEach>
			</div>
		
											
          <br><br>
         

        
    <a class="btn btn-secondary" style="display: inline-block; vertical-align: middle; line-height: 20px; background-color: rgb(250,107,111); height: 20px; text-decoration: none; color: #fff; padding: 0 10px; font-size: medium; margin-left: 1220px;" onclick="checkLogin()">
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
				            <c:out value="${b.boardTitle}"/>
				            <span id="rcount">(${b.replyCount})</span>
				            <fmt:formatDate var="today" pattern="yyyy-MM-dd" value="<%= new Date() %>" />
							<c:if test="${not empty b.boardDate and b.boardDate == today}">
							    <span><img height="15" width="15" alt="최신등록일자" src="/resources/img/board/ico_new.gif"></span>	
							</c:if>
							
				            <c:if test="${not empty b.thumbnail}">
				                <span><img height="15" width="15" alt="이미지 첨부유무" src="/resources/img/board/ico_img.gif"></span>
				            </c:if>
				            
				        </td>
				        <td>${b.nickName}</td>
				        <td>${b.boardView}</td>
				    </tr>
				</c:forEach>
				        </tbody>
        </table>
       

		<div id="pagingArea"  style = "margin-top : 22px;">
                <ul class="pagination" >
                	
                	<c:choose>
                		<c:when test="${ pi.currentPage eq 1 }">
                    		<li class="page-item disabled" ><a class="page-link" href="#" style="background-color : white; color : rgb(250, 107, 111);"><</a></li>
                		</c:when>
                		<c:otherwise>
		                    <li class="page-item"><a class="page-link" href="list.bo?cPage=${ pi.currentPage - 1 }"><</a></li>
                		</c:otherwise>
                	</c:choose>
                    
                    
                    <c:forEach var="p" begin="${ pi.startPage }" end="${ pi.endPage }" step="1">
                    	<li class="page-item"><a class="page-link" href="list.bo?cPage=${ p }" style="background-color : white; color : rgb(250, 107, 111);">${ p }</a></li>
                    </c:forEach>
                    
                    <c:choose>
                    	<c:when test="${ pi.currentPage eq pi.maxPage }">
                    		<li class="page-item disabled"><a class="page-link" href="#" style="background-color : white; color : rgb(250, 107, 111);">></a></li>
                    	</c:when>
                    	<c:otherwise>
                    		<li class="page-item"><a class="page-link" href="list.bo?cPage=${ pi.currentPage + 1 }" style="background-color : white; color : rgb(250, 107, 111);"> ></a></li>
                    	</c:otherwise>
                    </c:choose>
                </ul>
            </div>

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
        
         $(function() {
        	$("#freeboard>tbody>tr").click(function() {
        		let bno = $(this).children(".bno").text();
        		location.href = "detail.bo?bno=" + bno; //
        	});
        });
         
         $(function() {
        	  $(".bestcontainer .item").click(function() {
        	    let bno = $(this).find(".bno").text();
        	    location.href = "detail.bo?bno=" + bno;
        	  });
        	});
         
    	 function checkLogin() {
             // 이 부분에 로그인 여부를 체크하는 로직을 구현합니다.
             var isLoggedIn = ${not empty loginUser}; // loginUser 변수를 사용하여 로그인 여부를 체크

             if (isLoggedIn) {
                 // 로그인된 경우
                 window.location.href = "enrollForm.bo"; // 글작성 페이지로 이동
             } else {
                 // 로그인되지 않은 경우
                 alert("글을 작성하려면 로그인이 필요합니다.");
                 window.location.href = "/member/login"; // 로그인 페이지로 이동
             }
         }
	
          
         
         

      </script>  
      
      <script src="/resources/js/common/header.js"></script>
	  <script src="/resources/js/board/board.js"></script>


	<jsp:include page="/WEB-INF/views/common/footer.jsp"/> 

</body>
</html>