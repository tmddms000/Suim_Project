<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
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
            <link href="/resources/css/notice/noticeDetailCopy.css" rel="stylesheet" />
            
            
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

    <div id="noticeDiv" class="container main">
        <div class="col-lg-12">
    
    
            <div class="table-wrapper">
                <div id="noticeBold" class="table-title">
                    우주 공지사항
                </div>
            
                <div id="nListSearch" class="search-box">
                    <form>
                        <input type="text" placeholder="지역명, 주변명 입력">
                        <button type="submit">
                            <i class="fa fa-search" style="color : rgb(249,88,10)"></i>
                        </button>
                    </form>
                </div>
                
                <table id="noticeDetailTable" class="table">
                    <thead>
                        <tr class="table-header">
                            <td id="noticeNo" class="nListNo contentHeader" hidden>No</td>
                            <td class="title contentHeader">
                                <div>${n.noticeTitle}</div>
                            </td>              
                            <td class="createDate contentHeader">
                                <div class="text-center">작성일자</div>
                                <div>2023-05-23</div>
                            </td>
                            <td class="page_views">
                                <div>조회수</div>
                                <div>조회수 26회</div>
                            </td>
                        </tr>
                    </thead>
                    <tbody>
                        
                        <tr style="width: 100%;">
                            
                            <td class="noticeContent" style="height: 100px;">
                                날이 좋아서 
                                수요일이라서 
                                그냥 그래서 
                                피곤하다.
                                공지사항 작성 시
                                엔터키 누를 때마다
                                실제 줄바꿈됨
                                br 태그 안 써도 됨.         
                                동해물과 백두산이 폭발하게 생겼네. 한화에어로스페이스 주식 저점매수했더니 m&a, 그룹지배 구조개편으로 3배 가까이 오름. 민수형님이 얘기하신 제라드의 we go norich                          

d

                                d
                                d
                            </td>
                            
                        </tr>
                    
                        

                    </tbody>
                </table>
                
               
                
                <button class="btn btn-primary btn-block submit-btn">
                    <a href="./notice.html">목록가기</a>
                </button>

            </div>
        </div>
    </div>

	<jsp:include page="/WEB-INF/views/common/footer.jsp"></jsp:include>
    
      <script src="js/scripts.js"></script>
</body>
</html>

