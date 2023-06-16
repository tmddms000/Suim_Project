<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>


	 <link rel="stylesheet" href="/resources/css/summernote/summernote-lite.css">


	<%@ include file="../common/include.jsp" %>

	<div class="container-xxl position-relative bg-white d-flex p-0">
	
	    <!-- Spinner Start -->
		<%@ include file="../common/spinner.jsp" %>
        <!-- Spinner End -->


        <!-- Sidebar Start -->
		<%@ include file="../common/sidebar.jsp" %>
        <!-- Sidebar End -->


        <!-- Content Start -->
        <div class="content">

            <!-- Navbar Start -->
			<%@ include file="../common/navbar.jsp" %>
            <!-- Navbar End -->

        <div class="content">
        <br><br><br><br>
        <div class="innerOuter">

            <h2>사람구해요 수정하기</h2>

            <br><br>

            <form id="enrollForm" method="post" action="/adminFreeUpdate.bo" enctype="multipart/form-data">
            <input type="hidden" name="findNo" value="${ fb.findNo }">
                <table algin="center">
                    <tr>
                        <th><label for="title">제목</label></th>
                        <td><input type="text" id="title" class="form-control" name="findTitle" required value="${ fb.findTitle }"></td>
                    </tr>
                    <tr>
                        <th style="width: 80px;"><label for="writer">작성자</label></th>
                        <td><input type="text" id="writer" class="form-control" value="${loginUser.nickName}" name="memberId" readonly></td>
                    </tr>
                    
				<tr>
				    <th style="width: 80px;"><label for="category">카테고리</label></th>
				    <td>
				        <input type="checkbox" id="personNeeded" name="category" value="방구해요" ${fb.category eq '방구해요' ? 'checked' : ''} style="transform: scale(1.5);" onclick="uncheckOtherCheckbox('personNeeded');">
				        <label for="personNeeded" style="font-size: 20px;">방구해요</label>
				        <input type="checkbox" id="roomAvailable" name="category" value="세놓아요" ${fb.category eq '세놓아요' ? 'checked' : ''} style="transform: scale(1.5);" onclick="uncheckOtherCheckbox('roomAvailable');">
				        <label for="roomAvailable" style="font-size: 20px;">세놓아요</label>
				    </td>
				</tr>




			
                    <tr>
                        <th><label for="content">내용</label></th>
                        <td>
                            <textarea id="summernote" class="form-control" name="findContent" rows="10" style="resize:none; height: 200px;"  required>${ fb.findContent }</textarea>
                        </td>
                    </tr>
                </table>
                <br>
                <div align="center">
                    <button type="submit" class="btn btn-primary">수정하기</button>
                    <button type="reset" class="btn btn-danger" onclick="goBack()">취소하기</button>
                </div>
            </form>
        </div>
    </div>
    
    
	<script src="/resources/js/summernote/summernote-lite.js"></script>
    <script src="/resources/js/summernote/lang/summernote-ko-KR.js"></script>
    
    <script>
	  function goBack() {
	    window.history.back();
	  }
	</script>
    
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
   
        
 	       $('#boardcontent').summernote('editor.insertText', "${board_data.BOARD_COTENT}")
 	       
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
	    	        
	    	        $(document).ready(function() { $('#getValueButton').click(function() { var checkedValue = $('input[type="checkbox"]:checked').val(); if (checkedValue) { console.log(checkedValue); } else { console.log("No checkbox is checked."); } }); });
 	       
 	       
      </script>
      
                  <br clear="both"><br>
            
            <!-- Footer Start -->
			<%@ include file="../common/footer.jsp" %>
            <!-- Footer End -->
        </div>
        <!-- Content End -->

	</div>
      