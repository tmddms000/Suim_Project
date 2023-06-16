package com.suim.admin.controller;

import java.util.ArrayList;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import com.suim.admin.model.service.AdminDashboardService;
import com.suim.admin.model.vo.Dashboard;
import com.suim.house.model.vo.Region;
import com.suim.member.model.vo.Member;

@RequestMapping("/admin")
@Controller
public class AdminDashboardController {

	@Autowired
	private AdminDashboardService adminDashboardService;
	
	@RequestMapping("/dashboard")
	public String showDashboard(Model model) {
		
		Dashboard dashboard = adminDashboardService.getDashboardData();
		
		model.addAttribute("dashboard", dashboard);
		System.out.println(dashboard);
		/*
		// 전체 회원 수 조회
		ArrayList<Member> selectMemberAll = adminDashboardService.selectMemberAll();
		
		// 신규 가입 회원 수(월별)
		int selectEnrollMember = adminDashboardService.selectEnrollMember();
		
		// 성별별 회원 수 조회
		int selectMemberGender = adminDashboardService.selectMemberGender();
		
		// 예약 TOP 3 회원 조회
		ArrayList<Member> selectMemberHouseTopN = adminDashboardService.selectMemberHouseTopN();
		
		// 후기 TOP 3 회원 조회
		ArrayList<Member> selectMemberInreviewTopN = adminDashboardService.selectMemberInreviewTopN();
		
		// 결제된 방 수
		int selectHouseCount = adminDashboardService.selectHouseCount();
		
		// 예약된 방 수
		int selectReservationCount = adminDashboardService.selectReservationCount();
		
		// 예약률
		int selectReservationRate = adminDashboardService.selectReservationRate();
		
		// 공실률
		int selectEmptyRate = adminDashboardService.selectEmptyRate();
		
		// 매출 분석
		// 월별 매출
		int selectHouseMonth = adminDashboardService.selectHouseMonth();
		
		// 최근 등록된 쉐어하우스 10개
		int selectHouseDate = adminDashboardService.selectHouseDate();
		
		// 쉐어하우스 많은 지역 TOP 3
		ArrayList<Region> selectRegionTopN = adminDashboardService.selectRegionTopN();
		
		// 전체 회원 수 대비 신규 가입 회원 수 비율
		double selectEnrollMemberRate = adminDashboardService.selectEnrollMemberRate();
		
		// 전달 대비 신규 가입 회원 비율
		double selectEnrollMemberMonthRate = adminDashboardService.selectEnrollMemberMonthRate();
		
		// 회원가입 일별 회원 수 조회
		int selectEnrollMemberDate = adminDashboardService.selectEnrollMemberDate();
		
		// 회원탈퇴율
		double selectLeaveMemberRate = adminDashboardService.selectLeaveMemberRate();
		 */
		
		return "admin/dashboard";
	}


}
