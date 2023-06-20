<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
    
<style>
	.memberTableLeft{
		display: inline-block;
		float: left;
	}
	.memberTableRight{
		display: inline-block;
		float: rigth;	
	}
</style>

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
                
                <table id="eventDetailTable" class="table">
                    <thead>
                        <tr class="table-header">
                            <td id="eventNo" class="nListNo contentHeader" hidden>No</td>
                            <td class="title contentHeader">
                                <div style = "padding-left : 10% ">${e.eventTitle}</div>
                            </td>              
                            <td class="createDate contentHeader" style="width:15%;">
                                <div class="text-center">작성일자</div>
                                <div><fmt:formatDate pattern="yyyy-MM-dd" value="${e.eventDate }" /></div>
                            </td>
                            <td class="page_views">
                                <div>조회수</div>
                                <div>${ e.eventView }</div>
                            </td>
                           
                            
                            
                        </tr>
                    </thead>
                    <tbody>
                        <tr rowspan="3">
                          	
                          
                            <td class="eventContent" colspan="3" id="eventFileAndContent">
                               <c:forEach items="${eAttach}" var="eAttach">
		                          <img src="${fn:replace(eAttach.changeName, '/admin/resources', 'resources')}" style= "width : 100%;" name="eno">
		                          
		                       </c:forEach>		                	
                            </td>
                            
                           
                            
                        </tr>
                        <tr rowspan="3">
                        	<td class="eventContent">
                          		${ e.eventContent }
                          	</td>
                         </tr>
                         
                      	 <c:if test="${ not empty loginUser and loginUser.email eq (('oox14@naver.com') or ('suimm012@gmail.com')) }">
                         	<div align="center" style="display: inline-block;" align="right">
				                <!-- 수정하기, 삭제하기 버튼은 이 글이 본인이 작성한 글일 경우에만 보여져야 함 -->
				                <a class="btn btn-primary" onclick="postFormSubmit(1);">수정하기</a>
				                <a class="btn btn-danger" onclick="postFormSubmit(2);">삭제하기</a>
			        		</div>
                        </c:if> 	
                         	
                			<form id="postForm" action="" method="post">
			            		<!-- 글번호는 노출되면 안되므로 hidden 타입으로 넘김 -->
			            		<input type="hidden" name="eno" value="${ e.eventNo }">
			            		
			            		<!-- 이벤트 파일이 있을 경우에만 해당 이벤트 파일을 삭제 처리 하기 위해 넘김 -->
			            		<c:forEach items="${eAttach}" var="eAttach">
			            	    	<input type="hidden" name="filePath" value="${ eAttach.changeName }"> 
			            	    </c:forEach>
			            	        		
	            			</form>
	            			
				       
				        
				        
	               
		            

                    </tbody>
                </table>
                
               
                
                <button class="btn btn-primary btn-block submit-btn">
                    <a href="event.ev">목록가기</a>
                </button>
               
            </div>
        </div>
   
	<script>
	               		// 수정하기 버튼과 삭제하기 버튼을 클릭했을 때 실행할 선언적 함수 (수정, 삭제 관련 controller 추가 예정)
	               		function postFormSubmit(num) {
	               	
	               		// 해당 form 태그 선택 후 action 속성값을 각각 부여 후 곧바로 submit 시키기
	               			if(num==1) { // 수정하기 버튼을 클릭했을 경우
	            				$("#postForm").attr("action", "updateForm.ev?eno=${e.eventNo}").submit();
	            			} else { // 삭제하기 버튼을 클릭했을 경우
	            				$("#postForm").attr("action", "delete.ev?eno=${e.eventNo}").submit();
	            			}	
	            		}
	               		
	                
	           		</script>
	     </div>      	
	 </div>
            <br><br>    
            <!-- Table End -->

            <br clear="both"><br>
            
            <!-- Footer Start -->
			<%@ include file="../common/footer.jsp" %>
            <!-- Footer End -->
        </div>
        <!-- Content End -->

	</div>
          
