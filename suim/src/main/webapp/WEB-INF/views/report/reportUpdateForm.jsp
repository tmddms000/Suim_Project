<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<head>
    <meta charset="UTF-8">

    <%@ include file="/WEB-INF/views/common/include.jsp" %>

<link rel="stylesheet" href="/resources/css/summernote/summernote-lite.css">
<link rel="stylesheet" href="/resources/css/report/report.css">
</head>
<body>	    
    <jsp:include page="/WEB-INF/views/common/header.jsp"/>

     <div class="container">
       <br><br><br><br>
       <div class="innerOuter">
           <h2>신고합니다</h2>
           <br><br>

           <form id="enrollForm" method="post" action="insert.re" enctype="multipart/form-data">

           		<c:set var="parsedReportId" value="${empty r.reportId ? '' : r.reportId}" />
				<input type="hidden" name="reportId" value="${parsedReportId}" />
           		
           		<c:set var="parsedHouseNo" value="${empty r.houseNo ? 0 : Integer.parseInt(r.houseNo)}" />
				<input type="hidden" name="houseNo" value="${parsedHouseNo}" />
				
				<c:set var="parsedFindNo" value="${empty r.findNo ? 0 : Integer.parseInt(r.findNo)}" />
				<input type="hidden" name="findNo" value="${parsedFindNo}" />
				
				<c:set var="parsedFreNo" value="${empty r.freNo ? 0 : Integer.parseInt(r.freNo)}" />
				<input type="hidden" name="freNo" value="${parsedFreNo}" />
				
				<c:set var="parsedBoardNo" value="${empty r.boardNo ? 0 : Integer.parseInt(r.boardNo)}" />
				<input type="hidden" name="boardNo" value="${parsedBoardNo}" />
				
				<c:set var="parsedBreNo" value="${empty r.breNo ? 0 : Integer.parseInt(r.breNo)}" />
				<input type="hidden" name="breNo" value="${parsedBreNo}" />
				
				<c:set var="parsedChatNo" value="${empty r.chatNo ? 0 : Integer.parseInt(r.chatNo)}" />
				<input type="hidden" name="chatNo" value="${parsedChatNo}" />
				
               <table align="center">
               		<tr>
                       <th><label for="type">유형</label></th>
                       <td>
                       		<select class="form-select form-select-sm mb-3" name="reportType" id="type" required onchange="updateHiddenInput()">
		                        <option value="">선택</option>
		                        <option value="MEMBER">회원</option>
		                        <option value="HOUSE">셰어하우스</option>
		                        <option value="BOARD">자유게시판</option>
		                        <option value="BRE">자유게시판 댓글</option>
		                        <option value="FIND">사람구해요</option>
		                        <option value="FRE">사람구해요 댓글</option>
		                        <option value="CHAT">채팅방</option>
				            </select>
                       </td>
                   </tr>
                   <script>
                   function updateHiddenInput() { 
                	   var select = document.getElementById("mySelect"); 
                	   var hiddenInput = document.getElementById("hiddenInput"); 
                	   hiddenInput.value = select.value; 
                	  }
                   </script>
                   <input type="hidden" name="hiddenInput" id="reportTypeHidden" value="">
                   <tr>
                       <th><label for="title">제목</label></th>
                       <td><input type="text" id="title" class="form-control" name="reportTitle" required value="${ r.reportTitle }"></td>
                   </tr>
                   <tr>
                       <th style="width: 80px;"><label for="writer">작성자</label></th>
                       <td><input type="text" id="writer" class="form-control" value="${loginUser.memberId}" name="memberId" readonly></td>
                   </tr>

                   <tr>
                       <th><label for="content">내용</label></th>
                       <td>
                           <textarea id="summernote" class="form-control" name="reportContent" rows="10" style="resize:none; height: 200px;"  required>${ r.reportContent }</textarea>
                       </td>
                   </tr>
               </table>
               <br>
               <div align="center">
                   <button type="submit" class="btn btn-primary">작성하기</button>
                   <button type="reset" class="btn btn-danger">취소하기</button>
               </div>
           </form>
       </div>
   </div>

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
	            	uploadSummerNoteImageFile(files[i],
	            this);
	            		}
	            	}
	            }
	         };
	        $('#summernote').summernote(setting);
	        });
	        
	        function uploadSummerNoteImageFile(file, el) {
				data = new FormData();
				data.append("file", file);
				$.ajax({
					data : data,
					type : "POST",
					url : "/uploadSummerNoteImageFile",
					contentType : false,
					enctype : 'multipart/form-data',
					processData : false,
					success : function(data) {
						$(el).summernote('editor.insertImage', data.url);
					}
				});
			}
   
        
 	     //  $('#reportcontent').summernote('editor.insertText', "${report_data.REPORT_COTENT}")
	</script>

	<script src="/resources/js/summernote/summernote-lite.js"></script>
	<script src="/resources/js/summernote/lang/summernote-ko-KR.js"></script>
	
   <jsp:include page="/WEB-INF/views/common/footer.jsp"/>
	

</body>
</html>