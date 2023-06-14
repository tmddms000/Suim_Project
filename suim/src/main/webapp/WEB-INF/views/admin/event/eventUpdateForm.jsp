<%@page import="com.suim.notice.model.vo.Nattachment"%>
<%@page import="com.suim.notice.model.vo.Notice" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
 <!-- 부트스트랩 -->
     
     <link href="/resources/css/admin/style.css" rel="stylesheet" />
     <!-- 폰트어썸 icon -->
     <script src="https://use.fontawesome.com/releases/v6.3.0/js/all.js" crossorigin="anonymous"></script>
     <!-- Core theme CSS (includes Bootstrap)-->
     <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/normalize/8.0.1/normalize.min.css" />
     <link href="css/styles.css" rel="stylesheet" />
     <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"></script>
     <!-- TypeIt CDN -->
     <script src="https://unpkg.com/typeit@8.7.1/dist/index.umd.js"></script>
     <!-- jQuery CDN -->
     <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.3/jquery.min.js"></script>
     <!-- 1:1문의 js -->
     <script src="js/chatbot.js"></script>
     <!-- 공지사항 css -->
     <link href="/resources/css/notice/noticeDetailCopy.css" rel="stylesheet" />
     <link href="/resources/css/admin/bootstrap.min.css" rel="stylesheet">
     
     <script src="/resources/js/common/header.js"></script>
     
     
</head>
<body>

	
	 <%@ include file="../common/include.jsp" %>
	
 	
    
  
  
    
    <c:if test="${ not empty loginUser and loginUser.memberId eq ('admin1') }">
<div class="container-xxl position-relative bg-white d-flex p-0">
 <%@ include file="../common/sidebar.jsp" %>
	    <div class="content">
	        <br><br>
	        <%@ include file="../common/navbar.jsp" %>
	        <div class="innerOuter">
	            <h2>이벤트 게시글 수정하기</h2>
	            <br>
	
	            <form id="updateForm" method="post" action="update.ev" enctype="multipart/form-data">
	            
	            
	            	<input type="hidden" name="eventNo" value="${e.eventNo }">
	                <table>
	                    <tr>
	                        <th><label for="title">제목</label></th>
	                        <td><input type="text" id="title" class="form-control" name="eventTitle" value="${ e.eventTitle }"></td>
	                    </tr>
	                    
	                    <tr>
	                        <th><label for="upfile">첨부파일</label></th>
	                        <td><input type="file" id="upfile" class="form-control-file border" name="reupFile">
	                        
	                            <c:if test="${ not empty eAttach }">
	                            
	                            
	                            	현재 업로드된 파일 : 
	                            	
	                            	
	                            	<c:forEach items="${ eAttach}" var="eeee">
	                            	
		                            	<a href="${ eeee.changeName }" download="${ eeee.originName }">"${ eeee.changeName }"</a>
		                            	
		                            	
		                            	<!-- 파일 수정 시 기존 첨부파일이 있을 경우 : 기존첨부파일의 원본명과 수정명을 같이 넘겨줄 것 -->
		                            	<input type="hidden" name="originName" value="${ eeee.originName }">
		                            	<input type="hidden" name="changeName" value="${ eeee.changeName }">
		                            	
	                            
	                            	</c:forEach>
	                            
	                            
	                            </c:if>
	                         
	                         </td>
	                        
	                    </tr>
	                    <tr>
	                        <th><label for="content">내용</label></th>
	                        <td><textarea id="content" class="form-control" rows="10" style="resize:none;" name="eventContent">${e.eventContent }</textarea></td>
	
	                    </tr>
	                </table>
	                <br>
	
	                <div align="center">
	                    <button type="submit" class="btn btn-primary">등록하기</button>
	                    
	                    <!-- 취소 버튼 누르면 이벤트 게시판 화면으로 이동 -->
	                    <button type="reset" class="btn btn-danger">
	                    	<a href="event.ev">취소하기</a>
	                    </button>
	                </div>
	            </form>
	        </div>
	        <br><br>
	
	    </div>
	</div>
	</c:if>
    
    <jsp:include page="/WEB-INF/views/admin/common/footer.jsp" />
    
    
</body>
</html>