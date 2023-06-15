package com.suim.house.model.dao;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

import com.suim.house.model.vo.House;
import com.suim.house.model.vo.Photo;
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
    
	public ArrayList<Photo> selectPhoto(SqlSessionTemplate sqlSession, int hno) {
		return (ArrayList)sqlSession.selectList("houseMapper.selectPhoto", hno);
	}
	
	public int enrollPhoto(SqlSessionTemplate sqlSession, Photo p) {
		return sqlSession.insert("houseMapper.enrollPhoto", p);
	}
	
	public int enrollHouse(SqlSessionTemplate sqlSession, House h) {
		return sqlSession.insert("houseMapper.enrollHouse", h);
	}
	
    public int selectHno(SqlSessionTemplate sqlSession, String Id) {
        return sqlSession.selectOne("houseMapper.selectHno", Id);
    }
    
	public int updateHouse(SqlSessionTemplate sqlSession, House h) {
		return sqlSession.insert("houseMapper.updateHouse", h);
	}
	
	public int updatePhoto(SqlSessionTemplate sqlSession, Photo p) {
		return sqlSession.update("houseMapper.updatePhoto", p);
	}
	
	public int delete(SqlSessionTemplate sqlSession, int hno) {
		return sqlSession.update("houseMapper.deleteHouse", hno);
	}

	public House selectEnroll(SqlSessionTemplate sqlSession, int hno) {
		return sqlSession.selectOne("houseMapper.selectEnroll", hno);
	}
}
