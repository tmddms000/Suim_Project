package com.suim.admin.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import com.suim.admin.model.service.AdminMainService;
import com.suim.admin.model.vo.AdminMain;

@Controller
public class AdminMainController {

	@Autowired
	private AdminMainService adminMainService;
	
	@RequestMapping("admin")
	public void selectChart() {
		AdminMain am = new AdminMain();
		am = adminMainService.selectChart();
		System.out.println(am.toString());
	}
}
