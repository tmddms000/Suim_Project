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

		int selectMemberAll = adminDashboardService.selectMemberAll();
		
		int selectHouseAll = adminDashboardService.selectHouseAll();
		
		Dashboard selectEnrollMember = adminDashboardService.selectEnrollMember();
		
		ArrayList<Dashboard> selectMemberGender = adminDashboardService.selectMemberGender();
		
		ArrayList<Dashboard> selectMemberHouseTopN = adminDashboardService.selectMemberHouseTopN();
		
		ArrayList<Dashboard> selectMemberInreviewTopN = adminDashboardService.selectMemberInreviewTopN();
		
		int selectHouseCount = adminDashboardService.selectHouseCount();
		
		int selectReservationCount = adminDashboardService.selectReservationCount();
		
		Dashboard selectReservationRate = adminDashboardService.selectReservationRate();
		
		Dashboard selectEmptyRate = adminDashboardService.selectEmptyRate();
		
		ArrayList<Dashboard> selectHouseRevenue = adminDashboardService.selectHouseRevenue();
		
		ArrayList<Dashboard> selectHouseDate = adminDashboardService.selectHouseDate();
		
		ArrayList<Dashboard> selectRegionTopN = adminDashboardService.selectRegionTopN();
		
		Dashboard selectEnrollMemberRate = adminDashboardService.selectEnrollMemberRate();
		
		Dashboard selectEnrollMemberMonthRate = adminDashboardService.selectEnrollMemberMonthRate();
		
		ArrayList<Dashboard> selectEnrollMemberDate = adminDashboardService.selectEnrollMemberDate();
		
		Dashboard selectLeaveMemberRate = adminDashboardService.selectLeaveMemberRate();
		
		int selectFind1 = adminDashboardService.selectFind1();
		int selectFind2 = adminDashboardService.selectFind2();
		
		model.addAttribute("selectMemberAll", selectMemberAll)
			 .addAttribute("selectHouseAll", selectHouseAll)
			 .addAttribute("selectEnrollMember", selectEnrollMember)
			 .addAttribute("selectMemberGender", selectMemberGender)
			 .addAttribute("selectMemberHouseTopN", selectMemberHouseTopN)
			 .addAttribute("selectMemberInreviewTopN", selectMemberInreviewTopN)
			 .addAttribute("selectHouseCount", selectHouseCount)
			 .addAttribute("selectReservationCount", selectReservationCount)
			 .addAttribute("selectReservationRate", selectReservationRate)
			 .addAttribute("selectEmptyRate", selectEmptyRate)
			 .addAttribute("selectHouseRevenue", selectHouseRevenue)
			 .addAttribute("selectHouseDate", selectHouseDate)
			 .addAttribute("selectRegionTopN", selectRegionTopN)
			 .addAttribute("selectEnrollMemberRate", selectEnrollMemberRate)
			 .addAttribute("selectEnrollMemberMonthRate", selectEnrollMemberMonthRate)
			 .addAttribute("selectEnrollMemberDate", selectEnrollMemberDate)
			 .addAttribute("selectLeaveMemberRate", selectLeaveMemberRate)
			 .addAttribute("selectFind1", selectFind1)
			 .addAttribute("selectFind2", selectFind2);
			 
		
		return "admin/dashboard";
	}


}
