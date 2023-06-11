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
                                <p class="mb-2">뭐넣지?</p>
                                <h6 class="mb-0">$1234</h6>
                            </div>
                        </div>
                    </div>
                    <div class="col-sm-6 col-xl-3">
                        <div class="bg-light rounded d-flex align-items-center justify-content-between p-4">
                            <i class="fa fa-chart-bar fa-3x text-primary"></i>
                            <div class="ms-3">
                                <p class="mb-2">무엇?</p>
                                <h6 class="mb-0">$1234</h6>
                            </div>
                        </div>
                    </div>
                    <div class="col-sm-6 col-xl-3">
                        <div class="bg-light rounded d-flex align-items-center justify-content-between p-4">
                            <i class="fa fa-chart-area fa-3x text-primary"></i>
                            <div class="ms-3">
                                <p class="mb-2">넣지?</p>
                                <h6 class="mb-0">$1234</h6>
                            </div>
                        </div>
                    </div>
                    <div class="col-sm-6 col-xl-3">
                        <div class="bg-light rounded d-flex align-items-center justify-content-between p-4">
                            <i class="fa fa-chart-pie fa-3x text-primary"></i>
                            <div class="ms-3">
                                <p class="mb-2">매출?</p>
                                <h6 class="mb-0">$1234</h6>
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
                        <div class="bg-light text-center rounded p-4">
                            <div class="d-flex align-items-center justify-content-between mb-4">
                                <h6 class="mb-0">성비</h6>
                            </div>
                            <div style="width:550px;height:308px;">
                            	<canvas id="genderChart"></canvas>
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
                                <h6 class="mb-0">신고 순위</h6>
                            </div>
                            <canvas id="reportChart"></canvas>
                        </div>
                    </div>
                    <div class="col-sm-12 col-xl-6">
                        <div class="bg-light text-center rounded p-4">
                            <div class="d-flex align-items-center justify-content-between mb-4">
                                <h6 class="mb-0">게시글 순위</h6>
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
			
			  new Chart(ctx_gender, {
			    type: 'doughnut',
			    data: {
			      labels: ['남성', '여성'],
			      datasets: [{
			        label: '성비',
			        data: [1, 3],
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

			  const ctx_board = document.getElementById('boardChart');
			
			  new Chart(ctx_board, {
			    type: 'bar',
			    data: {
			      labels: ['방구해요', '세놓아요'],
			      datasets: [{
			        label: '게시글 순위',
			        data: [1, 3],
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

			  const ctx_report = document.getElementById('reportChart');
			
			  new Chart(ctx_report, {
			    type: 'line',
			    data: {
			      labels: ['회원', '쉐어하우스', '자유게시판', '자유게시판 댓글', '사람구해요', '사람구해요 댓글', '채팅방'],
			      datasets: [{
			        label: '신고 순위',
			        data: [1, 3],
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

				function addZero(i) {
					var rtn = i + 100;
					return rtn.toString().substr(1, 3);
				}
		
				var monthList = [];
				var monthData = [50,60,70,45,50,66,77];
		
				var today = new Date();
				var year = today.getFullYear();
				var month = ("0" + (today.getMonth() + 1)).slice(-2);
				var day = ("0" + today.getDate()).slice(-2);
		
				var monthList = [];
		
				for (var i = 6; i >= 0; i--) {
				  var currentDate = new Date(year, today.getMonth(), today.getDate() - i);
				  var format = currentDate.getFullYear() + "-" + ("0" + (currentDate.getMonth() + 1)).slice(-2) + "-" + ("0" + currentDate.getDate()).slice(-2);
				  monthList.push(format);
				}
		
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