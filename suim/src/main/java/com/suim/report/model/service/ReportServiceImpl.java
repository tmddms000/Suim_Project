package com.suim.report.model.service;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.suim.report.model.dao.ReportDao;
import com.suim.report.model.vo.Rattachment;
import com.suim.report.model.vo.Report;

@Service
public class ReportServiceImpl implements ReportService {

	@Autowired
	private ReportDao reportDao;
	
	@Autowired
	private SqlSessionTemplate sqlSession;
	
	@Override
	public int insertReport(Report r) {
		return reportDao.insertReport(sqlSession, r);
	}
	@Override
	public int insertRattachment(Rattachment ra) {
		return reportDao.insertRattachment(sqlSession, ra);
	}
}
