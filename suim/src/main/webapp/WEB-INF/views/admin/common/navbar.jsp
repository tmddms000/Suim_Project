<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
                <!-- Navbar Start -->
                <nav class="navbar navbar-expand bg-light navbar-light sticky-top px-4 py-0">
                    <a href="index.html" class="navbar-brand d-flex d-lg-none me-4">
                        <h2 class="text-primary mb-0"><i class="fa fa-hashtag"></i></h2>
                    </a>
                    <a href="#" class="sidebar-toggler flex-shrink-0">
                        <i class="fa fa-bars"></i>
                    </a>
                    <!-- 
                    <form class="d-none d-md-flex ms-4">
                        <input class="form-control border-0" type="search" placeholder="Search">
                    </form>
                    -->
                    <div class="navbar-nav align-items-center ms-auto">

                        <div class="nav-item dropdown">
                            <a href="#" class="nav-link dropdown-toggle" data-bs-toggle="dropdown">
                                <i class="fa fa-bell me-lg-2"></i>
                                <span class="d-none d-lg-inline-flex">알림</span>
                            </a>
                            <div class="dropdown-menu dropdown-menu-end bg-light border-0 rounded-0 rounded-bottom m-0">
                                 <a href="#" class="dropdown-item" id="sendNotificationBtn">알림보내기</a>                  
                            </div>
                        </div>
                        <div class="nav-item dropdown">
                            <a href="#" class="nav-link dropdown-toggle" data-bs-toggle="dropdown">
                            <c:choose>
				        		<c:when test="${not empty loginUser.changeName}">
                                	<img class="rounded-circle me-lg-2" src="${loginUser.changeName}" alt="" style="width: 40px; height: 40px;">
                               	</c:when>
						        <c:otherwise>
						            <img class="rounded-circle me-lg-2" src="/resources/img/common/default_profile.png" style="width: 40px; height: 40px;"></img>
						        </c:otherwise>
						    </c:choose>
							<span class="d-none d-lg-inline-flex">${ loginUser.nickName }</span>
                            </a>
                            <div class="dropdown-menu dropdown-menu-end bg-light border-0 rounded-0 rounded-bottom m-0">
                                <a href="#" class="dropdown-item" onclick="event.preventDefault(); logout();">로그아웃</a>
                                <a href="/" class="dropdown-item">메인페이지로 이동</a>
                            </div>
                            
                            <script>
	                            function logout() {
	                		        $.ajax({
	                		            url: '/member/logout',
	                		            method: 'POST',
	                		            success: function(response) {
	                		            	alert("로그아웃 되었습니다.");
	                		                location.reload(true);
	                		            }
	                		        });
	                		    }
	                            
	                            $(document).ready(function() {
	                            	  $("#sendNotificationBtn").click(function() {
	                            	    var message = prompt("보낼 메시지를 입력 :");

	                            	    if (message) {
	                            	      $.ajax({
	                            	        url: "/admin/alarm.me",
	                            	        type: "POST",
	                            	        data: {
	                            	          message: message,
	                            	          role: "admin" // Set the custom variable value here
	                            	        },
	                            	        success: function() {
	                            	          // Handle the success response if needed
	                            	        },
	                            	        error: function() {
	                            	          // Handle the error response if needed
	                            	        }
	                            	      });
	                            	    }
	                            	  });
	                            	});
	                            
	                            
                            </script>
                        </div>
                    </div>
                </nav>
                <!-- Navbar End -->
