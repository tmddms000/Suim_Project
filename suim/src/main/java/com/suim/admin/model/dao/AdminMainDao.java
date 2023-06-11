package com.suim.admin.model.dao;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

import com.suim.admin.model.vo.AdminMain;

@Repository
public class AdminMainDao {
	
	public AdminMain selectChart(SqlSessionTemplate sqlSession) {
		return sqlSession.selectOne("adminMainMapper.selectChart");
	}
}
