package com.suim.report.model.dao;

import java.util.ArrayList;

import org.apache.ibatis.session.RowBounds;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

import com.suim.common.model.vo.PageInfo;
import com.suim.member.model.vo.Member;
import com.suim.report.model.vo.Report;

@Repository
public class AdminReportDao {

	public int selectListCount(SqlSessionTemplate sqlSession) {
		return sqlSession.selectOne("adminReportMapper.selectListCount");
	}
	
	// 전체 조회용 selectList
	public ArrayList<Report> selectList(SqlSessionTemplate sqlSession, PageInfo pi) {
		
		int offset = (pi.getCurrentPage() - 1) * pi.getBoardLimit(); // offset : 건너뛸 숫자
		int limit = pi.getBoardLimit(); // limit : 조회할 갯수
		
		RowBounds rowBounds = new RowBounds(offset, limit);
		
		return (ArrayList)sqlSession.selectList("adminReportMapper.selectList", null, rowBounds);
	}
	
	// 카테고리용 selectList
	public ArrayList<Report> selectList(SqlSessionTemplate sqlSession, PageInfo pi, String category) {
		
		int offset = (pi.getCurrentPage() - 1) * pi.getBoardLimit(); // offset : 건너뛸 숫자
		int limit = pi.getBoardLimit(); // limit : 조회할 갯수
		
		RowBounds rowBounds = new RowBounds(offset, limit);
		
		return (ArrayList)sqlSession.selectList("adminReportMapper.selectCategoryList", category, rowBounds);
	}
	
	public int insertReport(SqlSessionTemplate sqlSession, Report r) {
		return sqlSession.insert("adminReportMapper.insertReport", r);
	}

	
	public Report selectReport(SqlSessionTemplate sqlSession, int reportNo) {
		return sqlSession.selectOne("adminReportMapper.selectReport", reportNo);
	}
	
	public int deleteReport(SqlSessionTemplate sqlSession, int reportNo) {
		return sqlSession.update("adminReportMapper.deleteReport", reportNo);
	}
	
	public int updateReport(SqlSessionTemplate sqlSession, Report r) {
		return sqlSession.update("adminReportMapper.updateReport", r);
	}
	
	public ArrayList<Member> selectTopMemberList(SqlSessionTemplate sqlSession) {
		return (ArrayList)sqlSession.selectList("adminReportMapper.selectTopMemberList");
	}
}
