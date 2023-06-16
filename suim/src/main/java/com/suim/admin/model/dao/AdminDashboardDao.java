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

	public Dashboard selectEnrollMember(SqlSessionTemplate sqlSession) {
		return (Dashboard)sqlSession.selectOne("adminDashboardMapper.selectEnrollMember");
	}

	public Dashboard selectMemberGender(SqlSessionTemplate sqlSession) {
		return (Dashboard)sqlSession.selectOne("adminDashboardMapper.selectMemberGender");
	}

	public Dashboard selectMemberHouseTopN(SqlSessionTemplate sqlSession) {
		return (Dashboard)sqlSession.selectOne("adminDashboardMapper.selectMemberHouseTopN");
	}

	public Dashboard selectMemberInreviewTopN(SqlSessionTemplate sqlSession) {
		return (Dashboard)sqlSession.selectOne("adminDashboardMapper.selectMemberInreviewTopN");
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

	public Dashboard selectHouseMonth(SqlSessionTemplate sqlSession) {
		return (Dashboard)sqlSession.selectOne("adminDashboardMapper.selectHouseMonth");
	}

	public Dashboard selectHouseDate(SqlSessionTemplate sqlSession) {
		return (Dashboard)sqlSession.selectOne("adminDashboardMapper.selectHouseDate");
	}

	public Dashboard selectRegionTopN(SqlSessionTemplate sqlSession) {
		return (Dashboard)sqlSession.selectOne("adminDashboardMapper.selectRegionTopN");
	}

	public Dashboard selectEnrollMemberRate(SqlSessionTemplate sqlSession) {
		return (Dashboard)sqlSession.selectOne("adminDashboardMapper.selectEnrollMemberRate");
	}

	public Dashboard selectEnrollMemberMonthRate(SqlSessionTemplate sqlSession) {
		return (Dashboard)sqlSession.selectOne("adminDashboardMapper.selectEnrollMemberMonthRate");
	}

	public Dashboard selectEnrollMemberDate(SqlSessionTemplate sqlSession) {
		return (Dashboard)sqlSession.selectOne("adminDashboardMapper.selectEnrollMemberDate");
	}

	public Dashboard selectLeaveMemberRate(SqlSessionTemplate sqlSession) {
		return (Dashboard)sqlSession.selectOne("adminDashboardMapper.selectLeaveMemberRate");
	}
}
