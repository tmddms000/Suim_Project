<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<script src="https://cdn.jsdelivr.net/npm/chart.js"></script>

	<%@ include file="common/include.jsp" %>

	<div class="container-xxl position-relative bg-white d-flex p-0">
    
        <!-- Spinner Start -->
		<%@ include file="common/spinner.jsp" %>
        <!-- Spinner End -->

        <!-- Sidebar Start -->
		<%@ include file="common/sidebar.jsp" %>
		<!-- Sidebar End -->
		
        <!-- Content Start -->
        <div class="content">
        
            <!-- Navbar Start -->
			<%@ include file="common/navbar.jsp" %>
            <!-- Navbar End -->
            
                        <!-- Sale & Revenue Start -->
            <div class="container-fluid pt-4 px-4">
                <div class="row g-4">
                    <div class="col-sm-6 col-xl-3">
                        <div class="bg-light rounded d-flex align-items-center justify-content-between p-4">
                            <i class="fa fa-chart-line fa-3x text-primary"></i>
                            <div class="ms-3">
                                <p class="mb-2">전체 회원 수 조회</p>
                                <h6 class="mb-0 nums" data-count="${selectMemberAll}">${ selectMemberAll } 개</h6>
                            </div>
                        </div>
                    </div>
                    <div class="col-sm-6 col-xl-3">
                        <div class="bg-light rounded d-flex align-items-center justify-content-between p-4">
                            <i class="fa fa-chart-pie fa-3x text-primary"></i>
                            <div class="ms-3">
                                <p class="mb-2">전체 쉐어하우스 수 </p>
                                <h6 class="mb-0 nums" data-count="${selectHouseAll}">${ selectHouseAll } 개</h6>
                            </div>
                        </div>
                    </div>
                    <div class="col-sm-6 col-xl-3">
                        <div class="bg-light rounded d-flex align-items-center justify-content-between p-4">
                            <i class="fa fa-chart-bar fa-3x text-primary"></i>
                            <div class="ms-3">
                                <p class="mb-2">결제된 방 수</p>
                                <h6 class="mb-0 nums" data-count="${selectHouseCount}">${ selectHouseCount } 개</h6>
                            </div>
                        </div>
                    </div>
                    <div class="col-sm-6 col-xl-3">
                        <div class="bg-light rounded d-flex align-items-center justify-content-between p-4">
                            <i class="fa fa-chart-area fa-3x text-primary"></i>
                            <div class="ms-3">
                                <p class="mb-2">예약된 방 수</p>
                                <h6 class="mb-0 nums" data-count="${selectReservationCount}">${ selectReservationCount } 개</h6>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <!-- Sale & Revenue End -->

            <!-- Sales Chart Start -->
            <div class="container-fluid pt-4 px-4">
                <div class="row g-4">
                    <div class="col-sm-12 col-xl-6">
                        <div class="bg-light text-center rounded p-4" style="height:316.19">
                            <div class="d-flex align-items-center justify-content-between mb-4">
                                <h6 class="mb-0">가입자 성별 비율</h6><br>
                                <div style="display: block;box-sizing: border-box;height: 255;width: 255;">
                            	<canvas id="genderChart"></canvas>
                            	</div>
                            </div>
                        </div>
                    </div>
                    <div class="col-sm-12 col-xl-6">
                        <div class="bg-light text-center rounded p-4">
                            <div class="d-flex align-items-center justify-content-between mb-4">
                                <h6 class="mb-0">일자별 회원가입 수</h6>
                            </div>
                            <canvas id="dayChart"></canvas>
                        </div>
                    </div>
                    <div class="col-sm-12 col-xl-6">
                        <div class="bg-light text-center rounded p-4">
                            <div class="d-flex align-items-center justify-content-between mb-4">
                                <h6 class="mb-0">일별 매출</h6>
                            </div>
                            <canvas id="revenueChart"></canvas>
                        </div>
                    </div>
                    <div class="col-sm-12 col-xl-6">
                        <div class="bg-light text-center rounded p-4">
                            <div class="d-flex align-items-center justify-content-between mb-4">
                                <h6 class="mb-0">사람구해요 순위</h6>
                            </div>
                            <canvas id="boardChart"></canvas>
                        </div>
                    </div>
                </div>
            </div>
            <!-- Sales Chart End -->
            
            <!-- 차트 시작 -->
			<script>
			  const ctx_gender = document.getElementById('genderChart');
			  
			  <c:forEach var="dashboard" items="${selectMemberGender}">
			    <c:choose>
			      <c:when test="${dashboard.gender == 'M'}">
			        maleCount = ${dashboard.memberCount};
			      </c:when>
			      <c:when test="${dashboard.gender == 'F'}">
			        femaleCount = ${dashboard.memberCount};
			      </c:when>
			    </c:choose>
			  </c:forEach>

			  new Chart(ctx_gender, {
			    type: 'doughnut',
			    data: {
			      labels: ['남성', '여성'],
			      datasets: [{
			        label: '성비',
			        data: [
			        	maleCount, femaleCount
					],
			        borderWidth: 1
			      }]
			    },
			    options: {
			        scales: {
			            display: false
			        },
			        plugins: {
			            legend: {
			                position: 'top',
			                labels: {
			                    boxWidth: 10
			                }
			            }
			        }
			    }
			  });

				
			  
			  const ctx_board = document.getElementById('boardChart');		
			  const selectFind1 = <c:out value="${selectFind1}" />;
			  const selectFind2 = <c:out value="${selectFind2}" />;
		      
			  new Chart(ctx_board, {
			    type: 'bar',
			    data: {
			      labels: ['방구해요', '세놓아요'],
			      datasets: [{
			        label: '게시글 순위',
			        data: [selectFind1, selectFind2],
			        borderColor:'rgba(255, 99, 132, 1)',
			        backgroundColor: 'rgba(255, 99, 132, 1)',
			        borderWidth: 1
			      }]
			    },
			    options: {
			      scales: {
			        y: {
			          beginAtZero: true
			        }
			      }
			    }
			  });

			  // 일별 매출
			
			  function addZero_rev(num) {
					var rtn_rev = num + 100;
					return rtn_rev.toString().substr(1, 3);
				}
	
				var dayList = [];
				var dayData = [];
		
				<c:forEach var="data" items="${selectHouseRevenue}">
			        var day = "${data.day}";
			        var revenue = ${data.totalRevenue};
			        dayList.push(day);
			        dayData.push(revenue);
				</c:forEach>
			  
			  const ctx_revenue = document.getElementById('revenueChart').getContext('2d');
			  const revenueChart = new Chart(ctx_revenue, {
			    type: 'line',
			    data: {
			      labels: dayList,
			      datasets: [{
				    label: '일별 매출',
			        data: dayData,
			        borderColor:'rgba(255, 99, 132, 1)',
			        backgroundColor: 'rgba(255, 99, 132, 1)',
			        borderWidth: 1
			      }]
			    },
			    options: {
			      scales: {
			        y: {
			          beginAtZero: true
			        }
			      }
			    }
			  });

			  	// 일자별 회원가입 수
				function addZero(i) {
					var rtn = i + 100;
					return rtn.toString().substr(1, 3);
				}
	
				var monthList = [];
				var monthData = [];
		
				<c:forEach var="data" items="${selectEnrollMemberDate}">
			        var date = "${data.registrationDate}";
			        var count = ${data.memberCount};
			        monthList.push(date);
			        monthData.push(count);
				</c:forEach>
	
				const ctx_day = document.getElementById('dayChart').getContext('2d');
				const dayChart = new Chart(ctx_day, {
					type: 'line',
					data: {
						labels: monthList,
						datasets: [{
							data: monthData,
							borderColor:'rgba(255, 99, 132, 1)',
							borderWidth: 1
						}]
					},
		
					options: {
					  responsive: true,
					  plugins: {
						legend: {
						  display: false
						}
					  },
				        scales: {
				            y: {
				                ticks: {
				                    precision: 0 // 소수점 자리수를 0으로 설정하여 소수점 제거
				                }
				            }
				        }
					}
				});
			</script>
            <!-- 차트 끝 -->
            
            <!-- Footer Start -->
			<%@ include file="common/footer.jsp" %>
            <!-- Footer End -->
		</div>
        <!-- Content End -->
	
    </div>
    
</body>
</html>