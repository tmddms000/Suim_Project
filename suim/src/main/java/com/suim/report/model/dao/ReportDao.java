package com.suim.report.model.dao;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

import com.suim.report.model.vo.Rattachment;
import com.suim.report.model.vo.Report;

@Repository
public class ReportDao {

	public int insertReport(SqlSessionTemplate sqlSession, Report r) {
		return sqlSession.insert("reportMapper.insertReport", r);
	}
	public int insertRattachment(SqlSessionTemplate sqlSession, Rattachment ra) {
		return sqlSession.insert("reportMapper.rattachment", ra);
	}
}
