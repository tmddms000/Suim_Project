<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
 
<head>
<meta charset="UTF-8">

	    <link rel="stylesheet" href="/resources/css/summernote/summernote-lite.css">
        <link rel="stylesheet" href="/resources/css/board/board.css">
		<link href="/resources/css/user/signup.css" rel="stylesheet" />
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
        <!-- 게시판 js -->
        <script src="/resources/js/board/board.js"></script>
        <!-- 나중에 한번에 include 할 부분 -->


        
<title>자유게시판</title>

		<%@ include file="/WEB-INF/views/common/include.jsp" %>
		

</head>	


<body>	    
	 <jsp:include page="/WEB-INF/views/common/header.jsp"/>

	  <div class="content">
        <br><br><br><br>
        <div class="innerOuter">
            <h2>자유게시판 수정하기</h2>
            <br><br>

            <form id="enrollForm" method="post" action="" enctype="">
                <table algin="center">
                    <tr>
                        <th><label for="title">제목</label></th>
                        <td><input type="text" id="title" class="form-control" name="" required></td>
                    </tr>
                    <tr>
                        <th style="width: 80px;"><label for="writer">작성자</label></th>
                        <td><input type="text" id="writer" class="form-control" value="user01" name="" readonly></td>
                    </tr>

                    <tr>
                        <th><label for="content">내용</label></th>
                        <td>
                            <textarea id="summernote" class="form-control" rows="10" style="resize:none; height: 200px;" name="" required></textarea>
                        </td>
                    </tr>
                </table>
                <br>

                <div align="center">
                    <button type="submit" class="btn btn-primary">수정하기</button>
                    <button type="reset" class="btn btn-danger">취소하기</button>
                </div>
            </form>
        </div>
    </div>
    
    
	<script src="/resources/js/summernote/summernote-lite.js"></script>
    <script src="/resources/js/summernote/lang/summernote-ko-KR.js"></script>
    
     <script>
        $(document).ready(function () {
          //여기 아래 부분
          $('#summernote').summernote({
            height: 10, // 에디터 높이
            focus: true, // 에디터 로딩후 포커스를 맞출지 여부
            lang: 'ko-KR', // 한글 설정
            placeholder: '내용',
            disableResizeEditor: true, // 크기 조절 기능 삭제
            toolbar: [
              ['fontname', ['fontname']],
              ['fontsize', ['fontsize']],
              ['style', ['bold', 'italic', 'underline', 'strikethrough', 'clear']],
              ['color', ['forecolor', 'color']],
              ['table', ['table']],
              ['para', ['ul', 'ol', 'paragraph']],
              ['height', ['height']],
              ['insert', ['picture', 'link', 'video']],
              ['view', ['fullscreen', 'codeview']],
              ['help', ['help']],
            ],
            fontNames: ['Arial', 'Arial Black', 'Comic Sans MS', 'Courier New', '맑은 고딕', '궁서', '굴림체', '굴림', '돋움체', '바탕체'],
            fontSizes: ['8', '9', '10', '11', '12', '14', '16', '18', '20', '22', '24', '28', '30', '36', '50', '72'],
          });
        });

        // 서머노트에 text 쓰기
        $('#summernote').summernote('insertText', '내용');


        // 서머노트 쓰기 비활성화
        $('#summernote').summernote('disable');

        // 서머노트 쓰기 활성화
        $('#summernote').summernote('enable');


        // 서머노트 리셋
        $('#summernote').summernote('reset');


        // 마지막으로 한 행동 취소 ( 뒤로가기 )
        $('#summernote').summernote('undo');
        // 앞으로가기
        $('#summernote').summernote('redo');
      </script>
    
	<jsp:include page="/WEB-INF/views/common/footer.jsp"/>
	

</body>
</html>