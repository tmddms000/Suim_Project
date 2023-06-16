package com.suim.admin.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import com.suim.admin.model.service.AdminDashboardService;
import com.suim.admin.model.vo.Dashboard;

@Controller
public class AdminDashboardController {

	@Autowired
	private AdminDashboardService adminDashboardService;
	
	@RequestMapping("admin")
	public void selectChart() {
		Dashboard da = new Dashboard();
		da = adminDashboardService.selectChart();
		System.out.println(da.toString());
	}
}
