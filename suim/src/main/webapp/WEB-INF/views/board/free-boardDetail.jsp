<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
 
<head>
<meta charset="UTF-8">
		
		<%@ include file="/WEB-INF/views/common/include.jsp" %>
	    <link rel="stylesheet" href="/resources/css/summernote/summernote-lite.css">
        <link rel="stylesheet" href="/resources/css/board/board.css">
      
		<link href="/resources/css/user/signup.css" rel="stylesheet" />

	<style>
        .content {
            width:80%;
            margin:auto;
        }
        .innerOuter { 
            width:100%;
            margin:auto;
            padding:5% 10%;
            background-color:white;
        }

        table * {margin:5px;}
        table {width:100%;}
        
        .deleteButton {
    	font-size: 10px; /* 원하는 크기로 조정하세요 */
    	padding: 1px 3px; /* 원하는 패딩 값을 적용하세요 */
		}
		
		#updateButton {
    	font-size: 10px; /* 원하는 크기로 조정하세요 */
    	padding: 1px 3px; /* 원하는 패딩 값을 적용하세요 */
    	
		}
    </style>       
        

        
<title>자유게시판</title>

		

</head>	


<body>	    
	 <jsp:include page="/WEB-INF/views/common/header.jsp"/>

	<div class="content">
        <br><br>
        <div class="innerOuter">
            <br><br>
            <h2>게시판 상세보기</h2>
            <br>

            <a class="btn btn-secondary" style="float:right; background-color: rgb(250, 107, 111);">목록으로</a>
            <br><br>
			
					<div style="margin-left : 10px;">
						<a class="reportBtn" id="reportBtn" > <img title="신고" alt="신고"
							src="/resources/img/house/ico_report.png">
						</a>
					</div>
			
            <table id="contentArea" align="center" class="table">
                <tr>
                    <th width="100">제목</th>
                    <td colspan="3">${ b.boardTitle }</td>
                </tr>
                <tr>
                    <th>작성자</th>
                    <td>${ b.nickName }</td>
                    <th>작성일</th>
                    <td>${ b.boardDate }</td>
                </tr>
                <tr>    
                	<th>글번호</th>
                       <td>
                        ${ b.boardNo}
                    </td>
                    <th>조회수</th>
                    <td>
                        ${ b.boardView }
                    </td>
                     <th></th>
                    <td>
                      
                    </td>
                </tr>
                <tr>
                    <th>내용</th>
                    <td colspan="3"></td>
                </tr>
                <tr>
                    <td colspan="4"><p style="height:150px;">${ b.boardContent }</p></td>
                </tr>
            </table>
            <br>
			<c:if test="${ (not empty loginUser) and (loginUser.memberId eq b.memberId) }">
            <div align="center">
                <!-- 수정하기, 삭제하기 버튼은 이 글이 본인이 작성한 글일 경우에만 보여져야 함 -->
		                <a class="btn btn-primary" onclick="postFormSubmit(1);" >수정하기</a>
		                <a class="btn btn-danger" onclick="postFormSubmit(2);" >삭제하기</a>

            </div>
            <br><br>
            
         		<form id="postForm" action="" method="post">
	            	<input type="hidden" name="bno" value="${ b.boardNo }">
	            	<input type="hidden" name="filePath" value="${ b.changeName }">
	            </form>
	            <script>
	            	// 수정하기 버튼과 삭제하기 버튼을 클릭했을 때 실행할 선언적 함수
	            	function postFormSubmit(num) {
	            		
	            		// 해당 form 태그 선택 후 action 속성값을 각각 부여 후 곧바로 submit 시키기
	            		if(num == 1) { // 수정하기 버튼을 클릭했을 경우
	            			$("#postForm").attr("action", "updateForm.bo").submit();
	            		} else { // 삭제하기 버튼을 클릭했을 경우
	            			$("#postForm").attr("action", "delete.bo").submit();
	            		}
	            	}
	            </script>
            </c:if>

            <!-- 댓글 기능은 나중에 ajax 배우고 나서 구현할 예정! 우선은 화면구현만 해놓음 -->
		            <table id="replyArea" class="table" align="center">
                <thead>
                	<c:choose>
                		<c:when test="${ empty loginUser }">
                			<!-- 로그인 전 -->
                			<tr>
		                        <th colspan="2">
		                            <textarea class="form-control" id="content" cols="55" rows="2" style="resize:none; width:100%;" readonly>로그인한 사용자만 이용 가능한 서비스입니다. 로그인 후 이용 바랍니다.</textarea>
		                        </th>
		                        <th style="vertical-align:middle"><button class="btn btn-secondary" disabled>등록하기</button></th>
		                    </tr>
                		</c:when>
                		<c:otherwise>
                			<!-- 로그인 후 -->
		                	<tr>
		                        <th colspan="2">
		                            <textarea class="form-control" id="content" cols="55" rows="2" style="resize:none; width:100%;"></textarea>
		                        </th>
		                        <th style="vertical-align:middle"><button class="btn btn-secondary" onclick="addReply();">등록하기</button></th>
		                    </tr>
                		</c:otherwise>
                	</c:choose>
                    <tr>
                        <td colspan="3">댓글(<span id="rcount">0</span>)</td>
                    </tr>
                </thead>
                <tbody>
                </tbody>
            </table>
        </div>
        <br><br>

      </div>
      
      <!-- 모달 창 -->
		<div class="modal fade" id="updateModal" tabindex="-1" aria-labelledby="updateModalLabel" aria-hidden="true">
		    <div class="modal-dialog">
		        <div class="modal-content">
		            <div class="modal-header">
		                <h5 class="modal-title" id="updateModalLabel">댓글 수정</h5>
		                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
		            </div>
		            <div class="modal-body">
		                <form id="updateForm">
		                    <div class="mb-3">
		                        <label for="updateContent" class="form-label" >댓글 내용</label>
		                        <textarea class="form-control" id="updateContent" rows="3" name="content"></textarea>
		                    </div>
		                    <button type="submit" id="submitButton" class="btn btn-primary">수정하기</button>
		                </form>
		            </div>
		        </div>
		    </div>
		</div>
    
    <script>

    $(function() {
		// 댓글 리스트 조회용 함수 호출
		selectReplyList(); // setInterval 로 마찬가지로 실시간 조회 효과를 줄 수 있다.
	});
	
	function addReply() { // 댓글 작성용 ajax
		
		var content = "${b.boardTitle}";
		var receiverId = "${b.memberId}";
		var senderId = "${loginUser.memberId}";
		var postNo = "${b.boardNo}";
		var postContent = $("#content").val();
		var postType = "board";
		
		if($("#content").val().trim().length != 0) {
			// 즉, 유효한 내용이 한자라도 있을 경우
			
			$.ajax({
				url : "rinsert.bo",
				data : {
					boardNo : ${ b.boardNo },
					breContent : $("#content").val(),
					memberId : "${ loginUser.memberId }"
				},
				type : "post", 
				success : function(result) {
					
					if(result == "success") {
						selectReplyList();
						

						
						$("#content").val("");
					
						
						if(senderId != receiverId){
			           		if(socket){
			        			let socketMsg = postType+","+senderId+","+receiverId+","+postNo+","+content+","+postContent;
	
			        			console.log(socketMsg);
			        			socket.send(socketMsg);
			           		}
						}
						
					}
				},
				error : function() {
					console.log("댓글 작성용 ajax 통신 실패!");
				}
			});
			
			
			if(senderId != receiverId){
				 $.ajax({
				        url : '/insertNotification',
				        type : 'post',
				        
				        data : {
				        	'content' : content,
				        	'receiverId' : receiverId,
				        	'senderId' : senderId,
				        	'postNo' : postNo,
				        	'postType' : postType,
				        	'postContent' : postContent
				        },
				        dataType : "json", 
				        success : function(alram){
				        }
				    
				    });
				}

		} else {
			alertify.alert("알림", "댓글 작성 후 등록 요청해주세요.");
		}
	}
	
	function selectReplyList() {
	    $.ajax({
	        url: "rlist.bo",
	        data: { bno: `${b.boardNo}` },
	        type: "get",
	        success: function(result) {
	            let resultStr = "";
	            const loginUser = "${loginUser.memberId}"; // 현재 사용자의 식별자 또는 닉네임을 가져와서 할당해주세요.
	            
	            for (let i = 0; i < result.length; i++) {
	                resultStr += "<tr data-id=" + result[i].breNo + ">" +
	                    "<td>" + result[i].nickName + "</td>" +
	                    "<td>" + result[i].breContent + "</td>" +
	                    "<td>" + result[i].breDate + "</td>";

	                if (result[i].memberId == loginUser) {
	                    resultStr += "<td><button class='btn btn-danger deleteButton' data-id='" + result[i].memberId + "' style='float:right; background-color: rgb(250, 107, 111); font-size: 11px; padding: 4px 8px;'>" +
	                        "<span style='font-weight: bold;'>삭제</span>" +
	                        "</button></td>";
	                    resultStr += "<td><button class='btn btn-secondary updateButton' data-id='" + result[i].memberId + "' data-content='" + result[i].breContent + "' style='float:right; background-color: #7464a1; font-size: 11px; padding: 4px 8px;'>" +
	                        "<span style='font-weight: bold;'>수정</span>" +
	                        "</button></td>";
	                }
	                resultStr += "</tr>";
	            }

	            $("#replyArea>tbody").html(resultStr);
	            $("#rcount").text(result.length);
	           
	        }
	    });

	}
	


	// 추가된 부분: 삭제 버튼 클릭 이벤트 처리
	$(document).off("click", ".deleteButton").on("click", ".deleteButton", function() {
	    let memberId = $(this).data("id");
	    let tr = $(this).closest("tr");
	    let breNo = tr.data("id");
	    console.log(breNo);
	    
	    // Confirmation prompt before deleting
	    var confirmation = confirm("삭제하시겠습니까?");

	    if (confirmation) {
	        // Execute the deletion
	        $.ajax({
	            url: "rdelete.bo",
	            data: { bre: breNo },
	            type: "post",
	            success: function(response) {
	                // 삭제 성공한 경우 해당 댓글을 테이블에서 제거
	                tr.remove();
					
	                // 삭제 후 댓글 목록을 다시 로드
	                selectReplyList();

	                // Show success message using alert
	                alert("성공적으로 삭제 되었습니다.");
	            },
	            error: function(xhr, status, error) {
	                // 오류 발생 시 처리할 내용
	                console.log(error);

	                // Show error message using alert
	                alert("An error occurred while deleting the reply.");
	            }
	        });
	    }

	});

	    
	    

	// 수정 버튼 클릭 이벤트 처리
	$(document).off("click", ".updateButton").on("click", ".updateButton", function() {
	    let memberId = $(this).data("id");
	    let content = $(this).data("content");
	    let breNo = $(this).closest("tr").data("id");
	    

	    // 모달 창 열기
	    $("#updateModal").modal("show");

	    // 모달의 입력 필드에 content 값 설정
	    $("#updateContent").val(content);

	    // 수정하기 버튼 클릭 이벤트 처리
	    $("#updateForm").off("submit").on("submit", function(e) {
	        e.preventDefault();

	        let updateContent = $("#updateContent").val();
	        
	        // 알림 대화상자 표시
	        
	            // AJAX로 서버에 수정된 내용 전송 및 처리
	            
	            $.ajax({
	                url: "rupdate.bo",
	                data: { bre: breNo, content: updateContent },
	                type: "post",
	                success: function(response) {
	                        // 댓글 내용 업데이트
	                      
							let tr = $(this).closest("tr");
							
						    tr.find("td:nth-child(2)").html(updateContent); // 수정된 댓글 내용으로 업데이트

						    // ...

						    // 수정된 댓글이 리스트에 실시간으로 반영되도록 추가
						    let targetRow = $("tr[data-id='" + breNo + "']");
						    targetRow.find("td:nth-child(2)").html(updateContent);
							console.log(updateContent);
	                        // 모달 창 닫기
	                        $("#updateModal").modal("hide");
							
	                        alert("댓글이 수정되었습니다.");

	                },
	                error: function() {
	                    alert("댓글 수정에 실패하였습니다.");
	                }
	           });
	        
	    });

	    // 모달 창 닫힐 때 입력 필드 초기화
	    $("#updateModal").on("hidden.bs.modal", function() {
	        $("#updateContent").val("");
	    });
	});


	document.getElementById('content').addEventListener('keydown', function(event) {
	    if (event.keyCode === 13) { // Enter 키의 keyCode는 13입니다.
	        event.preventDefault(); // 엔터 키의 기본 동작인 줄바꿈을 막습니다.
	        addReply(); // 등록 버튼을 클릭합니다.
	    }
	});
	
	// HTML에서 목록으로 버튼을 클릭했을 때 호출할 함수
	function goBack() {
	  window.history.back();
	}

	// 버튼 요소를 가져온다
	var backButton = document.querySelector('.btn-secondary');

	// 버튼을 클릭하면 goBack 함수를 호출한다
	backButton.addEventListener('click', goBack);
	
	
/* 		$(function() {
		  $('#apibtn').click(function() {
		    $.ajax({
		      url: '/kakaoPay',
		      dataType: "json",
		      success: function(data) {

		    	  console.log(data);
        	var box = data.next_redirect_pc_url;
		        window.open(box); 

		    	  
		      },
		      error: function(error) {
		        alert(error);
		      }
		    });
		  });
		}); */
		  // Enter 키를 눌렀을 때 동작할 함수
		  function handleEnterKey(event) {
		    if (event.keyCode === 13) {
		      event.preventDefault(); // 기본 동작인 폼 제출 방지
		      document.getElementById("submitButton").click(); // "수정하기" 버튼 클릭
		    }
		  }

		$(document).ready(function() {
			let boardNo = "${b.boardNo}";
	        let boardTitle = "${b.boardTitle}";
	        let memberId = "${b.memberId}";
	        
			  $('#reportBtn').click(function() {
		       
				var popupUrl = "report.fi?value=" + encodeURIComponent(boardNo) + "&value2=" + encodeURIComponent(boardTitle) + "&value3=" + encodeURIComponent(memberId);
			    var popupWidth = 800;
			    var popupHeight = 800;

			    var windowWidth = window.innerWidth || document.documentElement.clientWidth || document.body.clientWidth;
			    var windowHeight = window.innerHeight || document.documentElement.clientHeight || document.body.clientHeight;

			    var popupX = (windowWidth / 2) - (popupWidth / 2) + window.screenX;
			    var popupY = (windowHeight / 2) - (popupHeight / 2) + window.screenY;

			    var options = "width=" + popupWidth + ",height=" + popupHeight + ",left=" + popupX + ",top=" + popupY;

			    var popupWindow = window.open(popupUrl, "신고 팝업창", options);
			    popupWindow.document.documentElement.classList.add('popup');
			  });
			});


		  // 엔터 키 이벤트 리스너 추가

		  /*document.addEventListener("keydown", handleEnterKey);  */
    
    </script>
    

	<jsp:include page="/WEB-INF/views/common/footer.jsp"/>
	

</body>
</html>