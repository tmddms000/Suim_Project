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
		/*
		Dashboard dashboard = adminDashboardService.getDashboardData();
		
		model.addAttribute("dashboard", dashboard);
		*/
		
		// 전체 회원 수 조회
		int selectMemberAll = adminDashboardService.selectMemberAll();
		
		// 신규 가입 회원 수(월별)
		Dashboard selectEnrollMember = adminDashboardService.selectEnrollMember();
		
		// 성별별 회원 수 조회
		ArrayList<Dashboard> selectMemberGender = adminDashboardService.selectMemberGender();
		
		// 예약 TOP 3 회원 조회
		ArrayList<Dashboard> selectMemberHouseTopN = adminDashboardService.selectMemberHouseTopN();
		
		// 후기 TOP 3 회원 조회
		ArrayList<Dashboard> selectMemberInreviewTopN = adminDashboardService.selectMemberInreviewTopN();
		
		// 결제된 방 수
		int selectHouseCount = adminDashboardService.selectHouseCount();
		
		// 예약된 방 수
		int selectReservationCount = adminDashboardService.selectReservationCount();
		
		// 예약률
		Dashboard selectReservationRate = adminDashboardService.selectReservationRate();
		
		// 공실률
		Dashboard selectEmptyRate = adminDashboardService.selectEmptyRate();
		
		// 매출 분석
		// 월별 매출
		Dashboard selectHouseMonth = adminDashboardService.selectHouseMonth();
		
		// 최근 등록된 쉐어하우스 10개
		ArrayList<Dashboard> selectHouseDate = adminDashboardService.selectHouseDate();
		
		// 쉐어하우스 많은 지역 TOP 3
		ArrayList<Dashboard> selectRegionTopN = adminDashboardService.selectRegionTopN();
		
		// 전체 회원 수 대비 신규 가입 회원 수 비율
		Dashboard selectEnrollMemberRate = adminDashboardService.selectEnrollMemberRate();
		
		// 전달 대비 신규 가입 회원 비율
		Dashboard selectEnrollMemberMonthRate = adminDashboardService.selectEnrollMemberMonthRate();
		
		// 회원가입 일별 회원 수 조회
		ArrayList<Dashboard> selectEnrollMemberDate = adminDashboardService.selectEnrollMemberDate();
		
		// 회원탈퇴율
		Dashboard selectLeaveMemberRate = adminDashboardService.selectLeaveMemberRate();
		
		System.out.println(selectLeaveMemberRate);
		
		model.addAttribute("selectMemberAll", selectMemberAll)
			 .addAttribute("selectEnrollMember", selectEnrollMember)
			 .addAttribute("selectMemberGender", selectMemberGender)
			 .addAttribute("selectMemberHouseTopN", selectMemberHouseTopN)
			 .addAttribute("selectMemberInreviewTopN", selectMemberInreviewTopN)
			 .addAttribute("selectHouseCount", selectHouseCount)
			 .addAttribute("selectReservationCount", selectReservationCount)
			 .addAttribute("selectReservationRate", selectReservationRate)
			 .addAttribute("selectEmptyRate", selectEmptyRate)
			 .addAttribute("selectHouseMonth", selectHouseMonth)
			 .addAttribute("selectHouseDate", selectHouseDate)
			 .addAttribute("selectRegionTopN", selectRegionTopN)
			 .addAttribute("selectEnrollMemberRate", selectEnrollMemberRate)
			 .addAttribute("selectEnrollMemberMonthRate", selectEnrollMemberMonthRate)
			 .addAttribute("selectEnrollMemberDate", selectEnrollMemberDate)
			 .addAttribute("selectLeaveMemberRate", selectLeaveMemberRate);
			 
		
		return "admin/dashboard";
	}


}
