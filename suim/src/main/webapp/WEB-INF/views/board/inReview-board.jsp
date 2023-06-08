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
        
        
<title>입주후기</title>
		<%@ include file="/WEB-INF/views/common/include.jsp" %>
		<link href="/resources/css/user/signup.css" rel="stylesheet" />

</head>	




<body>	    
	 <jsp:include page="/WEB-INF/views/common/header.jsp"/>



	
	 <div class="container" style="margin-top: 120px;">
        <h1>입주후기</h1>
        <br><br>



         

        
<c:if test="${not empty loginUser}">
    <a class="btn btn-secondary" style="display: inline-block; vertical-align: middle; line-height: 30px; background-color: rgb(250,107,111); height: 30px; text-decoration: none; color: #fff; padding: 0 10px; font-size: medium; margin-left: 1196px; margin-bottom: 12px; width: 100px;" href="enrollForm.bo">
        후기작성
    </a>
</c:if>
        
       <!-- Gallery -->
<div class="row">
  <div class="col-lg-4 col-md-12 mb-4 mb-lg-0">
    <img
      src="https://mdbcdn.b-cdn.net/img/Photos/Horizontal/Nature/4-col/img%20(73).webp"
      class="w-100 shadow-1-strong rounded mb-4"
      alt="Boat on Calm Water"
    />
	
    <img
      src="https://mdbcdn.b-cdn.net/img/Photos/Vertical/mountain1.webp"
      class="w-100 shadow-1-strong rounded mb-4"
      alt="Wintry Mountain Landscape"
    />
  </div>

  <div class="col-lg-4 mb-4 mb-lg-0">
    <img
      src="https://mdbcdn.b-cdn.net/img/Photos/Vertical/mountain2.webp"
      class="w-100 shadow-1-strong rounded mb-4"
      alt="Mountains in the Clouds"
    />

    <img
      src="https://mdbcdn.b-cdn.net/img/Photos/Horizontal/Nature/4-col/img%20(73).webp"
      class="w-100 shadow-1-strong rounded mb-4"
      alt="Boat on Calm Water"
    />
  </div>

  <div class="col-lg-4 mb-4 mb-lg-0">
    <img
      src="https://mdbcdn.b-cdn.net/img/Photos/Horizontal/Nature/4-col/img%20(18).webp"
      class="w-100 shadow-1-strong rounded mb-4"
      alt="Waves at Sea"
    />

    <img
      src="https://mdbcdn.b-cdn.net/img/Photos/Vertical/mountain3.webp"
      class="w-100 shadow-1-strong rounded mb-4"
      alt="Yosemite National Park"
    />
  </div>
</div>
<!-- Gallery -->
       

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
         
         
          
         
         

      </script>  
      
      <script src="/resources/js/common/header.js"></script>
	  <script src="/resources/js/board/board.js"></script>


	<jsp:include page="/WEB-INF/views/common/footer.jsp"/> 

</body>
</html>