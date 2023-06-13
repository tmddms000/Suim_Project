<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@page import="com.suim.event.model.vo.Eattachment"%>
<%@page import="com.suim.event.model.vo.Event" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>

            <!-- 부트스트랩 -->
            <link href="/resources/css/common/styles.css" rel="stylesheet" />
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
            <link href="/resources/css/event/eventDetailView.css" rel="stylesheet" />
            
            
    <style>
       body {
                display: flex;
                flex-direction: column;
                min-height: 100vh;
            }
            .main {
                flex: 1;
                margin-top : 90px;
            }
            footer {
                margin-top: auto;
            }
    </style>
</head>
<body>
<!-- 헤더 부분-->
    <jsp:include page="/WEB-INF/views/common/header.jsp"/>
    <!-- 헤더 부분 끝 -->
   
    <!--공지사항(Content) 영역 -->

    <div id="eventDiv" class="container main">
        <div class="col-lg-12">
    
    
            <div class="table-wrapper">
            
            <div style="display:inline-block">
                <div id="eventBold" class="table-title">
                    	SUIM 이벤트
                </div>
            
                <div id="nListSearch" class="search-box">
                    <form>
                        <input type="text" placeholder="지역명, 주변명 입력">
                        <button type="submit">
                            <i class="fa fa-search" style="color : rgb(249,88,10)"></i>
                        </button>
                    </form>
                </div>
            </div>
                
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
		                          <img src="${eAttach.changeName }" style= "width : 100%;" name="eno">
		                          
		                       </c:forEach>		                	
                            </td>
                            
                           
                            
                        </tr>
                        <tr rowspan="3">
                        	<td class="eventContent">
                          		${ e.eventContent }
                          	</td>
                         </tr>
                         
                      	<c:if test="${ not empty loginUser and loginUser.memberId eq ('admin1') }">
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
    </div>
	<script>
	               		// 수정하기 버튼과 삭제하기 버튼을 클릭했을 때 실행할 선언적 함수 (수정, 삭제 관련 controller 추가 예정)
	               		function postFormSubmit(num) {
	               	
	               		// 해당 form 태그 선택 후 action 속성값을 각각 부여 후 곧바로 submit 시키기
	               			if(num==1) { // 수정하기 버튼을 클릭했을 경우
	            				$("#postForm").attr("action", "updateForm.eno?eno=${e.eventNo}").submit();
	            			} else { // 삭제하기 버튼을 클릭했을 경우
	            				$("#postForm").attr("action", "delete.eno?eno=${e.eventNo}").submit();
	            			}	
	            		}
	               		
	                
	           		</script>
	<jsp:include page="/WEB-INF/views/common/footer.jsp"></jsp:include>
    
      <script src="js/scripts.js"></script>
</body>
</html>

