package com.suim.house.model.dao;

import java.util.ArrayList;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

import com.suim.house.model.vo.House;
import com.suim.house.model.vo.Region;

@Repository
public class ListHouseDao {

		public ArrayList<House> selectList(SqlSessionTemplate sqlSession) {
				
				return (ArrayList)sqlSession.selectList("listHouseMapper.selectList");
				
			}
		
		public ArrayList<Region> regionSelectList(SqlSessionTemplate sqlSession, String searchKeyword){
			
			
			return (ArrayList)sqlSession.selectList("listHouseMapper.regionSelectList", searchKeyword);
	
		}
	
	
}
