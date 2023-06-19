package com.suim.admin.model.service;

import java.util.ArrayList;

import com.suim.admin.model.vo.Dashboard;

public interface AdminDashboardService {
	
	int selectMemberAll();
	
	int selectHouseAll();
	
	Dashboard selectEnrollMember();
	
	ArrayList<Dashboard> selectMemberGender();
	
	ArrayList<Dashboard> selectMemberHouseTopN();
	
	ArrayList<Dashboard> selectMemberInreviewTopN();
	
	int selectHouseCount();
	
	int selectReservationCount();
	
	Dashboard selectReservationRate();
	
	Dashboard selectEmptyRate();
	
	ArrayList<Dashboard> selectHouseRevenue();
	
	ArrayList<Dashboard> selectHouseDate();
	
	ArrayList<Dashboard> selectRegionTopN();
	
	Dashboard selectEnrollMemberRate();
	
	Dashboard selectEnrollMemberMonthRate();
	
	ArrayList<Dashboard> selectEnrollMemberDate();
	
	Dashboard selectLeaveMemberRate();
	
	
	int selectFind1();
	int selectFind2();
}
