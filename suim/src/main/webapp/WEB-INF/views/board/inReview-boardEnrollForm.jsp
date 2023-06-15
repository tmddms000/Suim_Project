<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
 
<head>
<meta charset="UTF-8">
		  <!-- 서머노트를 위해 추가해야할 부분 -->
	   <script src="/resources/js/summernote/summernote-lite.js"></script>
	   <script src="/resources/js/summernote/lang/summernote-ko-KR.js"></script>
	   <link rel="stylesheet" href="/resources/css/summernote/summernote-lite.css">
	   
	   <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/sweetalert2@11.4.10/dist/sweetalert2.min.css">
	   <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11.4.10/dist/sweetalert2.min.js"></script>
	    
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
        
        
        
<title>이용후기</title>
		<%@ include file="/WEB-INF/views/common/include.jsp" %>
		<link href="/resources/css/user/signup.css" rel="stylesheet" />

</head>	




<body>	    
	 <jsp:include page="/WEB-INF/views/common/header.jsp"/>

	 <div class="content">
        <br><br><br><br>
        <div class="innerOuter">
            <h2>이용후기 작성하기</h2>
            <br><br>

            <form id="enrollForm" method="post" action="insert.in" enctype="multipart/form-data">
                <table algin="center">
                    <tr>
                        <th><label for="title">제목</label></th>
                        <td><input type="text" id="title" class="form-control" name="inrTitle" value="" required></td>
                    </tr>
                    
                    <tr>
                        <th style="width: 80px;"><label for="writer">작성자</label></th>
                        <td><input type="text" id="writer" class="form-control" value="${loginUser.nickName}" name="memberNickname" readonly>
                        	<input type="hidden" value="${loginUser.memberId}" name="memberId" readonly>
                        </td>
                        	
                    </tr>

                    <tr>
                        <th><label for="content">내용</label></th>
                        <td><textarea id="summernote" class="form-control" rows="10" style="resize:none;" name="inrContent" required></textarea></td>
                    </tr>
                </table>
                <br>

                <div align="center">
                    <button type="submit" class="btn btn-primary">등록하기</button>
                    <button type="reset" class="btn btn-danger">취소하기</button>
                </div>
            </form>
        </div>
    </div>
    
    <br><br><br><br><br>
    

      <script src="/resources/js/common/header.js"></script>
      <script src="/resources/js/summernote/summernote-lite.js"></script>
      <script src="/resources/js/summernote/lang/summernote-ko-KR.js"></script>


	


	<jsp:include page="/WEB-INF/views/common/footer.jsp"/>
	
	      <script>
	      $(document).ready(function() {

	    		var toolbar = [
	    			    // 글꼴 설정
	    			    ['fontname', ['fontname']],
	    			    // 글자 크기 설정
	    			    ['fontsize', ['fontsize']],
	    			    // 굵기, 기울임꼴, 밑줄,취소 선, 서식지우기
	    			    ['style', ['bold', 'italic', 'underline','strikethrough', 'clear']],
	    			    // 글자색
	    			    ['color', ['forecolor','color']],
	    			    // 표만들기
	    			    ['table', ['table']],
	    			    // 글머리 기호, 번호매기기, 문단정렬
	    			    ['para', ['ul', 'ol', 'paragraph']],
	    			    // 줄간격
	    			    ['height', ['height']],
	    			    // 그림첨부, 링크만들기, 동영상첨부
	    			    ['insert',['picture','link','video']],
	    			    // 코드보기, 확대해서보기, 도움말
	    			    ['view', ['codeview','fullscreen', 'help']]
	    			  ];

	    		// 툴바생략
	    		var setting = {
	    	            height : 300,
	    	            minHeight : null,
	    	            maxHeight : null,
	    	            focus : true,
	    	            lang : 'ko-KR',
	    	            toolbar : toolbar,
	    	            //콜백 함수
	    	            callbacks : { 
	    	            	onImageUpload : function(files, editor, welEditable) {
	    	            // 파일 업로드(다중업로드를 위해 반복문 사용)
	    	            for (var i = files.length - 1; i >= 0; i--) {
	    	            uploadSummernoteImageFile(files[i],
	    	            this);
	    	            		}
	    	            	}
	    	            }
	    	         };
	    	        $('#summernote').summernote(setting);
	    	        });
	    	        
	    	        function uploadSummernoteImageFile(file, el) {
	    				data = new FormData();
	    				data.append("file", file);
	    				$.ajax({
	    					data : data,
	    					type : "POST",
	    					url : "/uploadSummernoteImageFile",
	    					contentType : false,
	    					enctype : 'multipart/form-data',
	    					processData : false,
	    					success : function(data) {
	    						$(el).summernote('editor.insertImage', data.url);
	    					}
	    				});
	    			}
	    	        function uncheckOtherCheckbox(checkboxId) {
	    	            if (checkboxId === 'personNeeded') {
	    	                document.getElementById('roomAvailable').checked = false;
	    	            } else if (checkboxId === 'roomAvailable') {
	    	                document.getElementById('personNeeded').checked = false;
	    	            }
	    	        }

	    	        document.getElementById("enrollForm").addEventListener("submit", function(event) {
	    	            // summernote 내용 가져오기
	    	            var content = document.getElementById("summernote").value;
	    	            
	    	            // 내용에 이미지 태그가 최소 하나 이상 있는 경우에만 폼 제출
	    	            if (hasImageTag(content)) {
	    	                return true;  // 폼 제출
	    	            } else {
	    	                event.preventDefault();  // 폼 제출 방지
	    	                
	    	                // 경고창 표시
	    	                Swal.fire({
								  title: '경고!',
								  text: '이미지 1개이상 꼭 등록해주세요!',
								  imageUrl: 'https://unsplash.it/400/200',
								  imageWidth: 400,
								  imageHeight: 200,
								  imageAlt: 'Custom image',
								})
	    	                return false;
	    	            }
	    	        });
	    	        
	    	        // 내용에 이미지 태그 확인 함수
	    	        function hasImageTag(content) {
	    	            var div = document.createElement("div");
	    	            div.innerHTML = content;
	    	            var images = div.getElementsByTagName("img");
	    	            return (images.length > 0);
	    	        }
	          
	         
      </script>
	
        

</body>
</html>