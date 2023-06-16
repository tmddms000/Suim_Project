package com.suim.house.model.dao;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map;

import org.apache.ibatis.session.RowBounds;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

import com.suim.common.model.vo.PageInfo;
import com.suim.house.model.vo.House;
import com.suim.report.model.vo.Report;

@Repository
public class AdminHouseDao {

	// 쉐어하우스 총 갯수 조회
	public int selectListCount(SqlSessionTemplate sqlSession) {
		return sqlSession.selectOne("adminHouseMapper.selectListCount");
	}
	
	// 카테고리용 총 갯수 조회
	public int selectListCount(SqlSessionTemplate sqlSession, String category) {
		return sqlSession.selectOne("adminHouseMapper.selectCategoryListCount", category);
	}
	
	// 전체 조회용 selectList
	public ArrayList<House> selectList(SqlSessionTemplate sqlSession, PageInfo pi) {
		
		int offset = (pi.getCurrentPage() - 1) * pi.getBoardLimit(); // offset : 건너뛸 숫자
		int limit = pi.getBoardLimit(); // limit : 조회할 갯수
		
		RowBounds rowBounds = new RowBounds(offset, limit);
		
		return (ArrayList)sqlSession.selectList("adminHouseMapper.selectList", null, rowBounds);
	}
	
	// 카테고리용 selectList
	public ArrayList<House> selectList(SqlSessionTemplate sqlSession, PageInfo pi, String category) {
		
		int offset = (pi.getCurrentPage() - 1) * pi.getBoardLimit(); // offset : 건너뛸 숫자
		int limit = pi.getBoardLimit(); // limit : 조회할 갯수
		
		RowBounds rowBounds = new RowBounds(offset, limit);
		
		return (ArrayList)sqlSession.selectList("adminHouseMapper.selectCategoryList", category, rowBounds);
	}
	
	// 카테고리용 총 갯수 조회
	public int selectCategoryListCount(SqlSessionTemplate sqlSession, String category) {
		return sqlSession.selectOne("adminHouseMapper.selectCategoryListCount", category);
	}
	
	// 카테고리용 selectList
	public ArrayList<House> selectCategoryList(SqlSessionTemplate sqlSession, PageInfo pi, String category) {
		
		int offset = (pi.getCurrentPage() - 1) * pi.getBoardLimit(); // offset : 건너뛸 숫자
		int limit = pi.getBoardLimit(); // limit : 조회할 갯수
		
		RowBounds rowBounds = new RowBounds(offset, limit);
		
		return (ArrayList)sqlSession.selectList("adminHouseMapper.selectCategoryList", category, rowBounds);
	}
	
	public int insertHouse(SqlSessionTemplate sqlSession, House h) {
		return sqlSession.insert("adminHouseMapper.insertHouse", h);
	}

	
	public House selectHouse(SqlSessionTemplate sqlSession, int houseNo) {
		return sqlSession.selectOne("adminHouseMapper.selectHouse", houseNo);
	}
	
	public int deleteHouse(SqlSessionTemplate sqlSession, int houseNo) {
		return sqlSession.update("adminHouseMapper.deleteHouse", houseNo);
	}
	
	public int updateHouse(SqlSessionTemplate sqlSession, House h) {
		return sqlSession.update("adminHouseMapper.updateHouse", h);
	}
	
	// 승인/반려 처리용
	public int updateHouseStatus(SqlSessionTemplate sqlSession, House r) {
		return sqlSession.update("adminHouseMapper.updateHouseStatus", r);
	}
	// 전체선택용 승인/반려용
	public int updateStatusAll(SqlSessionTemplate sqlSession, int[] intArray, String houseStatus) {
		Map<String, Object> map = new HashMap<>();
		map.put("houseStatus", houseStatus);
		map.put("intArray", intArray);
		return sqlSession.update("adminHouseMapper.updateStatusAll", map);
	}
	
	// 검색용
	public int selectSearchCount(SqlSessionTemplate sqlSession, HashMap<String, String> map) {
		
		return sqlSession.selectOne("adminHouseMapper.selectSearchCount", map);
	}
	
	public ArrayList<House> selectSearchList(SqlSessionTemplate sqlSession, HashMap<String, String> map, PageInfo pi){
	
		// 페이징 처리에 필요한 마이바티스용 객체: RowBounds
		// => 객체 생성 시 필요한 변수: offset(건너 뛸 숫자), limit(조회할 개수)
		int limit = pi.getBoardLimit();
		int offset = (pi.getCurrentPage() - 1) * limit;
		
		RowBounds rowBounds = new RowBounds(offset, limit);
		
		return (ArrayList)sqlSession.selectList("adminHouseMapper.selectSearchList", map, rowBounds);
	}
	
	public String selectEmail(SqlSessionTemplate sqlSession, String Id) {
		
		return sqlSession.selectOne("adminHouseMapper.selectEmail", Id);
	}
}
