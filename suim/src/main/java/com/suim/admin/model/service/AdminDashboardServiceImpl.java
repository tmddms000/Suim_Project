package com.suim.admin.model.service;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.suim.admin.model.dao.AdminDashboardDao;
import com.suim.admin.model.vo.Dashboard;

@Service
public class AdminDashboardServiceImpl implements AdminDashboardService {

	@Autowired
	private AdminDashboardDao adminDashboardDao;
	
	@Autowired
	private SqlSessionTemplate sqlSession;

	@Override
	public Dashboard selectChart() {
		return adminDashboardDao.selectChart(sqlSession);
	}

}
