package com.suim.report.model.dao;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map;

import org.apache.ibatis.session.RowBounds;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

import com.suim.common.model.vo.PageInfo;
import com.suim.report.model.vo.Report;

@Repository
public class AdminReportDao {

	// 신고 총 갯수 조회
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
		
	// 카테고리용 총 갯수 조회
	public int selectCategoryListCount(SqlSessionTemplate sqlSession, String category) {
		return sqlSession.selectOne("adminReportMapper.selectCategoryListCount", category);
	}
	
	// 카테고리용 selectList
	public ArrayList<Report> selectCategoryList(SqlSessionTemplate sqlSession, PageInfo pi, String category) {
		
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
	
	// 승인/반려 처리용
	public int updateReportStatus(SqlSessionTemplate sqlSession, Report r) {
		return sqlSession.update("adminReportMapper.updateReportStatus", r);
	}
	// 전체선택용 승인/반려용
	public int updateStatusAll(SqlSessionTemplate sqlSession, int[] intArray, String reportStatus) {
		Map<String, Object> map = new HashMap<>();
		map.put("reportStatus", reportStatus);
		map.put("intArray", intArray);
		return sqlSession.update("adminReportMapper.updateStatusAll", map);
	}
	
	// 검색용
	public int selectSearchCount(SqlSessionTemplate sqlSession, HashMap<String, String> map) {
		
		return sqlSession.selectOne("adminReportMapper.selectSearchCount", map);
	}
	
	public ArrayList<Report> selectSearchList(SqlSessionTemplate sqlSession, HashMap<String, String> map, PageInfo pi){
	
		// 페이징 처리에 필요한 마이바티스용 객체: RowBounds
		// => 객체 생성 시 필요한 변수: offset(건너 뛸 숫자), limit(조회할 개수)
		int limit = pi.getBoardLimit();
		int offset = (pi.getCurrentPage() - 1) * limit;
		
		RowBounds rowBounds = new RowBounds(offset, limit);
		
		return (ArrayList)sqlSession.selectList("adminReportMapper.selectSearchList", map, rowBounds);
	}

	
}
