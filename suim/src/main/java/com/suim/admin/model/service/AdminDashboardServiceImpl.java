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

	@Override
	public int selectMemberAll() {
		return adminDashboardDao.selectMemberAll(sqlSession);
	}
	
	@Override
	public int selectHouseAll() {
		return adminDashboardDao.selectHouseAll(sqlSession);
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
	public ArrayList<Dashboard> selectHouseRevenue() {
		return adminDashboardDao.selectHouseRevenue(sqlSession);
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
	
	@Override
	public int selectFind1() {
		return adminDashboardDao.selectFind1(sqlSession);
	}
	@Override
	public int selectFind2() {
		return adminDashboardDao.selectFind2(sqlSession);
	}
}
