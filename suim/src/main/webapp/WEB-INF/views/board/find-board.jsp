<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page import="java.util.Date" %>




 
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
        
        
<title>사람구해요</title>
		<%@ include file="/WEB-INF/views/common/include.jsp" %>
		<link href="/resources/css/user/signup.css" rel="stylesheet" />

</head>	




<body>	    
	 <jsp:include page="/WEB-INF/views/common/header.jsp"/>


		<div class="container" style="margin-top: 120px;">
        <h1>사람구해요</h1>
        <br><br><br><br>



		
   <form id="enrollForm" method="get" action="list.fi" enctype="multipart/form-data">     
    <div class="search-filter">
    

<div class="search-find" style="display: flex;">
    <input type="text"  id = "search" placeholder="제목을 입력해주세요." name="search" value="" style="border: 2px solid pink; border-radius: 10px 0 0 10px; padding: 5px; flex: 1; margin-right: -2px;">
    <button type="submit" style="border: 2px solid pink; border-radius: 0 10px 10px 0; background-color: white; margin-left: -2px;">
        <i class="fa fa-search" style="color: rgb(249, 88, 10)"></i>
    </button>
</div>

		
    <label for="sex">성별:</label>
    <select id="sex" name="gender" style="border-radius: 8px;">
        <option value="all">성별을 선택하세요</option>
        <option value="M" >남자</option>
        <option value="F" >여자</option>
    </select>

    &nbsp;&nbsp;

    <label for="condition">조건:</label>

    <select id="condition" name="category" style="border-radius: 8px;">
        <option value="all">조건을 선택하세요</option>
        <option value="방구해요" >방구해요</option>
        <option value="세놓아요" >세놓아요</option>

    </select>
    &nbsp;

    <button onclick="updateTableList()" class="btn btn-secondary2" style="display: inline-block; vertical-align: middle; line-height: 20px; background-color: rgb(250,107,111); height: 20px; text-decoration: none; color: #fff; padding: 0 10px; font-size: medium; margin-bottom: 03px;">검색</button>
	</div>
	</form>

        



        <h2></h2>
        <br><br><br>
		



		
    <a class="btn btn-secondary" style="display: inline-block; vertical-align: middle; line-height: 20px; background-color: rgb(250,107,111); height: 20px; text-decoration: none; color: #fff; padding: 0 10px; font-size: medium; margin-left: 1220px;" onclick="checkLogin()">
        글작성
    </a>
		
		        

        <table class="table" style="text-align: center;" id="freeboard">
        <thead>
            <tr>
                <th width="60px">번호</th>
                <th width="120px">등록일</th>
                <th width="100px">카테고리</th>
                <th width="50px">성별</th>
                <th width="500px">제목</th>
                <th width="90px">작성자</th>
                <th width="90px">조회수</th>
            </tr>
        </thead>

        <tbody>
				<c:if test="${empty flist}">
    <tr>
        <td colspan="8">게시글이 없습니다.</td>
    </tr>
</c:if>
<c:if test="${not empty flist}">
    <c:forEach var="fb" items="${flist}">
        <tr>
            <td class="fno">${fb.findNo}</td>
            <td>${fb.findDate}</td>
            <td>${fb.category}</td>
            <td>
                <c:choose>
                    <c:when test="${fb.gender == 'M'}">
                        남자
                    </c:when>
                    <c:when test="${fb.gender == 'F'}">
                        여자
                    </c:when>
                    <c:otherwise>
                        성별 정보 없음
                    </c:otherwise>
                </c:choose>
            </td>
            <td>
                <c:if test="${empty fb.findTitle}">
                    게시글이 없습니다.
                </c:if>
                <c:if test="${not empty fb.findTitle}">
                    <c:out value="${fb.findTitle}"/>
                    <span id="rcount">(${fb.freplyCount})</span>
                    <fmt:formatDate var="today" pattern="yyyy-MM-dd" value="<%= new Date() %>" />
                    <c:if test="${not empty fb.findDate and fb.findDate == today}">
                        <span><img height="15" width="15" alt="최신등록일자" src="/resources/img/board/ico_new.gif"></span>	
                    </c:if>
                    <c:if test="${not empty fb.thumbnail}">
                        <span><img height="15" width="15" alt="이미지 첨부유무" src="/resources/img/board/ico_img.gif"></span>
                    </c:if>
                </c:if>
            </td>
            <td>${fb.nickName}</td>
            <td>${fb.findView}</td>
        </tr>
    </c:forEach>
</c:if>

				        </tbody>
        </table>
	
	
       


<div id="pagingArea" style="margin-top: 22px;">
  <ul class="pagination">
    <c:choose>
      <c:when test="${pi.currentPage eq 1}">
        <li class="page-item disabled"><a class="page-link" href="#" style="background-color: white; color: rgb(250, 107, 111);"><</a></li>
      </c:when>
      <c:otherwise>
        <li class="page-item"><a class="page-link" href="list.fi?cPage=${pi.currentPage - 1}"><</a></li>
      </c:otherwise>
    </c:choose>

    <c:set var="hasPosts" value="${not empty flist}" />
    <c:if test="${hasPosts}">
      <c:forEach var="p" begin="${pi.startPage}" end="${pi.endPage}" step="1">
        <li class="page-item"><a class="page-link" href="list.fi?cPage=${p}&search=${param.search}&gender=${param.gender}&category=${param.category}" style="background-color: white; color: rgb(250, 107, 111);">${p}</a></li>
      </c:forEach>
    </c:if>

    <c:choose>
      <c:when test="${pi.currentPage eq pi.maxPage}">
        <li class="page-item disabled"><a class="page-link" href="#" style="background-color: white; color: rgb(250, 107, 111);">></a></li>
      </c:when>
      <c:otherwise>
        <li class="page-item"><a class="page-link" href="list.fi?cPage=${pi.currentPage + 1}&search=${param.search}&gender=${param.gender}&category=${param.category}" style="background-color: white; color: rgb(250, 107, 111);">></a></li>
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
         		let fno = $(this).children(".fno").text();
         		location.href = "detail.fi?fno=" + fno; //
         	});
         });
         
      // 페이지 로드 시 저장된 옵션 가져오기
         document.addEventListener("DOMContentLoaded", function() {
           var storedGender = localStorage.getItem("selectedGender");
           var storedCategory = localStorage.getItem("selectedCategory");
           var storedSearch = localStorage.getItem("selectedSearch");
           if (storedGender) {
             document.getElementById("sex").value = storedGender;
           }

           if (storedCategory) {
             document.getElementById("condition").value = storedCategory;
           }
           if (storedSearch) {
               document.getElementById("search").value = storedSearch;
             }
         });

         function updateTableList() {
           // 선택된 값 가져오기
           var gender = document.getElementById("sex").value;
           var category = document.getElementById("condition").value;
           var search = document.getElementById("search").value;

           // 선택된 값 localStorage에 저장
           localStorage.setItem("selectedGender", gender);
           localStorage.setItem("selectedCategory", category);
           localStorage.setItem("selectedSearch", search);

           // 선택된 값에 따라 데이터 처리 및 결과 노출
           var results = []; // 결과를 저장할 배열

           // 예시로서, 선택된 성별과 조건에 따라 결과를 설정
           if (gender === "M" && category === "방구해요") {
             results = ["남자 - 방구해요 결과 1", "남자 - 방구해요 결과 2"];
           } else if (gender === "M" && category === "세놓아요") {
             results = ["남자 - 세놓아요 결과 1", "남자 - 세놓아요 결과 2"];
           } else if (gender === "F" && category === "방구해요") {
             results = ["여자 - 방구해요 결과 1", "여자 - 방구해요 결과 2"];
           } else if (gender === "F" && category === "세놓아요") {
             results = ["여자 - 세놓아요 결과 1", "여자 - 세놓아요 결과 2"];
           }

           // 결과 노출
           var resultContainer = document.getElementById("resultContainer");
           resultContainer.innerHTML = ""; // 이전 결과 초기화

           if (results.length > 0) {
             for (var i = 0; i < results.length; i++) {
               var resultItem = document.createElement("p");
               resultItem.textContent = results[i];
               resultContainer.appendChild(resultItem);
             }
           } else {
             var noResults = document.createElement("p");
             noResults.textContent = "검색 결과가 없습니다.";
             resultContainer.appendChild(noResults);
           }

           // 폼 제출 방지
           event.preventDefault();
         }
         
         document.addEventListener("DOMContentLoaded", function() {
        	  var storedGender = localStorage.getItem("selectedGender");
        	  var storedCategory = localStorage.getItem("selectedCategory");
        	  var storedSearch = localStorage.getItem("selectedSearch");

        	  // 이전에 저장된 옵션을 가져오고, 해당 옵션이 유효한 경우에만 선택합니다.
        	  if (storedGender && document.getElementById("sex").querySelector(`option[value="${storedGender}"]`)) {
        	    document.getElementById("sex").value = storedGender;
        	  }

        	  if (storedCategory && document.getElementById("condition").querySelector(`option[value="${storedCategory}"]`)) {
        	    document.getElementById("condition").value = storedCategory;
        	  }
        	  
        	  if (storedCategory && document.getElementById("search").querySelector(`option[value="${selectedSearch}"]`)) {
          	    document.getElementById("search").value = storedCategory;
          	  }

        	  // 폼 제출 시 선택된 옵션을 저장합니다.
        	  document.getElementById("enrollForm").addEventListener("submit", function() {
        	    var gender = document.getElementById("sex").value;
        	    var category = document.getElementById("condition").value;
        	    var search = document.getElementById("search").value;

        	    localStorage.setItem("selectedGender", gender);
        	    localStorage.setItem("selectedCategory", category);
        	    localStorage.setItem("selectedSearch", search);
        	  });
        	});

        	// 페이지 로드 시 localStorage의 값을 초기화합니다.
        	window.addEventListener("load", function() {
        	  localStorage.removeItem("selectedGender");
        	  localStorage.removeItem("selectedCategory");
        	  localStorage.removeItem("selectedSearch");
        	});
        	
        	 function checkLogin() {
                 // 이 부분에 로그인 여부를 체크하는 로직을 구현합니다.
                 var isLoggedIn = ${not empty loginUser}; // loginUser 변수를 사용하여 로그인 여부를 체크

                 if (isLoggedIn) {
                     // 로그인된 경우
                     window.location.href = "enrollForm.fi"; // 글작성 페이지로 이동
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