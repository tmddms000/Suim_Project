package com.suim.report.model.dao;

import java.util.HashMap;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

import com.suim.report.model.vo.Rattachment;
import com.suim.report.model.vo.Report;

@Repository
public class ReportDao {

	public int insertReport(SqlSessionTemplate sqlSession, Report r) {
		return sqlSession.insert("reportMapper.insertReport", r);
	}

	// 신고 누적 횟수 구하기
	public int selectBlackList(SqlSessionTemplate sqlSession, String reportId) {
		return sqlSession.selectOne("reportMapper.selectBlackList", reportId);
	}
	// 누적되면 상태값을 블랙으로 바꾸기용
	public int updateBlackList(SqlSessionTemplate sqlSession, String reportId) {
		return sqlSession.update("reportMapper.updateBlackList", reportId);
	}
	
	public int insertRattachment(SqlSessionTemplate sqlSession, Rattachment ra) {
		return sqlSession.insert("reportMapper.rattachment", ra);
	}
	
	public Integer hasDuplicateReport(SqlSessionTemplate sqlSession, Report r) {
		return sqlSession.selectOne("reportMapper.hasDuplicateReport", r);
	}

	public int selectY(SqlSessionTemplate sqlSession, String reportId) {
		return sqlSession.selectOne("reportMapper.selectY", reportId);
	}
	
	public Report selectReport(SqlSessionTemplate sqlSession, int reportNo) {
		return sqlSession.selectOne("reportMapper.selectReport", reportNo);
	}
}
