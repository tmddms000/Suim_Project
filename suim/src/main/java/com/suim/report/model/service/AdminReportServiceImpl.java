package com.suim.report.model.service;

import java.util.ArrayList;
import java.util.HashMap;

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

	// 신고 총 갯수 조회
	@Override
	public int selectListCount() {
		return adminReportDao.selectListCount(sqlSession);
	}
	
	// 전체 조회용
	@Override
	public ArrayList<Report> selectList(PageInfo pi) {
		return adminReportDao.selectList(sqlSession, pi);
	}

	// 카테고리용 전체 조회
	@Override
	public int selectCategoryListCount(String category) {
		return adminReportDao.selectCategoryListCount(sqlSession, category);
	}
	@Override
	public ArrayList<Report> selectCategoryList(PageInfo pi, String category) {
		return adminReportDao.selectCategoryList(sqlSession, pi, category);
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
	
	// 승인/반려 처리용
	@Override
	public int updateReportStatus(Report r) {
		return adminReportDao.updateReportStatus(sqlSession, r);
	}
	
	// 전체선택 승인/반려용
	@Override
	public int updateStatusAll(int[] intArray, String reportStatus) {
		return adminReportDao.updateStatusAll(sqlSession, intArray, reportStatus);
	}

	// 검색용
	@Override
	public int selectSearchCount(HashMap<String, String> map) {
		return adminReportDao.selectSearchCount(sqlSession, map);
	}
	@Override
	public ArrayList<Report> selectSearchList(HashMap<String, String> map, PageInfo pi) {
		return adminReportDao.selectSearchList(sqlSession, map, pi);
	}


	
}
