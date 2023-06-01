package com.suim.report.model.service;

import java.util.ArrayList;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.suim.common.model.vo.PageInfo;
import com.suim.report.model.dao.AdminReportDao;
import com.suim.report.model.vo.Report;

@Service
public class AdminReportServiceImpl implements AdminReportService {

	@Autowired
	private AdminReportDao adminReportDao;
	
	@Autowired
	private SqlSessionTemplate sqlSession;

	@Override
	public int selectListCount() {
		return adminReportDao.selectListCount(sqlSession);
	}

	@Override
	public ArrayList<Report> selectList(PageInfo pi) {
		return adminReportDao.selectList(sqlSession, pi);
	}

	@Override
	public int insertReport(Report r) {
		return adminReportDao.insertReport(sqlSession, r);
	}

	@Override
	public Report selectReport(int reportNo) {
		return adminReportDao.selectReport(sqlSession, reportNo);
	}

	@Override
	public int deleteReport(int reportNo) {
		return adminReportDao.deleteReport(sqlSession, reportNo);
	}

	@Override
	public int updateReport(Report r) {
		return adminReportDao.updateReport(sqlSession, r);
	}

}
