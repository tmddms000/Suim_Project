package com.suim.admin.model.dao;

import java.util.ArrayList;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

import com.suim.admin.model.vo.Dashboard;
import com.suim.house.model.vo.Region;
import com.suim.member.model.vo.Member;

@Repository
public class AdminDashboardDao {
	
	public ArrayList<Member> selectMemberAll(SqlSessionTemplate sqlSession) {
		return (ArrayList)sqlSession.selectList("adminDashboardMapper.selectMemberAll");
	}

	public ArrayList<Member> selectEnrollMember(SqlSessionTemplate sqlSession) {
		return (ArrayList)sqlSession.selectList("adminDashboardMapper.selectEnrollMember");
	}

	public ArrayList<Member> selectMemberGender(SqlSessionTemplate sqlSession) {
		return (ArrayList)sqlSession.selectList("adminDashboardMapper.selectMemberGender");
	}

	public ArrayList<Member> selectMemberHouseTopN(SqlSessionTemplate sqlSession) {
		return (ArrayList)sqlSession.selectList("adminDashboardMapper.selectMemberHouseTopN");
	}

	public ArrayList<Member> selectMemberInreviewTopN(SqlSessionTemplate sqlSession) {
		return (ArrayList)sqlSession.selectList("adminDashboardMapper.selectMemberInreviewTopN");
	}

	public int selectHouseCount(SqlSessionTemplate sqlSession) {
		return sqlSession.selectOne("adminDashboardMapper.selectHouseCount");
	}

	public int selectReservationCount(SqlSessionTemplate sqlSession) {
		return sqlSession.selectOne("adminDashboardMapper.selectReservationCount");
	}

	public ArrayList<Member> selectReservationRate(SqlSessionTemplate sqlSession) {
		return (ArrayList)sqlSession.selectList("adminDashboardMapper.selectReservationRate");
	}

	public ArrayList<Member> selectEmptyRate(SqlSessionTemplate sqlSession) {
		return (ArrayList)sqlSession.selectList("adminDashboardMapper.selectEmptyRate");
	}

	public ArrayList<Member> selectHouseMonth(SqlSessionTemplate sqlSession) {
		return (ArrayList)sqlSession.selectList("adminDashboardMapper.selectHouseMonth");
	}

	public ArrayList<Member> selectHouseDate(SqlSessionTemplate sqlSession) {
		return (ArrayList)sqlSession.selectList("adminDashboardMapper.selectHouseDate");
	}

	public ArrayList<Region> selectRegionTopN(SqlSessionTemplate sqlSession) {
		return (ArrayList)sqlSession.selectList("adminDashboardMapper.selectRegionTopN");
	}

	public ArrayList<Member> selectEnrollMemberRate(SqlSessionTemplate sqlSession) {
		return (ArrayList)sqlSession.selectList("adminDashboardMapper.selectEnrollMemberRate");
	}

	public ArrayList<Member> selectEnrollMemberMonthRate(SqlSessionTemplate sqlSession) {
		return (ArrayList)sqlSession.selectList("adminDashboardMapper.selectEnrollMemberMonthRate");
	}

	public ArrayList<Member> selectEnrollMemberDate(SqlSessionTemplate sqlSession) {
		return (ArrayList)sqlSession.selectList("adminDashboardMapper.selectEnrollMemberDate");
	}

	public ArrayList<Member> selectLeaveMemberRate(SqlSessionTemplate sqlSession) {
		return (ArrayList)sqlSession.selectList("adminDashboardMapper.selectLeaveMemberRate");
	}
}
