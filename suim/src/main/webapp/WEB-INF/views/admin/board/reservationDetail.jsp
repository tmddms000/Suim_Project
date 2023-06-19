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
		.cancelContent {
        width: 600px; /* 크기 조정 */
        height: 250px; /* 크기 조정 */
        resize: none; /* 크기 고정 */
    	}
    </style>       
        

        
<title>자유게시판</title>

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
            <h2>예약 정보 상세보기</h2>
            <br>

			<a id="backButton" class="btn btn-secondary" style="float:right; background-color: rgb(250, 107, 111);" href="adminRez.ho">목록으로</a>
     
            <br><br>
			<form action="/admin/adminRezUpdate.ho" method="post">
			<input type="hidden" name="rezNo" id="rezNo" value="${r.rezNo}" >
            <table id="contentArea" align="center" class="table">
                <tr>
                    <th width="100">제목</th>
                    <td colspan="3">${ r.houseName }</td>
                </tr>
                <tr>
                    <th>예약자Id</th>
                    <td>${ r.sendMemberId }</td>
                    <th>호스트 Id</th>
                    <td>${ r.recMemberId }</td>
                </tr>
                <tr>
                    <th>예약 신청일</th>
                    <td>${ r.rezRequestDate }</td>
                    <th></th>
                    <td></td>
                </tr>
                <tr>
                    <th>예약일</th>
                    <td>
 						<input type="date" id="rezDate" value="${r.rezDate}" name="rezDate">
 					</td>
                    <th>예약시간</th>
                    <td>
	                   	<select name="rezHour" id="rezHour" required>
								<option value="오전 8시 ~ 9시" ${r.rezHour == '오전 8시 ~ 9시' ? 'selected' : ''}>오전 8시 ~ 9시</option>
								<option value="오전 9시 ~ 10시" ${r.rezHour == '오전 9시 ~ 10시' ? 'selected' : ''}>오전 9시 ~ 10시</option>
								<option value="오전 10시 ~ 11시" ${r.rezHour == '오전 10시 ~ 11시' ? 'selected' : ''}>오전 10시 ~ 11시</option>
								<option value="오전 11시 ~ 12시" ${r.rezHour == '오전 11시 ~ 12시' ? 'selected' : ''}>오전 11시 ~ 12시</option>
								<option value="오후 12시 ~ 1시" ${r.rezHour == '오후 12시 ~ 1시' ? 'selected' : ''}>오후 12시 ~ 1시</option>
								<option value="오후 1시 ~ 2시" ${r.rezHour == '오후 1시 ~ 2시' ? 'selected' : ''}>오후 1시 ~ 2시</option>
								<option value="오후 2시 ~ 3시" ${r.rezHour == '오후 2시 ~ 3시' ? 'selected' : ''}>오후 2시 ~ 3시</option>
								<option value="오후 3시 ~ 4시" ${r.rezHour == '오후 3시 ~ 4시' ? 'selected' : ''}>오후 3시 ~ 4시</option>
								<option value="오후 4시 ~ 5시" ${r.rezHour == '오후 4시 ~ 5시' ? 'selected' : ''}>오후 4시 ~ 5시</option>
								<option value="오후 5시 ~ 6시" ${r.rezHour == '오후 5시 ~ 6시' ? 'selected' : ''}>오후 5시 ~ 6시</option>
								<option value="오후 6시 ~ 7시" ${r.rezHour == '오후 6시 ~ 7시' ? 'selected' : ''}>오후 6시 ~ 7시</option>
								<option value="오후 7시 ~ 8시" ${r.rezHour == '오후 7시 ~ 8시' ? 'selected' : ''}>오후 7시 ~ 8시</option>
								<option value="오후 8시 ~ 9시" ${r.rezHour == '오후 8시 ~ 9시' ? 'selected' : ''}>오후 8시 ~ 9시</option>		
								<option value="오후 9시 ~ 10시" ${r.rezHour == '오후 9시 ~ 10시' ? 'selected' : ''}>오후 9시 ~ 10시</option>								
								<option value="오후 10시 ~ 11시" ${r.rezHour == '오후 10시 ~ 11시' ? 'selected' : ''}>오후 10시 ~ 11시</option>								
								<option value="오후 11시 ~ 12시" ${r.rezHour == '오후 11시 ~ 12시' ? 'selected' : ''}>오후 11시 ~ 12시</option>
								<option value="기타" ${r.rezHour == '기타' ? 'selected' : ''}>기타</option>
						</select> 
                    </td>
                </tr>	
                <tr>
                    <th>진행상태</th>
                    <td>
                    	<select name="rezStatus" id="rezStatus">
						  <option value="예약신청" ${r.rezStatus == '예약신청' ? 'selected' : ''}>예약신청</option>
						  <option value="예약확정" ${r.rezStatus == '예약확정' ? 'selected' : ''}>예약확정</option>
						  <option value="예약취소" ${r.rezStatus == '예약취소' ? 'selected' : ''}>예약취소</option>
						</select>
                    </td>
                    <th>삭제 상태</th>
                    <td>
                   		<select name="delStatus" id="delStatus">
						  <option value="N" ${r.delStatus == 'N' ? 'selected' : ''}>등록</option>
						  <option value="Y" ${r.delStatus == 'Y' ? 'selected' : ''}>삭제</option>
						</select> 	
                    </td>
                </tr>
                <tr>
                    <th>취소 사유</th>
                    <td colspan="3"></td>
                </tr>
                <tr>
                    <td colspan="4">
                    	<textarea id="cancelContent" class="cancelContent" name="cancelContent">${r.cancelContent}</textarea>
                    </td>
                </tr>
            </table>
        <div align="center">
	        <button type="submit" class="btn btn-primary" >수정하기</button>
			<button type="reset" class="btn btn-danger" onclick="window.location.href = 'adminRez.ho'">취소</button>
        </div>
        </form>
      </div>
      </div>
      
    <script>
	  var adRezMsg = "<%= session.getAttribute("adRezMsg") %>";
	    if (adRezMsg && adRezMsg !== "null" && adRezMsg !== "") {
	        alert(adRezMsg);
	        <% session.removeAttribute("adRezMsg"); %>
	    }
    </script>

		<br clear="both"><br>
            
            <!-- Footer Start -->
			<%@ include file="../common/footer.jsp" %>
            <!-- Footer End -->
        </div>
        <!-- Content End -->

	</div>	

