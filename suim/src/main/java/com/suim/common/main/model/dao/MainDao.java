package com.suim.common.main.model.dao;

import java.util.ArrayList;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

import com.suim.board.model.vo.Find;
import com.suim.board.model.vo.InReview;
import com.suim.house.model.vo.House;

@Repository
public class MainDao {

	public ArrayList<House> selectHouseList(SqlSessionTemplate sqlSession) {
		return (ArrayList) sqlSession.selectList("mainMapper.selectHouseList");
	}

	public Map<String, Object> selectCountList(SqlSessionTemplate sqlSession) {
		return sqlSession.selectOne("mainMapper.selectCountList");
	}

	public ArrayList<Find> selectfList(SqlSessionTemplate sqlSession) {
		return (ArrayList) sqlSession.selectList("mainMapper.selectfList");
	}

	public ArrayList<InReview> selectiList(SqlSessionTemplate sqlSession) {
		return (ArrayList) sqlSession.selectList("mainMapper.selectiList");
	}

}
