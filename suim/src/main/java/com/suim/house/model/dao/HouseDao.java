package com.suim.house.model.dao;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

import com.suim.house.model.vo.House;
import com.suim.house.model.vo.Wish;

@Repository
public class HouseDao {

	public House selectHouse(SqlSessionTemplate sqlSession, int hno) {
		return sqlSession.selectOne("houseMapper.selectHouse", hno);
	}
	
	public ArrayList<Wish> checkHeart(SqlSessionTemplate sqlSession, int hno) {
		return (ArrayList)sqlSession.selectList("houseMapper.checkHeart", hno);
	}
	
    public void addHeart(SqlSessionTemplate sqlSession, String id, int hno) {
        Map<String, Object> params = new HashMap<>();
        params.put("id", id);
        params.put("hno", hno);
        sqlSession.insert("houseMapper.addHeart", params);
    }

    public void removeHeart(SqlSessionTemplate sqlSession, String id, int hno) {
    	 Map<String, Object> params = new HashMap<>();
         params.put("id", id);
         params.put("hno", hno);
         sqlSession.delete("houseMapper.removeHeart", params);
    }
}
