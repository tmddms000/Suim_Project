package com.suim.admin.model.service;

import java.util.ArrayList;

import com.suim.admin.model.vo.Dashboard;

public interface AdminDashboardService {
	
	// Dashboard getDashboardData();


	// 전체 회원 수 조회
	int selectMemberAll();
	
	// 신규 가입 회원 수(월별)
	Dashboard selectEnrollMember();
	
	// 성별별 회원 수 조회
	ArrayList<Dashboard> selectMemberGender();
	
	// 예약 TOP 3 회원 조회
	ArrayList<Dashboard> selectMemberHouseTopN();
	
	// 후기 TOP 3 회원 조회
	ArrayList<Dashboard> selectMemberInreviewTopN();
	
	// 결제된 방 수
	int selectHouseCount();
	
	// 예약된 방 수
	int selectReservationCount();
	
	// 예약률
	Dashboard selectReservationRate();
	
	// 공실률
	Dashboard selectEmptyRate();
	
	// 매출 분석
	// 월별 매출
	Dashboard selectHouseMonth();
	
	// 최근 등록된 쉐어하우스 10개
	ArrayList<Dashboard> selectHouseDate();
	
	// 쉐어하우스 많은 지역 TOP 3
	ArrayList<Dashboard> selectRegionTopN();
	
	// 전체 회원 수 대비 신규 가입 회원 수 비율
	Dashboard selectEnrollMemberRate();
	
	// 전달 대비 신규 가입 회원 비율
	Dashboard selectEnrollMemberMonthRate();
	
	// 회원가입 일별 회원 수 조회
	ArrayList<Dashboard> selectEnrollMemberDate();
	
	// 회원탈퇴율
	Dashboard selectLeaveMemberRate();
	
}
