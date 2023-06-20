<%@page import="com.suim.notice.model.vo.Nattachment"%>
<%@page import="com.suim.notice.model.vo.Notice" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

     <link href="/resources/css/notice/noticeDetailCopy.css" rel="stylesheet" />
     
     


	
	 <%@ include file="../common/include.jsp" %>
	
 	
    
  
  
    
    <c:if test="${ not empty loginUser and loginUser.email eq (('oox14@naver.com') or ('suimm012@gmail.com')) }">
<div class="container-xxl position-relative bg-white d-flex p-0">
 <%@ include file="../common/sidebar.jsp" %>
	    <div class="content">
	        <br><br>
	        <%@ include file="../common/navbar.jsp" %>
	        <div class="innerOuter">
	            <h2>공지사항 수정하기</h2>
	            <br>
	
	            <form id="updateForm" method="post" action="update.no" enctype="multipart/form-data">
	            
	            
	            	<input type="hidden" name="noticeNo" value="${n.noticeNo }">
	                <table>
	                    <tr>
	                        <th><label for="title">제목</label></th>
	                        <td><input type="text" id="title" class="form-control" name="noticeTitle" value="${ n.noticeTitle }"></td>
	                    </tr>
	                    
	                    <tr>
	                        <th><label for="upfile">첨부파일</label></th>
	                        <td><input type="file" id="upfile" class="form-control-file border" name="reupFile">
	                        
	                            <c:if test="${ not empty nAttach }">
	                            
	                            
	                            	현재 업로드된 파일 : 
	                            	
	                            	
	                            	<c:forEach items="${ nAttach}" var="nnnn">
	                            	
	                            	<a href="${ nnnn.changeName }" download="${ nnnn.originName }">"${ nnnn.changeName }"</a>
	                            	
	                            	
	                            	<!-- 파일 수정 시 기존 첨부파일이 있을 경우 : 기존첨부파일의 원본명과 수정명을 같이 넘겨줄 것 -->
	                            	<input type="hidden" name="originName" value="${ nnnn.originName }">
	                            	<input type="hidden" name="changeName" value="${ nnnn.changeName }">
	                            	
	                            
	                            	</c:forEach>
	                            
	                            
	                            </c:if>
	                         
	                         </td>
	                        
	                    </tr>
	                    <tr>
	                        <th><label for="content">내용</label></th>
	                        <td><textarea id="content" class="form-control" rows="10" style="resize:none;" name="noticeContent">${n.noticeContent }</textarea></td>
	
	                    </tr>
	                </table>
	                <br>
	
	                <div align="center">
	                    <button type="submit" class="btn btn-primary">등록하기</button>
	                    
	                    <!-- 취소 버튼 누르면 공지사항 화면으로 이동 -->
	                    <button type="reset" class="btn btn-danger">
	                    	<a href="notice.no">취소하기</a>
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