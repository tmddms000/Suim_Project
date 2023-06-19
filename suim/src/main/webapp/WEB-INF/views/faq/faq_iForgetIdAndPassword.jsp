<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>FAQ - 회원가입은 어떻게 하나요?</title>

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
         <!-- faq css -->
         <link href="/resources/css/faq/faqList.css" rel="stylesheet" />
         
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
 
 .faqTitle {
 	text-align: left;
 }
 

 </style>

</head>
<body>
<!-- 헤더 부분-->
    <jsp:include page="/WEB-INF/views/common/header.jsp"></jsp:include>
    <!-- 헤더 부분 끝 -->
   
    <!-- faq (Content) 영역 -->

    <div id="faqDiv" class="container main" style="margin-top : 150px;">
        <div class="col-lg-12">
    
    
            <div class="table-wrapper">

                <!-- 자주 묻는 질문이라는 걸 알 수 있게 함 -->
                <div id="faqBold" class="table-title">
                    	자주 묻는 질문입니다.
                </div>
                <table id="faqDetailTable" class="table">
                    <thead>
                        <tr class="table-header">
                            <!--
                            <td id="faqNo" class="faqListNo contentHeader">No</td>
                            -->
                            <td class="faqList title contentHeader">
                                <div class="faqTitle">
                                    <b>내가 원하는 방의 판매자와 소통하고 싶어요.</b>
                                </div>
                            </td>                   
                        </tr>
                    </thead>
                    <tbody>
                        
                        <tr id="faqDetailContent" style="height : 400px;">
                            <td class="faqAnswer">
                            	
                               		원하시는 방의 판매자와 대화하고 싶으시다면 해당 방의 판매자와 1:1 채팅으로 연락이 가능합니다.
                               <br/>   
                            </td>
                        </tr>
                    </tbody>
                </table>
                
               
            </div>
            
            <div align="center">
            	<button class="btn btn-primary btn-block submit-btn">
            		<a href="faqList">FAQ 목록</a>
            	</button>
            </div>
        </div>
        
    </div>

	<jsp:include page="/WEB-INF/views/common/footer.jsp"/>
    
      <script src="js/scripts.js"></script>
    
</body>
</html>
