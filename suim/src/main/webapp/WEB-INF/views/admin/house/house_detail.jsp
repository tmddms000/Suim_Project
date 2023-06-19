<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
 
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
        

        
<title>쉐어하우스 정보보기</title>

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
            <!-- Navbar End -->
	


	<div class="content">
        <br><br>
        <div class="innerOuter">
            <br><br>
            <h2>쉐어하우스 상세보기</h2>
            <br>

            <a id="backButton" class="btn btn-secondary" style="float:right; background-color: rgb(250, 107, 111);">목록으로</a>
               <script>
				    document.getElementById("backButton").addEventListener("click", function() {
				        history.back();
				    });
				</script>
            <br><br>

            <table id="contentArea" align="center" class="table">
                <tr>
                    <th width="100">제목</th>
                    <td colspan="3">${ h.boardTitle }</td>
                </tr>
                <tr>
                    <th>작성자</th>
                    <td>${ h.memberId }</td>
                    <th>작성일</th>
                    <td>${ h.boardDate }</td>
                </tr>
                <tr>
      
                 
                    <th>조회수</th>
                    <td>
                        ${ h.boardView }
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
                    <td colspan="4"><p style="height:150px;">${ h.boardContent }</p></td>
                </tr>
            </table>
            <br>
            <br><br>
            
         		
            <!-- 댓글 기능은 나중에 ajax 배우고 나서 구현할 예정! 우선은 화면구현만 해놓음 -->
		            <table id="replyArea" class="table" align="center">
                <thead>
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
		                    <button type="submit" class="btn btn-primary">수정하기</button>
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
	
	function selectReplyList() {
	    $.ajax({
	        url: "/rlist.bo",
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

	                if (true) {
	                    resultStr += "<td style='width: 70px;'><button class='btn btn-danger deleteButton' data-id='" + result[i].memberId + "' style='float:right; background-color: rgb(250, 107, 111); font-size: 11px; padding: 4px 8px;'>" +
	                        "<span style='font-weight: bold;'>삭제</span>" +
	                        "</button></td>";
	                    resultStr += "<td style='width: 70px;'><button class='btn btn-secondary updateButton' data-id='" + result[i].memberId + "' data-content='" + result[i].breContent + "' style='float:right; background-color: #7464a1; font-size: 11px; padding: 4px 8px; width'>" +
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
	    
	    
	    $.ajax({
	        url: "/rdelete.bo",
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

	    // Confirmation prompt before deleting
	    var confirmation = confirm("삭제하시겠습니까?");

	    
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
	                url: "/rupdate.bo",
	                data: { bre: breNo, content: updateContent },
	                type: "post",
	                success: function(response) {
	                        // 댓글 내용 업데이트
	                      
							let tr = $(this).closest("tr");
							
						    tr.find("td:nth-child(2)").html(updateContent); // 수정된 댓글 내용으로 업데이트

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
    </script>

		<br clear="both"><br>
            
            <!-- Footer Start -->
			<%@ include file="../common/footer.jsp" %>
            <!-- Footer End -->
        </div>
        <!-- Content End -->

	</div>	

