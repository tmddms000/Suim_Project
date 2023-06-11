package com.suim.admin.model.service;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.suim.admin.model.dao.AdminMainDao;
import com.suim.admin.model.vo.AdminMain;

@Service
public class AdminMainServiceImpl implements AdminMainService {

	@Autowired
	private AdminMainDao adminMainDao;
	
	@Autowired
	private SqlSessionTemplate sqlSession;

	@Override
	public AdminMain selectChart() {
		return adminMainDao.selectChart(sqlSession);
	}

}
