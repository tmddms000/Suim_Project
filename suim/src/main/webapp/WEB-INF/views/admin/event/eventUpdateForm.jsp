<%@page import="com.suim.notice.model.vo.Nattachment"%>
<%@page import="com.suim.notice.model.vo.Notice" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<%@ include file="../common/include.jsp" %>
	
	
  
  
    
      <c:if test="${ not empty loginUser and loginUser.email eq (('oox14@naver.com') or ('suimm012@gmail.com')) }">
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
	                        <td><input type="text" id="title" class="form-control" name="eventTitle" value="${ e.eventTitle }" required></td>
	                    </tr>
	                    <tr>
	                    	<th><label for="category">이벤트 카테고리</label></th>
		                    <td>
	                    		<select id="category" name="eventCategory" required>
	                    			<option value="">이벤트 선택</option>
						            <option value="랜덤 이벤트">랜덤 이벤트</option>
						            <option value="종료된 이벤트">종료된 이벤트</option>
						            <option value="테스트 작성용 카테고리">테스트 작성용 이벤트 카테고리</option>
						        </select>
						    </td>
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
	                        <td><textarea id="content" class="form-control" rows="10" style="resize:none;" name="eventContent" required>${e.eventContent }</textarea></td>
	
	                    </tr>
	                </table>
	                <br>
	
	                <div align="left" style="">
	                    <button type="submit" class="btn btn-primary">등록하기</button>
	                    
	                    <!-- 취소 버튼 누르면 이벤트 게시판 화면으로 이동 -->
	                    <button type="reset" class="btn btn-danger">
	                    	<a href="event.ev">취소하기</a>
	                    </button>
	                </div>
	            </form>
	        </div>
	        <br><br>
	<!-- Table End -->
            
                        <br clear="both"><br>
                        <!-- Footer Start -->
			<%@ include file="../common/footer.jsp" %>
            <!-- Footer End -->
	    </div>
	</div>
	</c:if>
    
    
    
    
