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
	
	// 블랙리스트 횟수 조회용
	@Override
	public int selectBlackList(String reportId) {
		return reportDao.selectBlackList(sqlSession, reportId);
	}
	// 블랙리스트로 상태 변경용
	@Override
	public int updateBlackList(String reportId) {
		return reportDao.updateBlackList(sqlSession, reportId);
	}

	@Override
	public int insertRattachment(Rattachment ra) {
		return reportDao.insertRattachment(sqlSession, ra);
	}

	@Override
	public Integer hasDuplicateReport(Report r) {
		return reportDao.hasDuplicateReport(sqlSession, r);
	}
	
	@Override
	public int selectY(String reportId) {
		return reportDao.selectY(sqlSession, reportId);
	}
	
	@Override
	public Report selectReport(int reportNo) {
		return reportDao.selectReport(sqlSession, reportNo);
	}
}
