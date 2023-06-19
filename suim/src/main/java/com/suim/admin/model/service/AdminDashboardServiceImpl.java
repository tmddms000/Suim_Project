package com.suim.admin.model.service;

import java.util.ArrayList;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.suim.admin.model.dao.AdminDashboardDao;
import com.suim.admin.model.vo.Dashboard;
import com.suim.house.model.vo.Region;
import com.suim.member.model.vo.Member;

@Service
public class AdminDashboardServiceImpl implements AdminDashboardService {

	@Autowired
	private AdminDashboardDao adminDashboardDao;
	
	@Autowired
	private SqlSessionTemplate sqlSession;
	
	/*
	public Dashboard getDashboardData() {
		
		Dashboard dashboard = new Dashboard();
		
		dashboard.setSelectMemberAll(dashboard.getSelectMemberAll());
		dashboard.setSelectEnrollMember(dashboard.getSelectEnrollMember());
		dashboard.setSelectMemberGender(dashboard.getSelectMemberGender());
		dashboard.setSelectMemberHouseTopN(dashboard.getSelectMemberHouseTopN());
		dashboard.setSelectMemberInreviewTopN(dashboard.getSelectMemberInreviewTopN());
		dashboard.setSelectHouseCount(dashboard.getSelectHouseCount());
		dashboard.setSelectReservationCount(dashboard.getSelectReservationCount());
		dashboard.setSelectReservationRate(dashboard.getSelectReservationRate());
		dashboard.setSelectEmptyRate(dashboard.getSelectEmptyRate());
		dashboard.setSelectHouseMonth(dashboard.getSelectHouseMonth());
		dashboard.setSelectHouseDate(dashboard.getSelectHouseDate());
		dashboard.setSelectRegionTopN(dashboard.getSelectRegionTopN());
		dashboard.setSelectEnrollMemberRate(dashboard.getSelectEnrollMemberRate());
		dashboard.setSelectEnrollMemberMonthRate(dashboard.getSelectEnrollMemberMonthRate());
		dashboard.setSelectEnrollMemberDate(dashboard.getSelectEnrollMemberDate());
		dashboard.setSelectLeaveMemberRate(dashboard.getSelectLeaveMemberRate());
		
		return dashboard;
	}
	*/
	/*
	public Dashboard getDashboardData() {
		
		Dashboard dashboard = new Dashboard();
		
		dashboard.setSelectMemberAll(adminDashboardDao.selectMemberAll(sqlSession));
		dashboard.setSelectEnrollMember(adminDashboardDao.selectEnrollMember(sqlSession));
		dashboard.setSelectMemberGender(adminDashboardDao.selectMemberGender(sqlSession));
		dashboard.setSelectMemberHouseTopN(adminDashboardDao.selectMemberHouseTopN(sqlSession));
		dashboard.setSelectMemberInreviewTopN(adminDashboardDao.selectMemberInreviewTopN(sqlSession));
		dashboard.setSelectHouseCount(adminDashboardDao.selectHouseCount(sqlSession));
		dashboard.setSelectReservationCount(adminDashboardDao.selectReservationCount(sqlSession));
		dashboard.setSelectReservationRate(adminDashboardDao.selectReservationRate(sqlSession));
		dashboard.setSelectEmptyRate(adminDashboardDao.selectEmptyRate(sqlSession));
		dashboard.setSelectHouseMonth(adminDashboardDao.selectHouseMonth(sqlSession));
		dashboard.setSelectHouseDate(adminDashboardDao.selectHouseDate(sqlSession));
		dashboard.setSelectRegionTopN(adminDashboardDao.selectRegionTopN(sqlSession));
		dashboard.setSelectEnrollMemberRate(adminDashboardDao.selectEnrollMemberRate(sqlSession));
		dashboard.setSelectEnrollMemberMonthRate(adminDashboardDao.selectEnrollMemberMonthRate(sqlSession));
		dashboard.setSelectEnrollMemberDate(adminDashboardDao.selectEnrollMemberDate(sqlSession));
		dashboard.setSelectLeaveMemberRate(adminDashboardDao.selectLeaveMemberRate(sqlSession));
		
		return dashboard;
	}
	*/

	@Override
	public int selectMemberAll() {
		return adminDashboardDao.selectMemberAll(sqlSession);
	}

	@Override
	public Dashboard selectEnrollMember() {
		return adminDashboardDao.selectEnrollMember(sqlSession);
	}

	@Override
	public ArrayList<Dashboard> selectMemberGender() {
		return adminDashboardDao.selectMemberGender(sqlSession);
	}

	@Override
	public ArrayList<Dashboard> selectMemberHouseTopN() {
		return adminDashboardDao.selectMemberHouseTopN(sqlSession);
	}

	@Override
	public ArrayList<Dashboard> selectMemberInreviewTopN() {
		return adminDashboardDao.selectMemberInreviewTopN(sqlSession);
	}

	@Override
	public int selectHouseCount() {
		return adminDashboardDao.selectHouseCount(sqlSession);
	}

	@Override
	public int selectReservationCount() {
		return adminDashboardDao.selectReservationCount(sqlSession);
	}

	@Override
	public Dashboard selectReservationRate() {
		return adminDashboardDao.selectReservationRate(sqlSession);
	}

	@Override
	public Dashboard selectEmptyRate() {
		return adminDashboardDao.selectEmptyRate(sqlSession);
	}

	@Override
	public Dashboard selectHouseMonth() {
		return adminDashboardDao.selectHouseMonth(sqlSession);
	}

	@Override
	public ArrayList<Dashboard> selectHouseDate() {
		return adminDashboardDao.selectHouseDate(sqlSession);
	}

	@Override
	public ArrayList<Dashboard> selectRegionTopN() {
		return adminDashboardDao.selectRegionTopN(sqlSession);
	}

	@Override
	public Dashboard selectEnrollMemberRate() {
		return adminDashboardDao.selectEnrollMemberRate(sqlSession);
	}

	@Override
	public Dashboard selectEnrollMemberMonthRate() {
		return adminDashboardDao.selectEnrollMemberMonthRate(sqlSession);
	}

	@Override
	public ArrayList<Dashboard> selectEnrollMemberDate() {
		return adminDashboardDao.selectEnrollMemberDate(sqlSession);
	}

	@Override
	public Dashboard selectLeaveMemberRate() {
		return adminDashboardDao.selectLeaveMemberRate(sqlSession);
	}
}
