package com.suim.admin.model.dao;

import java.util.ArrayList;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

import com.suim.admin.model.vo.Dashboard;
import com.suim.house.model.vo.Region;

@Repository
public class AdminDashboardDao {
	
	public int selectMemberAll(SqlSessionTemplate sqlSession) {
		return sqlSession.selectOne("adminDashboardMapper.selectMemberAll");
	}
	
	public int selectHouseAll(SqlSessionTemplate sqlSession) {
		return sqlSession.selectOne("adminDashboardMapper.selectHouseAll");
	}

	public Dashboard selectEnrollMember(SqlSessionTemplate sqlSession) {
		return (Dashboard)sqlSession.selectOne("adminDashboardMapper.selectEnrollMember");
	}

	public ArrayList<Dashboard> selectMemberGender(SqlSessionTemplate sqlSession) {
		return (ArrayList)sqlSession.selectList("adminDashboardMapper.selectMemberGender");
	}

	public ArrayList<Dashboard> selectMemberHouseTopN(SqlSessionTemplate sqlSession) {
		return (ArrayList)sqlSession.selectList("adminDashboardMapper.selectMemberHouseTopN");
	}

	public ArrayList<Dashboard> selectMemberInreviewTopN(SqlSessionTemplate sqlSession) {
		return (ArrayList)sqlSession.selectList("adminDashboardMapper.selectMemberInreviewTopN");
	}

	public int selectHouseCount(SqlSessionTemplate sqlSession) {
		return sqlSession.selectOne("adminDashboardMapper.selectHouseCount");
	}

	public int selectReservationCount(SqlSessionTemplate sqlSession) {
		return sqlSession.selectOne("adminDashboardMapper.selectReservationCount");
	}

	public Dashboard selectReservationRate(SqlSessionTemplate sqlSession) {
		return (Dashboard)sqlSession.selectOne("adminDashboardMapper.selectReservationRate");
	}

	public Dashboard selectEmptyRate(SqlSessionTemplate sqlSession) {
		return (Dashboard)sqlSession.selectOne("adminDashboardMapper.selectEmptyRate");
	}

	public ArrayList<Dashboard> selectHouseRevenue(SqlSessionTemplate sqlSession) {
		return (ArrayList)sqlSession.selectList("adminDashboardMapper.selectHouseRevenue");
	}

	public ArrayList<Dashboard> selectHouseDate(SqlSessionTemplate sqlSession) {
		return (ArrayList)sqlSession.selectList("adminDashboardMapper.selectHouseDate");
	}

	public ArrayList<Dashboard> selectRegionTopN(SqlSessionTemplate sqlSession) {
		return (ArrayList)sqlSession.selectList("adminDashboardMapper.selectRegionTopN");
	}

	public Dashboard selectEnrollMemberRate(SqlSessionTemplate sqlSession) {
		return (Dashboard)sqlSession.selectOne("adminDashboardMapper.selectEnrollMemberRate");
	}

	public Dashboard selectEnrollMemberMonthRate(SqlSessionTemplate sqlSession) {
		return (Dashboard)sqlSession.selectOne("adminDashboardMapper.selectEnrollMemberMonthRate");
	}

	public ArrayList<Dashboard> selectEnrollMemberDate(SqlSessionTemplate sqlSession) {
		return (ArrayList)sqlSession.selectList("adminDashboardMapper.selectEnrollMemberDate");
	}

	public Dashboard selectLeaveMemberRate(SqlSessionTemplate sqlSession) {
		return (Dashboard)sqlSession.selectOne("adminDashboardMapper.selectLeaveMemberRate");
	}
	
	public int selectFind1(SqlSessionTemplate sqlSession) {
		return sqlSession.selectOne("adminDashboardMapper.selectFind1");
	}
	public int selectFind2(SqlSessionTemplate sqlSession) {
		return sqlSession.selectOne("adminDashboardMapper.selectFind2");
	}
}
