<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

	

	<c:if test="${ not empty alertMsg }">
		<script>
			alert("${ alertMsg }");
		</script>
		<c:remove var="alertMsg" scope="session" />
	</c:if>
	
	
	<header>
	        <nav class="navbar navbar-expand-lg navbar-light fixed-top header_wrap" id="mainNav">
	            <div class="header container px-4 px-lg-5">
	                <a class="navbar-brand" href="/"><img class="logo" src="/resources/img/common/sim5.png"></a>
	                
	                <ul class="nav nav-pills navi">
	                    
	                        <li class="nav-item"><a href="#" class="nav-link nav-text">방 찾기</a></li>
	                        <li class="nav-item">
	                            <a href="#" class="nav-link nav-text">쉼</a>
	                            <ul>
	                                <li><a href="">쉼 소개</a></li>
	                            </ul>
	                        </li>
	                        <li class="nav-item">
	                            <a href="#" class="nav-link nav-text">커뮤니티</a>
	                            <ul>
	                                <li><a href="list.bo">자유게시판</a></li>
	                                <li><a href="">입주후기</a></li>
	                                <li><a href="">사람구해요</a></li>
	                            </ul>
	                        </li>
	                        
	                        <c:choose>
				            	<c:when test="${ empty loginUser }">
					                <!-- 로그인 전 -->
					                 <li class="nav-item">
	                            		<a href="/member/login" class="nav-link nav-text">로그인</a>
	                        		</li>
				                </c:when>
				                <c:otherwise>
					                <li class="nav-item">
	                            		<a href="#" class="nav-link nav-text">${ loginUser.memberName }님</a>
		                            	<ul>
			                                <li><a href="">마이페이지</a></li>
			                                
			                                
			                                <li>
			                                <form id="logout-form" action="/member/logout" method="post">
			                                <a href="#" onclick="event.preventDefault(); document.getElementById('logout-form').submit();">로그아웃</a>
			                                </form>
			                                </li>
			                                
		                            	</ul>
	                        		</li>
				                </c:otherwise>
				            </c:choose>    
	                        
	                        <li class="nav-item">
	                            <a href="#" class="nav-link nav-text">고객센터</a>
	                            <ul>
	                                <li><a href="">공지사항</a></li>
	                                <li><a href="">자주 묻는 질문</a></li>
	                            </ul>
	                        </li>
	                </ul>
	                
	                    <!-- 햄버거 메뉴 -->
	                    <button class="navbar-toggler" type="button" data-bs-toggle="offcanvas" data-bs-target="#offcanvasNavbar" aria-controls="offcanvasNavbar">
	                            <span class="navbar-toggler-icon"></span>
	                    </button>
	                    <div class="offcanvas offcanvas-end" tabindex="-1" id="offcanvasNavbar" aria-labelledby="offcanvasNavbarLabel">
	                        <div class="offcanvas-header">
	                        <c:choose>
				            	<c:when test="${ empty loginUser }">
	                            <h5 class="offcanvas-title" id="offcanvasNavbarLabel">&nbsp;&nbsp;&nbsp;&nbsp;로그인 해주세요.</h5>
	                           	</c:when>
	                       </c:choose>
	                            <button type="button" class="btn-close text-reset"
	                                data-bs-dismiss="offcanvas" aria-label="Close"></button>
	                        </div>
	                        <div class="offcanvas-body">
	                        
	                        
	                        <c:choose>
				            	<c:when test="${ empty loginUser }">
					                 <div class="user-button">
	                                <button type="button"
	                                    style="width: 150px; margin-right: 20px; margin-left: 20px;"
	                                    class="btn btn-success btn-lg" onclick="location.href='/member/login'">로그인</button>
	                                <button type="button" style="width: 150px;"
	                                    class="btn btn-outline-success btn-lg" onclick="location.href='/member/join'">회원가입</button>
	                            	</div>
				                </c:when>
				            </c:choose>
	                        
	                        
	
	                           
	
	                            <ul class="navbar-nav justify-content-end flex-grow-1 pe-3 pb-2">
	                            
									<c:choose>
									  <c:when test="${not empty loginUser}">
									    <c:choose>
									      <c:when test="${empty loginUser.changeName}">
									        <img src="/resources/img/common/default_profile.png" style="width: 200px; height: 200px; margin-left: 25px;">
									      </c:when>
									      <c:otherwise>
									        <img src="${loginUser.changeName}"/>
									      </c:otherwise>
									    </c:choose>
									  </c:when>
									</c:choose>
									
								<c:choose>
								  <c:when test="${not empty loginUser}">
								    <li class="nav-item dropdown m-4">
								      <a class="side-black" href="#" id="offcanvasNavbarDropdown1" role="button" data-bs-toggle="dropdown" aria-expanded="false">${loginUser.memberName}님</a>
								      <ul class="dropdown-menu" aria-labelledby="offcanvasNavbarDropdown1">
								        <li><a class="dropdown-item" href="#">마이페이지</a></li>
								        <li><a class="dropdown-item" href="#">로그아웃</a></li>
								      </ul>   
								    </li>
								  </c:when>
								</c:choose>
	                                <li class="nav-item offcanvas-text m-4">
	                                    <a class="side-black" aria-current="page" href="#">방 찾기</a>
	                                </li>
	                                <li class="nav-item dropdown m-4">
	                                    <a class="side-black" href="#" id="offcanvasNavbarDropdown1" role="button" data-bs-toggle="dropdown" aria-expanded="false">셰어하우스 쉼</a>
	                                        <ul class="dropdown-menu" aria-labelledby="offcanvasNavbarDropdown1">
	                                           <li><a class="dropdown-item" href="#">쉼 소개</a></li>
	                                        </ul> 
	                                </li>
	                                <li class="nav-item dropdown m-4"><a class="side-black" href="#" id="offcanvasNavbarDropdown2" role="button" data-bs-toggle="dropdown" aria-expanded="false">커뮤니티 </a>
	                                    <ul class="dropdown-menu" aria-labelledby="offcanvasNavbarDropdown2">
	                                        <li><a class="dropdown-item" href="#">자유게시판</a></li>
	                                        <li><a class="dropdown-item" href="#">사람구해요</a></li>
	                                        <li><a class="dropdown-item" href="#">입주 후기 </a></li>                                            
	                                    </ul>
	                                </li>
	                                <li class="nav-item dropdown m-4"><a class="side-black" href="#" id="offcanvasNavbarDropdown3" role="button" data-bs-toggle="dropdown" aria-expanded="false">고객센터 </a>
	                                    <ul class="dropdown-menu" aria-labelledby="offcanvasNavbarDropdown3">
	                                        <li><a class="dropdown-item" href="#">공지사항</a></li>
	                                        <li><a class="dropdown-item" href="#">자주 묻는 질문</a></li>                        
	                                    </ul>
	                                </li>
	                            </ul>
	                        </div>
	                    </div>
	            </div>
	        </nav>
	    </header>
	    
	    
	    