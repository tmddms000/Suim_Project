package com.suim.admin.model.dao;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

import com.suim.admin.model.vo.Dashboard;

@Repository
public class AdminDashboardDao {
	
	public Dashboard selectChart(SqlSessionTemplate sqlSession) {
		return sqlSession.selectOne("adminDashboardMapper.selectChart");
	}
}
